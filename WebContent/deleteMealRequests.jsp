<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.Dbconnection" %>

<%
    String idParam = request.getParameter("id");
    if(idParam != null){
        try {
            int id = Integer.parseInt(idParam);
            Connection con = Dbconnection.connect();
            PreparedStatement ps = con.prepareStatement("DELETE FROM meal_requests WHERE request_id=?");
            ps.setInt(1, id);

            int x = ps.executeUpdate();
            if(x > 0){
                response.sendRedirect("admin_requests.jsp?msg=request_deleted");
            } else {
                out.print("Failed to delete request.");
            }
            ps.close(); con.close();
        } catch(Exception e){ out.print("Error: "+e.getMessage()); }
    } else {
        out.print("No request selected.");
    }
%>
