<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.Dbconnection" %>

<%
    Connection con = Dbconnection.connect();
    PreparedStatement ps = null;

    // --------- UPDATE LOGIC ----------
    if ("true".equals(request.getParameter("update"))) {
        int id = Integer.parseInt(request.getParameter("id"));
        String mealType = request.getParameter("meal_type");
        String quantity = request.getParameter("quantity");
        String urgency = request.getParameter("urgency");
        String message = request.getParameter("message");
        String status = request.getParameter("status");

        ps = con.prepareStatement("UPDATE meal_requests SET meal_type=?, quantity=?, urgency=?, message=?, status=? WHERE request_id=?");
        ps.setString(1, mealType);
        ps.setString(2, quantity);
        ps.setString(3, urgency);
        ps.setString(4, message);
        ps.setString(5, status);
        ps.setInt(6, id);
        ps.executeUpdate();

        out.println("<script>alert('Meal Request updated successfully!'); window.location='admin_requests.jsp';</script>");
        return;
    }

    // --------- FETCH RECORD FOR EDIT ----------
    String idParam = request.getParameter("id");
    ResultSet requestData = null;

    if (idParam != null) {
        ps = con.prepareStatement("SELECT * FROM meal_requests WHERE request_id=?");
        ps.setInt(1, Integer.parseInt(idParam));
        requestData = ps.executeQuery();
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Meal Request</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
<style>
body { background:#f5f4ef; font-family:'Poppins',sans-serif; padding:20px; display:flex; justify-content:center; }
.edit-box { width:400px; background:white; padding:25px; border-radius:14px; box-shadow:0 5px 18px rgba(0,0,0,0.1); }
h2 { text-align:center; color:#333; }
label { font-weight:600; margin-top:10px; display:block; }
input, textarea, select { width:100%; padding:10px; border-radius:8px; border:1px solid #ccc; margin-top:6px; font-size:14px; }
button { width:100%; padding:12px; margin-top:20px; border:none; background:#7abec9; color:white; border-radius:10px; font-size:15px; font-weight:600; cursor:pointer; }
button:hover { background:#67aeb9; }
</style>
</head>
<body>
<div class="edit-box">
<%
    if (requestData != null && requestData.next()) {
%>
<h2>Edit Meal Request</h2>
<form action="editMealRequests.jsp" method="post">
    <input type="hidden" name="update" value="true">
    <input type="hidden" name="id" value="<%= requestData.getInt("request_id") %>">

    <label>Meal Type:</label>
    <input type="text" name="meal_type" value="<%= requestData.getString("meal_type") %>" required>

    <label>Quantity:</label>
    <input type="text" name="quantity" value="<%= requestData.getString("quantity") %>" required>

    <label>Urgency:</label>
    <select name="urgency" required>
        <option value="Low" <%= "Low".equals(requestData.getString("urgency"))?"selected":"" %>>Low</option>
        <option value="Medium" <%= "Medium".equals(requestData.getString("urgency"))?"selected":"" %>>Medium</option>
        <option value="High" <%= "High".equals(requestData.getString("urgency"))?"selected":"" %>>High</option>
    </select>

    <label>Message:</label>
    <textarea name="message" required><%= requestData.getString("message") %></textarea>

    <label>Status:</label>
    <select name="status" required>
        <option value="Pending" <%= "Pending".equals(requestData.getString("status"))?"selected":"" %>>Pending</option>
        <option value="Assigned" <%= "Assigned".equals(requestData.getString("status"))?"selected":"" %>>Assigned</option>
        <option value="Delivered" <%= "Delivered".equals(requestData.getString("status"))?"selected":"" %>>Delivered</option>
    </select>

    <button type="submit">Update Request</button>
</form>
<%
    } else {
        out.println("<p>No request selected.</p>");
    }
%>
</div>
</body>
</html>
