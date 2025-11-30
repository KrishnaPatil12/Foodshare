<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String taskId = request.getParameter("task_id");
    if (taskId == null) {
        out.println("<h3 style='text-align:center;color:red;'>Invalid Task</h3>");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Upload Delivery Image</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: #f5f4ef;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
    }

    .card {
        background: #fff;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        width: 100%;
        max-width: 500px;
        text-align: center;
    }

    h2 {
        color: #0b757f;
        margin-bottom: 30px;
        font-weight: 600;
    }

    label {
        display: block;
        margin-bottom: 8px;
        color: #0b757f;
        font-weight: 500;
        text-align: left;
    }

    input[type="file"] {
        width: 100%;
        padding: 10px 14px;
        margin-bottom: 20px;
        border: 1px solid #cceeef;
        border-radius: 8px;
        background: #f9fdfd;
    }

    input[type="file"]:focus {
        border-color: #2ca9c8;
        outline: none;
    }

    button {
        width: 100%;
        padding: 12px 0;
        background: #7abec9;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 500;
        cursor: pointer;
        transition: 0.3s;
    }

    button:hover {
        background: #5daab6;
    }
</style>
</head>
<body>

<div class="card">
    <h2>Upload Delivery Image</h2>

    <form action="UploadDelivery" method="post" enctype="multipart/form-data">
        <input type="hidden" name="task_id" value="<%= taskId %>">

        <label>Select Delivery Image:</label>
        <input type="file" name="delivery_image" accept="image/*" required>

        <button type="submit">Upload Image</button>
    </form>
</div>

</body>
</html>
