<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.Dbconnection" %>

<%
    Connection con = Dbconnection.connect();
    PreparedStatement ps = null;

    // ---------- UPDATE LOGIC ----------
    if ("true".equals(request.getParameter("update"))) {

        int id = Integer.parseInt(request.getParameter("event_id"));
        String eventName = request.getParameter("event_name");
        String eventDate = request.getParameter("event_date");
        String eventTime = request.getParameter("event_time");
        String location = request.getParameter("location");
        String description = request.getParameter("description");

        ps = con.prepareStatement(
            "UPDATE ngo_events SET event_name=?, event_date=?, event_time=?, location=?, description=? WHERE ngo_event_id=?"
        );

        ps.setString(1, eventName);
        ps.setString(2, eventDate);
        ps.setString(3, eventTime);
        ps.setString(4, location);
        ps.setString(5, description);
        ps.setInt(6, id);

        ps.executeUpdate();

        out.println("<script>alert('Event updated successfully!'); window.location='admin_events.jsp';</script>");
        return;
    }

    // ---------- FETCH DATA FOR EDIT ----------
    String idParam = request.getParameter("id");
    ResultSet eventData = null;

    if (idParam != null) {
        ps = con.prepareStatement("SELECT * FROM ngo_events WHERE ngo_event_id=?");
        ps.setInt(1, Integer.parseInt(idParam));
        eventData = ps.executeQuery();
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Event</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
body { background:#f5f4ef; font-family:'Poppins',sans-serif; padding:20px; display:flex; justify-content:center; }
.edit-box { width:420px; background:white; padding:25px; border-radius:14px; box-shadow:0 5px 18px rgba(0,0,0,0.1); }
h2 { text-align:center; color:#333; }
label { font-weight:600; margin-top:10px; display:block; }
input, textarea, select { width:100%; padding:10px; border-radius:8px; border:1px solid #ccc; margin-top:6px; font-size:14px; }
button { width:100%; padding:12px; margin-top:20px; border:none; background:#7abec9; color:white; border-radius:10px; font-size:15px; font-weight:600; cursor:pointer; }
button:hover { background:#67aeb9; }
</style>
</head>

<body>
<div class="edit-box">

<%
    if (eventData != null && eventData.next()) {
%>

<h2>Edit Event</h2>

<form action="editEvent.jsp" method="post">
    <input type="hidden" name="update" value="true">
    <input type="hidden" name="event_id" value="<%= eventData.getInt("ngo_event_id") %>">

    <label>Event Name:</label>
    <input type="text" name="event_name" value="<%= eventData.getString("event_name") %>" required>

    <label>Event Date:</label>
    <input type="date" name="event_date" value="<%= eventData.getString("event_date") %>" required>

    <label>Event Time:</label>
    <input type="time" name="event_time" value="<%= eventData.getString("event_time") %>" required>

    <label>Location:</label>
    <input type="text" name="location" value="<%= eventData.getString("location") %>">

    <label>Description:</label>
    <textarea name="description" rows="3"><%= eventData.getString("description") %></textarea>

    <button type="submit">Update Event</button>
</form>

<%
    } else {
        out.println("<p>No event found.</p>");
    }
%>

</div>
</body>
</html>
