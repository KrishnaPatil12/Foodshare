<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.Dbconnection" %>

<%
    Connection con = Dbconnection.connect();
    PreparedStatement ps = null;

    // ---------- UPDATE LOGIC ----------
    if ("true".equals(request.getParameter("update"))) {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String location = request.getParameter("location");
        String contact = request.getParameter("contactNo");

        ps = con.prepareStatement(
            "UPDATE donor SET name=?, email=?, location=?, contactNo=? WHERE id=?"
        );
        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, location);
        ps.setString(4, contact);
        ps.setInt(5, id);
        ps.executeUpdate();

        out.println("<script>alert('Donor updated successfully!'); window.location='admin_users.jsp';</script>");
        return;
    }

    // ---------- FETCH RECORD FOR EDIT ----------
    String idParam = request.getParameter("id");
    ResultSet donorData = null;

    if (idParam != null) {
        ps = con.prepareStatement("SELECT * FROM donor WHERE id=?");
        ps.setInt(1, Integer.parseInt(idParam));
        donorData = ps.executeQuery();
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Donor</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
body {
    margin:0; padding:0; font-family:'Poppins',sans-serif;
    background:#f5f4ef; display:flex; justify-content:center; align-items:center; height:100vh;
}

.edit-card {
    width:380px; background:rgba(255,255,255,0.6); padding:32px;
    border-radius:20px; backdrop-filter:blur(14px); border:1px solid rgba(200,200,200,0.4);
    box-shadow:0 8px 25px rgba(0,0,0,0.08); color:#444;
}

.edit-card h2 {
    text-align:center; font-size:24px; font-weight:600; color:#333; margin-bottom:20px;
}

label {
    display:block; margin-top:12px; font-weight:500; font-size:14px; color:#555;
}

input {
    width:100%; margin-top:5px; padding:12px; border-radius:12px; border:1px solid #d4d4d4;
    background:#ffffffaa; font-size:14px; color:#333; outline:none; transition:0.2s;
}

input:focus { border-color:#7abec9; box-shadow:0 0 0 3px rgba(122,190,201,0.25); }

button {
    margin-top:22px; width:100%; padding:12px; border:none; border-radius:14px;
    font-size:16px; font-weight:600; cursor:pointer; background:#7abec9; color:white; transition:all 0.3s ease;
}

button:hover { background:#67aeb9; }
</style>
</head>
<body>

<div class="edit-card">
<%
    if (donorData != null && donorData.next()) {
%>
<h2>Edit Donor</h2>
<form action="editDonor.jsp" method="post">
    <input type="hidden" name="update" value="true">
    <input type="hidden" name="id" value="<%= donorData.getInt("id") %>">

    <label>Name:</label>
    <input type="text" name="name" value="<%= donorData.getString("name") %>" required>

    <label>Email:</label>
    <input type="email" name="email" value="<%= donorData.getString("email") %>" required>

    <label>Location:</label>
    <input type="text" name="location" value="<%= donorData.getString("location") %>" required>

    <label>Contact:</label>
    <input type="text" name="contactNo" value="<%= donorData.getString("contactNo") %>" required>

    <button type="submit">Update Donor</button>
</form>
<%
    } else {
%>
<p>No donor selected.</p>
<%
    }
%>
</div>

</body>
</html>
