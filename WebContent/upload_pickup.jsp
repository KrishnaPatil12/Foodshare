<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String taskId = request.getParameter("task_id");
    if (taskId == null) {
        out.println("<h3>Invalid Task</h3>");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Upload Pickup Image</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
    body {
        margin: 0;
        padding: 30px;
        font-family: 'Poppins', sans-serif;
        background: #f5f4ef;
        display: flex;
        justify-content: center;
    }

    .container {
        width: 420px;
        background: white;
        padding: 30px;
        border-radius: 14px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    }

    h2 {
        text-align: center;
        margin-bottom: 25px;
        color: #333;
        font-weight: 600;
        font-size: 22px;
    }

    label {
        font-size: 15px;
        font-weight: 500;
        color: #444;
    }

    input[type="file"] {
        margin-top: 10px;
        padding: 8px;
        width: 100%;
        background: #f0f9fa;
        border: 1px solid #ccc;
        border-radius: 8px;
        cursor: pointer;
    }

    .upload-btn {
        margin-top: 20px;
        width: 100%;
        padding: 12px;
        background: #7abec9;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: 0.3s;
    }

    .upload-btn:hover {
        background: #5daab6;
    }

</style>
</head>

<body>

<div class="container">
    <h2>Upload Pickup Image<br>Task ID: <%= taskId %></h2>

    <form action="UploadPickup" method="post" enctype="multipart/form-data">
        <input type="hidden" name="task_id" value="<%= taskId %>">

        <label>Select Pickup Image:</label>
        <input type="file" name="pickup_image" accept="image/*" required>

        <button type="submit" class="upload-btn">Upload Image</button>
    </form>
</div>

</body>
</html>
