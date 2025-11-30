<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Surplus Food</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
    body {
        margin: 0;
        padding: 0;
        font-family: 'Poppins', sans-serif;
        background: #f5f4ef;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .form-card {
        width: 420px;
        background: rgba(255,255,255,0.7);
        padding: 32px;
        border-radius: 20px;
        backdrop-filter: blur(14px);
        border: 1px solid rgba(200,200,200,0.4);
        box-shadow: 0 8px 25px rgba(0,0,0,0.08);
    }

    h2 {
        text-align: center;
        margin-bottom: 20px;
        font-size: 24px;
        font-weight: 600;
        color: #333;
    }

    label {
        display: block;
        margin-top: 12px;
        font-size: 14px;
        font-weight: 500;
        color: #555;
    }

    input {
        width: 100%;
        margin-top: 6px;
        padding: 12px;
        border-radius: 12px;
        border: 1px solid #d4d4d4;
        background: #ffffffaa;
        font-size: 14px;
    }

    button {
        margin-top: 22px;
        width: 100%;
        padding: 12px;
        border: none;
        border-radius: 14px;
        background: #7abec9;
        color: white;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
    }

    button:hover {
        background: #67aeb9;
    }
</style>
</head>

<body>

<div class="form-card">

    <h2>Add Surplus Food</h2>

    <form method="post" action="addfood.jsp">

        <label>Food Name</label>
        <input type="text" name="food_name" required>

        <label>Quantity (meals/packets)</label>
        <input type="number" name="quantity" required>

        <label>Prepared Time</label>
        <input type="text" name="prepared_time" placeholder="e.g. 3:00 PM" required>

        <label>Pickup Time</label>
        <input type="text" name="pickup_time" placeholder="e.g. 6:00 PM" required>

        <button type="submit">Submit Donation</button>
    </form>

    <%  
        Connection con = Dbconnection.connect();
    	Integer donorId=Getset.getId();
        String fname = request.getParameter("food_name");
        String qty = request.getParameter("quantity");
        String ptime = request.getParameter("prepared_time");
        String picktime = request.getParameter("pickup_time");



        if (fname != null && qty != null && ptime != null && picktime != null) {

            try {

                PreparedStatement pstmt = con.prepareStatement(
                    "INSERT INTO donations(donation_id, donor_id, food_name, quantity, prepared_time, pickup_time, status) VALUES (?,?,?,?,?,?,?)"
                );
                pstmt.setInt(1, 0);
                pstmt.setInt(2, donorId);
                pstmt.setString(3, fname);
                pstmt.setString(4, qty);
                pstmt.setString(5, ptime);
                pstmt.setString(6, picktime);
                pstmt.setString(7, "Waiting for volunteer");

                int i = pstmt.executeUpdate();

                if (i > 0) {
                	out.println("<p style='color:green; text-align:center;'>Donation Added !</p>");
                } else {
                    out.println("<p style='color:red; text-align:center;'>Failed to Add Donation!</p>");
                }

            } catch (Exception e) {
                out.println("<p style='color:red; text-align:center;'>Error: " + e + "</p>");
                e.printStackTrace();
            }
        }
    %>

</div>

</body>
</html>
