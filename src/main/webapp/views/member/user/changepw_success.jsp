<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Knock Book</title>
<style>
	  @charset "UTF-8";

	  @font-face {
		    font-family: 'JalnanGothic';
		    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_231029@1.1/JalnanGothic.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		
	    body {
	        display: flex;
	        justify-content: center;
	        align-items: center;
	        background-color: #fff;
	        height: 100vh;
	        padding: 0;
	        margin: 0;
	        font-family: Arial, sans-serif;
	    }
	
	    .container {
	        width: 100%;
	        max-width: 600px;
	        margin-top: -50px;
	    }
        #header_div {
            width: 100%;
            height: 90px;
            display: flex;
            justify-content: space-between;
            align-items: center; 
            margin-bottom: 10px;
        }
	    #main_logo {
	        font-size: 33px;
	        color: rgb(224, 195, 163);
	        text-decoration: none;
	        font-family: 'JalnanGothic';
	    }
		
		.navbar {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    height: 100px;
		}
        main div{
            padding-bottom: 20px;
        }
        
        footer{
            display: flex;
            justify-content: center;
            align-items: center;
            height: 20vh; 
            text-align: center;
        }
        .btn {
            padding: 10px 20px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100px;
        }
</style>
<link href='../../resources/css/user/changepw_success.css'
	rel="stylesheet" type="text/css">
</head>
<body>
	<section class="main_header">
	 	<div class="container">
        <nav class="navbar">
            <a href="/" id="main_logo">Knock Book</a>
        </nav>
        </div>
        <main>
        <div style="font-size: 40px;">변경이 완료되었습니다.</div>
        <div style="font-size: 40px;">로그인을 진행해 주세요.</div>
        </main>
        <footer>
            <input class="btn" type="button" value="로그인" style="margin-right: 20px;"onclick="location.href='/user/login'">
            <input class="btn" type="button" value="홈으로" style="margin-left: 20px;"onclick="location.href='/'">
        </footer>
    </section> 
</body>
</html>