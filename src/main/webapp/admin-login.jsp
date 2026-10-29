<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login | Grand Stay</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; font-family: 'Inter', sans-serif; margin: 0; padding: 0; }
        body { background: #f0f4f8; display: flex; justify-content: center; align-items: center; min-height: 100vh; }
        .login-card { background: #ffffff; width: 380px; border-radius: 12px; padding: 30px; box-shadow: 0 8px 24px rgba(0,0,0,0.08); }
        h2 { font-size: 20px; color: #1e293b; margin-bottom: 20px; text-align: center; }
        label { display: block; font-size: 13px; font-weight: 600; color: #475569; margin-bottom: 6px; }
        input { width: 100%; padding: 10px 12px; border: 1.5px solid #cbd5e1; border-radius: 6px; margin-bottom: 16px; font-size: 14px; }
        .btn-login { width: 100%; padding: 11px; background: #0f172a; color: white; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; }
        .btn-login:hover { background: #334155; }
        .error { color: #dc2626; font-size: 13px; margin-bottom: 12px; text-align: center; }
        .back-link { display: block; text-align: center; margin-top: 15px; font-size: 13px; text-decoration: none; color: #2563eb; }
    </style>
</head>
<body>

<div class="login-card">
    <h2>Admin Portal</h2>
    <% if (request.getParameter("error") != null) { %>
        <div class="error">Galat username ya password!</div>
    <% } %>
    <form action="admin-auth" method="post">
        <label>Username</label>
        <input type="text" name="username" required placeholder="admin">

        <label>Password</label>
        <input type="password" name="password" required placeholder="admin123">

        <button type="submit" class="btn-login">Login to Dashboard</button>
    </form>
    <a href="index.jsp" class="back-link">← Back to Customer Home</a>
</div>

</body>
</html>