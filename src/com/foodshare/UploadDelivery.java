package com.foodshare;

import java.io.*;
import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import java.text.SimpleDateFormat;

@MultipartConfig   // required for file upload
public class UploadDelivery extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public UploadDelivery() {
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
            out.println("<script>alert('Invalid Task!'); window.location='volunteer_dashboard.jsp';</script>");
            return;
        }
        int taskId = Integer.parseInt(taskIdStr);

        // Get uploaded file
        Part filePart = request.getPart("delivery_image");
        if (filePart == null || filePart.getSize() == 0) {
            out.println("<script>alert('Please select an image!'); window.history.back();</script>");
            return;
        }

        try {
            // Prepare image data
            InputStream imageStream = filePart.getInputStream();

            // Get current timestamp as string
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String deliveryTimeStr = sdf.format(new java.util.Date());

            Connection con = Dbconnection.connect();

            // Update record: set delivery image, delivery time, and mark task as delivered
            PreparedStatement ps = con.prepareStatement(
                "UPDATE volunteer_tasks SET delivery_image_path=?, delivery_time=?, task_status='Delivered' WHERE task_id=?"
            );

            ps.setBinaryStream(1, imageStream, (int) filePart.getSize());
            ps.setString(2, deliveryTimeStr);  // store timestamp as VARCHAR
            ps.setInt(3, taskId);

            int result = ps.executeUpdate();

            if (result > 0) {
                out.println("<script>alert('Delivery image uploaded successfully!'); window.location='volunteer_dashboard.jsp';</script>");
            } else {
                out.println("<script>alert('Failed to upload image!'); window.history.back();</script>");
            }

        } catch (Exception e) {
            e.printStackTrace(out);
            out.println("<script>alert('Error occurred!'); window.history.back();</script>");
        }
    }
}
