<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Knock Book</title>
<style>  
    body { 
        background-color: #f0f2f5;
        margin: 0;
        padding: 0;
    }
    .container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 30px;
        max-width: 1200px;
        margin: 200px auto;
        padding: 20px;
    }
    .box {
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.4);
        padding: 25px;
        transition: transform 0.3s ease;
    }
    .box:hover {
        transform: translateY(-10px);
    }
    
    .box h2 {
    	margin-top: 30px;
    }
    
    h2 {
    	font-family: 'LINESeedKR-Bd';
        font-size: 24px;
        color: #333;
        margin-bottom: 20px;
        text-align: center;
    }
    .list {
        list-style: none;
        padding: 0;
        margin: 40px 0;
    }
    
    .list-item {
    	font-family: 'LINESeedKR-Bd';
        margin-bottom: 12px;
    }
    .list-item a {
    	text-align : center;
        text-decoration: none;
        color: #4a4a4a;
        font-size: 20px;
        display: block;
        padding: 8px 12px;
        border-radius: 5px;
        transition: background-color 0.2s ease;
    }
    .list-item a:hover {
    	text-decoration: none;
        background-color: #f0f0f0;
        color: #000;
    }
</style> 
</head>
<body>
    
	<%@ include file="../include/header.jsp" %>
	<div class="container">
	    <div class="box">
	        <h2>도서</h2>
	        <ul class="list">
	            <li class="list-item"><a href="/book/list">도서 목록</a></li>
	            <li class="list-item"><a href="/book/create">도서 추가</a></li>
	            <li class="list-item"><a href="/book/applyStatusList">도서 신청 목록</a></li>
	        </ul>
	    </div>
	    <div class="box">
	        <h2>이벤트</h2>
	        <ul class="list">
	            <li class="list-item"><a href="/event/list">이벤트 목록</a></li>
	            <li class="list-item"><a href="/event/create">이벤트 추가</a></li>
	            <li class="list-item"><a href="/event/parList">참여자 목록</a></li>
	        </ul>
	    </div>
	    <div class="box">
	        <h2>문의사항</h2>
	        <ul class="list">
	            <li class="list-item"><a href="/admin/sg/list">문의사항 목록</a></li>
	            <li class="list-item"><a href="/admin/sg/basic">문의사항 기본 답변</a></li>
	        </ul>
	    </div>
	    <div class="box">
	        <h2>회원</h2>
	        <ul class="list">
	            <li class="list-item"><a href="/user/check_table">회원 목록</a></li> 
	        </ul>
	    </div>
	</div>
</body>
</html>