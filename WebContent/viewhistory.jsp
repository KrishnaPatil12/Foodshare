<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Meal Request History | NGO</title>

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
        padding: 6px 10px;
        border-radius: 8px;
    }

    .pending { background: #ffe7aa; color: #a56900; }
    .approved { background: #cde9ff; color: #005b96; }
    .rejected { background: #fde2d7; color: #b04100; }
</style>

</head>
<body>

<h2>Meal Request History</h2>

<table>
    <tr>
        <th>Request ID</th>
        <th>Meal Type</th>
        <th>Quantity</th>
        <th>Urgency</th>
        <th>Message</th>
        <th>Donation ID</th>
        <th>Request Time</th>
        <th>Status</th>
    </tr>

<%
Integer ngoId = Getset.getId();
Connection con = Dbconnection.connect();

PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM meal_requests WHERE ngo_id=? ORDER BY request_time DESC"
);
ps.setInt(1, ngoId);

ResultSet rs = ps.executeQuery();

while(rs.next()){
    int requestId = rs.getInt("request_id");
    String mealType = rs.getString("meal_type");
    String quantity = rs.getString("quantity");
    String urgency = rs.getString("urgency");
    String message = rs.getString("message");
    String donationId = rs.getString("donation_id");
    Timestamp requestTime = rs.getTimestamp("request_time");
    String status = rs.getString("status");

    String statusClass = "pending";
    if(status != null){
        if(status.equalsIgnoreCase("Approved")) statusClass="approved";
        else if(status.equalsIgnoreCase("Rejected")) statusClass="rejected";
    }
%>
    <tr>
        <td><%= requestId %></td>
        <td><%= mealType != null ? mealType : "-" %></td>
        <td><%= quantity != null ? quantity : "-" %></td>
        <td><%= urgency != null ? urgency : "-" %></td>
        <td><%= message != null ? message : "-" %></td>
        <td><%= donationId != null ? donationId : "-" %></td>
        <td><%= requestTime %></td>
        <td><span class="status <%= statusClass %>"><%= status != null ? status : "Pending" %></span></td>
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
