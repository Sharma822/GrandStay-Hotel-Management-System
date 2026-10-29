<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Confirmed | Grand Stay</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; font-family: 'Inter', sans-serif; margin: 0; padding: 0; }
        body { background: #f0f4f8; display: flex; justify-content: center; align-items: center; min-height: 100vh; padding: 20px; }
        .receipt-card { background: #ffffff; max-width: 480px; width: 100%; border-radius: 14px; padding: 32px; box-shadow: 0 8px 24px rgba(0,0,0,0.08); text-align: center; }
        .success-icon { width: 64px; height: 64px; background: #d1fae5; color: #059669; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 30px; margin: 0 auto 18px; }
        h2 { color: #1f2937; margin-bottom: 8px; }
        p.subtitle { color: #6b7280; font-size: 14px; margin-bottom: 24px; }
        .details-box { background: #f9fafb; border: 1px solid #e5e7eb; border-radius: 8px; padding: 18px; text-align: left; margin-bottom: 24px; }
        .row { display: flex; justify-content: space-between; margin-bottom: 10px; font-size: 14px; }
        .row:last-child { margin-bottom: 0; }
        .row span { color: #6b7280; }
        .row strong { color: #111827; }
        .btn-home { display: inline-block; width: 100%; padding: 12px; background: #2563eb; color: #ffffff; text-decoration: none; border-radius: 8px; font-weight: 600; transition: background 0.2s; }
        .btn-home:hover { background: #1d4ed8; }
    </style>
</head>
<body>

<div class="receipt-card">
    <div class="success-icon">✓</div>
    <h2>Reservation Confirmed!</h2>
    <p class="subtitle">Aapka room safaltapoorvak book ho chuka hai.</p>

    <div class="details-box">
        <div class="row">
            <span>Guest Name:</span>
            <strong><%= request.getParameter("name") != null ? request.getParameter("name") : "Guest" %></strong>
        </div>
        <div class="row">
            <span>Room Number:</span>
            <strong>Room <%= request.getParameter("roomNumber") != null ? request.getParameter("roomNumber") : "-" %></strong>
        </div>
        <div class="row">
            <span>Check-in:</span>
            <strong><%= request.getParameter("checkIn") != null ? request.getParameter("checkIn") : "-" %></strong>
        </div>
        <div class="row">
            <span>Check-out:</span>
            <strong><%= request.getParameter("checkOut") != null ? request.getParameter("checkOut") : "-" %></strong>
        </div>
        <div class="row">
            <span>Status:</span>
            <strong style="color: #059669;">CONFIRMED</strong>
        </div>
    </div>

    <a href="index.jsp" class="btn-home">Book Another Room</a>
</div>

</body>
</html>