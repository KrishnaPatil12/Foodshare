<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Volunteer Registration</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
body {
    margin: 0;
    padding: 0;
    font-family: 'Poppins', sans-serif;
    background: #f5f4ef;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.register-card {
    width: 420px;
    background: rgba(255,255,255,0.7);
    padding: 32px;
    border-radius: 20px;
    backdrop-filter: blur(14px);
    border: 1px solid rgba(200,200,200,0.4);
    box-shadow: 0 8px 25px rgba(0,0,0,0.08);
}

.register-card h2 {
    text-align: center;
    margin-bottom: 20px;
    font-size: 24px;
    font-weight: 600;
    color: #333;
}

label {
    display: block;
    margin-top: 12px;
    font-size: 14px;
    font-weight: 500;
    color: #555;
}

input {
    width: 100%;
    margin-top: 6px;
    padding: 12px;
    border-radius: 12px;
    border: 1px solid #d4d4d4;
    background: #ffffffaa;
    font-size: 14px;
}

button {
    margin-top: 22px;
    width: 100%;
    padding: 12px;
    border: none;
    border-radius: 14px;
    background: #7abec9;
    color: white;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
}

button:hover {
    background: #67aeb9;
}

p {
    font-size: 14px;
    margin-top: 12px;
    text-align: center;
}
</style>
</head>

<body>

<div class="register-card">
    <h2>Volunteer Registration</h2>
    <form action="Vregister.jsp" method="post">
        <label>Name</label>
        <input type="text" name="name" placeholder="Your Name" required>

        <label>Email</label>
        <input type="email" name="email" placeholder="Email Address" required>

        <label>Password</label>
        <input type="password" name="password" placeholder="Password" required>

        <label>Age</label>
        <input type="number" name="age" placeholder="Your Age" required>

        <label>Contact Number</label>
        <input type="text" name="contact" placeholder="Contact Number" required>

        <label>Location</label>
        <input type="text" name="location" placeholder="Your Location" required>

        <button type="submit">Register</button>
    </form>

<%
    Connection con = Dbconnection.connect();

    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String ageStr = request.getParameter("age");
    String contact = request.getParameter("contact");
    String location = request.getParameter("location");

    if(name != null && email != null && password != null && ageStr != null && contact != null && location != null) {
        try {
            int age = Integer.parseInt(ageStr);
            PreparedStatement pstmt = con.prepareStatement(
                "INSERT INTO volunteer(volunteer_id, name, email, password, age, contact, location) VALUES (?,?,?,?,?,?,?)"
            );
            pstmt.setInt(1, 0); // Auto-increment
            pstmt.setString(2, name);
            pstmt.setString(3, email);
            pstmt.setString(4, password);
            pstmt.setInt(5, age);
            pstmt.setString(6, contact);
            pstmt.setString(7, location);

            int i = pstmt.executeUpdate();
            if(i > 0) {
            	ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    int newVolId = rs.getInt(1);  // this is the auto-increment volunteer_id
                    Getset.setId(newVolId);       // update Getset with the new volunteer ID
                }
                out.println("<p style='color:green;'>Registration Successful! <a href='volunteer_dashboard.jsp'>Go to Dashboard</a></p>");
            } else {
                out.println("<p style='color:red;'>Failed to register. Try again!</p>");
            }

        } catch(Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }
%>
</div>

</body>
</html>
