<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.Dbconnection" %>

<%
String idParam = request.getParameter("id");

if(idParam != null){
    try{
        Connection con = Dbconnection.connect();
        PreparedStatement ps = con.prepareStatement("DELETE FROM donations WHERE donation_id=?");
        ps.setInt(1, Integer.parseInt(idParam));
        int x = ps.executeUpdate();
        if(x>0){
            response.sendRedirect("admin_donations.jsp?msg=donation_deleted");
        } else {
            out.print("Failed to delete donation.");
        }
        ps.close();
        con.close();
    } catch(Exception e){
        out.print("Error: "+e.getMessage());
    }
}else{
    out.print("No donation selected.");
}
%>
