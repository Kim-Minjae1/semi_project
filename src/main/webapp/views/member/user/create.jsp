<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Knock Book</title>
<style>
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
        min-width: 120px;
    }

    input[type="text"], input[type="password"], input[type="button"], input[type="email"], select {
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
    }

    input[type="text"], input[type="password"], input[type="email"] {
        width: calc(100% - 135px);
        max-width: 400px;
        margin-right: 10px;
    }

    select {
        width: 200px;
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
    <div class="container">
        <nav class="navbar">
            <a href="/" id="main_logo">Knock Book</a>
        </nav>
        <div class="text-center">
            <h2>회원가입</h2>
            <hr />
        </div>
        <div>
            <form name="create_account_form" action="/user/createEnd" method="post">
                <div class="form-group">
                    <label for="name">이름</label>
                    <input type="text" name="name" placeholder="이름을 입력해주세요." style="width: 500px;">
                </div>
                <div class="form-group">
                    <label for="id">아이디</label>
                    <input type="text" oninput="validateId()" name="id" id="id" placeholder="아이디를 입력해주세요." style="width: 500px;">
                    <input type="button" value="아이디 중복 확인" onclick="checkId();">
                </div>
                <span id="tooltipText" style="font-size: 10px;color: red; position: relative; top: -15px; left: 140px;">길이가 8~16자이며 첫 글자가 영문자인 영문자 숫자 문자열만 사용 가능합니다.</span>
                <div class="form-group">
                    <label for="pw">비밀번호</label>
                    <input type="password" oninput="validatePassword()" placeholder="비밀번호를 입력해주세요." id="pw" name="pw" style="width: 500px;">
                </div>
                <span id="tooltip-text" style="font-size: 10px;color: red; position: relative; top: -15px; left: 140px;">길이가 8~16자리 이하의 영문 대/소문자, 숫자, 특수문자(@$!%*?&)만 사용 가능합니다.</span>
                <div class="form-group">
                    <label for="chpw">비밀번호 확인</label>
                    <input type="password" placeholder="비밀번호를 다시 입력해주세요." name="chpw" style="width: 500px;">
                </div>
                <div class="form-group">
                    <label for="email_prefix">이메일</label>
                    <input type="text" id="email_prefix" name="email_prefix" style="width: 176px;"> @ 
                    <input type="text" id="email_domain" name="email_domain" style="width: 176px;">
                    <select id="email_select" name="email_select" onchange="setEmailDomain();">
                        <option value="">직접입력</option>
                        <option value="naver.com">네이버</option>
                        <option value="gmail.com">구글</option>
                        <option value="daum.net">다음</option>
                    </select>
                    <input type="button" value="인증번호 받기" onclick="sendVerificationCode();" style="margin-left: 10px;">
                </div>
                <div class="form-group">
                    <input type="text" name="email_number" maxlength="6" placeholder="인증 코드 6자리를 입력해주세요." style="width: 500px; margin-left: 135px;">
                    <input type="button" value="인증번호 확인" onclick="verifyCode();">
                </div>
                <div class="form-group">
                    <label for="nickname">닉네임</label>
                    <input type="text" placeholder="닉네임을 입력해주세요." id="nickname" name="nickname" style="width: 500px;">
                    <input type="button" onclick="checkNickname();" value="닉네임 중복확인">
                    <input type="button" onclick="generateNickname();" value="닉네임 랜덤 생성">
                </div>
                <div class="button-group">
                    <button type="button" class="btn" onclick="submit_button();">확인</button>
                    <button type="button" class="btn btn-secondary"onclick="location.href='/'">취소</button>
                </div>
            </form>
        </div>
    </div>
    <script>
    // 비밀번호 정규식
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
    
    // 아이디 정규식
    function validateId() {
        const idInput = document.getElementById('id');
        const tooltipText_id = document.getElementById('tooltipText');
        
        const letterAndNumberPattern = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+$/;
        const lengthPattern = /^[a-zA-Z\d]{8,16}$/;
        const startsWithLetterPattern = /^[a-zA-Z]/;

        if (letterAndNumberPattern.test(idInput.value) &&
            lengthPattern.test(idInput.value) &&
            startsWithLetterPattern.test(idInput.value)) {
            tooltipText_id.style.color = 'blue';
        } else {
            tooltipText_id.style.color = 'red';
        }
    }
    
    // 아이디 중복 확인 함수 정의
    function checkId() {
        const form = document.create_account_form;
        const id = form.id.value;
        
        const letterAndNumberPattern = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+$/;
        const lengthPattern = /^[a-zA-Z\d]{8,16}$/;
        const startsWithLetterPattern = /^[a-zA-Z]/;
        
        if (!id) {
            alert("아이디를 입력하세요.");
            form.id.focus();
        } else if (!letterAndNumberPattern.test(id)) {
            alert('아이디는 영문자와 숫자를 포함해야 합니다.');
            form.id.focus();
        } else if (!lengthPattern.test(id)) {
            alert('아이디는 길이 8~16자 문자 및 숫자를 포함해야 합니다.');
            form.id.focus();  
        } else if (!startsWithLetterPattern.test(id)) {
            alert('첫 글자는 영문자로 시작해야 합니다.');
            form.id.focus();  
        } else {
            // AJAX 요청을 사용하여 아이디 중복 확인
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "/user/checkId", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    if (xhr.responseText === "duplicate") {
                        alert("중복된 아이디입니다.                                                             설정한 아이디는 나중에 변경할수 없으니 신중히 입력해주세요.");
                    } else if (xhr.responseText === "available") {
                        alert("사용 가능한 아이디입니다.                                                      설정한 아이디는 나중에 변경할수 없으니 신중히 입력해주세요.");
                    } 
                }
            };
            xhr.send("id=" + encodeURIComponent(id));
        }
    }
    // 닉네임 중복 확인 함수 정의
    function checkNickname() {
        const form = document.create_account_form;
        const nickname = form.nickname.value;
        
        const letterNumberHangulPattern = /^[a-zA-Z0-9가-힣\s]{2,16}$/;
        
        if (!nickname) {
            alert("닉네임을 입력하세요.");
            form.nickname.focus();
        }else if (!letterNumberHangulPattern.test(nickname)) {
            alert('닉네임은 길이 2~16자의 영문자 또는 한글만 포함할 수 있습니다.');
            form.nickname.focus();
        } else {
            // AJAX 요청을 사용하여 아이디 중복 확인
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "/user/checkNickname", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    if (xhr.responseText === "duplicate") {
                        alert("중복된 닉네임입니다.");
                    } else if (xhr.responseText === "available") {
                        alert("사용 가능한 닉네임입니다.");
                    }
                }
            };
            xhr.send("nickname=" + encodeURIComponent(nickname));
        }
    }

    // 이메일 도메인 설정 함수 정의
    function setEmailDomain() {
        const emailSelect = document.getElementById('email_select');
        const emailDomain = document.getElementById('email_domain');
        emailDomain.value = emailSelect.value;
    }

    // 인증번호 발송 함수 정의
    function sendVerificationCode() {
        const form = document.create_account_form;
        const email = form.email_prefix.value + "@" + form.email_domain.value;
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

    // 인증번호 확인 함수 정의
    function verifyCode() {
        const form = document.create_account_form;
        const email = form.email_prefix.value + "@" + form.email_domain.value;
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
    // 닉네임 랜덤생성
    function generateNickname() {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', '/user/nicknameRandom', true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                document.getElementById('nickname').value = xhr.responseText;
            } else if (xhr.readyState === 4) {
                alert('닉네임 생성에 실패하였습니다.');
            }
        };
        xhr.send();
    }

    function submit_button() {
        const form = document.create_account_form;
        const lengthPattern = /^[a-zA-Z\d@$!%*?&]{8,16}$/;
        const letterPattern = /[a-zA-Z]/; 
        const numberPattern = /\d/; 
        const specialCharPattern = /[@$!%*?&]/;
        const namePattern1 = /^[가-힣]{2,4}$/;
        const namePattern2 = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/; 
        
        if (!form.id.value) {
            alert("아이디를 입력하세요.");
            form.id.focus();
        } else if (!form.pw.value) {
            alert("비밀번호를 입력하세요.");
            form.pw.focus();
        } else if (!form.chpw.value) {
            alert("비밀번호 확인을 입력하세요.");
            form.chpw.focus();
        } else if (form.pw.value !== form.chpw.value) {
            alert("비밀번호가 일치하는지 확인해주세요.");
            form.pw.focus(); 
        } else if (!lengthPattern.test(form.pw.value)) {
            alert('비밀번호는 8자에서 16자 사이의 영문자, 숫자 및 특수문자(@$!%*?&)만 포함해야 합니다.');
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
        } else if (!form.name.value) {
            alert("이름을 입력하세요.");
            form.name.focus();
        } else if (!namePattern1.test(form.name.value)) {
            alert("이름은 2~4자 사이의 한글 문자열이어야 합니다.");
            form.name.focus();
        } else if (!namePattern2.test(form.name.value)) {
            alert("이름은 영문자를 포함할 수 없습니다.");
            form.name.focus();
        } else if (!form.email_prefix.value || !form.email_domain.value) {
            alert("이메일을 입력하세요.");
            form.email_prefix.focus();
        } else if (!form.email_number.value) {
            alert("인증번호를 입력하세요.");
            form.email_number.focus();
        } else if (!form.nickname.value) {
            alert("닉네임을 입력하세요.");
            form.nickname.focus();
        } else {
            form.submit();
        }
        
       
    }
    </script>
</body>
</html>