<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.Dbconnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Event Management | Admin</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
<style>
body { background:#f5f4ef; margin:0; font-family:'Poppins',sans-serif; }

/* Sidebar */
.sidebar { width:250px; height:100vh; background:#2d3436; color:white; padding:25px; position:fixed; }
.sidebar h2 { margin-bottom:30px; font-size:22px; }
.sidebar a { color:#dfe6e9; text-decoration:none; display:block; margin:12px 0; padding:8px; border-radius:8px; }
.sidebar a:hover { background:#636e72; }

/* Content */
.content { margin-left:300px; padding:30px; }
h1 { font-size:28px; margin-bottom:20px; font-weight:600; }

/* Filter box */
.filter-box { margin-bottom:20px; background:#ffffffb8; padding:15px; border-radius:12px;
              box-shadow:0 6px 15px rgba(0,0,0,0.08); display:flex; gap:20px; align-items:center; }
.filter-box select, .filter-box input {
    padding:8px 12px; border-radius:8px; border:1px solid #ccc; font-size:14px;
}

/* Table */
.table-box { background:rgba(255,255,255,0.6); padding:25px; border-radius:20px;
             backdrop-filter:blur(12px); box-shadow:0 8px 25px rgba(0,0,0,0.08); overflow-x:auto; }
table { width:100%; border-collapse:collapse; margin-top:10px; min-width:900px; }
th { background:#7abec9; color:white; padding:12px; text-align:center; font-size:15px; }
td { padding:10px; text-align:center; background:#ffffffd9; border-bottom:1px solid #ddd; }
tr:hover td { background:#e8f9fb; }

/* Buttons */
.action-buttons { display:flex; justify-content:center; gap:8px; }
.btn-edit { background:#00b894; padding:6px 10px; color:white; border:none; border-radius:8px; cursor:pointer; font-size:13px; }
.btn-delete { background:#d63031; padding:6px 10px; color:white; border:none; border-radius:8px; cursor:pointer; font-size:13px; }
.btn-assign { background:#0984e3; padding:6px 10px; color:white; border:none; border-radius:8px; cursor:pointer; font-size:13px; }
.btn-edit:hover { background:#019870; }
.btn-delete:hover { background:#b02426; }
.btn-assign:hover { background:#0652dd; }
</style>
</head>

<body>

<!-- Sidebar -->
<div class="sidebar">
<h2>FoodShare Admin</h2>
<a href="adminDashboard.jsp">Dashboard</a>
<a href="admin_users.jsp">User Management</a>
<a href="admin_donations.jsp">Donation Management</a>
<a href="admin_requests.jsp">Meal Requests</a>
<a href="admin_events.jsp" style="background:#636e72;">Event Management</a>
</div>

<!-- Main Content -->
<div class="content">
<h1>Event Management</h1>

<!-- FILTERS -->
<div class="filter-box">
<form method="get" style="display:flex; gap:20px;">

<!-- Filter by NGO -->
<select name="ngo" onchange="this.form.submit()">
    <option value="">All NGOs</option>
<%
Connection conFilter = Dbconnection.connect();
PreparedStatement psNgo = conFilter.prepareStatement("SELECT ngo_id, name FROM ngo");
ResultSet rsNgo = psNgo.executeQuery();
String ngoFilter = request.getParameter("ngo");

while(rsNgo.next()) {
%>
    <option value="<%= rsNgo.getInt("ngo_id") %>" 
        <%= (ngoFilter != null && ngoFilter.equals(rsNgo.getInt("ngo_id")+"")) ? "selected" : "" %>>
        <%= rsNgo.getString("name") %>
    </option>
<%
}
%>
</select>

<!-- Filter by Event Date -->
<input type="date" name="date" value="<%= request.getParameter("date") != null ? request.getParameter("date") : "" %>"
       onchange="this.form.submit()">

<!-- Filter by Event Name -->
<select name="eventName" onchange="this.form.submit()">
    <option value="">All Event Types</option>
    <option value="Food Drive" <%= "Food Drive".equals(request.getParameter("eventName")) ? "selected" : "" %>>Food Drive</option>
    <option value="Distribution Camp" <%= "Distribution Camp".equals(request.getParameter("eventName")) ? "selected" : "" %>>Distribution Camp</option>
    <option value="Awareness Program" <%= "Awareness Program".equals(request.getParameter("eventName")) ? "selected" : "" %>>Awareness Program</option>
</select>

</form>
</div>

<div class="table-box">
<table>
<thead>
<tr>
<th>Event ID</th>
<th>NGO</th>
<th>Event Name</th>
<th>Date</th>
<th>Time</th>
<th>Location</th>
<th>Description</th>
<th>Actions</th>
</tr>
</thead>

<tbody>
<%
try {
    Connection con = Dbconnection.connect();

    String baseQuery =
        "SELECT e.ngo_event_id, n.name AS ngo_name, e.event_name, e.event_date, e.event_time, " +
        "e.location, e.description FROM ngo_events e " +
        "JOIN ngo n ON e.ngo_id = n.ngo_id WHERE 1=1 ";

    String ngoParam = request.getParameter("ngo");
    String dateParam = request.getParameter("date");
    String eventParam = request.getParameter("eventName");

    if (ngoParam != null && !ngoParam.isEmpty()) baseQuery += " AND e.ngo_id = " + ngoParam + " ";
    if (dateParam != null && !dateParam.isEmpty()) baseQuery += " AND e.event_date = '" + dateParam + "' ";
    if (eventParam != null && !eventParam.isEmpty()) baseQuery += " AND e.event_name = '" + eventParam + "' ";

    PreparedStatement ps = con.prepareStatement(baseQuery);
    ResultSet rs = ps.executeQuery();

    while(rs.next()){
%>

<tr>
<td><%= rs.getInt("ngo_event_id") %></td>
<td><%= rs.getString("ngo_name") %></td>
<td><%= rs.getString("event_name") %></td>
<td><%= rs.getString("event_date") %></td>
<td><%= rs.getString("event_time") %></td>
<td><%= rs.getString("location") %></td>
<td><%= rs.getString("description") %></td>

<td>
<div class="action-buttons">
    <a href="editEvent.jsp?id=<%= rs.getInt("ngo_event_id") %>" class="btn-edit">Edit</a>
    <a href="deleteEvent.jsp?id=<%= rs.getInt("ngo_event_id") %>" class="btn-delete" onclick="return confirm('Are you sure?');">Delete</a>
    <a href="assignVolunteerEvent.jsp?id=<%= rs.getInt("ngo_event_id") %>" class="btn-assign">Assign Volunteer</a>
    
    
</div>
</td>
</tr>

<%
    }
} catch(Exception e){
    out.println("Error: " + e);
}
%>

</tbody>
</table>
</div>

</div>
</body>
</html>
