<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>

<%
Integer ngoId = (Integer)session.getAttribute("ngoId");
if(ngoId == null){
    response.sendRedirect("ngo.jsp");
    return;
}
Connection con = Dbconnection.connect();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NGO Dashboard | FoodShare</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
/* Global */
body { margin:0; font-family:'Poppins',sans-serif; background:#f5f4ef; display:flex; }
a { text-decoration:none; }

/* Sidebar */
.sidebar {
    width:220px;
    background:#7abec9; /* Volunteer palette */
    color:white;
    min-height:100vh;
    position:fixed;
    top:0;
    left:0;
    padding:20px 0;
}
.sidebar h2 { text-align:center; margin-bottom:30px; font-weight:600; }
.sidebar a { display:block; padding:12px 25px; color:white; font-weight:500; transition:0.3s; }
.sidebar a:hover, .sidebar a.active { background:#5daab6; color:white; }

/* Main content */
.main-content { margin-left:220px; padding:25px 30px; flex:1; }

/* Top bar */
.topbar {
    display:flex;
    justify-content:space-between;
    align-items:center;
    background:white;
    padding:15px 25px;
    border-radius:10px;
    box-shadow:0 4px 12px rgba(0,0,0,0.08);
    margin-bottom:25px;
}
.topbar h1 { margin:0; font-size:22px; color:#333; }

/* Dashboard cards */
.dashboard { display:grid; grid-template-columns:repeat(auto-fit, minmax(250px,1fr)); gap:20px; }
.card {
    background:white;
    padding:20px;
    border-radius:12px;
    box-shadow:0 6px 18px rgba(0,0,0,0.08);
    transition:transform 0.3s;
}
.card:hover { transform:translateY(-5px); }
.card h3 { color:#0b2545; margin-bottom:15px; }
.card a {
    display:block;
    padding:10px;
    margin:8px 0;
    background:#f5f5f5;
    border-radius:8px;
    color:#0b757f;
    font-weight:500;
    transition:0.3s;
}
.card a:hover { background:#7abec9; color:white; }

/* Tables */
table { width:100%; border-collapse:collapse; margin-top:10px; table-layout:fixed; }
th, td { padding:10px; border:1px solid #ddd; text-align:center; word-wrap:break-word; }
th { background:#7abec9; color:white; }
tr:hover { background:#f0f9fa; }
</style>
</head>

<body>
<div class="sidebar">
    <h2>FoodShare </h2>
    <a href="ngoDashboard.jsp" class="active">Dashboard</a>
    <a href="ngo_request_meals.jsp">Request Meals</a>
    <a href="ngo_distribution.jsp">Distribution History</a>
    <a href="display_events.jsp">Events</a>
    <a href="index.html">Logout</a>
</div>

<div class="main-content">
    <div class="topbar">
        <h1>Welcome, NGO!</h1>
        <span><%= new java.util.Date() %></span>
    </div>

    <div class="dashboard">
        <!-- View Donors -->
        <div class="card">
            <h3>View Donors</h3>
            <a href="view_donors.jsp">Donor List</a>
        </div>

        <!-- View Volunteers -->
        <div class="card">
            <h3>View Volunteers</h3>
            <a href="view_volunteers.jsp">Volunteer List</a>
        </div>

        <!-- Request Meals -->
        <div class="card">
            <h3>Request Meals</h3>
            <a href="ngoMealRequests.jsp">Make a Request</a>
        </div>

        <!-- Distribution History -->
        <div class="card">
            <h3>Distribution History</h3>
            <a href="viewhistory.jsp">View History</a>
        </div>

        <!-- Event Collaboration -->
        <div class="card">
            <h3>Event Collaboration</h3>
            <a href="ngo_events.jsp">Manage Events</a>
            <a href="display_events.jsp">All Events</a>
        </div>
    </div>
</div>

<%
if(con != null) con.close();
%>
</body>
</html>
