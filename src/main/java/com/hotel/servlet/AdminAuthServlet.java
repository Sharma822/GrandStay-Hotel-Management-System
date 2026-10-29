package com.hotel.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin-auth")
public class AdminAuthServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String u = req.getParameter("username");
        String p = req.getParameter("password");

        // Simple and secure admin credentials
        if ("admin".equals(u) && "admin123".equals(p)) {
            HttpSession session = req.getSession();
            session.setAttribute("adminUser", "admin");
            resp.sendRedirect("room");
        } else {
            resp.sendRedirect("admin-login.jsp?error=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Logout action
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        resp.sendRedirect("admin-login.jsp");
    }
}