<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
<head>
<meta charset="UTF-8">
<title>Knock Book</title>
<link href="../../resources/css/user/changepw.css" rel="stylesheet">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<style>
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
            margin-top: -50px; /* Slightly move up */
        }

        #main_logo {
            font-size: 30px;
            color: rgb(146, 136, 107);
            text-decoration: none;
            font-family: 'NanumSquare', sans-serif;
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
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="password"], input[type="text"], select {
            width: 90%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
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
	 <div class="container">
        <nav class="navbar">
            <a href="/" id="main_logo">Knock Book</a>
        </nav>
        <div class="text-center">
            <h2>비밀번호 재설정</h2>
            <hr />
            <p>비밀번호를 재설정 해주세요.</p>
        </div>
        <div>
            <form name="changepw_form" action="/user/changepw" method="post">
            <div class="form-group">
                <label for="pw">새 비밀번호</label>
                <div style="display: flex; align-items: center;">
                    <input type="password" id="pw" name="pw" placeholder="새 비밀번호" oninput="validatePassword()">
                </div>
                <div class="tooltip">
                    <span id="tooltip-text"  style="font-size: 10px;color: red;">길이가8~16자리 이하의 영문 대/소문자, 숫자, 특수문자 사용 가능합니다.</span>
                </div>
            </div>
            <div class="form-group">
                <label for="chpw">새 비밀번호 확인</label>
                <input type="password" id="chpw" name="chpw" placeholder="새 비밀번호 확인" style="margin-bottom: 100px;">
            </div>
            <div class="button-group">
                <button type="button" onclick="submit_button();" class="btn" style="margin-top: 50px; margin-right: 30px">확인</button>
                <button type="button" class="btn btn-secondary" style="margin-top: 50px; margin-left: 30px" onclick="location.href='/'">취소</button>
            </div>
            </form>
        </div>
    </div>
    <script>
        
        function validatePassword() {
            const passwordInput = document.getElementById('pw');
            const tooltipText = document.getElementById('tooltip-text');
            const lengthPattern = /^[a-zA-Z\d@$!%*?&]{8,16}$/;
            const letterPattern = /[a-zA-Z]/; 
            const numberPattern = /\d/; 
            const specialCharPattern = /[@$!%*?&]/;

            if (lengthPattern.test(passwordInput.value) &&
                letterPattern.test(passwordInput.value) &&
                numberPattern.test(passwordInput.value) &&
                specialCharPattern.test(passwordInput.value)) {
                tooltipText.style.color = 'blue';
            } else {
                tooltipText.style.color = 'red';
            }
        }

        function submit_button() {
            const form = document.changepw_form;

            var lengthPattern = /^[a-zA-Z\d@$!%*?&]{8,16}$/;
            var letterPattern = /[a-zA-Z]/; 
            var numberPattern = /\d/; 
            var specialCharPattern = /[@$!%*?&]/;

            if (!form.pw.value) {
                alert("비밀번호를 입력하세요.");
                form.id.focus();
            } else if (!form.chpw.value) {
                alert("비밀번호 확인을 입력하세요.");
                form.chpw.focus();
            } else if (form.pw.value !== form.chpw.value) {
                alert("비밀번호가 일치하는지 확인해주세요.");
                form.pw.focus();
            } else if (!lengthPattern.test(form.pw.value)) {
                alert('비밀번호는 8자에서 16자 사이의 영문자, 숫자 및 특수문자만 포함해야 합니다.');
                form.pw.focus();
            } else if (!letterPattern.test(form.pw.value)) {
                alert('비밀번호는 적어도 하나의 영문자를 포함해야 합니다.');
                form.pw.focus();
            } else if (!numberPattern.test(form.pw.value)) {
                alert('비밀번호는 적어도 하나의 숫자를 포함해야 합니다.');
                form.pw.focus();
            }else if(!specialCharPattern.test(form.pw.value)){
                alert('비밀번호는 적어도 하나의 특수문자를 포함해야 합니다.');
                form.pw.focus();
            } else {
                form.submit();
            }
        }
    </script>
</body>
</html>