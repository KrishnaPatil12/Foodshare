<%@ page import="java.sql.*" %>
<%@ page import="com.foodshare.Dbconnection" %>

<%
    String idParam = request.getParameter("id");

    if (idParam != null) {
        try {
            Connection con = Dbconnection.connect();
            PreparedStatement ps = con.prepareStatement("DELETE FROM ngo_events WHERE ngo_event_id=?");
            ps.setInt(1, Integer.parseInt(idParam));
            int result = ps.executeUpdate();

            if (result > 0) {
                out.println("<script>alert('Event deleted successfully!'); window.location='admin_events.jsp';</script>");
            } else {
                out.println("<script>alert('Failed to delete event!'); window.location='admin_events.jsp';</script>");
            }

        } catch(Exception e) {
            out.println("<script>alert('Error deleting event: " + e.getMessage() + "'); window.location='admin_events.jsp';</script>");
        }
    } else {
        out.println("<script>alert('Invalid event ID!'); window.location='admin_events.jsp';</script>");
    }
%>
