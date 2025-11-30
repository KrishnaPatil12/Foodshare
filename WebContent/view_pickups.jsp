<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.Dbconnection" %>

<!DOCTYPE html>
<html>
<head>
<title>Pickup Records</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: #f5f4ef;
        padding: 25px;
        margin: 0;
    }

    h2 {
        text-align: center;
        color: #333;
        font-weight: 600;
        margin-bottom: 25px;
    }

    table {
        width: 92%;
        margin: auto;
        background: white;
        border-collapse: collapse;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 4px 18px rgba(0,0,0,0.1);
    }

    th, td {
        padding: 14px;
        text-align: center;
        border-bottom: 1px solid #ddd;
        color: #333;
    }

    th {
        background: #7abec9;
        color: white;
        font-weight: 600;
        font-size: 15px;
    }

    tr:hover {
        background: #e8f6f8;
    }

    img {
        width: 110px;
        height: auto;
        border-radius: 8px;
        object-fit: contain;
        background: #fafafa;
        padding: 4px;
        border: 1px solid #ccc;
    }
</style>
</head>

<body>

<h2>Volunteer Pickup Records</h2>

<table>
<tr>
    <th>Task ID</th>
    <th>Volunteer ID</th>
    <th>Food Item</th>
    <th>Quantity</th>
    <th>Pickup Time</th>
    <th>Pickup Image</th>
    <th>Status</th>
</tr>

<%
Connection con = Dbconnection.connect();
PreparedStatement ps = con.prepareStatement(
    "SELECT task_id, volunteer_id, food_item, quantity, pickup_time, task_status " +
    "FROM volunteer_tasks WHERE pickup_image_path IS NOT NULL ORDER BY task_id DESC"
);
ResultSet rs = ps.executeQuery();

while(rs.next()) {
%>

<tr>
    <td><%= rs.getInt("task_id") %></td>
    <td><%= rs.getInt("volunteer_id") %></td>
    <td><%= rs.getString("food_item") %></td>
    <td><%= rs.getString("quantity") %></td>
    <td><%= rs.getString("pickup_time") %></td>

    <!-- FIXED IMAGE DISPLAY -->
    <td>
        <img src="DisplayPickupImage?task_id=<%= rs.getInt("task_id") %>" alt="Pickup Image">
    </td>

    <td><%= rs.getString("task_status") %></td>
</tr>

<% } con.close(); %>

</table>

</body>
</html>
