<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.*" %>

<%
    String idParam = request.getParameter("id");

    if(idParam != null){
        try {
            int id = Integer.parseInt(idParam); // convert to int

            Connection con = Dbconnection.connect();
            PreparedStatement ps = con.prepareStatement("DELETE FROM donor WHERE id=?");
            ps.setInt(1, id); // use setInt

            int x = ps.executeUpdate();
            if (x > 0) {
                response.sendRedirect("admin_users.jsp?msg=donor_deleted");
            } else {
                out.print("Failed to delete donor.");
            }

            ps.close();
            con.close();

        } catch (Exception e) {
            out.print("Error: " + e.getMessage());
        }
    } else {
        out.print("No donor selected.");
    }
%>
