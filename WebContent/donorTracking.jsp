<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>

<!DOCTYPE html>
<html>
<head>
<title>Track Your Donations</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
    body {
        margin: 0;
        padding: 20px;
        font-family: 'Poppins', sans-serif;
        background: #f5f4ef;
    }

    h2 {
        text-align: center;
        margin-bottom: 20px;
        color: #333;
    }

    table {
        width: 90%;
        margin: auto;
        border-collapse: collapse;
        background: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }

    th, td {
        padding: 14px;
        text-align: center;
        border-bottom: 1px solid #ddd;
        font-size: 15px;
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

</style>

<!-- Auto-refresh every 6 seconds -->
<meta http-equiv="refresh" content="6">

</head>
<body>

<h2>Your Donation Status</h2>

<table>
<tr>
    <th>Food</th>
    <th>Quantity</th>
    <th>Prepared Time</th>
    <th>Pickup Time</th>
    <th>Status</th>
</tr>

<%
Connection con = Dbconnection.connect();
int donorId = Getset.getId();  // Donor session ID

PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM donations WHERE donor_id=? ORDER BY donation_id DESC"
);
ps.setInt(1, donorId);
ResultSet rs = ps.executeQuery();

while(rs.next()) {
    String status = rs.getString("status");
    String statusClass = "";

    if(status.equals("Waiting for volunteer")) statusClass = "waiting";
    else if(status.equals("Volunteer assigned")) statusClass = "assigned";
    else if(status.equals("Picked up")) statusClass = "picked";
    else if(status.equals("Delivered")) statusClass = "delivered";
%>

<tr>
    <td><%= rs.getString("food_name") %></td>
    <td><%= rs.getString("quantity") %></td>
    <td><%= rs.getString("prepared_time") %></td>
    <td><%= rs.getString("pickup_time") %></td>
    <td><span class="status <%= statusClass %>"><%= status %></span></td>
</tr>

<% } %>

</table>

</body>
</html>
