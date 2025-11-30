<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Events | NGO</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
body { margin:0; padding:20px; font-family:'Poppins',sans-serif; background:#f5f4ef; }
h2 { text-align:center; margin-bottom:20px; color:#333; }
table {
    width:90%; margin:auto; border-collapse:collapse;
    background:white; border-radius:10px; overflow:hidden;
    box-shadow:0 4px 15px rgba(0,0,0,0.1);
}
th, td { padding:14px; text-align:center; border-bottom:1px solid #ddd; font-size:15px; }
th { background:#7abec9; color:white; }
tr:hover { background:#f0f9fa; }
</style>

</head>
<body>


<h2>Events</h2>
<p style="text-align:center; color:#555; font-size:14px; margin-bottom:10px;">
  These are major events organized by NGOs. Anyone can participate!
</p>
<table>
<tr>
    <th>Event Name</th>
    <th>Date</th>
    <th>Time</th>
    <th>Location</th>
    <th>Description</th>
</tr>

<%
    Integer ngoId = Getset.getId();
    try{
        Connection con = Dbconnection.connect();
        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM ngo_events ORDER BY event_date DESC"
        );
        ResultSet rs = ps.executeQuery();

        while(rs.next()){
%>
<tr>
    <td><%=rs.getString("event_name")%></td>
    <td><%=rs.getDate("event_date")%></td>
    <td><%=rs.getTime("event_time")%></td>
    <td><%=rs.getString("location")%></td>
    <td><%=rs.getString("description")%></td>
</tr>
<%
        }
        rs.close(); ps.close(); con.close();
    }catch(Exception e){
        out.println("<p style='color:red;text-align:center;'>Error: "+e.getMessage()+"</p>");
    }
%>
</table>

</body>
</html>
