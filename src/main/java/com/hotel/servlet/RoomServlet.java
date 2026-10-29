package com.hotel.servlet;

import com.hotel.dao.HotelDAO;
import com.hotel.entity.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/room")
public class RoomServlet extends HttpServlet {
    private final HotelDAO hotelDAO = new HotelDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("rooms", hotelDAO.getAllRooms());
        req.getRequestDispatcher("rooms.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String roomNumber = req.getParameter("roomNumber");
        String roomType = req.getParameter("roomType");
        double price = Double.parseDouble(req.getParameter("price"));

        Room room = new Room(roomNumber, roomType, price, "AVAILABLE");
        hotelDAO.saveRoom(room);
        resp.sendRedirect("room");
    }
}