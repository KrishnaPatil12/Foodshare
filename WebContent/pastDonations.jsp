<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>

<!DOCTYPE html>
<html>
<head>
<title>Past Donations</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: #f5f4ef;
        margin: 0;
        padding: 30px;
    }

    h2 {
        text-align: center;
        color: #333;
        margin-bottom: 25px;
    }

    .container {
        width: 85%;
        margin: auto;
        background: white;
        padding: 25px;
        border-radius: 15px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.07);
    }

    .donation-box {
        padding: 18px;
        margin-bottom: 18px;
        background: #e8f5e9;
        border: 1px solid #cfe9d6;
        border-radius: 12px;
    }

    .title {
        font-size: 18px;
        font-weight: 600;
        color: #0b485b;
    }

    .info {
        margin-top: 8px;
        font-size: 15px;
        color: #444;
    }

    .status {
        margin-top: 10px;
        font-weight: 600;
        padding: 8px;
        border-radius: 10px;
        text-align: center;
        width: 220px;
        background: #d4edda;
        color: #155724;
    }

    .none {
        text-align: center;
        padding: 20px;
        color: #777;
        font-size: 16px;
    }
</style>

</head>
<body>

<h2>Your Past Donations</h2>

<div class="container">

<%
Connection con = Dbconnection.connect();
Integer donorId = Getset.getId();

PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM donations WHERE donor_id=? AND status='Delivered'"
);
ps.setInt(1, donorId);

ResultSet rs = ps.executeQuery();

boolean hasDonations = false;

while(rs.next()){
    hasDonations = true;
    String food = rs.getString("food_name");
    String qty = rs.getString("quantity");
    String prep = rs.getString("prepared_time");
    String pick = rs.getString("pickup_time");
%>

    <div class="donation-box">
        <div class="title"><%= food %> - <%= qty %> meals</div>

        <div class="info">Prepared Time: <%= prep %></div>
        <div class="info">Pickup Time: <%= pick %></div>

        <div class="status">Delivered</div>
    </div>

<%
}
if(!hasDonations){
%>

<div class="none">
    No past donations found.
</div>

<%
}
%>

</div>

</body>
</html>
