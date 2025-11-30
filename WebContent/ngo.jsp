<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>NGO Login | FoodShare</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
    body {
        margin: 0; padding: 0;
        font-family: 'Poppins', sans-serif;
        background: #f5f4ef; /* Soft beige */
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .login-card {
        width: 400px;
        background: rgba(255, 255, 255, 0.6);
        padding: 36px;
        border-radius: 22px;
        backdrop-filter: blur(14px);
        border: 1px solid rgba(200, 200, 200, 0.4);
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        text-align: center;
        color: #444;
    }

    .login-card h2 {
        font-size: 26px;
        font-weight: 600;
        color: #333;
        margin-bottom: 25px;
    }

    label {
        display: block;
        text-align: left;
        font-size: 14px;
        font-weight: 500;
        color: #555;
        margin-top: 12px;
    }

    input[type=email], input[type=password] {
        width: 100%;
        margin-top: 6px;
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
        border-color: #7abec9;
        box-shadow: 0 0 0 3px rgba(122, 190, 201, 0.25);
    }

    button {
        width: 100%;
        padding: 14px;
        border: none;
        border-radius: 16px;
        background: #7abec9;
        color: white;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        margin-top: 20px;
        transition: 0.3s;
    }

    button:hover {
        background: #67aeb9;
    }

    .register-link {
        display: inline;
        color: #006d77;
        text-decoration: none;
        font-weight: 500;
        margin-left: 4px;
    }

    .register-link:hover {
        text-decoration: underline;
    }

    .error {
        color: red;
        margin-bottom: 10px;
        display: block;
        text-align: center;
    }
</style>
</head>
<body>

<div class="login-card">
    <h2>NGO Login</h2>

<%
String msg="";
String email=request.getParameter("email");
String password=request.getParameter("password");

if(email!=null && password!=null){
    try{
        Connection con=Dbconnection.connect();
        PreparedStatement ps=con.prepareStatement("SELECT * FROM ngo WHERE email=? AND password=?");
        ps.setString(1,email);
        ps.setString(2,password);
        ResultSet rs=ps.executeQuery();
        if(rs.next()){
            session.setAttribute("ngoId",rs.getInt("ngo_id"));
            session.setAttribute("ngoName",rs.getString("name"));
            response.sendRedirect("ngoDashboard.jsp");
            return;
        } else {
            msg="<span class='error'>Invalid email or password</span>";
        }
        rs.close(); ps.close(); con.close();
    }catch(Exception e){ msg="<span class='error'>Error: "+e.getMessage()+"</span>"; }
}
%>

<%= msg %>

<form method="post">
    <label>Email:</label>
    <input type="email" name="email" placeholder="Enter Email" required>

    <label>Password:</label>
    <input type="password" name="password" placeholder="Enter Password" required>

    <button type="submit">Login</button>
</form>

<p style="margin-top:12px;">New here?<a class="register-link" href="ngoregister.jsp">Register</a></p>
</div>

</body>
</html>
