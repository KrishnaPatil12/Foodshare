
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Donor Dashboard</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
    body {
        margin: 0;
        padding: 0;
        font-family: 'Poppins', sans-serif;
        background: #f5f4ef;      /* Soft beige */
        display: flex;
    }

    /* SIDEBAR */
    .sidebar {
        width: 230px;
        background: linear-gradient(135deg, #5fb7c4, #3d8b99); /* teal theme */
        color: white;
        min-height: 100vh;
        padding: 25px 0;
        position: fixed;
        left: 0;
        top: 0;
        box-shadow: 4px 0 12px rgba(0,0,0,0.08);
    }

    .sidebar h2 {
        text-align: center;
        margin-bottom: 35px;
        font-weight: 600;
        letter-spacing: .5px;
    }

    .sidebar a {
        display: block;
        padding: 12px 22px;
        text-decoration: none;
        color: #e6f7fa;
        font-size: 15px;
        transition: 0.3s;
    }

    .sidebar a:hover {
        background: rgba(255,255,255,0.15);
        padding-left: 28px;
    }

    /* MAIN SECTION */
    .main-content {
        margin-left: 230px;
        padding: 30px;
        flex: 1;
    }

    .topbar {
        background: white;
        padding: 18px 25px;
        border-radius: 14px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        margin-bottom: 30px;
    }

    .topbar h2 {
        margin: 0;
        color: #333;
        font-weight: 600;
    }

    /* DASHBOARD GRID */
    .dashboard {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
        gap: 25px;
    }

    .card {
        background: white;
        padding: 25px;
        border-radius: 18px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        transition: 0.3s;
    }

    .card:hover {
        transform: translateY(-6px);
    }

    .card h3 {
        margin-top: 0;
        color: #3d8b99;
        font-weight: 600;
        margin-bottom: 12px;
    }

    .feature-list li {
        margin: 6px 0;
        color: #555;
    }

    /* Buttons inside cards */
    .card a {
        display: block;
        text-decoration: none;
        color: white;
        background: #7abec9;
        padding: 10px;
        margin-top: 12px;
        text-align: center;
        border-radius: 10px;
        font-weight: 500;
        transition: 0.3s;
    }

    .card a:hover {
        background: #67aeb9;
    }
</style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h2>FoodShare</h2>

    <a href="Ddashboard.jsp">Dashboard</a>
    <a href="addfood.jsp">Add Surplus Food</a>
    <a href="activeDonations.jsp">Active Donations</a>
    <a href="pastDonations.jsp">Past Donations</a>
    <a href="donorTracking.jsp">Pickup Status</a>
    <a href="display_events.jsp">Events</a>
    <a href="index.html">Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="main-content">

    <div class="topbar">
       <h2>Welcome Donor !! </h2>
    </div>

    <div class="dashboard">

        <!-- ADD FOOD -->
        <div class="card">
            <h3>Add Surplus Food</h3>
            <ul class="feature-list">
                <li>Food name</li>
                <li>Quantity</li>
                <li>Preparation time</li>
                <li>Pickup time</li>
                <li>Upload image</li>
            </ul>
            <a href="addfood.jsp">Add Food</a>
        </div>

        <!-- PICKUP STATUS -->
        <div class="card">
            <h3>Live Pickup Status</h3>
            <ul class="feature-list">
                <li>Waiting for volunteer</li>
                <li>Volunteer assigned</li>
                <li>Picked up</li>
                <li>Delivered</li>
            </ul>
            <a href="donorTracking.jsp">Track Status</a>
        </div>

        <!-- IMPACT STATS -->
        <div class="card">
            <h3>Your Impact</h3>
            <ul class="feature-list">
                <li>Total meals donated</li>
                <li>Carbon saved</li>
                <li>Food waste reduced</li>
            </ul>
            <a href="donorImpact.jsp">View Impact</a>
        </div>

        <!-- SAFETY CHECKLIST -->
        <div class="card">
            <h3>Safety Checklist</h3>
            <ul class="feature-list">
                <li>Food not expired</li>
                <li>Packed properly</li>
                <li>Temperature maintained</li>
            </ul>
            <a href="safetyChecklist.jsp">View Checklist</a>
        </div>

        <!-- ACTIVE DONATIONS -->
        <div class="card">
            <h3>Active Donations</h3>
            <p>View all ongoing food pickups.</p>
            <a href="activeDonations.jsp">View Active</a>
        </div>

        <!-- PAST DONATIONS -->
        <div class="card">
            <h3>Past Donations</h3>
            <p>Your completed donation history.</p>
            <a href="pastDonations.jsp">View History</a>
        </div>

    </div>
</div>

</body>
</html>
