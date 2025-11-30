<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Donors | FoodShare</title>

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

    a.view-link {
        color: #006d77;
        font-weight: 600;
        text-decoration: none;
    }

    a.view-link:hover {
        text-decoration: underline;
    }
</style>

</head>
<body>

<h2>Donors List</h2>

<table>
<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Email</th>
    <th>Contact</th>
    <th>Location</th>
    <th>Total Donations</th>
    <th>View</th>
</tr>

<%
Connection con = Dbconnection.connect();

PreparedStatement ps = con.prepareStatement("SELECT * FROM donor");
ResultSet rs = ps.executeQuery();

while(rs.next()){
    int donorId = rs.getInt("id");
    String name = rs.getString("name");
    String email = rs.getString("email");
    String contact = rs.getString("contactNo");
    String location = rs.getString("location");

    // Count donations by this donor
    PreparedStatement psCount = con.prepareStatement(
        "SELECT COUNT(*) AS total FROM donations WHERE donor_id=?"
    );
    psCount.setInt(1, donorId);
    ResultSet rsCount = psCount.executeQuery();
    int totalDonations = 0;
    if(rsCount.next()) totalDonations = rsCount.getInt("total");
    rsCount.close();
    psCount.close();
%>

<tr>
    <td><%= donorId %></td>
    <td><%= name %></td>
    <td><%= email %></td>
    <td><%= contact %></td>
    <td><%= location %></td>
    <td><%= totalDonations %></td>
    <td>
        <a class="view-link" href="view_donor_details.jsp?donorId=<%= donorId %>">
            View Details
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
