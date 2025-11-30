<!DOCTYPE html>
<html>
<head>
<title>Safety Checklist</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
    body {
        margin: 0;
        padding: 40px;
        font-family: 'Poppins', sans-serif;
        background: #f5f4ef;
    }

    h2 {
        text-align: center;
        margin-bottom: 25px;
        color: #333;
    }

    .checklist-box {
        width: 70%;
        margin: auto;
        background: white;
        padding: 30px;
        border-radius: 18px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.08);
    }

    .item {
        display: flex;
        align-items: center;
        gap: 10px;
        margin: 18px 0;
        padding: 12px;
        background: #eef9fa;
        border-radius: 12px;
        border: 1px solid #cfecee;
    }

    .item label {
        font-size: 16px;
        color: #333;
        cursor: pointer;
    }

    input[type="checkbox"] {
        width: 20px;
        height: 20px;
        cursor: pointer;
    }

    .submit-btn {
        width: 100%;
        margin-top: 25px;
        padding: 12px;
        border: none;
        border-radius: 14px;
        background: #7abec9;
        color: white;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
    }

    .submit-btn:hover {
        background: #67aeb9;
    }

    .msg {
        text-align: center;
        margin-top: 20px;
        font-size: 16px;
        font-weight: 600;
    }
</style>
</head>

<body>

<h2>Safety Checklist Before Donating Food</h2>

<div class="checklist-box">

<form method="post" action="safetyChecklist.jsp">

    <div class="item">
        <input type="checkbox" name="expired">
        <label>Food is NOT expired</label>
    </div>

    <div class="item">
        <input type="checkbox" name="packed">
        <label>Food is packed properly</label>
    </div>

    <div class="item">
        <input type="checkbox" name="temp">
        <label>Food temperature is maintained</label>
    </div>

    <button class="submit-btn" type="submit">Confirm Checklist</button>

</form>

<%
String expired = request.getParameter("expired");
String packed = request.getParameter("packed");
String temp = request.getParameter("temp");

if(request.getParameter("expired") != null || 
   request.getParameter("packed") != null || 
   request.getParameter("temp") != null ) {

    if(expired != null && packed != null && temp != null) {
%>
        <p class="msg" style="color:green;"> All Safety Checks Passed!</p>
<%
    } else {
%>
        <p class="msg" style="color:red;">Please complete all safety steps.</p>
<%
    }
}
%>

</div>

</body>
</html>
