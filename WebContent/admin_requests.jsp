<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.Dbconnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Meal Requests | Admin</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
<style>
body { background:#f5f4ef; margin:0; font-family:'Poppins',sans-serif; }

/* Sidebar */
.sidebar { width:250px; height:100vh; background:#2d3436; color:white; padding:25px; position:fixed; }
.sidebar h2 { margin-bottom:30px; font-size:22px; }
.sidebar a { color:#dfe6e9; text-decoration:none; display:block; margin:12px 0; padding:8px; border-radius:8px; }
.sidebar a:hover { background:#636e72; }

/* Main content */
.content { margin-left:300px; padding:30px; }
h1 { font-size:28px; margin-bottom:20px; font-weight:600; }

/* Filter */
.filter-box { margin-bottom:20px; }
.filter-box select { padding:8px 12px; border-radius:8px; border:1px solid #ccc; font-size:14px; }

/* Table container */
.table-box { background:rgba(255,255,255,0.6); padding:25px; border-radius:20px; backdrop-filter:blur(12px); box-shadow:0 8px 25px rgba(0,0,0,0.08); overflow-x:auto; }
table { width:100%; border-collapse:collapse; margin-top:10px; min-width:900px; }
th { background:#7abec9; color:white; padding:12px; text-align:center; font-size:15px; }
td { padding:10px; text-align:center; background:#ffffffd9; border-bottom:1px solid #ddd; vertical-align:middle; }
tr:hover td { background:#e8f9fb; }

/* Buttons */
.action-buttons { display:flex; justify-content:center; gap:8px; flex-wrap:wrap; }
.btn-edit { background:#00b894; padding:6px 10px; color:white; border:none; border-radius:8px; cursor:pointer; font-size:13px; }
.btn-delete { background:#d63031; padding:6px 10px; color:white; border:none; border-radius:8px; cursor:pointer; font-size:13px; }
.btn-assign { background:#0984e3; padding:6px 10px; color:white; border:none; border-radius:8px; cursor:pointer; font-size:13px; }
.btn-edit:hover { background:#019870; }
.btn-delete:hover { background:#b02426; }
.btn-assign:hover { background:#0652dd; }
</style>
</head>
<body>

<div class="sidebar">
<h2>FoodShare Admin</h2>
<a href="adminDashboard.jsp">Dashboard</a>
<a href="admin_users.jsp">User Management</a>
<a href="admin_donations.jsp">Donation Management</a>
<a href="admin_requests.jsp" style="background:#636e72;">Meal Requests</a>
<a href="admin_events.jsp">Event Management</a>
</div>

<div class="content">
<h1>Meal Requests</h1>

<!-- Status Filter -->
<div class="filter-box">
<form method="get">
<label>Filter by Status:</label>
<select name="status" onchange="this.form.submit()">
    <option value="">All</option>
    <option value="Pending" <%= "Pending".equals(request.getParameter("status"))?"selected":"" %>>Pending</option>
    <option value="Assigned" <%= "Assigned".equals(request.getParameter("status"))?"selected":"" %>>Assigned</option>
    <option value="Delivered" <%= "Delivered".equals(request.getParameter("status"))?"selected":"" %>>Delivered</option>
</select>
</form>
</div>

<!-- Meal Requests Table -->
<div class="table-box">
<table>
<thead>
<tr>
<th>ID</th>
<th>NGO</th>
<th>Meal Type</th>
<th>Quantity</th>
<th>Urgency</th>
<th>Message</th>
<th>Request Time</th>
<th>Status</th>
<th>Donation ID</th>
<th>Assigned Volunteer</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<%
try {
    Connection con = Dbconnection.connect();
    String query = "SELECT r.request_id, n.name AS ngo_name, r.meal_type, r.quantity, r.urgency, r.message, r.request_time, r.status, r.donation_id, " +
                   "v.name AS volunteer_name " +
                   "FROM meal_requests r " +
                   "JOIN ngo n ON r.ngo_id = n.ngo_id " +
                   "LEFT JOIN meal_request_assignments mra ON r.request_id = mra.request_id " +
                   "LEFT JOIN volunteer v ON mra.volunteer_id = v.volunteer_id " +
                   "WHERE (? IS NULL OR r.status=?)";

    PreparedStatement ps = con.prepareStatement(query);
    String statusFilter = request.getParameter("status");
    ps.setString(1, (statusFilter != null && !statusFilter.isEmpty()) ? statusFilter : null);
    ps.setString(2, (statusFilter != null && !statusFilter.isEmpty()) ? statusFilter : null);

    ResultSet rs = ps.executeQuery();
    while(rs.next()){
%>
<tr>
<td><%= rs.getInt("request_id") %></td>
<td><%= rs.getString("ngo_name") %></td>
<td><%= rs.getString("meal_type") %></td>
<td><%= rs.getString("quantity") %></td>
<td><%= rs.getString("urgency") %></td>
<td><%= rs.getString("message") %></td>
<td><%= rs.getTimestamp("request_time") %></td>
<td><%= rs.getString("status") %></td>
<td><%= rs.getString("donation_id") != null ? rs.getString("donation_id") : "-" %></td>
<td><%= rs.getString("volunteer_name") != null ? rs.getString("volunteer_name") : "-" %></td>
<td>
<div class="action-buttons">
<a href="editMealRequests.jsp?id=<%= rs.getInt("request_id") %>" class="btn-edit">Edit</a>
<a href="deleteMealRequests.jsp?id=<%= rs.getInt("request_id") %>" class="btn-delete" onclick="return confirm('Are you sure?');">Delete</a>
<a href="assignVolunteerMeal.jsp?id=<%= rs.getInt("request_id") %>" class="btn-assign">Assign Volunteer</a>
</div>
</td>
</tr>
<%
    }
} catch(Exception e){ out.println(e); }
%>
</tbody>
</table>
</div>

</div>
</body>
</html>
