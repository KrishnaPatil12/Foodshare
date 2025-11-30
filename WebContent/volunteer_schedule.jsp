<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>

<%
    Integer volunteerId = Getset.getId(); // Logged-in volunteer
    if(volunteerId == null){
        response.sendRedirect("volunteer_login.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String currentDays = "";
    String currentStart = "";
    String currentEnd = "";

    try {
        con = Dbconnection.connect();
        ps = con.prepareStatement("SELECT availability_days, availability_start_time, availability_end_time FROM volunteer WHERE volunteer_id=?");
        ps.setInt(1, volunteerId);
        rs = ps.executeQuery();
        if(rs.next()){
            currentDays = rs.getString("availability_days") != null ? rs.getString("availability_days") : "";
            currentStart = rs.getString("availability_start_time") != null ? rs.getString("availability_start_time") : "";
            currentEnd = rs.getString("availability_end_time") != null ? rs.getString("availability_end_time") : "";
        }
    } catch(Exception e){
        e.printStackTrace();
    } finally {
        try{ if(rs!=null) rs.close(); } catch(Exception e){}
        try{ if(ps!=null) ps.close(); } catch(Exception e){}
        try{ if(con!=null) con.close(); } catch(Exception e){}
    }

    // Split days into array for checkboxes
    String[] selectedDays = currentDays.split(",");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Volunteer Schedule Availability</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
<style>
body {
    font-family: 'Poppins', sans-serif;
    background: #f5f4ef;
    margin: 0;
    padding: 0;
}
.container {
    max-width: 700px;
    margin: 50px auto;
    background: white;
    padding: 30px 40px;
    border-radius: 12px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.1);
}
h2 {
    text-align: center;
    color: #333;
    margin-bottom: 30px;
}
label {
    display: block;
    margin-top: 15px;
    font-weight: 500;
}
input[type="time"], select {
    width: 100%;
    padding: 10px;
    margin-top: 6px;
    border-radius: 8px;
    border: 1px solid #ccc;
}
.days-checkboxes label {
    display: inline-block;
    margin-right: 15px;
    font-weight: 400;
}
button {
    margin-top: 25px;
    width: 100%;
    padding: 12px;
    background: #7abec9;
    color: white;
    border: none;
    border-radius: 10px;
    font-size: 16px;
    cursor: pointer;
    transition: 0.3s;
    font-weight: 500;
}
button:hover {
    background: #5daab6;
}
</style>
</head>
<body>

<div class="container">
    <h2>Set Your Availability</h2>

    <form method="post">
        <label>Available Days:</label>
        <div class="days-checkboxes">
            <%
                String[] allDays = {"Mon","Tue","Wed","Thu","Fri","Sat","Sun"};
                for(String day : allDays){
                    String checked = "";
                    for(String sel : selectedDays){
                        if(sel.trim().equals(day)) checked = "checked";
                    }
            %>
            <label><input type="checkbox" name="days" value="<%=day%>" <%=checked%> > <%=day%></label>
            <% } %>
        </div>

        <label>Start Time:</label>
        <input type="time" name="start_time" value="<%=currentStart%>" required>

        <label>End Time:</label>
        <input type="time" name="end_time" value="<%=currentEnd%>" required>

        <button type="submit">Save Schedule</button>
    </form>

<%
    if(request.getMethod().equalsIgnoreCase("POST")){
        String[] daysArr = request.getParameterValues("days");
        String startTime = request.getParameter("start_time");
        String endTime = request.getParameter("end_time");

        if(daysArr != null && startTime != null && endTime != null){
            String days = String.join(",", daysArr);

            try{
                con = Dbconnection.connect();
                ps = con.prepareStatement("UPDATE volunteer SET availability_days=?, availability_start_time=?, availability_end_time=? WHERE volunteer_id=?");
                ps.setString(1, days);
                ps.setString(2, startTime);
                ps.setString(3, endTime);
                ps.setInt(4, volunteerId);

                int updated = ps.executeUpdate();
                if(updated > 0){
%>
                    <script>alert('Schedule saved successfully!'); window.location='volunteer_dashboard.jsp';</script>
<%
                } else {
%>
                    <script>alert('Failed to save schedule!');</script>
<%
                }
            } catch(Exception e){
                e.printStackTrace();
%>
                <script>alert('Error: <%= e.getMessage() %>');</script>
<%
            } finally{
                try{ if(ps!=null) ps.close(); } catch(Exception e){}
                try{ if(con!=null) con.close(); } catch(Exception e){}
            }
        } else {
%>
            <script>alert('Please select days and time!');</script>
<%
        }
    }
%>

</div>
</body>
</html>
