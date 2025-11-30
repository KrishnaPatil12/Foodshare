<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.Dbconnection" %>

<%
Connection con = Dbconnection.connect();
PreparedStatement ps = null;

// ---------- UPDATE LOGIC ----------
if("true".equals(request.getParameter("update"))){
    int donationId = Integer.parseInt(request.getParameter("id"));
    String foodName = request.getParameter("food_name");
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    String preparedTime = request.getParameter("prepared_time");
    String pickupTime = request.getParameter("pickup_time");
    String status = request.getParameter("status");

    ps = con.prepareStatement(
        "UPDATE donations SET food_name=?, quantity=?, prepared_time=?, pickup_time=?, status=? WHERE donation_id=?"
    );
    ps.setString(1, foodName);
    ps.setInt(2, quantity);
    ps.setString(3, preparedTime);
    ps.setString(4, pickupTime);
    ps.setString(5, status);
    ps.setInt(6, donationId);
    ps.executeUpdate();

    out.println("<script>alert('Donation updated successfully!'); window.location='admin_donations.jsp';</script>");
    return;
}

// ---------- FETCH DONATION ----------
String idParam = request.getParameter("id");
ResultSet donationData = null;
if(idParam != null){
    ps = con.prepareStatement("SELECT * FROM donations WHERE donation_id=?");
    ps.setInt(1, Integer.parseInt(idParam));
    donationData = ps.executeQuery();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Donation</title>
<style>
body { font-family:'Poppins',sans-serif; background:#f5f4ef; display:flex; justify-content:center; padding:30px; }
.edit-box { width:400px; background:white; padding:25px; border-radius:14px; box-shadow:0 5px 18px rgba(0,0,0,0.1); }
h2 { text-align:center; color:#333; margin-bottom:20px; }
label { font-weight:600; margin-top:10px; display:block; }
input, select { width:100%; padding:10px; border-radius:8px; border:1px solid #ccc; margin-top:6px; font-size:14px; }
button { width:100%; padding:12px; margin-top:20px; border:none; background:#7abec9; color:white; border-radius:10px; font-size:15px; cursor:pointer; font-weight:600; }
button:hover { background:#67aeb9; }
</style>
</head>
<body>

<div class="edit-box">
<%
if(donationData != null && donationData.next()){
%>
<h2>Edit Donation</h2>
<form action="editDonation.jsp" method="post">
<input type="hidden" name="update" value="true">
<input type="hidden" name="id" value="<%= donationData.getInt("donation_id") %>">

<label>Food Name:</label>
<input type="text" name="food_name" value="<%= donationData.getString("food_name") %>" required>

<label>Quantity:</label>
<input type="number" name="quantity" value="<%= donationData.getInt("quantity") %>" required>

<label>Prepared Time:</label>
<input type="text" name="prepared_time" value="<%= donationData.getString("prepared_time") %>" required>

<label>Pickup Time:</label>
<input type="text" name="pickup_time" value="<%= donationData.getString("pickup_time") %>" required>

<label>Status:</label>
<select name="status" required>
<option value="Waiting for volunteer" <%= "Waiting for volunteer".equals(donationData.getString("status"))?"selected":"" %>>Waiting for volunteer</option>
<option value="Volunteer assigned" <%= "Volunteer assigned".equals(donationData.getString("status"))?"selected":"" %>>Volunteer assigned</option>
<option value="Delivered" <%= "Delivered".equals(donationData.getString("status"))?"selected":"" %>>Delivered</option>
</select>

<button type="submit">Update Donation</button>
</form>
<%
}else{
    out.println("<p>No donation selected.</p>");
}
%>
</div>

</body>
</html>
