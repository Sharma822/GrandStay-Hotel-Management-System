<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.hotel.entity.Booking" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Bookings | Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; font-family: 'Inter', sans-serif; margin: 0; padding: 0; }
        body { background: #f0f4f8; color: #2d3748; padding: 30px 15px; }
        .container { max-width: 1050px; margin: 0 auto; }
        
        .navbar { display: flex; justify-content: space-between; align-items: center; background: #ffffff; padding: 18px 28px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); margin-bottom: 25px; }
        .nav-links { display: flex; align-items: center; gap: 20px; }
        .nav-links a { text-decoration: none; color: #4a5568; font-weight: 600; font-size: 14px; }
        .nav-links a:hover { color: #2b6cb0; }
        .logout-btn { color: #ef4444 !important; font-weight: 700 !important; background: #fee2e2; padding: 6px 14px; border-radius: 6px; }

        .card { background: #ffffff; border-radius: 14px; padding: 25px; box-shadow: 0 6px 18px rgba(0,0,0,0.06); }
        .card h2 { font-size: 18px; font-weight: 700; margin-bottom: 18px; }

        table { width: 100%; border-collapse: collapse; }
        th { background: #1e293b; color: #ffffff; font-size: 12px; font-weight: 600; text-transform: uppercase; padding: 12px 14px; text-align: left; }
        td { padding: 14px; border-bottom: 1px solid #edf2f7; font-size: 14px; }
        tr:hover { background: #f8fafc; }
        
        .cancel-btn { background: #fee2e2; color: #b91c1c; padding: 6px 12px; border-radius: 6px; text-decoration: none; font-weight: 600; font-size: 13px; }
        .cancel-btn:hover { background: #fecaca; }
    </style>
</head>
<body>

<div class="container">
    <!-- Navbar with Logout -->
    <div class="navbar">
        <h2 style="font-size: 18px;">🏨 Admin Dashboard: Bookings</h2>
        <div class="nav-links">
            <a href="room">Manage Rooms</a>
            <a href="index.jsp">Public Booking View</a>
            <a href="admin-auth" class="logout-btn">Logout ⎋</a>
        </div>
    </div>

    <!-- Booking Table -->
    <div class="card">
        <h2>All Customer Reservations</h2>
        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Customer Name</th>
                    <th>Phone</th>
                    <th>Room No</th>
                    <th>Category</th>
                    <th>Check-in</th>
                    <th>Check-out</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
                    if (bookings != null && !bookings.isEmpty()) {
                        for (Booking b : bookings) {
                %>
                <tr>
                    <td>#<%= b.getBookingId() %></td>
                    <td><strong><%= b.getCustomer().getName() %></strong></td>
                    <td><%= b.getCustomer().getPhone() %></td>
                    <td>Room <%= b.getRoom().getRoomNumber() %></td>
                    <td><%= b.getRoom().getRoomType() %></td>
                    <td><%= b.getCheckIn() %></td>
                    <td><%= b.getCheckOut() %></td>
                    <td>
                        <a class="cancel-btn" href="booking?action=cancel&id=<%= b.getBookingId() %>" 
                           onclick="return confirm('Do you want to cancel this reservation? Room will become AVAILABLE again.');">Cancel</a>
                    </td>
                </tr>
                <% 
                        }
                    } else {
                %>
                <tr><td colspan="8" style="text-align: center; color: #94a3b8; padding: 25px;">No active bookings found.</td></tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>