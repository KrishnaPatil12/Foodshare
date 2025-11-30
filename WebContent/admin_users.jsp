<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.Dbconnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>User Management | Admin</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
    body {
        background: #f5f4ef;
        margin: 0;
        font-family: 'Poppins', sans-serif;
    }

    /* Sidebar */
    .sidebar {
        width: 250px;
        height: 100vh;
        background: #2d3436;
        color: white;
        padding: 25px;
        position: fixed;
    }

    .sidebar h2 {
        margin-bottom: 30px;
        font-size: 22px;
    }

    .sidebar a {
        color: #dfe6e9;
        text-decoration: none;
        display: block;
        margin: 12px 0;
        font-size: 16px;
        padding: 8px;
        border-radius: 8px;
    }

    .sidebar a:hover {
        background: #636e72;
    }

    /* Main content */
    .content {
        margin-left: 300px;
        padding: 30px;
    }

    h1 {
        font-size: 28px;
        margin-bottom: 20px;
        font-weight: 600;
    }

    /* Tabs */
    .tabs {
        display: flex;
        gap: 15px;
        margin-bottom: 25px;
    }

    .tab-btn {
        background: #7abec9;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 12px;
        cursor: pointer;
        font-size: 15px;
        font-weight: 500;
        transition: 0.3s;
    }

    .tab-btn:hover {
        background: #67aeb9;
    }

    /* Table Container */
    .table-box {
        background: rgba(255, 255, 255, 0.6);
        padding: 25px;
        border-radius: 20px;
        backdrop-filter: blur(12px);
        box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        margin-bottom: 30px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }

    th {
        background: #7abec9;
        color: white;
        padding: 12px;
        text-align: center;
        font-size: 15px;
    }

    td {
        padding: 10px;
        text-align: center;
        background: #ffffffd9;
        border-bottom: 1px solid #ddd;
    }

    tr:hover td {
        background: #e8f9fb;
    }

    /* Buttons */
    .btn-edit {
        background: #00b894;
        padding: 6px 14px;
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
    }

    .btn-delete {
        background: #d63031;
        padding: 6px 14px;
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
    }

    .btn-edit:hover { background: #019870; }
    .btn-delete:hover { background: #b02426; }
</style>

</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h2>FoodShare Admin</h2>
    <a href="adminDashboard.jsp">Dashboard</a>
    <a href="admin_users.jsp" style="background:#636e72;">User Management</a>
    <a href="admin_donations.jsp">Donation Management</a>
    <a href="admin_requests.jsp">Meal Requests</a>
    <a href="admin_events.jsp">Event Management</a>
</div>

<div class="content">

<h1>User Management</h1>

<div class="tabs">
    <button class="tab-btn" onclick="openTab('donors')">Donors</button>
    <button class="tab-btn" onclick="openTab('volunteers')">Volunteers</button>
    <button class="tab-btn" onclick="openTab('ngos')">NGOs</button>
</div>

<!-- DONORS TABLE -->
<div id="donors" class="table-box">
    <h2>Donors</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Location</th>
                <th>Contact</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <%
            try {
                Connection con = Dbconnection.connect();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM donor");
                ResultSet rs = ps.executeQuery();
                while(rs.next()){
        %>
            <tr>
                <td><%=rs.getInt("id")%></td>
                <td><%=rs.getString("name")%></td>
                <td><%=rs.getString("email")%></td>
                <td><%=rs.getString("location")%></td>
                <td><%=rs.getString("contactNo")%></td>
                <td>
                    <a href="editDonor.jsp?id=<%= rs.getInt("id") %>" class="btn-edit">Edit</a>
					<a href="deleteDonor.jsp?id=<%= rs.getInt("id") %>" class="btn-delete"
   									onclick="return confirm('Are you sure?');">Delete</a>
                                    </td>
            </tr>
        <%
                }
            } catch(Exception e){ out.println(e);}
        %>
        </tbody>
    </table>
</div>

<!-- VOLUNTEERS TABLE -->
<div id="volunteers" class="table-box" style="display:none;">
    <h2>Volunteers</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Age</th>
                <th>Contact</th>
                <th>Location</th>
                <th>Availability Days</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <%
            try {
                Connection con = Dbconnection.connect();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM volunteer");
                ResultSet rs = ps.executeQuery();
                while(rs.next()){
        %>
            <tr>
                <td><%=rs.getInt("volunteer_id")%></td>
                <td><%=rs.getString("name")%></td>
                <td><%=rs.getString("email")%></td>
                <td><%=rs.getInt("age")%></td>
                <td><%=rs.getString("contact")%></td>
                <td><%=rs.getString("location")%></td>
                <td><%=rs.getString("availability_days")%></td>
                <td><%=rs.getString("availability_start_time")%></td>
                <td><%=rs.getString("availability_end_time")%></td>
                <td>
                      <a href="editVolunteer.jsp?id=<%= rs.getInt("volunteer_id") %>" class="btn-edit">Edit</a>
<a href="deleteVolunteer.jsp?id=<%= rs.getInt("volunteer_id") %>" class="btn-delete"
    onclick="return confirm('Are you sure?');">Delete</a>
                      
                </td>
            </tr>
        <%
                }
            } catch(Exception e){ out.println(e);}
        %>
        </tbody>
    </table>
</div>

<!-- NGOS TABLE -->
<div id="ngos" class="table-box" style="display:none;">
    <h2>NGOs</h2>
    <table>
        <thead>
            <tr>
                <th>NGO ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Contact</th>
                <th>Location</th>
                <th>Created At</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <%
            try {
                Connection con = Dbconnection.connect();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM ngo");
                ResultSet rs = ps.executeQuery();
                while(rs.next()){
        %>
            <tr>
                <td><%=rs.getInt("ngo_id")%></td>
                <td><%=rs.getString("name")%></td>
                <td><%=rs.getString("email")%></td>
                <td><%=rs.getString("contact")%></td>
                <td><%=rs.getString("location")%></td>
                <td><%=rs.getString("created_at")%></td>
                <td>
                      <a href="editNgo.jsp?id=<%= rs.getInt("ngo_id") %>" class="btn-edit">Edit</a>
			<a href="deleteNgo.jsp?id=<%= rs.getInt("ngo_id") %>" class="btn-delete"
    onclick="return confirm('Are you sure?');">Delete</a>
                      
                </td>
            </tr>
        <%
                }
            } catch(Exception e){ out.println(e);}
        %>
        </tbody>
    </table>
</div>

</div>

<script>
function openTab(tabId){
    document.getElementById("donors").style.display = "none";
    document.getElementById("volunteers").style.display = "none";
    document.getElementById("ngos").style.display = "none";

    document.getElementById(tabId).style.display = "block";
}
</script>

</body>
</html>
