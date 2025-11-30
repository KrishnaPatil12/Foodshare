package com.foodshare;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class DisplayPickupImage extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int taskId = Integer.parseInt(request.getParameter("task_id"));

        try {
            Connection con = Dbconnection.connect();
            PreparedStatement ps = con.prepareStatement(
                "SELECT pickup_image_path FROM volunteer_tasks WHERE task_id=?"
            );
            ps.setInt(1, taskId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                InputStream is = rs.getBinaryStream("pickup_image_path");

                if (is == null) {
                    return; // no image
                }

                response.setContentType("image/jpeg");

                OutputStream os = response.getOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead;

                while ((bytesRead = is.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }

                is.close();
                os.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
