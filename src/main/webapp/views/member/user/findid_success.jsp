<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.book.member.user.vo.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html> 
<head>
<meta charset="UTF-8">
<title>Knock Book</title> 
<style>
	@charset "UTF-8";

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
	
	@font-face {
	    font-family: 'JalnanGothic';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_231029@1.1/JalnanGothic.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	
	#main_logo {
        font-size: 33px;
        color: rgb(224, 195, 163);
        text-decoration: none;
        font-family: 'JalnanGothic';
    } 
	
	#header_nav {
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    height: 100px;
	}
	
	.container {
	    width: 100%;
	    max-width: 600px;
	    margin-top: -50px;
	}
	
	.text-center {
	    margin-top: 20px; 
	}
	
	.input-group {
	    margin-bottom: 15px;
	    display: flex;
	    align-items: center;
	    border: 2px solid black; width : 600px; height: 200px;
	}
	
	.button-group {
	    margin-top: 100px;
	    display: flex;
	    justify-content: center; /* Center align buttons */
	    gap: 10px;
	}
	
	.input-group ol li {
	    font-size: 20px;
	    margin-bottom: 10px;
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
	
	.btn-secondary {
	    background-color: #6c757d;
	}
</style>
</head>
<body>
	 <div class="container">
        <nav id="header_nav">
            <a href="/" id="main_logo">Knock Book</a>
        </nav>
        <div class="text-center" >
            <h2>아이디 찾기</h2>
            <hr>
            <p>고객님의 정보와 일치하는 아이디 목록입니다.</p>
            <br><br>
        </div>
        <div class="input-group" >
        
            <ol>
 		       <%
                    List<User> users = (List<User>)session.getAttribute("user");  
                    for (User user : users) {
                %>
                        <li>
                            <%= user.getUser_id() %>  
                        </li>
                <%
                    }
                %>
            </ol>
        </div>
        <div class="button-group">
            <button type="button" class="btn"onclick="location.href='/user/findpw'"style="width: 125px;">비밀번호 찾기</button>
            <button type="button" class="btn btn-secondary"onclick="location.href='/user/login'"style="width: 125px;">취소</button>
        </div>
    </div>
</body>
</html>