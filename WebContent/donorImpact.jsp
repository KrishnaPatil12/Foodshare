<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>

<!DOCTYPE html>
<html>
<head>
<title>Your Impact</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
    body {
        margin: 0;
        padding: 40px;
        font-family: 'Poppins', sans-serif;
        background: #f5f4ef;
    }

    h2 {
        text-align: center;
        margin-bottom: 25px;
        color: #333;
    }

    .impact-box {
        width: 70%;
        margin: auto;
        background: white;
        padding: 30px;
        border-radius: 18px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.08);
    }

    .stats {
        display: flex;
        justify-content: space-between;
        margin-top: 20px;
    }

    .stat-card {
        width: 30%;
        background: #e9f7f8;
        padding: 18px;
        border-radius: 15px;
        text-align: center;
        box-shadow: 0 5px 14px rgba(0,0,0,0.05);
    }

    .stat-card h3 {
        font-size: 20px;
        color: #0b5c68;
        margin-bottom: 10px;
    }

    .stat-card p {
        font-size: 22px;
        font-weight: 600;
        color: #333;
    }
</style>
</head>

<body>

<h2>Your Impact</h2>

<div class="impact-box">

<%
Connection con = Dbconnection.connect();
int donorId = Getset.getId();

// Calculate total meals
PreparedStatement ps = con.prepareStatement(
    "SELECT SUM(quantity) AS totalMeals FROM donations WHERE donor_id=? AND status='Delivered'"
);
ps.setInt(1, donorId);
ResultSet rs = ps.executeQuery();

int totalMeals = 0;
if(rs.next()) {
    totalMeals = rs.getInt("totalMeals");
}

// Carbon saved = totalMeals × 2.5
double carbonSaved = totalMeals * 2.5;

// Food waste reduced = totalMeals × 0.5 kg
double wasteReduced = totalMeals * 0.5;
%>

<div class="stats">
    <div class="stat-card">
        <h3>Total Meals Donated</h3>
        <p><%= totalMeals %></p>
    </div>

    <div class="stat-card">
        <h3>Carbon Saved (kg)</h3>
        <p><%= carbonSaved %></p>
    </div>

    <div class="stat-card">
        <h3>Food Waste Reduced (kg)</h3>
        <p><%= wasteReduced %></p>
    </div>
</div>

</div>

</body>
</html>
