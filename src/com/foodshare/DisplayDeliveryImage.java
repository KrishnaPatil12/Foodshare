package com.foodshare;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class DisplayDeliveryImage extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int taskId = Integer.parseInt(request.getParameter("task_id"));

        try {
            Connection con = Dbconnection.connect();
            PreparedStatement ps = con.prepareStatement("SELECT delivery_image_path FROM volunteer_tasks WHERE task_id=?");
            ps.setInt(1, taskId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Blob blob = rs.getBlob("delivery_image_path");
                if (blob != null) {
                    response.setContentType("image/jpeg"); // or image/png depending on your file
                    InputStream is = blob.getBinaryStream();
                    OutputStream os = response.getOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead;
                    while ((bytesRead = is.read(buffer)) != -1) {
                        os.write(buffer, 0, bytesRead);
                    }
                    is.close();
                    os.close();
                }
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
