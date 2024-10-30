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
	
	    .text-center {
	        margin-bottom: 50px;
	    }
	
	    .form-group {
	        margin-bottom: 15px;
	        display: flex;
	        align-items: center;
	        justify-content: flex-start;
	    }
	
	    label {
	        margin-right: 15px;
	        font-weight: bold;
	        min-width: 80px; 
	    }
	
	    input[type="text"], input[type="email"], input[type="button"] {
	        padding: 10px;
	        border: 1px solid #ccc;
	        border-radius: 5px;
	        font-size: 16px;
	    }
	
	    input[type="text"], input[type="email"] {
	        width: calc(100% - 95px); 
	        max-width: 400px;
	        margin-right: 10px;
	    }
	
	    input[type="button"] {
	        background-color: #007BFF;
	        color: white;
	        cursor: pointer;
	        width: auto;
	    }
	
	    .button-group {
	        display: flex;
	        justify-content: center;
	        gap: 20px;
	        margin-top: 40px;
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
	<main>
        <div class="container">
        <nav class="navbar">
            <a href="/" id="main_logo">Knock Book</a>
        </nav>
        <div class="text-center">
            <h2>비밀번호 찾기</h2>
            <hr />
            <h4>본인확인 이메일로 인증</h4>
            <p>본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</p>
        </div>
        <div>
        <form name="findpw_form" action="/user/findpwend" method="post">
            <div class="form-group">
                <label for="name">아이디 :</label>
                <input type="text" id="id" name="id" placeholder="아이디를 입력하세요" style="width: 352px;">
            </div>
            <div class="form-group">
                <label for="email">이메일:</label>
                <input type="email" id="email" name="email" placeholder="이메일을 입력하세요">
                <input type="button" value="인증번호 받기" onclick="sendVerificationCode()">
            </div>
            <div class="form-group">
                <input type="text" name="email_number" maxlength="6" placeholder="인증번호 6자리 입력해 주세요." style="margin-left: 95px;">
                <input type="button" value="인증번호 확인" onclick="verifyCode();">
            </div>
            <div class="button-group">
                <button type="button" class="btn" onclick="next_button();">다음</button>
                <button type="button" class="btn btn-secondary" onclick="location.href='/'">취소</button>
            </div>
            </form>
        </div>
    </div>
    </main>
	<script type="text/javascript">
	function sendVerificationCode() {
        const form = document.findpw_form;
        const email = form.email.value;
        if (!email.includes("@")) {
            alert("올바른 이메일 주소를 입력하세요.");
            return;
        }
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "/user/sendVerificationCode", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                alert("인증번호가 발송되었습니다. 이메일을 확인하세요.");
            }
        };
        xhr.send("email=" + encodeURIComponent(email));
    }

    function verifyCode() {
        const form = document.findpw_form;
        const email = form.email.value;
        const code = form.email_number.value;
        if (code.length !== 6) {
            alert("6자리 인증 코드를 입력하세요.");
            return;
        }
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "/user/verifyCode", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                if (xhr.responseText === "success") {
                    alert("인증번호가 확인되었습니다.");
                } else {
                    alert("잘못된 인증번호입니다.");
                }
            }
        };
        xhr.send("email=" + encodeURIComponent(email) + "&code=" + encodeURIComponent(code));
    }
	
		function next_button() {
			let form = document.findpw_form;
			if (form.id.value == '') {
				alert('아이디를 입력하세요.');
				form.id.focus();	
			} else if (form.email.value == '') {
				alert('이메일을 입력하세요.');
				form.email.focus();
			} else if (form.email_number.value == '') {
				alert('인증번호를 입력하세요.');
				form.email_number.focus();
			} else {
				form.submit();
			}
		}
	</script>
</body>
</html>