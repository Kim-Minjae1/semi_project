<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Knock Book</title>
<link href='../../resources/css/member/user/create_success.css'
	rel="stylesheet" type="text/css">
</head>
<style>
	@charset "UTF-8";
	
	@font-face {
	    font-family: 'JalnanGothic';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_231029@1.1/JalnanGothic.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	
	/* 프리젠테이션 */
	@font-face {
	    font-family: 'Freesentation-9Black';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2404@1.0/Freesentation-9Black.woff2') format('woff2');
	    font-weight: 700;
	    font-style: normal;
	}
	/* LINE Seed */
	@font-face {
	    font-family: 'LINESeedKR-Bd';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Bd.woff2') format('woff2');
	    font-weight: 700;
	    font-style: normal;
	}
	
	* {
		 font-family: 'LINESeedKR-Bd';
         box-sizing: border-box; 
         margin: 0;  
     }
     .main_logo {
         font-size: 30px;
         color: rgb(224, 195, 163);
         text-decoration: none;
         font-family: 'JalnanGothic';
         
     }
     #header_div {
         width: 100%;
         height: 90px;
         display: flex;
         justify-content: space-between;
         align-items: center; 
         margin-bottom: 10px;
     }
     main {
         display: flex;
         flex-direction: column;
         justify-content: center;
         align-items: center;
         height: 50vh; 
         text-align: center;
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
<body>
	<section class="main_header">
        <header>
            <div id="header_div">
                <a href="/" class="main_logo" style="margin-left: 100px;">Knock Book</a>
            </div>
        </header>
        <main>
        <div style="font-size: 40px;">회원가입이 완료되었습니다.</div>
        <div style="font-size: 40px;">로그인을 진행해 주세요.</div>
        </main>
        <footer>
            <input class="btn" type="button" value="로그인" style="margin-right: 20px;"onclick="location.href='/user/login'">
            <input class="btn" type="button" value="홈으로" style="margin-left: 20px;"onclick="location.href='/'">
        </footer>
    </section> 
</body>
</html>