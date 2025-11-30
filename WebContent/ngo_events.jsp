<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Event | NGO</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
body { margin:0; padding:20px; font-family:'Poppins',sans-serif; background:#f5f4ef; }
h2 { text-align:center; margin-bottom:20px; color:#333; }
form {
    width: 90%; max-width:500px; margin:0 auto;
    background:white; padding:20px; border-radius:10px;
    box-shadow:0 4px 15px rgba(0,0,0,0.1);
}
form label { display:block; margin-top:10px; font-weight:500; }
form input, form textarea { width:100%; padding:10px; margin-top:6px; border-radius:8px; border:1px solid #ccc; font-size:14px; }
form button { margin-top:15px; width:100%; padding:12px; border:none; border-radius:10px; background:#7abec9; color:white; font-weight:600; cursor:pointer; }
form button:hover { background:#67aeb9; }
</style>

</head>
<body>

<h2>Add New Event</h2>

<form method="post" action="ngo_events.jsp">
    <label>Event Name</label>
    <input type="text" name="event_name" required>

    <label>Event Date</label>
    <input type="date" name="event_date" required>

    <label>Event Time</label>
    <input type="time" name="event_time" required>

    <label>Location</label>
    <input type="text" name="location" required>

    <label>Description</label>
    <textarea name="description" rows="3"></textarea>

    <button type="submit">Add Event</button>
</form>

<%
    String eventName = request.getParameter("event_name");
    String eventDate = request.getParameter("event_date");
    String eventTime = request.getParameter("event_time");
    String location = request.getParameter("location");
    String description = request.getParameter("description");
    Integer ngoId = Getset.getId();

    if(eventName != null && eventDate != null && eventTime != null && location != null){
        try{
            Connection con = Dbconnection.connect();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO ngo_events(ngo_id, event_name, event_date, event_time, location, description) VALUES (?,?,?,?,?,?)"
            );
            ps.setInt(1, ngoId);
            ps.setString(2, eventName);
            ps.setString(3, eventDate);
            ps.setString(4, eventTime);
            ps.setString(5, location);
            ps.setString(6, description);

            int result = ps.executeUpdate();
            if(result > 0){
                out.println("<p style='color:green;text-align:center;'>Event added successfully!</p>");
            }
            ps.close(); con.close();
        }catch(Exception e){
            out.println("<p style='color:red;text-align:center;'>Error: "+e.getMessage()+"</p>");
        }
    }
%>

</body>
</html>
