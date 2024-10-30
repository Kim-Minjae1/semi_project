<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Knock Book</title>
</head>
<body>
<style>
      body {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            color: #333;
        }
        .container {
            text-align: center;
        }
        .error-code {
            font-size: 200px;
            font-weight: bold;
        }
        .error-message {
            font-size: 32px;
            margin-bottom: 20px;
        }
        .back-button {
            padding: 15px 30px;
            font-size: 18px;
            color: #fff;
            background-color: #e1ddb0;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
        }
       
        .back-button:hover {
            background-color: #e1ddb0;
            transform: translateY(-5px);
        }
    </style>
    <div class="container">
        <div class="error-code">403</div>
        <div class="error-message">Forbidden</div>
        <button class="back-button" onclick="goToHome()">Back Home →</button>
    </div>

    <script>
        function goToHome() {
            window.location.href = "/";
        }
    </script>
</body>
</html>