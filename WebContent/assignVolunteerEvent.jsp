<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.Dbconnection" %>

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet eventData = null;
    ResultSet volunteers = null;

    try {
        con = Dbconnection.connect();

        // ---------- ASSIGN VOLUNTEER TO EVENT ----------
        if ("true".equals(request.getParameter("assign"))) {

            int eventId = Integer.parseInt(request.getParameter("event_id"));
            int volunteerId = Integer.parseInt(request.getParameter("volunteer_id"));

            ps = con.prepareStatement(
                "INSERT INTO event_assignments (ngo_event_id, volunteer_id) VALUES (?, ?)"
            );
            ps.setInt(1, eventId);
            ps.setInt(2, volunteerId);
            ps.executeUpdate();
            ps.close();

            out.println("<script>alert('Volunteer assigned successfully!'); window.location='admin_events.jsp';</script>");
            return;
        }

        // ---------- FETCH EVENT ----------
        String idParam = request.getParameter("id");
        if (idParam != null) {
            ps = con.prepareStatement(
                "SELECT e.*, n.name AS ngo_name FROM ngo_events e JOIN ngo n ON e.ngo_id=n.ngo_id WHERE e.ngo_event_id=?"
            );
            ps.setInt(1, Integer.parseInt(idParam));
            eventData = ps.executeQuery();
        }

        // ---------- FETCH VOLUNTEERS (CORRECT TABLE NAME) ----------
        volunteers = con.createStatement().executeQuery(
            "SELECT volunteer_id, name FROM volunteer"
        );

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Assign Volunteer to Event</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
<style>
body { background:#f5f4ef; font-family:'Poppins',sans-serif; padding:20px; display:flex; justify-content:center; }
.assign-box { width:420px; background:white; padding:25px; border-radius:14px; box-shadow:0 5px 18px rgba(0,0,0,0.1); }
h2 { text-align:center; color:#333; }
label { font-weight:600; margin-top:10px; display:block; }
select { width:100%; padding:10px; border-radius:8px; border:1px solid #ccc; margin-top:6px; font-size:14px; }
button { width:100%; padding:12px; margin-top:20px; border:none; background:#7abec9; color:white; border-radius:10px; font-size:15px; font-weight:600; cursor:pointer; }
button:hover { background:#67aeb9; }
</style>
</head>
<body>

<div class="assign-box">
<%
    if (eventData != null && eventData.next()) {
%>

<h2>Assign Volunteer</h2>

<p>
<b>Event:</b> <%= eventData.getString("event_name") %><br>
<b>NGO:</b> <%= eventData.getString("ngo_name") %><br>
<b>Date:</b> <%= eventData.getString("event_date") %>
</p>

<form action="assignVolunteerEvent.jsp" method="post">
    <input type="hidden" name="assign" value="true">
    <input type="hidden" name="event_id" value="<%= eventData.getInt("ngo_event_id") %>">

    <label>Select Volunteer:</label>
    <select name="volunteer_id" required>
        <option value="">-- Select Volunteer --</option>

        <%
            if (volunteers != null) {
                while (volunteers.next()) {
        %>
                    <option value="<%= volunteers.getInt("volunteer_id") %>">
                        <%= volunteers.getString("name") %>
                    </option>
        <%
                }
            }
        %>
    </select>

    <button type="submit">Assign Volunteer</button>
</form>

<%
    } else {
        out.println("<p>No event selected.</p>");
    }
%>
</div>

</body>
</html>
