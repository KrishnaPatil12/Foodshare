<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.foodshare.*" %>

<%
    // Get the logged-in volunteer ID
    Integer volunteerId = Getset.getId();  
    if(volunteerId == null) { 
        response.sendRedirect("volunteer_login.jsp"); 
        return;
    }

    // Get donation/task id from form
    String donationIdStr = request.getParameter("donation_id");
    if(donationIdStr == null) {
        out.println("Invalid request!");
        return;
    }
    int donationId = Integer.parseInt(donationIdStr);

    Connection con = null;
    PreparedStatement psTask = null;
    PreparedStatement psUpdateDonation = null;

    try {
        con = Dbconnection.connect();

        //Get donation details
        PreparedStatement psGet = con.prepareStatement(
            "SELECT donor_id, food_name, quantity, pickup_time FROM donations WHERE donation_id=? AND status='Waiting for volunteer'"
        );
        psGet.setInt(1, donationId);
        ResultSet rs = psGet.executeQuery();

        if(rs.next()) {
            int donorId = rs.getInt("donor_id");
            String foodItem = rs.getString("food_name");
            int quantity = rs.getInt("quantity");
            String pickupTimeStr = rs.getString("pickup_time"); // string from donations

            // Format assigned_time as MySQL DATETIME string
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String assignedTimeStr = sdf.format(new java.util.Date()); // current timestamp

            // Insert into volunteer_tasks
            String insertTask = "INSERT INTO volunteer_tasks(donor_id, volunteer_id, food_item, quantity, pickup_time, assigned_time, task_status) VALUES (?,?,?,?,?,?,?)";
            psTask = con.prepareStatement(insertTask);
            psTask.setInt(1, donorId);
            psTask.setInt(2, volunteerId);
            psTask.setString(3, foodItem);
            psTask.setInt(4, quantity);
            psTask.setString(5, pickupTimeStr); // from donations
            psTask.setString(6, assignedTimeStr); // formatted current timestamp
            psTask.setString(7, "Assigned");

            int inserted = psTask.executeUpdate();

            if(inserted > 0) {
                // Update donation status
                psUpdateDonation = con.prepareStatement(
                    "UPDATE donations SET status='Volunteer assigned' WHERE donation_id=?"
                );
                psUpdateDonation.setInt(1, donationId);
                psUpdateDonation.executeUpdate();

                response.sendRedirect("volunteer_dashboard.jsp");
            } else {
                out.println("<p style='color:red;'>Failed to accept task!</p>");
            }

        } else {
            out.println("<p style='color:red;'>Task not available or already assigned!</p>");
        }

    } catch(Exception e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>Error: "+e.getMessage()+"</p>");
    } finally {
        try { if(psTask != null) psTask.close(); } catch(Exception e) {}
        try { if(psUpdateDonation != null) psUpdateDonation.close(); } catch(Exception e) {}
        try { if(con != null) con.close(); } catch(Exception e) {}
    }
%>
