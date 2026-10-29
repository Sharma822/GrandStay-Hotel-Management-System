<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hotel.dao.HotelDAO, com.hotel.entity.Room, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Grand Stay | Hotel Booking</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; font-family: 'Inter', sans-serif; margin: 0; padding: 0; }
        body { background: #f0f4f8; color: #2d3748; padding: 30px 15px; }
        .container { max-width: 900px; margin: 0 auto; }
        
        /* Navbar */
        .navbar { display: flex; justify-content: space-between; align-items: center; background: #ffffff; padding: 18px 28px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); margin-bottom: 30px; }
        .logo { font-size: 20px; font-weight: 700; color: #1a365d; }
        .nav-links a { text-decoration: none; color: #4a5568; font-weight: 600; margin-left: 20px; font-size: 14px; transition: color 0.2s; }
        .nav-links a:hover, .nav-links a.active { color: #2b6cb0; }
        .admin-link { background: #f1f5f9; padding: 6px 12px; border-radius: 6px; border: 1px solid #cbd5e1; }

        /* Grid Layout */
        .layout-grid { display: grid; grid-template-columns: 1.2fr 0.8fr; gap: 24px; }
        .card { background: #ffffff; border-radius: 14px; padding: 28px; box-shadow: 0 6px 18px rgba(0,0,0,0.06); }
        .card h2 { font-size: 20px; font-weight: 700; color: #1a202c; margin-bottom: 20px; }

        /* Form Controls */
        .form-group { margin-bottom: 16px; }
        label { display: block; font-size: 13px; font-weight: 600; color: #4a5568; margin-bottom: 6px; }
        input, select { width: 100%; padding: 11px 14px; border: 1.5px solid #e2e8f0; border-radius: 8px; font-size: 14px; outline: none; background: #fafafa; }
        input:focus, select:focus { border-color: #3182ce; background: #ffffff; box-shadow: 0 0 0 3px rgba(49,130,206,0.15); }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }

        /* Summary Panel */
        .summary-card { background: linear-gradient(135deg, #1e3a8a, #2563eb); color: #ffffff; }
        .summary-card h2 { color: #ffffff; }
        .summary-item { display: flex; justify-content: space-between; margin-bottom: 14px; font-size: 14px; opacity: 0.9; }
        .divider { border-bottom: 1px solid rgba(255,255,255,0.2); margin: 18px 0; }
        .total-box { display: flex; justify-content: space-between; align-items: baseline; font-size: 16px; font-weight: 600; }
        .total-amount { font-size: 28px; font-weight: 700; color: #6ee7b7; }

        /* Button */
        .btn-submit { width: 100%; margin-top: 20px; padding: 13px; background: #059669; color: #ffffff; border: none; border-radius: 8px; font-size: 15px; font-weight: 600; cursor: pointer; }
        .btn-submit:hover { background: #047857; }
    </style>
</head>
<body>

<div class="container">
    <!-- Navbar: Customer ko sirf Book Room aur Admin Portal link dikhega -->
    <div class="navbar">
        <div class="logo">🏨 Grand Stay</div>
        <div class="nav-links">
            <a href="index.jsp" class="active">Book Room</a>
            <a href="admin-login.jsp" class="admin-link">Admin Portal 🔒</a>
        </div>
    </div>

    <div class="layout-grid">
        <!-- Booking Form -->
        <div class="card">
            <h2>Book Your Stay</h2>
            <form action="booking" method="post" id="bookingForm">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="name" required placeholder="John Doe">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" name="email" required placeholder="john@example.com">
                    </div>
                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="text" name="phone" required placeholder="9876543210">
                    </div>
                </div>

                <div class="form-group">
                    <label>Select Room</label>
                    <select name="roomId" id="roomSelect" required onchange="updateLiveCalculation()">
                        <%
                            HotelDAO dao = new HotelDAO();
                            List<Room> rooms = dao.getAvailableRooms();
                            if(rooms == null || rooms.isEmpty()) {
                        %>
                            <option value="">No Rooms Available (Please contact hotel)</option>
                        <%
                            } else {
                                for(Room r : rooms) {
                        %>
                            <option value="<%= r.getRoomId() %>" data-price="<%= r.getPrice() %>" data-type="<%= r.getRoomType() %>" data-number="<%= r.getRoomNumber() %>">
                                Room <%= r.getRoomNumber() %> (<%= r.getRoomType() %>) - ₹<%= r.getPrice() %>/day
                            </option>
                        <%      } 
                            }
                        %>
                    </select>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Check-in Date</label>
                        <input type="date" name="checkIn" id="checkIn" required onchange="handleDateChange()">
                    </div>
                    <div class="form-group">
                        <label>Check-out Date</label>
                        <input type="date" name="checkOut" id="checkOut" required onchange="updateLiveCalculation()">
                    </div>
                </div>

                <button type="submit" class="btn-submit">Confirm Reservation</button>
            </form>
        </div>

        <!-- Live Estimate Summary Card -->
        <div class="card summary-card">
            <h2>Booking Estimate</h2>
            <div class="summary-item">
                <span>Selected Room</span>
                <strong id="displayRoomNumber">None</strong>
            </div>
            <div class="summary-item">
                <span>Room Type</span>
                <strong id="displayRoomType">-</strong>
            </div>
            <div class="summary-item">
                <span>Rate / Night</span>
                <strong id="displayRate">₹0</strong>
            </div>
            <div class="summary-item">
                <span>Total Nights</span>
                <strong id="displayNights">0 Night(s)</strong>
            </div>
            
            <div class="divider"></div>

            <div class="total-box">
                <span>Estimated Total:</span>
                <div class="total-amount" id="displayTotal">₹0</div>
            </div>
        </div>
    </div>
</div>

<script>
    const today = new Date().toISOString().split('T')[0];
    document.getElementById('checkIn').setAttribute('min', today);

    function handleDateChange() {
        const checkInVal = document.getElementById('checkIn').value;
        const checkOutElem = document.getElementById('checkOut');
        
        checkOutElem.setAttribute('min', checkInVal);
        if (checkOutElem.value && checkOutElem.value <= checkInVal) {
            checkOutElem.value = '';
        }
        updateLiveCalculation();
    }

    function updateLiveCalculation() {
        const select = document.getElementById('roomSelect');
        const selectedOption = select.options[select.selectedIndex];
        
        if (!selectedOption || !selectedOption.dataset.price) {
            return;
        }

        const price = parseFloat(selectedOption.dataset.price);
        const type = selectedOption.dataset.type;
        const number = selectedOption.dataset.number;

        const checkIn = new Date(document.getElementById('checkIn').value);
        const checkOut = new Date(document.getElementById('checkOut').value);

        document.getElementById('displayRoomNumber').innerText = "Room " + number;
        document.getElementById('displayRoomType').innerText = type;
        document.getElementById('displayRate').innerText = "₹" + price.toFixed(2);

        if (!isNaN(checkIn.getTime()) && !isNaN(checkOut.getTime()) && checkOut > checkIn) {
            const diffTime = Math.abs(checkOut - checkIn);
            const nights = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
            const total = nights * price;

            document.getElementById('displayNights').innerText = nights + " Night(s)";
            document.getElementById('displayTotal').innerText = "₹" + total.toLocaleString('en-IN');
        } else {
            document.getElementById('displayNights').innerText = "0 Night(s)";
            document.getElementById('displayTotal').innerText = "₹0";
        }
    }

    window.onload = updateLiveCalculation;
</script>

</body>
</html>