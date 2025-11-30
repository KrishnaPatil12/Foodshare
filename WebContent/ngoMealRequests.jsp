<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Available Donations | NGO</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
body { margin:0; padding:20px; font-family:'Poppins',sans-serif; background:#f5f4ef; }
h2 { text-align:center; margin-bottom:20px; color:#333; }
table { width:90%; margin:auto; border-collapse:collapse; background:white; border-radius:10px; overflow:hidden; box-shadow:0 4px 15px rgba(0,0,0,0.1);}
th,td{padding:14px; text-align:center; border-bottom:1px solid #ddd; font-size:15px;}
th{background:#7abec9;color:white;}
tr:hover{background:#f0f9fa;}
.btn{padding:8px 16px; background:#7abec9; color:white; border-radius:8px; text-decoration:none; font-weight:600;}
</style>
</head>
<body>

<h2>Available Donations</h2>
<table>
<tr>
    <th>Donation ID</th>
    <th>Food Name</th>
    <th>Quantity</th>
    <th>Prepared</th>
    <th>Pickup</th>
    <th>Action</th>
</tr>

<%
Connection con = Dbconnection.connect();
PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM donations WHERE status='Waiting for volunteer' OR status='Volunteer assigned'"
);
ResultSet rs = ps.executeQuery();
while(rs.next()){
%>
<tr>
    <td><%=rs.getInt("donation_id")%></td>
    <td><%=rs.getString("food_name")%></td>
    <td><%=rs.getString("quantity")%></td>
    <td><%=rs.getString("prepared_time")%></td>
    <td><%=rs.getString("pickup_time")%></td>
    <td>
        <a class="btn" href="ngo_requests_meal.jsp?donation_id=<%=rs.getInt("donation_id")%>">Request</a>
    </td>
</tr>
<%
}
rs.close(); ps.close(); con.close();
%>

</table>
</body>
</html>
