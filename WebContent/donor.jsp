<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Donor Login</title>

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
  <h2>Donor Login</h2>
  <form action="donor.jsp" method="post">
    <label>Enter your Email:</label>
    <input type="text" name="email" placeholder="Email here" required>

    <label>Enter your Password:</label>
    <input type="password" name="pass" placeholder="Password here" required>

    <button type="submit">Submit</button>
  </form>

  <a class="register-link" href="Dregister.jsp">New here? Click to Register</a>

<%
Connection con = Dbconnection.connect();
String email = request.getParameter("email");
String pass = request.getParameter("pass");
if (email != null && pass != null) {
    try {
        PreparedStatement pstmt = con.prepareStatement("select id from donor where email=? and password=?");
        pstmt.setString(1, email);
        pstmt.setString(2, pass);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            int id = rs.getInt(1);
            Getset.setId(id);
            System.out.println(id);
            response.sendRedirect("Ddashboard.jsp");
            return;
        } else {
            out.println("<p style='color:red; margin-top:15px;'>Invalid email or password</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
}
%>
</div>

</body>
</html>