<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>

<!DOCTYPE html>
<html>
<head>
<title>Your Delivery Tasks</title>
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
        margin-bottom: 25px;
        color: #333;
        font-weight: 600;
    }

    table {
        width: 90%;
        margin: auto;
        border-collapse: collapse;
        background: white;
        border-radius: 12px;
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
        font-weight: 600;
    }

    tr:hover {
        background: #f0f9fa;
    }

    .upload-btn {
        background: #7abec9;
        color: white;
        border: none;
        padding: 8px 14px;
        border-radius: 8px;
        cursor: pointer;
        font-size: 14px;
        font-weight: 500;
        transition: 0.3s;
    }

    .upload-btn:hover {
        background: #5daab6;
    }

    img {
        width: 90px;
        height: auto;
        border-radius: 5px;
    }

    .status {
        font-weight: 600;
        padding: 8px 12px;
        border-radius: 8px;
        display: inline-block;
    }

    .assigned { background: #cde9ff; color: #005b96; }
    .picked { background: #fde2d7; color: #b04100; }
    .delivered { background: #d9f7c8; color: #2f6b00; }
</style>
</head>
<body>

<h2>Your Delivery Tasks</h2>

<table>
<tr>
    <th>Task ID</th>
    <th>Food Item</th>
    <th>Quantity</th>
    <th>Pickup Time</th>
    <th>Delivery Status</th>

    <th>Action</th>
</tr>

<%
    int volunteerId = Getset.getId();

    Connection con = Dbconnection.connect();
    PreparedStatement ps = con.prepareStatement(
        "SELECT task_id, food_item, quantity, pickup_time, task_status, delivery_image_path " +
        "FROM volunteer_tasks WHERE volunteer_id=? ORDER BY task_id DESC"
    );
    ps.setInt(1, volunteerId);
    ResultSet rs = ps.executeQuery();

    while(rs.next()) {
        int tid = rs.getInt("task_id");
        String status = rs.getString("task_status");
%>

<tr>
    <td><%= tid %></td>
    <td><%= rs.getString("food_item") %></td>
    <td><%= rs.getString("quantity") %></td>
    <td><%= rs.getString("pickup_time") %></td>
    <td>
        <span class="status <%= status.toLowerCase().replace(" ", "") %>">
            <%= status %>
        </span>
    </td>

    <td>
        <% if(rs.getBlob("delivery_image_path") == null) { %>
        <form action="upload_delivery.jsp" method="get" style="margin:0;">
            <input type="hidden" name="task_id" value="<%= tid %>">
            <button class="upload-btn">Upload Delivery</button>
        </form>
        <% } else { %>
            Uploaded
        <% } %>
    </td>
</tr>

<%
    }
    con.close();
%>

</table>

</body>
</html>
