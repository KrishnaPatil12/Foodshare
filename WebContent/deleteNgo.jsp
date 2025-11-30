<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>

<%
    String idParam = request.getParameter("id");

    if(idParam != null && !idParam.isEmpty()){
        try {
            int id = Integer.parseInt(idParam);

            Connection con = Dbconnection.connect();
            PreparedStatement ps = con.prepareStatement("DELETE FROM ngo WHERE ngo_id=?");
            ps.setInt(1, id);

            int x = ps.executeUpdate();
            if (x > 0) {
                response.sendRedirect("admin_users.jsp?msg=ngo_deleted");
            } else {
                out.print("Failed to delete NGO.");
            }

            ps.close();
            con.close();

        } catch (Exception e) {
            out.print("Error: " + e.getMessage());
        }
    } else {
        out.print("No NGO selected.");
    }
%>
