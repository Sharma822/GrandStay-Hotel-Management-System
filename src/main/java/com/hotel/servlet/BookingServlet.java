package com.hotel.servlet;

import com.hotel.dao.HotelDAO;
import com.hotel.entity.Customer;
import com.hotel.entity.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
    private final HotelDAO hotelDAO = new HotelDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Security Check: Sirf login kiya hua Admin hi saari bookings dekh ya cancel kar sakta hai
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            resp.sendRedirect("admin-login.jsp");
            return;
        }

        String action = req.getParameter("action");
        if ("cancel".equals(action)) {
            int bookingId = Integer.parseInt(req.getParameter("id"));
            hotelDAO.cancelBooking(bookingId);
            resp.sendRedirect("booking?action=view");
            return;
        }

        req.setAttribute("bookings", hotelDAO.getAllBookings());
        req.getRequestDispatcher("bookings.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        int roomId = Integer.parseInt(req.getParameter("roomId"));
        Date checkIn = Date.valueOf(req.getParameter("checkIn"));
        Date checkOut = Date.valueOf(req.getParameter("checkOut"));

        Customer customer = hotelDAO.getCustomerByEmail(email);
        if (customer == null) {
            customer = new Customer(name, email, phone);
            hotelDAO.saveCustomer(customer);
            customer = hotelDAO.getCustomerByEmail(email);
        }

        boolean success = hotelDAO.bookRoom(customer.getCustomerId(), roomId, checkIn, checkOut);
        
        if (success) {
            Room bookedRoom = hotelDAO.getRoomById(roomId);
            String roomNo = (bookedRoom != null) ? bookedRoom.getRoomNumber() : "";
            // Saari bookings dikhane ke bajaye sirf customer ki confirmation receipt dikhao
            resp.sendRedirect("booking-success.jsp?name=" + URLEncoder.encode(name, StandardCharsets.UTF_8)
                    + "&roomNumber=" + URLEncoder.encode(roomNo, StandardCharsets.UTF_8)
                    + "&checkIn=" + checkIn
                    + "&checkOut=" + checkOut);
        } else {
            resp.sendRedirect("index.jsp");
        }
    }
}