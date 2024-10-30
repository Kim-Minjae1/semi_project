<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <title>Knock Book</title> 
	<script src="../../../resources/javascript/mypageSidebar.js"></script>  
   <style>
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
.section1{
    width: 25%;
    margin-right: 2rem;
    height: 100%;
    background-color: white;
    font-family: 'BMHANNAPro';
   box-shadow: 0 5px 7px rgba(0, 0, 0, 0.1);
   border-radius: 20px;
}
.menu {
    list-style-type: none;
    padding: 0;
    height: 680px;
    background-color: white;
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
</style>
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
			<!-- 여기에 파일을 넣으세요. -->
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