<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>

<!DOCTYPE html>
<html>
<head>
<title>Your Accepted Tasks</title>

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
        margin-bottom: 22px;
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

    /* Button styling */
    .upload-btn {
        background: #7abec9;
        color: white;
        border: none;
        padding: 8px 14px;
        border-radius: 8px;
        cursor: pointer;
        font-size: 14px;
        transition: 0.3s;
        font-weight: 500;
    }

    .upload-btn:hover {
        background: #5daab6;
    }

    .status {
        font-weight: 600;
        padding: 8px 12px;
        border-radius: 8px;
        display: inline-block;
    }

    .waiting { background: #ffe7aa; color: #a56900; }
    .assigned { background: #cde9ff; color: #005b96; }
    .picked { background: #fde2d7; color: #b04100; }
    .delivered { background: #d9f7c8; color: #2f6b00; }
</style>

</head>
<body>

<h2>Your Accepted Tasks</h2>

<table>
<tr>
    <th>Task ID</th>
    <th>Food Item</th>
    <th>Quantity</th>

    <th>Status</th>
    <th>Action</th>
</tr>

<%
    int volunteerId = Getset.getId();

    Connection con = Dbconnection.connect();
    PreparedStatement ps = con.prepareStatement(
        "SELECT task_id, food_item, quantity, pickup_address, task_status " +
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
    <td>
        <span class="status <%= status.toLowerCase().replace(" ", "") %>">
            <%= status %>
        </span>
    </td>
    <td>
        <form action="upload_pickup.jsp" method="get" style="margin:0;">
            <input type="hidden" name="task_id" value="<%= tid %>">
            <button class="upload-btn">Upload Image</button>
        </form>
    </td>
</tr>

<%
    }
    con.close();
%>

</table>

</body>
</html>
