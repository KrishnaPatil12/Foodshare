<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.Dbconnection" %>

<%
Connection con = Dbconnection.connect();
PreparedStatement ps = null;

// ---------- ASSIGN LOGIC ----------
if("true".equals(request.getParameter("assign"))){
    int donationId = Integer.parseInt(request.getParameter("id"));
    int volunteerId = Integer.parseInt(request.getParameter("volunteer_id"));

    ps = con.prepareStatement("UPDATE donations SET volunteer_id=?, status='Volunteer assigned' WHERE donation_id=?");
    ps.setInt(1, volunteerId);
    ps.setInt(2, donationId);
    ps.executeUpdate();

    out.println("<script>alert('Volunteer assigned successfully!'); window.location='admin_donations.jsp';</script>");
    return;
}

// ---------- FETCH DONATION & VOLUNTEERS ----------
String idParam = request.getParameter("id");
ResultSet donationData = null;
ResultSet volunteersData = null;

if(idParam != null){
    ps = con.prepareStatement("SELECT * FROM donations WHERE donation_id=?");
    ps.setInt(1, Integer.parseInt(idParam));
    donationData = ps.executeQuery();

    Statement st = con.createStatement();
    volunteersData = st.executeQuery("SELECT * FROM volunteer");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Assign Volunteer</title>
<style>
body { font-family:'Poppins',sans-serif; background:#f5f4ef; display:flex; justify-content:center; padding:30px; }
.assign-box { width:400px; background:white; padding:25px; border-radius:14px; box-shadow:0 5px 18px rgba(0,0,0,0.1); }
h2 { text-align:center; color:#333; margin-bottom:20px; }
label { font-weight:600; margin-top:10px; display:block; }
select { width:100%; padding:10px; border-radius:8px; border:1px solid #ccc; margin-top:6px; font-size:14px; }
button { width:100%; padding:12px; margin-top:20px; border:none; background:#7abec9; color:white; border-radius:10px; font-size:15px; cursor:pointer; font-weight:600; }
button:hover { background:#67aeb9; }
</style>
</head>
<body>

<div class="assign-box">
<%
if(donationData != null && donationData.next()){
%>
<h2>Assign Volunteer</h2>
<form action="assignVolunteer.jsp" method="post">
<input type="hidden" name="assign" value="true">
<input type="hidden" name="id" value="<%= donationData.getInt("donation_id") %>">

<label>Select Volunteer:</label>
<select name="volunteer_id" required>
<%
while(volunteersData.next()){
%>
<option value="<%= volunteersData.getInt("volunteer_id") %>"><%= volunteersData.getString("name") %></option>
<%
}
%>
</select>

<button type="submit">Assign Volunteer</button>
</form>
<%
}else{
    out.println("<p>No donation selected.</p>");
}
%>
</div>

</body>
</html>
