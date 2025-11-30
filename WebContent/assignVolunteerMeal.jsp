<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.Dbconnection" %>

<%
    Connection con = Dbconnection.connect();
    PreparedStatement ps = null;

    // ---------- ASSIGN VOLUNTEER LOGIC ----------
    if("true".equals(request.getParameter("assign"))) {
        int requestId = Integer.parseInt(request.getParameter("id"));
        int volunteerId = Integer.parseInt(request.getParameter("volunteer_id"));

        // Insert into meal_request_assignments
        ps = con.prepareStatement("INSERT INTO meal_request_assignments (request_id, volunteer_id) VALUES (?, ?)");
        ps.setInt(1, requestId);
        ps.setInt(2, volunteerId);
        ps.executeUpdate();

        // Update status in meal_requests
        ps = con.prepareStatement("UPDATE meal_requests SET status='Assigned' WHERE request_id=?");
        ps.setInt(1, requestId);
        ps.executeUpdate();

        out.println("<script>alert('Volunteer assigned successfully!'); window.location='admin_requests.jsp';</script>");
        return;
    }

    // ---------- FETCH REQUEST INFO ----------
    String idParam = request.getParameter("id");
    ResultSet requestData = null;
    if(idParam != null){
        ps = con.prepareStatement("SELECT r.*, n.name AS ngo_name FROM meal_requests r JOIN ngo n ON r.ngo_id=n.ngo_id WHERE r.request_id=?");
        ps.setInt(1,Integer.parseInt(idParam));
        requestData = ps.executeQuery();
    }

    // ---------- FETCH VOLUNTEERS ----------
    ResultSet volunteers = con.createStatement().executeQuery("SELECT * FROM volunteer");
%>

<!DOCTYPE html>
<html>
<head>
<title>Assign Volunteer</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
<style>
body { background:#f5f4ef; font-family:'Poppins',sans-serif; padding:20px; display:flex; justify-content:center; }
.assign-box { width:400px; background:white; padding:25px; border-radius:14px; box-shadow:0 5px 18px rgba(0,0,0,0.1); }
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
    if(requestData!=null && requestData.next()){
%>
<h2>Assign Volunteer</h2>
<p>Request ID: <%= requestData.getInt("request_id") %> | NGO: <%= requestData.getString("ngo_name") %></p>
<form action="assignVolunteerMeal.jsp" method="post">
    <input type="hidden" name="assign" value="true">
    <input type="hidden" name="id" value="<%= requestData.getInt("request_id") %>">

    <label>Select Volunteer:</label>
    <select name="volunteer_id" required>
    <option value="">--Select--</option>
    <%
        while(volunteers.next()){
    %>
        <option value="<%= volunteers.getInt("volunteer_id") %>"><%= volunteers.getString("name") %></option>
    <%
        }
    %>
    </select>

    <button type="submit">Assign Volunteer</button>
</form>
<%
    } else {
        out.println("<p>No request selected.</p>");
    }
%>
</div>
</body>
</html>
