<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.Dbconnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Donation Management | Admin</title>
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
.table-box { background:rgba(255,255,255,0.6); padding:25px; border-radius:20px; backdrop-filter:blur(12px); box-shadow:0 8px 25px rgba(0,0,0,0.08); }
table { width:100%; border-collapse:collapse; margin-top:10px; }
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

<div class="sidebar">
<h2>FoodShare Admin</h2>
<a href="adminDashboard.jsp">Dashboard</a>
<a href="admin_users.jsp">User Management</a>
<a href="admin_donations.jsp" style="background:#636e72;">Donation Management</a>
<a href="admin_requests.jsp">Meal Requests</a>
<a href="admin_events.jsp">Event Management</a>
</div>

<div class="content">
<h1>Donation Management</h1>

<!-- Status Filter -->
<div class="filter-box">
<form method="get">
<label>Filter by Status:</label>
<select name="status" onchange="this.form.submit()">
    <option value="">All</option>
    <option value="Waiting for volunteer" <%= "Waiting for volunteer".equals(request.getParameter("status"))?"selected":"" %>>Waiting</option>
    <option value="Volunteer assigned" <%= "Volunteer assigned".equals(request.getParameter("status"))?"selected":"" %>>Assigned</option>
    <option value="Delivered" <%= "Delivered".equals(request.getParameter("status"))?"selected":"" %>>Delivered</option>
</select>
</form>
</div>

<!-- Donations Table -->
<div class="table-box">
<table>
<thead>
<tr>
<th>ID</th>
<th>Donor</th>
<th>Food Name</th>
<th>Quantity</th>
<th>Prepared Time</th>
<th>Pickup Time</th>
<th>Status</th>
<th>Volunteer</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<%
try {
    Connection con = Dbconnection.connect();
    String query = "SELECT don.donation_id, d.name AS donor_name, don.food_name, don.quantity, don.prepared_time, don.pickup_time, don.status, v.name AS volunteer_name " +
                   "FROM donations don " +
                   "JOIN donor d ON don.donor_id = d.id " +
                   "LEFT JOIN volunteer v ON don.volunteer_id = v.volunteer_id";

    String statusFilter = request.getParameter("status");
    if(statusFilter != null && !statusFilter.isEmpty()){
        query += " WHERE don.status=?";
    }

    PreparedStatement ps = con.prepareStatement(query);
    if(statusFilter != null && !statusFilter.isEmpty()){
        ps.setString(1, statusFilter);
    }

    ResultSet rs = ps.executeQuery();
    while(rs.next()){
%>
<tr>
<td><%= rs.getInt("donation_id") %></td>
<td><%= rs.getString("donor_name") %></td>
<td><%= rs.getString("food_name") %></td>
<td><%= rs.getInt("quantity") %></td>
<td><%= rs.getString("prepared_time") %></td>
<td><%= rs.getString("pickup_time") %></td>
<td><%= rs.getString("status") %></td>
<td><%= rs.getString("volunteer_name") != null ? rs.getString("volunteer_name") : "-" %></td>
<td>
<div class="action-buttons">
<a href="editDonation.jsp?id=<%= rs.getInt("donation_id") %>" class="btn-edit">Edit</a>
<a href="deleteDonation.jsp?id=<%= rs.getInt("donation_id") %>" class="btn-delete" onclick="return confirm('Are you sure?');">Delete</a>
<a href="assignVolunteer.jsp?id=<%= rs.getInt("donation_id") %>" class="btn-assign">Assign Volunteer</a>
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
