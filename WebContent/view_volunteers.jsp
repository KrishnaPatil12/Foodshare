<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Volunteers | FoodShare</title>

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

    .btn-view {
        padding: 8px 14px;
        background: #7abec9;
        color: white;
        border-radius: 6px;
        text-decoration: none;
        font-weight: 600;
    }

    .btn-view:hover {
        background: #5ba8b2;
    }
</style>

</head>
<body>

<h2>Volunteer List</h2>

<%
Connection con = Dbconnection.connect();

PreparedStatement ps = con.prepareStatement(
    "SELECT v.volunteer_id, v.name, v.email, v.contact, v.location, " +
    "(SELECT COUNT(*) FROM volunteer_tasks t WHERE t.volunteer_id = v.volunteer_id AND t.task_status='DELIVERED') AS completed " +
    "FROM volunteer v ORDER BY volunteer_id DESC"
);

ResultSet rs = ps.executeQuery();
%>

<table>
    <tr>
        <th>Name</th>
        <th>Email</th>
        <th>Contact</th>
        <th>Location</th>
        <th>Completed Tasks</th>
        <th>Action</th>
    </tr>

<%
while(rs.next()){
%>
    <tr>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getString("contact") %></td>
        <td><%= rs.getString("location") %></td>
        <td><%= rs.getInt("completed") %></td>
        <td>
            <a class="btn-view" href="view_volunteer_details.jsp?volunteerId=<%= rs.getInt("volunteer_id") %>">
                View
            </a>
        </td>
    </tr>
<%
}
rs.close();
ps.close();
con.close();
%>

</table>

</body>
</html>
