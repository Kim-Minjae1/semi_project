<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.book.member.user.vo.User" %>  
<meta charset="UTF-8">
<title>Knock Book</title>
<style>

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
        width: 120px;
      
    }

    .btn-secondary {
        background-color: #6c757d;
    }
    .container {
    	margin-top : 30px;
    }
     .account_form{
     margin-left: 70px;
     }
</style>
<div class="container">
    
        <div class="text-center">
            <h2>회원 정보 수정</h2>
            <hr />
        </div>
        <form action='/user/editEnd' name="modify_account_form" method="post" class="account_form">
            <%User u= (User)session.getAttribute("user");%>
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" name="name" id="name" placeholder="이름을 입력해주세요" style="width: 500px;">
            </div>
            <div class="form-group">
                <label for="id">아이디</label>
                <input type="text" name="id" value="<%=u.getUser_id() %>" readonly style="width: 500px;">
            </div>
            <div class="form-group">
                    <label for="pw">비밀번호</label>
                    <input type="password" oninput="validatePassword()" placeholder="비밀번호를 입력해주세요." id="pw" name="pw" style="width: 500px;">
                </div>
                <span id="tooltip-text" style="font-size: 10px;color: red; position: relative; top: -15px; left: 140px;">길이가 8~16자리 이하의 영문 대/소문자, 숫자, 특수문자(@$!%*?&)만 사용 가능합니다.</span>
            <div class="form-group">
                <label for="chpw">비밀번호 확인</label>
                <input type="password" name="chpw" id="chpw" placeholder="비밀번호를 다시 입력해주세요" style="width: 500px;">
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
                <input type="button" value="인증번호 받기" onclick="sendVerificationCode()" style="margin-left: 10px;">
            </div>
            <div class="form-group">
                    <input type="text" name="email_number" maxlength="6" placeholder="인증 코드 6자리를 입력해주세요." style="width: 500px; margin-left: 135px;">
                    <input type="button" value="인증번호 확인" onclick="verifyCode()">
                </div>
            <div class="form-group">
                    <label for="nickname">닉네임</label>
                    <input type="text" placeholder="닉네임을 입력해주세요." id="nickname" name="nickname" style="width: 500px;">
                    <input type="button" onclick="checkNickname();" value="닉네임 중복확인">
                    <input type="button" onclick="generateNickname();" value="닉네임 랜덤 생성">
                </div>
            <div class="button-group">
                <button type="button" class="btn" onclick="submit_button();">수정 완료</button>
                <button type="button" class="btn btn-secondary"onclick="history.back();">취소</button>
            </div>
        </form>
    </div>
    <script type="text/javascript">
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
    
    
    // 이메일 도메인 설정 함수 정의
    function setEmailDomain() {
        const emailSelect = document.getElementById('email_select');
        const emailDomain = document.getElementById('email_domain');
        emailDomain.value = emailSelect.value;
    }

    // 인증번호 발송 함수 정의
    function sendVerificationCode() {
        const form = document.modify_account_form;
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
        const form = document.modify_account_form;
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
    
 // 닉네임 중복 확인 함수 정의
    function checkNickname() {
        const form = document.modify_account_form;
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
    
    function submit_button() {
        const form = document.modify_account_form;
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
