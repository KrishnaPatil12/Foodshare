<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.Dbconnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Login | FoodShare</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
    body {
        margin: 0;
        padding: 0;
        font-family: 'Poppins', sans-serif;
        background: #f5f4ef; /* Soft beige */
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .login-card {
        width: 380px;
        background: rgba(255, 255, 255, 0.6);
        padding: 32px;
        border-radius: 20px;
        backdrop-filter: blur(14px);
        border: 1px solid rgba(200, 200, 200, 0.4);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        text-align: center;
        color: #444;
    }

    .login-card h2 {
        margin-bottom: 20px;
        font-size: 24px;
        font-weight: 600;
        color: #333;
    }

    label {
        display: block;
        margin-top: 12px;
        text-align: left;
        font-size: 14px;
        font-weight: 500;
        color: #555;
    }

    input {
        width: 100%;
        margin-top: 5px;
        padding: 12px;
        border-radius: 12px;
        border: 1px solid #d4d4d4;
        background: #ffffffaa;
        font-size: 14px;
        color: #333;
        outline: none;
        transition: 0.2s;
    }

    input:focus {
        border-color: #7abec9; /* light teal border */
        box-shadow: 0 0 0 3px rgba(122,190,201,0.25);
    }

    button {
        margin-top: 22px;
        width: 100%;
        padding: 12px;
        border: none;
        border-radius: 14px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        background: #7abec9; /* soft teal */
        color: white;
        transition: all 0.3s ease;
    }

    button:hover {
        background: #67aeb9;
    }

    .register-link {
        display: block;
        margin-top: 15px;
        font-size: 14px;
        color: #006d77;
        text-decoration: none;
        font-weight: 500;
    }

    .register-link:hover {
        text-decoration: underline;
    }

    p {
        font-size: 14px;
        margin-top: 12px;
    }
</style>
</head>

<body>

<div class="login-card">
    <h2>Admin Login</h2>

    <form action="" method="post">
        <label>Email:</label>
        <input type="text" name="email" placeholder="Enter admin email" required>

        <label>Password:</label>
        <input type="password" name="pass" placeholder="Enter password" required>

        <button type="submit">Login</button>
    </form>

<%
String email = request.getParameter("email");
String password = request.getParameter("pass");

if(email != null && password != null){
    if(email.equals("admin@gmail.com") && password.equals("admin123")){
        response.sendRedirect("adminDashboard.jsp");
    } else {
        out.println("<p style='color:red;'>Invalid email or password!</p>");
    }
}
%>

</div>

</body>
</html>
