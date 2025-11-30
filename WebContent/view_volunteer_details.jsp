<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Volunteer Details | FoodShare</title>

<style>
    body {
        margin: 0;
        padding: 20px;
        font-family: 'Poppins', sans-serif;
        background: #f5f4ef;
    }

    .card {
        width: 90%;
        margin: auto;
        background: white;
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }

    h2, h3 {
        text-align: center;
        color: #333;
    }

    .info p {
        font-size: 16px;
        margin: 6px 0;
    }

    table {
        width: 100%;
        margin-top: 20px;
        border-collapse: collapse;
        background: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    }

    th, td {
        padding: 14px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }

    th {
        background: #7abec9;
        color: white;
    }

    tr:hover {
        background: #f0f9fa;
    }

    .status {
        font-weight: 600;
        padding: 8px 12px;
        border-radius: 8px;
    }

    .waiting { background: #ffe7aa; color: #a56900; }
    .assigned { background: #cde9ff; color: #005b96; }
    .picked { background: #fde2d7; color: #b04100; }
    .delivered { background: #d9f7c8; color: #2f6b00; }

    .back {
        display: block;
        margin-top: 20px;
        text-align: center;
        color: #333;
        font-weight: 600;
        text-decoration: none;
    }
</style>

</head>
<body>

<%
String idStr = request.getParameter("volunteerId");
if(idStr == null){
    response.sendRedirect("view_volunteers.jsp");
    return;
}

int volunteerId = Integer.parseInt(idStr);

Connection con = Dbconnection.connect();

// Fetch volunteer info
PreparedStatement ps = con.prepareStatement("SELECT * FROM volunteer WHERE volunteer_id=?");
ps.setInt(1, volunteerId);
ResultSet rs = ps.executeQuery();

String name="", email="", contact="", location="", days="", start="", end="";
int age = 0;

if(rs.next()){
    name = rs.getString("name");
    email = rs.getString("email");
    contact = rs.getString("contact");
    age = rs.getInt("age");
    location = rs.getString("location");
    days = rs.getString("availability_days");
    start = rs.getString("availability_start_time");
    end = rs.getString("availability_end_time");
}
rs.close();
ps.close();
%>

<div class="card">

<h2>Volunteer Profile</h2>

<div class="info">
    <p><strong>Name:</strong> <%= name %></p>
    <p><strong>Email:</strong> <%= email %></p>
    <p><strong>Contact:</strong> <%= contact %></p>
    <p><strong>Age:</strong> <%= age %></p>
    <p><strong>Location:</strong> <%= location %></p>
    <p><strong>Available Days:</strong> <%= days %></p>
    <p><strong>Available Time:</strong> <%= start %> - <%= end %></p>
</div>

<h3>Task History</h3>

<%
PreparedStatement ps2 = con.prepareStatement(
    "SELECT * FROM volunteer_tasks WHERE volunteer_id=? ORDER BY task_id DESC"
);
ps2.setInt(1, volunteerId);
ResultSet rs2 = ps2.executeQuery();
%>

<table>
    <tr>
        <th>Food Item</th>
        <th>Quantity</th>
        <th>Pickup Address</th>
        <th>NGO Address</th>
        <th>Status</th>
        <th>Assigned</th>
        <th>Pickup</th>
        <th>Delivered</th>
    </tr>

<%
while(rs2.next()){
    String status = rs2.getString("task_status");
    String statusClass = "waiting";

    if(status.equalsIgnoreCase("ASSIGNED")) statusClass="assigned";
    else if(status.equalsIgnoreCase("PICKED")) statusClass="picked";
    else if(status.equalsIgnoreCase("DELIVERED")) statusClass="delivered";
%>

    <tr>
        <td><%= rs2.getString("food_item") %></td>
        <td><%= rs2.getString("quantity") %></td>
        <td><%= rs2.getString("pickup_address") %></td>
        <td><%= rs2.getString("ngo_address") %></td>
        <td><span class="status <%=statusClass%>"><%= status %></span></td>
        <td><%= rs2.getString("assigned_time") %></td>
        <td><%= rs2.getString("pickup_time") %></td>
        <td><%= rs2.getString("delivery_time") %></td>
    </tr>

<%
}
rs2.close();
ps2.close();
con.close();
%>

</table>

<a href="view_volunteers.jsp" class="back">← Back to Volunteers</a>

</div>

</body>
</html>
