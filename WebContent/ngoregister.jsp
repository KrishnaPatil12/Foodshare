<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>NGO Registration | FoodShare</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
<style>
    body {
        margin:0; padding:0;
        font-family:'Poppins',sans-serif;
        background:#f5f4ef;
        display:flex;
        justify-content:center;
        align-items:center;
        height:100vh;
    }

    .login-card {
        width:420px;
        background: rgba(255,255,255,0.6);
        padding:40px;
        border-radius:22px;
        backdrop-filter: blur(14px);
        border:1px solid rgba(200,200,200,0.4);
        box-shadow:0 10px 30px rgba(0,0,0,0.08);
        color:#444;
    }

    .login-card h2 {
        text-align:center;
        font-size:26px;
        font-weight:600;
        color:#333;
        margin-bottom:25px;
    }

    label {
        display:block;
        text-align:left;
        font-size:14px;
        font-weight:500;
        color:#555;
        margin-top:12px;
    }

    input[type=text], input[type=email], input[type=password] {
        width:100%;
        margin-top:6px;
        padding:12px;
        border-radius:12px;
        border:1px solid #d4d4d4;
        background:#ffffffaa;
        font-size:14px;
        color:#333;
        outline:none;
        transition:0.2s;
    }

    input:focus {
        border-color:#7abec9;
        box-shadow:0 0 0 3px rgba(122,190,201,0.25);
    }

    button {
        width:100%;
        padding:14px;
        border:none;
        border-radius:16px;
        background:#7abec9;
        color:white;
        font-size:16px;
        font-weight:600;
        cursor:pointer;
        margin-top:20px;
        transition:0.3s;
    }

    button:hover {
        background:#67aeb9;
    }

    .login-card p {
        text-align:center;
        margin-top:12px;
        font-size:14px;
    }

    .register-link {
        color:#006d77;
        text-decoration:none;
        font-weight:500;
        margin-left:4px;
    }

    .register-link:hover {
        text-decoration:underline;
    }

    .error {
        color:red;
        margin-bottom:10px;
        display:block;
        text-align:center;
    }

    .success {
        color:green;
        margin-bottom:10px;
        display:block;
        text-align:center;
    }
</style>
</head>
<body>

<div class="login-card">
<h2>NGO Registration</h2>

<%
String msg="";
if(request.getMethod().equalsIgnoreCase("POST")){
    String name=request.getParameter("name");
    String email=request.getParameter("email");
    String password=request.getParameter("password");
    String contact=request.getParameter("contact");
    String location=request.getParameter("location");
    try{
        Connection con = Dbconnection.connect();
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO ngo(name,email,password,contact,location) VALUES(?,?,?,?,?)"
        );
        ps.setString(1,name);
        ps.setString(2,email);
        ps.setString(3,password);
        ps.setString(4,contact);
        ps.setString(5,location);
        int inserted=ps.executeUpdate();
        if(inserted>0){
            msg="<span class='success'>Registration successful! <a class='register-link' href='ngoDashboard.jsp'>Go to Dashboard</a></span>";
        } else { 
            msg="<span class='error'>Registration failed!</span>"; 
        }
        ps.close(); con.close();
    }catch(Exception e){ 
        msg="<span class='error'>Error: "+e.getMessage()+"</span>"; 
    }
}
%>



<form method="post">
    <label>NGO Name:</label>
    <input type="text" name="name" placeholder="Enter NGO Name" required>

    <label>Email:</label>
    <input type="email" name="email" placeholder="Enter Email" required>

    <label>Password:</label>
    <input type="password" name="password" placeholder="Enter Password" required>

    <label>Contact Number:</label>
    <input type="text" name="contact" placeholder="Contact Number">

    <label>Location:</label>
    <input type="text" name="location" placeholder="Location">

    <button type="submit">Register</button>
</form>
<%= msg %>
</div>

</body>
</html>
