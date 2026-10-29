<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.hotel.entity.Room" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Rooms | Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; font-family: 'Inter', sans-serif; margin: 0; padding: 0; }
        body { background: #f0f4f8; color: #2d3748; padding: 30px 15px; }
        .container { max-width: 1000px; margin: 0 auto; }
        
        .navbar { display: flex; justify-content: space-between; align-items: center; background: #ffffff; padding: 18px 28px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); margin-bottom: 25px; }
        .nav-links { display: flex; align-items: center; gap: 20px; }
        .nav-links a { text-decoration: none; color: #4a5568; font-weight: 600; font-size: 14px; }
        .nav-links a:hover { color: #2b6cb0; }
        .logout-btn { color: #ef4444 !important; font-weight: 700 !important; background: #fee2e2; padding: 6px 14px; border-radius: 6px; }

        .card { background: #ffffff; border-radius: 14px; padding: 25px; box-shadow: 0 6px 18px rgba(0,0,0,0.06); margin-bottom: 25px; }
        .card h2 { font-size: 18px; font-weight: 700; margin-bottom: 15px; }

        .inline-form { display: grid; grid-template-columns: 1fr 1fr 1fr auto; gap: 14px; align-items: end; }
        label { display: block; font-size: 12px; font-weight: 600; color: #4a5568; margin-bottom: 5px; }
        input, select { width: 100%; padding: 10px 12px; border: 1.5px solid #e2e8f0; border-radius: 8px; font-size: 14px; outline: none; }
        
        .btn-add { padding: 10px 24px; background: #2563eb; color: #ffffff; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; }
        .btn-add:hover { background: #1d4ed8; }

        .search-box { margin-bottom: 15px; }
        .search-box input { max-width: 300px; }

        table { width: 100%; border-collapse: collapse; }
        th { background: #f8fafc; color: #64748b; font-size: 12px; font-weight: 600; text-transform: uppercase; padding: 12px 16px; text-align: left; border-bottom: 1.5px solid #e2e8f0; }
        td { padding: 14px 16px; border-bottom: 1px solid #edf2f7; font-size: 14px; }
        
        .badge { padding: 4px 10px; border-radius: 20px; font-size: 12px; font-weight: 600; display: inline-block; }
        .badge-available { background: #d1fae5; color: #065f46; }
        .badge-booked { background: #fee2e2; color: #991b1b; }
    </style>
</head>
<body>

<div class="container">
    <!-- Navbar with Logout -->
    <div class="navbar">
        <h2 style="font-size: 18px;">🏨 Admin Dashboard: Rooms</h2>
        <div class="nav-links">
            <a href="index.jsp">Public Booking View</a>
            <a href="booking?action=view">Manage All Bookings</a>
            <a href="admin-auth" class="logout-btn">Logout ⎋</a>
        </div>
    </div>

    <!-- Add Room Form -->
    <div class="card">
        <h2>Add New Room</h2>
        <form action="room" method="post" class="inline-form">
            <div>
                <label>Room Number</label>
                <input type="text" name="roomNumber" placeholder="e.g. 204" required>
            </div>
            <div>
                <label>Room Category</label>
                <select name="roomType">
                    <option value="Standard AC">Standard AC</option>
                    <option value="Deluxe">Deluxe</option>
                    <option value="Super Deluxe">Super Deluxe</option>
                    <option value="Executive Suite">Executive Suite</option>
                </select>
            </div>
            <div>
                <label>Price / Night (₹)</label>
                <input type="number" step="0.01" name="price" placeholder="1800" required>
            </div>
            <div>
                <button type="submit" class="btn-add">+ Add</button>
            </div>
        </form>
    </div>

    <!-- Room List -->
    <div class="card">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
            <h2>Existing Rooms</h2>
            <div class="search-box">
                <input type="text" id="filterInput" placeholder="Quick search room..." onkeyup="filterTable()">
            </div>
        </div>

        <table id="roomsTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Room No</th>
                    <th>Category</th>
                    <th>Price / Night</th>
                    <th>Current Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Room> rooms = (List<Room>) request.getAttribute("rooms");
                    if (rooms != null && !rooms.isEmpty()) {
                        for (Room r : rooms) {
                            boolean isAvailable = "AVAILABLE".equalsIgnoreCase(r.getStatus());
                %>
                <tr>
                    <td>#<%= r.getRoomId() %></td>
                    <td><strong><%= r.getRoomNumber() %></strong></td>
                    <td><%= r.getRoomType() %></td>
                    <td>₹<%= r.getPrice() %></td>
                    <td>
                        <span class="badge <%= isAvailable ? "badge-available" : "badge-booked" %>">
                            <%= r.getStatus() %>
                        </span>
                    </td>
                </tr>
                <% 
                        }
                    } else {
                %>
                <tr><td colspan="5" style="text-align: center; color: #94a3b8;">No rooms added yet.</td></tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<script>
    function filterTable() {
        const query = document.getElementById("filterInput").value.toLowerCase();
        const rows = document.querySelectorAll("#roomsTable tbody tr");
        rows.forEach(row => {
            const text = row.innerText.toLowerCase();
            row.style.display = text.includes(query) ? "" : "none";
        });
    }
</script>

</body>
</html>