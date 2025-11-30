<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.Dbconnection" %>

<%
    Connection con = Dbconnection.connect();
    PreparedStatement ps = null;

    // ---------- UPDATE LOGIC ----------
    if ("true".equals(request.getParameter("update"))) {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        int age = Integer.parseInt(request.getParameter("age"));
        String contact = request.getParameter("contact");
        String location = request.getParameter("location");
        String availabilityDays = request.getParameter("availability_days");
        String startTime = request.getParameter("availability_start_time");
        String endTime = request.getParameter("availability_end_time");

        ps = con.prepareStatement(
            "UPDATE volunteer SET name=?, email=?, age=?, contact=?, location=?, availability_days=?, availability_start_time=?, availability_end_time=? WHERE volunteer_id=?"
        );
        ps.setString(1, name);
        ps.setString(2, email);
        ps.setInt(3, age);
        ps.setString(4, contact);
        ps.setString(5, location);
        ps.setString(6, availabilityDays);
        ps.setString(7, startTime);
        ps.setString(8, endTime);
        ps.setInt(9, id);
        ps.executeUpdate();

        out.println("<script>alert('Volunteer updated successfully!'); window.location='admin_users.jsp';</script>");
        return;
    }

    // ---------- FETCH RECORD FOR EDIT ----------
    String idParam = request.getParameter("id");
    ResultSet volunteerData = null;

    if (idParam != null) {
        ps = con.prepareStatement("SELECT * FROM volunteer WHERE volunteer_id=?");
        ps.setInt(1, Integer.parseInt(idParam));
        volunteerData = ps.executeQuery();
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Volunteer</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
body {
    margin:0; padding:0; font-family:'Poppins',sans-serif;
    background:#f5f4ef; display:flex; justify-content:center; align-items:center; height:100vh;
}

.edit-card {
    width:400px; background:rgba(255,255,255,0.6); padding:32px;
    border-radius:20px; backdrop-filter:blur(14px); border:1px solid rgba(200,200,200,0.4);
    box-shadow:0 8px 25px rgba(0,0,0,0.08); color:#444;
}

.edit-card h2 {
    text-align:center; font-size:24px; font-weight:600; color:#333; margin-bottom:20px;
}

label {
    display:block; margin-top:12px; font-weight:500; font-size:14px; color:#555;
}

input {
    width:100%; margin-top:5px; padding:12px; border-radius:12px; border:1px solid #d4d4d4;
    background:#ffffffaa; font-size:14px; color:#333; outline:none; transition:0.2s;
}

input:focus { border-color:#7abec9; box-shadow:0 0 0 3px rgba(122,190,201,0.25); }

button {
    margin-top:22px; width:100%; padding:12px; border:none; border-radius:14px;
    font-size:16px; font-weight:600; cursor:pointer; background:#7abec9; color:white; transition:all 0.3s ease;
}

button:hover { background:#67aeb9; }
</style>
</head>
<body>

<div class="edit-card">
<%
    if (volunteerData != null && volunteerData.next()) {
%>
<h2>Edit Volunteer</h2>
<form action="editVolunteer.jsp" method="post">
    <input type="hidden" name="update" value="true">
    <input type="hidden" name="id" value="<%= volunteerData.getInt("volunteer_id") %>">

    <label>Name:</label>
    <input type="text" name="name" value="<%= volunteerData.getString("name") %>" required>

    <label>Email:</label>
    <input type="email" name="email" value="<%= volunteerData.getString("email") %>" required>

    <label>Age:</label>
    <input type="number" name="age" value="<%= volunteerData.getInt("age") %>" required>

    <label>Contact:</label>
    <input type="text" name="contact" value="<%= volunteerData.getString("contact") %>" required>

    <label>Location:</label>
    <input type="text" name="location" value="<%= volunteerData.getString("location") %>" required>

    <label>Availability Days:</label>
    <input type="text" name="availability_days" value="<%= volunteerData.getString("availability_days") %>">

    <label>Start Time:</label>
    <input type="time" name="availability_start_time" value="<%= volunteerData.getString("availability_start_time") %>">

    <label>End Time:</label>
    <input type="time" name="availability_end_time" value="<%= volunteerData.getString("availability_end_time") %>">

    <button type="submit">Update Volunteer</button>
</form>

<%
    } else {
%>
<p>No volunteer selected.</p>
<%
    }
%>
</div>

</body>
</html>
