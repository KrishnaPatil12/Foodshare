<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FoodShare Admin Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f5f6fa;
            font-family: 'Poppins', sans-serif;
        }

        .sidebar {
            width: 260px;
            height: 100vh;
            position: fixed;
            background: #2d3436;
            padding: 20px;
            color: white;
        }

        .sidebar h2 {
            font-size: 22px;
            margin-bottom: 25px;
        }

        .sidebar a {
            display: block;
            color: #dfe6e9;
            text-decoration: none;
            margin: 12px 0;
            font-size: 16px;
            font-weight: 500;
        }

        .sidebar a:hover {
            color: #74b9ff;
        }

        .content {
            margin-left: 280px;
            padding: 30px;
        }

        .card-box {
            border-radius: 12px;
            padding: 25px;
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .card-box h3 {
            font-size: 26px;
            margin-bottom: 5px;
        }

        .card-box p {
            margin: 0;
            font-size: 14px;
        }

        .bg1 { background: #6c5ce7; }
        .bg2 { background: #00b894; }
        .bg3 { background: #fdcb6e; color: black; }
        .bg4 { background: #d63031; }

        .chart-container {
            background: white;
            padding: 20px;
            border-radius: 12px;
            margin-top: 30px;
        }
    </style>

</head>

<body>

<!-- Sidebar -->
<div class="sidebar">
    <h2>FoodShare Admin</h2>
    <a href="adminDashboard.html">Dashboard</a>
    <a href="admin_users.jsp">User Management</a>
    <a href="admin_donations.jsp">Donation Management</a>
    <a href="admin_requests.jsp">Meal Requests</a>
    <a href="admin_events.jsp">Event Management</a>
</div>

<!-- Main Content -->
<div class="content">
    <h1 class="mb-4">Admin Dashboard</h1>

    <!-- Statistics Row -->
    <div class="row">
        <div class="col-md-3">
            <div class="card-box bg1">
                <div>
                    <h3 id="donorCount">0</h3>
                    <p>Total Donors</p>
                </div>
                <i class="bi bi-people fs-1"></i>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card-box bg2">
                <div>
                    <h3 id="volCount">0</h3>
                    <p>Total Volunteers</p>
                </div>
                <i class="bi bi-person-badge fs-1"></i>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card-box bg3">
                <div>
                    <h3 id="donationCount">0</h3>
                    <p>Total Donations</p>
                </div>
                <i class="bi bi-basket fs-1"></i>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card-box bg4">
                <div>
                    <h3 id="ngoCount">0</h3>
                    <p>Verified NGOs</p>
                </div>
                <i class="bi bi-building fs-1"></i>
            </div>
        </div>
    </div>

    <!-- Chart Section -->
    <div class="chart-container">
        <h4>Donations Overview</h4>
        <canvas id="donationChart"></canvas>
    </div>

</div>

<!-- JS Links -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Dashboard Stats (connect with backend later)
    document.getElementById('donorCount').textContent = 45;
    document.getElementById('volCount').textContent = 32;
    document.getElementById('donationCount').textContent = 120;
    document.getElementById('ngoCount').textContent = 12;

    // Chart Data
    const ctx = document.getElementById('donationChart').getContext('2d');

    new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            datasets: [{
                label: 'Donations per Day',
                data: [12, 19, 7, 15, 22, 30, 25],
                borderWidth: 3
            }]
        }
    });
</script>

</body>
</html>
