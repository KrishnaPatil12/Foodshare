<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Submit Meal Request</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
body { margin:0; padding:0; font-family:'Poppins',sans-serif; background:#f5f4ef; height:100vh; display:flex; justify-content:center; align-items:center;}
.form-card{ width:420px; background:rgba(255,255,255,0.7); padding:32px; border-radius:20px; backdrop-filter:blur(14px); border:1px solid rgba(200,200,200,0.4); box-shadow:0 8px 25px rgba(0,0,0,0.08);}
h2{text-align:center;margin-bottom:20px; font-size:24px; font-weight:600; color:#333;}
label{display:block;margin-top:12px;font-size:14px;font-weight:500;color:#555;}
input, select, textarea{ width:100%; margin-top:6px; padding:12px; border-radius:12px; border:1px solid #d4d4d4; background:#ffffffaa; font-size:14px;}
button{margin-top:22px; width:100%; padding:12px; border:none; border-radius:14px; background:#7abec9; color:white; font-size:16px; font-weight:600; cursor:pointer;}
button:hover{background:#67aeb9;}
</style>
</head>

<body>
<div class="form-card">
<h2>Submit Meal Request</h2>

<%
String donationId = request.getParameter("donation_id");
Integer ngoId = Getset.getId();

if(donationId==null){
    out.println("<p style='color:red;text-align:center;'>Invalid request.</p>");
    return;
}

// If form submitted
if(request.getParameter("submit_request")!=null){
    String mealType = request.getParameter("meal_type");
    String qty = request.getParameter("quantity");
    String urgency = request.getParameter("urgency");
    String msg = request.getParameter("message");

    try{
        Connection con = Dbconnection.connect();
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO meal_requests(ngo_id, meal_type, quantity, urgency, message, donation_id) VALUES(?,?,?,?,?,?)"
        );
        ps.setInt(1, ngoId);
        ps.setString(2, mealType);
        ps.setString(3, qty);
        ps.setString(4, urgency);
        ps.setString(5, msg);
        ps.setInt(6, Integer.parseInt(donationId));

        int res = ps.executeUpdate();
        if(res>0){
            out.println("<p style='color:green;text-align:center;'>Meal Request Submitted!</p>");
        } else {
            out.println("<p style='color:red;text-align:center;'>Failed to Submit Request!</p>");
        }

        ps.close(); con.close();
    }catch(Exception e){
        out.println("<p style='color:red;text-align:center;'>Error: "+e.getMessage()+"</p>");
    }
}
%>

<form method="post">
    <input type="hidden" name="donation_id" value="<%=donationId%>">
    <label>Meal Type</label>
    <input type="text" name="meal_type" placeholder="e.g., Rice, Snacks" required>
    <label>Quantity Needed</label>
    <input type="text" name="quantity" placeholder="e.g., 50 plates" required>
    <label>Urgency</label>
    <select name="urgency" required>
        <option value="Low">Low</option>
        <option value="Moderate">Moderate</option>
        <option value="High">High</option>
        <option value="Immediate">Immediate</option>
    </select>
    <label>Message (Optional)</label>
    <textarea name="message" rows="3" placeholder="Optional message"></textarea>
    <button type="submit" name="submit_request">Submit Request</button>
</form>

</div>
</body>
</html>
