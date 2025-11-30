package com.foodshare;

import java.io.*;
import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;

@MultipartConfig   // required for file upload
public class UploadPickup extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public UploadPickup() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get task ID
        String taskIdStr = request.getParameter("task_id");
        if (taskIdStr == null) {
            out.println("<script>alert('Invalid Task!')</script>");
            return;
        }
        int taskId = Integer.parseInt(taskIdStr);

        // Get uploaded file
        Part filePart = request.getPart("pickup_image");
        if (filePart == null || filePart.getSize() == 0) {
            out.println("<script>alert('Please select an image!')</script>");
            return;
        }

        try {
            // Prepare image data
            InputStream imageStream = filePart.getInputStream();

            Connection con = Dbconnection.connect();

            // Update record
            PreparedStatement ps = con.prepareStatement(
                "UPDATE volunteer_tasks SET pickup_image_path=?, pickup_time=NOW(), task_status='Collected' WHERE task_id=?"
            );

            ps.setBinaryStream(1, imageStream, (int) filePart.getSize());
            ps.setInt(2, taskId);

            int result = ps.executeUpdate();

            if (result > 0) {
                out.println("<script>alert('Pickup image uploaded successfully!'); window.location='volunteer_dashboard.jsp';</script>");
            } else {
                out.println("<script>alert('Failed to upload image!');</script>");
            }

        } catch (Exception e) {
            e.printStackTrace(out);
        }
    }
}
