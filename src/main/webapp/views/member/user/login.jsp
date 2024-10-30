<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
<head>
<meta charset="UTF-8">
<title>Knock Book</title>
<link href='../../resources/css/member/user/login.css' rel="stylesheet" type="text/css">
</head>
<style>
	@charset "UTF-8";
	@font-face {
	    font-family: 'JalnanGothic';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_231029@1.1/JalnanGothic.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	
	/* LINE Seed */
	@font-face {
	    font-family: 'LINESeedKR-Bd';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Bd.woff2') format('woff2');
	    font-weight: 700;
	    font-style: normal;
	}  
	
	#main_logo {
        font-size: 30px;
        color: rgb(224, 195, 163);
        text-decoration: none;
        font-family: 'JalnanGothic';
    }

    /* 하단 content */
    main {
    	font-family: 'LINESeedKR-Bd'; 
        display: flex;
        justify-content: center;
        padding-top: 30px;
        padding-left: 50px;
        padding-right: 50px;
    }

    #right {
        background-color: rgba(255, 192, 203, 0);
        width: 1050px;
        height: 700px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: -70px;
    }

    #main_div {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        height: 75vh;
    }

    #main_div label,
    #main_div input {
        width: 50%;
    }

    #main_div input {
        margin-top: 20px;
        margin-bottom: 20px;
        height: 40px;
        width: 400px;
    }

    #main_div button {
        width: 100px;
        margin-top: 50px;
        background-color: #007BFF;
        color: white;
        cursor: pointer;
        width: 100px;
        border-radius: 5px;
        height: 35px;
    }

    #main_div button:first-child {
        margin-left: 0;
    }

    #down_link a {
        text-decoration: none;
        color: inherit; /* 원래 링크 색상으로 설정 */
		outline: none;
    }

    form {
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 100%;
    }
</style>
<body>
	<main>
        <section id="right">
            <div id="main_div">
                <a href="/" id="main_logo">
                    <h1>Knock Book</h1>
                </a>
                <form name="login_form" action="/user/loginEnd" method="post">
                    <input type="text" name="id" placeholder="아이디를 입력해 주세요" style="border-radius: 5px;">
                    <input type="password" name="pw" placeholder="비밀번호를 입력해 주세요" style="border-radius: 5px;">
                    <button type="button" onclick="loginForm();">로그인</button>
                </form>
                <br>
                <div id="down_link">
                    <a href="/user/findid">아이디 찾기 | </a><a href="/user/findpw">비밀번호 찾기 | </a><a href="/user/create">회원가입</a>
                </div>
            </div>
        </section>
    </main>

	<script type="text/javascript">
		function loginForm() {
			let form = document.login_form;
			if (form.id.value == '') {
				alert('아이디를 입력하세요.');
				form.id.focus();	
			} else if (form.pw.value == '') {
				alert('비밀번호를 입력하세요.');
				form.pw.focus();
			} else {
				form.submit();
			}
		}
	</script>
</body>
</html>