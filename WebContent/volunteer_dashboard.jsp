<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
Integer volId = Getset.getId();
if(volId == null){
    response.sendRedirect("volunteer_login.jsp");
    return;
}

Connection con = Dbconnection.connect();

// Fetch volunteer availability
PreparedStatement psAvail = con.prepareStatement(
    "SELECT availability_days, availability_start_time, availability_end_time FROM volunteer WHERE volunteer_id=?"
);
psAvail.setInt(1, volId);
ResultSet rsAvail = psAvail.executeQuery();
String days = "", startTime = "", endTime = "";
if(rsAvail.next()){
    days = rsAvail.getString("availability_days");
    startTime = rsAvail.getString("availability_start_time");
    endTime = rsAvail.getString("availability_end_time");
}
rsAvail.close();
psAvail.close();

// Stats
int totalPickups = 0, totalDeliveries = 0, impactScore = 0;

PreparedStatement psStats = con.prepareStatement(
    "SELECT COUNT(*) AS delivered_count FROM volunteer_tasks WHERE volunteer_id=? AND task_status='Delivered'"
);
psStats.setInt(1, volId);
ResultSet rsStats = psStats.executeQuery();
if(rsStats.next()){
    totalDeliveries = rsStats.getInt("delivered_count");
    impactScore = totalDeliveries * 10;
}
rsStats.close();
psStats.close();

PreparedStatement psPickups = con.prepareStatement(
    "SELECT COUNT(*) AS picked_count FROM volunteer_tasks WHERE volunteer_id=? AND task_status='Collected'"
);
psPickups.setInt(1, volId);
ResultSet rsPickups = psPickups.executeQuery();
if(rsPickups.next()){
    totalPickups = rsPickups.getInt("picked_count");
}
rsPickups.close();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Volunteer Dashboard | FoodShare</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
/* GLOBAL */
body { margin:0; font-family:'Poppins',sans-serif; background:#f5f4ef; display:flex; }
a { text-decoration:none; }

/* SIDEBAR */
.sidebar {
    width:220px;
    background:#7abec9; /* blue palette */
    color:white;
    min-height:100vh;
    position:fixed;
    top:0;
    left:0;
    padding:20px 0;
    transition:0.3s;
}
.sidebar h2 { text-align:center; margin-bottom:30px; font-weight:600; }
.sidebar a { display:block; padding:12px 25px; color:white; font-weight:500; transition:0.3s; }
.sidebar a:hover, .sidebar a.active { background:#5daab6; color:white; }

/* MAIN CONTENT */
.main-content { margin-left:220px; padding:25px 30px; flex:1; }

/* TOPBAR */
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
.topbar span { font-size:14px; color:#555; }

/* DASHBOARD CARDS */
.dashboard { display:grid; grid-template-columns:repeat(auto-fit, minmax(250px,1fr)); gap:20px; }
.card { background:white; padding:20px; border-radius:12px; box-shadow:0 6px 18px rgba(0,0,0,0.08); transition:transform 0.3s; }
.card:hover { transform:translateY(-5px); }
.card h3 { color:#0b2545; margin-bottom:15px; }

/* STATS HIGHLIGHT */
.stat-number { font-size:24px; font-weight:600; color:#0b757f; margin-top:5px; }
.stat-label { font-size:14px; color:#555; }

/* CARD LINKS */
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

/* AVAILABILITY BADGES */
.badge {
    display:inline-block;
    padding:5px 12px;
    margin:3px 5px 3px 0;
    background:#7abec9;
    color:white;
    border-radius:20px;
    font-size:13px;
    font-weight:500;
}

/* TABLE */
table { width:100%; border-collapse:collapse; margin-top:10px; table-layout:fixed; }
th, td { padding:10px; border:1px solid #ddd; text-align:center; word-wrap:break-word; }
th { background:#7abec9; color:white; }
tr:hover { background:#f0f9fa; }

/* STATUS LABELS */
.status { font-weight:600; padding:6px 10px; border-radius:8px; display:inline-block; }
.status-waiting { background:#ffe7aa; color:#a56900; }
.status-assigned { background:#cde9ff; color:#005b96; }
.status-picked { background:#fde2d7; color:#b04100; }
.status-delivered { background:#d9f7c8; color:#2f6b00; }

/* BUTTON */
button {
    padding:6px 12px;
    border:none;
    border-radius:6px;
    background:#7abec9;
    color:white;
    cursor:pointer;
    transition:0.3s;
}
button:hover { background:#5daab6; }
</style>
</head>

<body>
<div class="sidebar">
    <h2>FoodShare</h2>
    <a href="volunteer_dashboard.jsp" class="active">Dashboard</a>
    <a href="volunteer_schedule.jsp">Schedule Availability</a>
      <a href="display_events.jsp">Events</a>
    <a href="index.html">Logout</a>

</div>

<div class="main-content">
    <div class="topbar">
        <h1>Welcome, Volunteer!</h1>
        <span><%= new java.util.Date() %></span>
    </div>

    <div class="dashboard">

        <!-- STATS CARD -->
        <div class="card">
            <h3>My Stats</h3>
            <p class="stat-label">Total Pickups</p>
            <p class="stat-number"><%= totalPickups %></p>
            <p class="stat-label">Total Deliveries</p>
            <p class="stat-number"><%= totalDeliveries %></p>
            <p class="stat-label">Impact Score</p>
            <p class="stat-number"><%= impactScore %></p>
        </div>

        <!-- PICKUP TASKS CARD -->
        <div class="card">
            <h3>Pickup Tasks</h3>
            <a href="volunteer_tasks.jsp">Upload Pickup Image</a>
            <a href="view_pickups.jsp">View Pickups</a>
        </div>

        <!-- DELIVERY TASKS CARD -->
        <div class="card">
            <h3>Delivery Tasks</h3>
            <a href="delivery_tasks.jsp">Upload Delivery Image</a>
            <a href="view_delivered.jsp">View Delivered</a>
        </div>

        <!-- AVAILABILITY CARD -->
        <div class="card">
            <h3>My Availability</h3>
            <p><strong>Days:</strong></p>
            <%
                if(days != null && !days.isEmpty()){
                    String[] dayArr = days.split(",");
                    for(String d : dayArr){
            %>
                <span class="badge"><%= d %></span>
            <%
                    }
                } else {
            %>
                <span class="badge" style="background:#ccc;color:#333;">Not Set</span>
            <%
                }
            %>
            <p style="margin-top:10px;"><strong>Time:</strong> <%= startTime != null ? startTime : "--:--" %> - <%= endTime != null ? endTime : "--:--" %></p>
        </div>

        <!-- AVAILABLE PICKUPS TABLE -->
        <div class="card" style="grid-column: span 2;">
            <h3>Available Pickups</h3>
            <table>
                <tr>
                    <th>Food</th>
                    <th>Quantity</th>
                    <th>Pickup Time</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                <%
                    PreparedStatement psTasks = con.prepareStatement(
                        "SELECT * FROM donations WHERE status='Waiting for volunteer'"
                    );
                    ResultSet rsTasks = psTasks.executeQuery();
                    while(rsTasks.next()){
                        int donationId = rsTasks.getInt("donation_id");
                        String food = rsTasks.getString("food_name");
                        String qty = rsTasks.getString("quantity");
                        String pickupTime = rsTasks.getString("pickup_time");
                        String status = rsTasks.getString("status");
                %>
                <tr>
                    <td><%= food %></td>
                    <td><%= qty %></td>
                    <td><%= pickupTime %></td>
                    <td class="status-waiting"><%= status %></td>
                    <td>
                        <form action="accept_task.jsp" method="post">
                            <input type="hidden" name="donation_id" value="<%= donationId %>">
                            <button type="submit">Accept Task</button>
                        </form>
                    </td>
                </tr>
                <% } rsTasks.close(); psTasks.close(); con.close(); %>
            </table>
        </div>

    </div>
</div>
</body>
</html>
