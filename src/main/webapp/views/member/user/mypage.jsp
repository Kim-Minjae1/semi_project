<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Knock Book</title>
<style>
		body { 
		    -ms-overflow-style: none;
		}
		
		::-webkit-scrollbar {
			display: none;
		} 

		/* 한나체Pro */
		@font-face {
		    font-family: 'BMHANNAPro';
		    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_seven@1.0/BMHANNAPro.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		
		/* 여기어때 잘난체 고딕 */
		@font-face {
		    font-family: 'JalnanGothic';
		    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_231029@1.1/JalnanGothic.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		.main_content {
		    width: 75vw;
		    height: 740px;
		    margin: 5rem auto;
		    background-color: rgb(247, 247, 247);
		    display: flex;
		    flex-direction: row;
		}
		/* 사이드바 */
		.section1 {
		    width: 25%;
		    margin-right: 2rem;
		    height: 100%;
		    background-color: white;
		    font-family: 'BMHANNAPro';
		    box-shadow: 0 5px 7px rgba(0, 0, 0, 0.1);
		    border-radius: 20px;
		    overflow: hidden; /* 추가 */
		}
		
		.menu {
		    list-style-type: none;
		    padding: 0;
		    height: 680px;
		    background-color: white;
		    border-radius: 20px 20px 0 0; /* 추가 */
		}
		
		.menu-item:first-child a {
		    border-top-left-radius: 20px; /* 추가 */
		    border-top-right-radius: 20px; /* 추가 */
		}
		
		.menu-item {
		    width: 100%;
		    background-color: white;
		    font-family: 'BMHANNAPro';
		    font-size: 1vw;
		}
		
		.menu-item a {
		    color: black;
		    text-decoration: none;
		    display: block;
		    padding: 20px;
		    padding-left: 30px;
		    background-color: white;
		    transition: background-color 0.3s ease;
		    font-family: 'BMHANNAPro';
		}
		
		
		.menu-item a:hover {
		    background-color: rgb(247, 247, 247);
		}
		@keyframes slide-down {
		    0% {
		        opacity: 0;
		        transform: translateY(-10px);
		    }
		    100% {
		        opacity: 1;
		        transform: translateY(0);
		    }
		}
		
		@keyframes slide-up {
		    0% {
		        opacity: 1;
		        height: auto;
		    }
		    100% {
		        opacity: 0;
		        height: 0;
		        padding: 0;
		        margin: 0;
		        border: 0;
		    }
		}
		.submenu {
		    display: none;
		    list-style-type: none;
		    padding: 0;
		    margin-top: 5px;
		    overflow: hidden;
		}
		
		.submenu li a {
		    color: black;
		    text-decoration: none;
		    padding: 20px;
		    display: block;
		    transition: background-color 0.3s ease;
		}
		.submenu li a:hover {
		    background-color: rgb(247, 247, 247);
		}
		/* 나의 정보 form */
		.section2{
		    width: 100%;
		    background-color: white;
		    display: flex;
		    flex-direction: column;
		   box-shadow: 0 5px 7px rgba(0, 0, 0, 0.1);
		   border-radius: 20px;
		}
		/* 나의 프로필 */
		.profileForm{
		    background-color: white;
		    margin: 15px;
		    margin-bottom: 5px;
		    width: 60vw;
		    border: 1px solid #858585;
		    border-radius: 10px;
		}
		#myProfile{
		    font-size: 2vw;
		    font-weight: 500;
		    margin-bottom: 25px;
		    padding-left: 15px;
		    margin-top: 25px;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    width: 100%;
		    font-family: 'BMHANNAPro';
		}
		.profileInfo{
		    background-color: white;
		    width: 100%;
		      height: 140px;
		      font-family: 'BMHANNAPro';
		}
		.firstGroup{
		    background-color: white;
		    width: 96%;
		    display: flex;
		    margin-top : 30px;
		    margin-bottom: 10px;
		}
		.firstGroup > div{
		    background-color: white;
		    width: 50%;
		    display: flex;
		    justify-content: space-around;
		}
		.firstGroup > div > p{
		    background-color: white;
		    width: 30%;
		    text-align: center;
		    font-size: 1.2vw;
		    margin-top: 8px;
		    font-family: 'BMHANNAPro';
		}
		.firstGroup > div > input{
		   font-family: 'BMHANNAPro';
		   font-size : 1.2vw;
		   width : 60%;
		}
		.secondGroup{
		    background-color: white;
		    width: 96%;
		    display: flex;
		    margin-bottom: 20px;
		}
		.secondGroup > div {
		    background-color: white;
		    width: 50%;
		    display: flex;
		    justify-content: space-around;
		
		}.secondGroup > div > p{
		    background-color: white;
		    width: 30%;
		    text-align: center;
		    font-size: 1.2vw;
		    margin-top: 8px;
		}
		.secondGroup > div > input{
		   font-family: 'BMHANNAPro';
		   font-size : 1.2vw;
		   width : 60%;
		   }
		.profile{
		    background-color: rgb(247, 247, 247); 
		    height: 35px;
		    width: 100%;
		    border: none;
		    pointer-events: none;
		    margin-left: 10px;
		    text-align: center;
		    color: black;
		}
		.updateProfile{
		    text-align: right;
		    margin-bottom: 25px;
		    background-color: white;
		    margin-right: 30px;
		}
		.profileBtn{
		    padding: 6px 12px;
		    font-size: 0.8vw;
		    font-family: 'BMHANNAPro';
		    text-decoration: none;
		    color: black;
		    background-color: white;
		    border: solid 1px #858585;
		    border-radius: 10px;
		    margin-right: 30px;
		}
		/*  나의 프로필 아래 부분 */
		.underForm{
		   width : 100%;
		    display: flex;
		    background-color: white;
		}
		/* 출석 */
		.attendForm{
		    background-color: white;
		    margin: 15px;
		    height: 360px;
		    width: 50%;
		    border: 1px solid #858585;
		    border-radius: 10px;
		    flex-direction: column;
		    justify-content: center;
		}
		#attend{
		    font-size: 2vw;
		    font-weight: 500;
		    font-family: 'BMHANNAPro';
		    margin-top: 32px;
		    display: flex;
		    justify-content: center;
		}
		#attendInfo{
		    background-color: white;
		    width : 80%;
		    margin: 30px;
		}
		#attendInfo > div{
		    margin: 40px;
		    background-color: white;
		    font-size: 1.2vw;
		    font-family: 'BMHANNAPro';
		    margin-bottom: 20px;
		    display: flex;
		    justify-content: space-between;
		    width: 100%;
		}
		#attendInfo > div > p{
		   background-color : white;
		   margin-top : 8px;
		}
		#atCount{
		   width : 50%;
		   font-size : 1.2vw;
		}
		.atClass{
		   background-color : white;
		   text-align : center;
		   width : 100%;
		}
		#lastAt{
		   font-size: 1.2vw;
		   background-color : white;
		   width : 100%;
		}
		/* 나의 활동 */
		.myRecForm{
		    background-color: white;
		    margin: 15px;
		    height: 360px;
		    width: 50%;
		    border: 1px solid #858585;
		    border-radius: 10px;
		}
		.myRec{
		    font-size: 1.5vw;
		    font-family: 'BMHANNAPro';
		    font-weight: 500;
		   margin-top: 30px;
		    display: flex;
		    justify-content: center;
		}
		.myRecDiv{
		    background-color: white;
		    margin-top :20px;
		    margin-left : 30px;
		    margin-right : 30px;
		}
		.myRecDiv > div{
		    background-color: white;
		    font-size: 1.2vw;
		    font-family: 'BMHANNAPro';
		    margin-bottom: 20px;
		    display: flex;
		    justify-content: space-between;
		    width: 100%;
		}
		.myRecDiv > div > p{
		   background-color: white;
		   margin-top : 8px;
		   width : 40%;
		   margin-left : 20px;
		}
		.myCount{
		    background-color: rgb(247, 247, 247);
		    height: 35px;
		    width: 50%;
		    border: none;
		    font-size: 1.5vw;
		    font-family: 'BMHANNAPro';
		    pointer-events: none;
		    text-align: center;
		    margin-left : 20px;
		}
</style>
</head>
<body>
    <%@ include file="../../include/header.jsp" %>

     <div class="main_content">
        <div class="section1">
            <ul class="menu">
                <li class="menu-item"><a href="/user/mypage">나의 정보</a></li>
                <li class="menu-item">
                	<a href="#">독후감 목록</a>
                    <ul class="submenu">
                        <li><a href="/user/textList">&nbsp;&nbsp;&nbsp;&nbsp; 작성된 독후감</a></li>
                        <li><a href="/user/saveTextList">&nbsp;&nbsp;&nbsp;&nbsp; 임시저장</a></li>
                    </ul>
                </li>
                <li class="menu-item"><a href="/user/event/parList">이벤트 참여 내역</a></li>
	            <li class="menu-item">    
	                <a href="#">도서 신청</a>
	                <ul class="submenu">
	                	<li><a href='/book/apply'>&nbsp;&nbsp;&nbsp;&nbsp;도서 신청</a></li>
	                	<li><a href='/book/applyList'>&nbsp;&nbsp;&nbsp;&nbsp;도서 신청 목록</a></li>
                	</ul>
                </li>
                <li class="menu-item">
                    <a href="#">문의 사항</a>
                    <ul class="submenu">
                        <li><a href="/member/sg/create">&nbsp;&nbsp;&nbsp;&nbsp;문의 사항 작성</a></li>
                        <li><a href="/member/sg/list">&nbsp;&nbsp;&nbsp;&nbsp;문의 사항 목록</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        <div class="section2">
         <div class="profileForm">
             <div id="myProfile">나의 프로필</div>
             <%
                User us = (User)session.getAttribute("user");
             %>
                 <div class="profileInfo">
                     <div class="firstGroup">
                         <div>
                             <p>아이디</p>
                             <input type="text" class="profile" id="id"
                             value="<%=us.getUser_id()%>" readonly disabled>
                         </div>
                         <div>
                             <p>이름</p>
                             <input type="text" class="profile" id="name"
                             value="<%=us.getUser_name()%>" readonly disabled>
                         </div>
                     </div>
                     <div class="secondGroup">
                         <div>
                             <p>이메일</p>
                             <input type="text" class="profile" id="email"
                             value="<%=us.getUser_email()%>" readonly disabled>
                         </div>
                         <div>
                             <p>닉네임</p>
                             <input type="text" class="profile" id="nickname"
                             value="<%=us.getUser_nickname()%>" readonly disabled">
                         </div>
                     </div>
             </div>
             <div class="updateProfile">
                 <a href="/user/edit" class="profileBtn">프로필 수정</a>
                 <a href="/user/delete" class="profileBtn">회원 탈퇴</a>
             </div>
         </div>
         <div class="underForm">
             <div class="attendForm">
                 <div id="attend">출석</div>
                 <div id="attendInfo">
                    <div>
                       <p>총 출석일</p>
                       <input type="text" class="myCount" id="atCount" value="<%=request.getAttribute("atCount")%>" readonly disabled>
                    </div>
                    <div>
                       <div class="atClass">
                           <p id="lastAt"></p>
                                        <p id="lastAt">
                                            <%
                                                String yearStr = (String) request.getAttribute("year");
                                                String monthStr = (String) request.getAttribute("month");
                                                String dateStr = (String) request.getAttribute("date");

                                                int year = 0;
                                                int month = 0;
                                                int date = 0;

                                                if (yearStr != null && !yearStr.isEmpty()) {
                                                    year = Integer.parseInt(yearStr);
                                                }
                                                if (monthStr != null && !monthStr.isEmpty()) {
                                                    month = Integer.parseInt(monthStr);
                                                }
                                                if (dateStr != null && !dateStr.isEmpty()) {
                                                    date = Integer.parseInt(dateStr);
                                                }

                                                if (year == 0 || month == 0 || date == 0) {
                                                    out.print("오늘 첫 방문입니다.");
                                                } else {
                                                    out.print("마지막 출석날짜는"+"\n"+year + "년 " + month + "월 " + date + "일입니다.");
                                                }
                                                       %>
                                        </p>
                       </div>
                    </div>
                 </div>
             </div>
             <div class="myRecForm">
                 <div class="myRec">나의 활동</div>
                 <div class="myRecDiv">
                     <div>
                        <p>이벤트 참여 수</p>
                         <input type="text" class="myCount" id="eventCount" value="<%=request.getAttribute("evCount")%>" readonly disabled>
                     </div>
                     <div>
                        <p>독후감 수</p>
                         <input type="text" class="myCount" id="btCount" value="<%=request.getAttribute("btCount")%>" readonly disabled>
                     </div>
                     <div>
                        <p>문의사항 수</p>
                         <input type="text" class="myCount" id="askCount" value="<%=request.getAttribute("sgCount")%>" readonly disabled>
                     </div>
                 </div>
             </div>
         </div>
        </div>
    </div>
</body>
    <!-- 마이페이지 드롭다운 -->
    <script>
     document.addEventListener("DOMContentLoaded", function() {
         const menuItems = document.querySelectorAll(".menu-item > a");

         menuItems.forEach(function(item) {
             const submenu = item.nextElementSibling;
             let isOpen = false;

             item.addEventListener("click", function(event) {
                 if (submenu) {

                     if (isOpen) {
                         submenu.style.animation = "slide-up 0.3s ease";

                         setTimeout(function(){
                             submenu.style.display = "none";
                             submenu.style.animation = "";
                         }, 300);

                         isOpen = false;
                     } else {
                         submenu.style.display = "block";
                         submenu.style.height = "auto";
                         void submenu.offsetWidth;
                         submenu.style.animation = "slide-down 0.3s ease";
                         submenu.style.height = submenu.scrollHeight + "px";

                         isOpen = true;
                     }
                 }
             });
         });

         const submenuLinks = document.querySelectorAll(".submenu li a");
         submenuLinks.forEach(function(link) {
             link.addEventListener("click", function(event) {
             });
         });
     });
     </script>
</html>