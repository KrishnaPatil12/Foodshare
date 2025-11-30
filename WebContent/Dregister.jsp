<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!-- Poppins font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<title>Donor Registration</title>

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

    .register-card {
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

    .register-card h2 {
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
        border-color: #7abec9; 
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
        background: #7abec9;
        color: white;
        transition: 0.3s ease;
    }

    button:hover {
        background: #67aeb9;
    }

    .login-link {
        display: block;
        margin-top: 15px;
        font-size: 14px;
        color: #006d77;
        text-decoration: none;
        font-weight: 500;
    }

    .login-link:hover {
        text-decoration: underline;
    }

    p {
        font-size: 14px;
        margin-top: 12px;
    }
</style>
</head>

<body>


<div class="register-card">
  <h2>Donor Registration</h2>
  <form action="Dregister.jsp" method="post">
    
    <label>Enter your Name:</label>
    <input type="text" name="Name" placeholder="Name here" required>
	
	<label>Enter your Email:</label>
    <input type="text" name="email" placeholder="Email here" required>

    <label>Enter your Password:</label>
    <input type="password" name="pass" placeholder="Password here" required>
    
    <label>Enter your location:</label>
    <input type="text" name="loc" placeholder="location here" required>

    <label>Enter your Contact No:</label>
    <input type="text" name="contact" placeholder="Contact here" required>

    

    <button type="submit">Submit</button>
  </form>

<%
Connection con=Dbconnection.connect();
String name=request.getParameter("Name");
String email=request.getParameter("email");
String pass=request.getParameter("pass");
String loc=request.getParameter("loc");
String contact=request.getParameter("contact");

if(email!=null && name!=null && pass!=null && loc!=null && contact!=null) {
    int id=0;
    try {
        PreparedStatement pstmt=con.prepareStatement("insert into donor values (?,?,?,?,?,?)");
        pstmt.setInt(1,id);
        pstmt.setString(2,name);
        pstmt.setString(3,email);
        pstmt.setString(4,pass);
        pstmt.setString(5,loc);
        pstmt.setString(6,contact);

        int i=pstmt.executeUpdate();
        Getset.setId(id);
        if(i>0){
            response.sendRedirect("Ddashboard.jsp");
        } else {
            out.println("<p style='color:red; margin-top:15px;'>Invalid! Try again</p>");
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
}
%>
</div>


</body>
</html>