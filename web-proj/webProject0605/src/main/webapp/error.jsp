<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8d7da;
            color: #721c24;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            text-align: center;
            border: 1px solid #f5c6cb;
            background-color: #f8d7da;
            padding: 20px;
            border-radius: 5px;
        }
        h1 {
            font-size: 2em;
        }
        p {
            font-size: 1.2em;
        }
        a {
            color: #004085;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>무언가 잘못되었습니다.</h1>
        <p>요청에 응답하지 않습니다.</p>
        <p><a href="UserManagement.jsp">다시하기</a></p>
    </div>
</body>
</html>
