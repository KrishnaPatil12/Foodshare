<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Donor Details | FoodShare</title>

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

    a.back {
        display: block;
        text-align: center;
        margin-top: 20px;
        font-weight: 600;
        color: #006d77;
        text-decoration: none;
    }

    a.back:hover {
        text-decoration: underline;
    }
</style>

</head>
<body>

<%
String donorIdStr = request.getParameter("donorId");
if(donorIdStr == null){
    response.sendRedirect("view_donors.jsp");
    return;
}

int donorId = Integer.parseInt(donorIdStr);

Connection con = Dbconnection.connect();

// fetch donor name
PreparedStatement psDonor = con.prepareStatement(
    "SELECT name FROM donor WHERE id=?"
);
psDonor.setInt(1, donorId);
ResultSet rsDonor = psDonor.executeQuery();

String donorName = "";
if(rsDonor.next()){
    donorName = rsDonor.getString("name");
}
rsDonor.close();
psDonor.close();
%>

<h2>Donations by <%= donorName %></h2>

<table>
<tr>
    <th>Donation ID</th>
    <th>Food</th>
    <th>Quantity</th>
    <th>Prepared Time</th>
    <th>Pickup Time</th>
    <th>Status</th>
</tr>

<%
PreparedStatement psDon = con.prepareStatement(
    "SELECT * FROM donations WHERE donor_id=? ORDER BY donation_id DESC"
);
psDon.setInt(1, donorId);
ResultSet rs = psDon.executeQuery();

while(rs.next()){
    String status = rs.getString("status");
    String statusClass = "waiting";

    if(status.equalsIgnoreCase("Volunteer assigned")) statusClass = "assigned";
    else if(status.equalsIgnoreCase("Picked up")) statusClass = "picked";
    else if(status.equalsIgnoreCase("Delivered")) statusClass = "delivered";
%>

<tr>
    <td><%= rs.getInt("donation_id") %></td>
    <td><%= rs.getString("food_name") %></td>
    <td><%= rs.getString("quantity") %></td>
    <td><%= rs.getString("prepared_time") %></td>
    <td><%= rs.getString("pickup_time") %></td>
    <td><span class="status <%= statusClass %>"><%= status %></span></td>
</tr>

<%
}
rs.close();
psDon.close();
con.close();
%>
</table>

<a class="back" href="view_donors.jsp">← Back to Donors List</a>

</body>
</html>
