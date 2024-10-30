<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import = "com.book.member.user.vo.User" %>
<%@ page import="com.book.member.event.dao.MemEventDao" %>
<%@ page import="com.book.admin.event.vo.Event"%> 
<%@ page import="java.util.Date"%>
 
   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
     
   <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
   <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
       
    <style>
        @charset "UTF-8";
  
        @font-face {
            font-family: 'GangwonEduPowerExtraBoldA';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEduPowerExtraBoldA.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }

        @font-face {
            font-family: 'JalnanGothic';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_231029@1.1/JalnanGothic.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }

        @font-face {
            font-family: 'Freesentation-9Black';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2404@1.0/Freesentation-9Black.woff2') format('woff2');
            font-weight: 700;
            font-style: normal;
        }

        @font-face {
            font-family: 'LINESeedKR-Bd';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Bd.woff2') format('woff2');
            font-weight: 700;
            font-style: normal;
        }

        @font-face {
            font-family: 'BMHANNAPro';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_seven@1.0/BMHANNAPro.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }

        @font-face {
            font-family: 'SEBANG_Gothic_Bold';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2104@1.0/SEBANG_Gothic_Bold.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }

        @font-face {
            font-family: 'OAGothic-ExtraBold';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.0/OAGothic-ExtraBold.woff2') format('woff2');
            font-weight: 800;
            font-style: normal;
        }

        @font-face {
            font-family: 'LeferiPoint-BlackA';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/LeferiPoint-BlackA.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }

        * {
            box-sizing: border-box;
            margin: 0;
        }

        body {
            background-color: rgb(247, 247, 247);
        }

		.main_header{
			padding : 0 10px;
		}
		
        .main_logo {
            font-size: 30px;
            color: rgb(224, 195, 163);
            text-decoration: none;
            font-family: 'JalnanGothic';
           
        }

        .main_logo:hover {
            color: rgb(224, 195, 163);
            text-decoration: none;
        }

        .nav-link {
            color: #000000;
            font-family: 'BMHANNAPro';
        }

        .nav-link:hover {
            color: rgb(224, 195, 163);
        }

        #notification-icon {
            position: relative;
            margin-top:6px;
        }

        .notification-count {
            position: absolute;
            top: -5px;
            right: -5px;
            background-color: red;
            color: white;
            border-radius: 50%;
            padding: 2px 5px;
            font-size: 12px;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        a {
            text-decoration-line: none;
            color: black;
        }

        .navBarCss {
            gap: 2vw;
        }

        /* 메뉴 항목 스타일링 */
        .nav-item {
            position: relative;
        }

        .nav-link {
            display: block;
            padding: 10px;
        }

       /* 로그아웃과 마이페이지를 제외한 nav-item의 hover 상태 스타일링 */
       .nav-item:not(:has(#header_logout)):not(:has(#header_join)):hover .nav-link {
           color: rgb(224, 195, 163); /* 글자색 변경 */
       }

        /* 로그아웃과 마이페이지 버튼 스타일링 */
        #header_logout:hover, #header_join:hover {
            background-color: rgb(224, 195, 163); /* 배경색 변경 */
            color: white; /* 텍스트 색상 변경 */
            border-radius: 4px; /* 모서리 둥글게 */
        }
        
        /* 알림 */
      .notification-icon {
          position: relative;
          cursor: pointer;
      }
      
      .notification-count {
          position: absolute;
          top: -5px;
          right: -5px;
          background-color: red;
          color: white;
          border-radius: 50%;
          padding: 2px 5px;
          font-size: 12px;
      }
      
      .modal {
          display: none;
          position: fixed;
          z-index: 1;
          left: 0;
          top: 0;
          width: 100%;
          height: 100%;
          overflow: auto;
          background-color: rgba(0,0,0,0.6);
      }
      
      .modal-content {
          background-color: #fefefe;
          margin: 15% auto;
          padding: 20px;
          border: 1px solid #888;
          width: 80%;
          max-width: 600px;
      }
      
      .modal-content h2 {
         text-align: center;
         font-family: 'Freesentation-9Black';
         font-size:30px;
         margin-bottom: 30px;
      }
      
      a {
         text-decoration: none;
         color : black;
      }
      
      .notification-item {
         background-color: rgba(250, 210, 125, 0.5);
         padding : 10px 0px;
         text-align: center;
         font-size:18px;
         font-weight:600;
         border-radius: 15px;
         margin-bottom: 15px;
      }
      
      #noti_date {
         margin-top:5px;
         font-size:15px;
         color: rgba(77, 77, 77);
      }
      .close {
          color: #aaa;
          float: right;
          font-size: 28px;
          font-weight: bold;
          cursor: pointer;
      }
      
      .close:hover,
      .close:focus {
          color: black;
          text-decoration: none;
          cursor: pointer;
      }
      
      #notification-icon {
         font-size:20px;
          color: #ffd700;
      }
       
      #no_events {
         text-align: center;
      }
    </style>

<section class="main_header">
    <header>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <%
                   User user = (User) session.getAttribute("user");
                   if (user == null) {
                %>
               <a href="/" class="main_logo">Knock Book</a>
               <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                   <span class="navbar-toggler-icon"></span>
               </button>
               <div class="collapse navbar-collapse" id="navbarNav">
                   <ul class="navbar-nav navBarCss ml-auto">
                   <li class="nav-item">
                       <a class="nav-link" href="/user/bookList">도서</a>
                   </li>
                   <li class="nav-item">
                       <a class="nav-link" href="/book/textList">독후감</a>
                   </li>
                   <li class="nav-item">
                       <a class="nav-link" href="/user/event/list?status=ongoing">이벤트</a>
                   </li>
                   <li class="nav-item">
                       <a class="nav-link" href="/user/login" id="header_join">로그인</a>
                   </li>
                   <li class="nav-item">
                       <a class="nav-link" href="/user/create" id="header_join">회원가입</a>
                   </li>
                   <%
                   } else if (user.getUser_no() == 1) {
                   %> 
                   <a href="/views/admin/admin.jsp" class="main_logo">Knock Book</a>
                  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                      <span class="navbar-toggler-icon"></span>
                  </button>
                  <div class="collapse navbar-collapse" id="navbarNav">
                      <ul class="navbar-nav navBarCss ml-auto">
                   <li class="nav-item">
                       <a class="nav-link" href="/views/admin/admin.jsp" id="header_adminPage">관리자 페이지</a>
                   </li>
                   <li class="nav-item">
                       <a class="nav-link" href="/user/logout" id="header_logout">로그아웃</a>
                   </li>
                   <%
                   } else {
                   %>
                  <a href="/" class="main_logo">Knock Book</a>
                  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                      <span class="navbar-toggler-icon"></span>
                  </button>
                  <div class="collapse navbar-collapse" id="navbarNav">
                      <ul class="navbar-nav navBarCss ml-auto">
                      <li class="nav-item">
                          <a class="nav-link" href="/user/bookList">도서</a>
                      </li>
                      <li class="nav-item">
                          <a class="nav-link" href="/book/textList">독후감</a>
                      </li>
                      <li class="nav-item">
                          <a class="nav-link" href="/user/event/list?status=ongoing">이벤트</a>
                      </li>
                   <ul class="navbar-nav navBarCss ml-auto">
                       <li class="nav-item">
                           <span class="navbar-text"><%= user.getUser_nickname() + "님 환영합니다." %></span>
                       </li>
                       <li class="nav-item">
                           <a class="nav-link" href="/user/logout" id="header_join">로그아웃</a>
                       </li>
                       <li class="nav-item">
                           <a class="nav-link" href="/user/mypage" id="header_join">마이페이지</a>
                       </li>
                        <li id="notification-icon" class="notification-icon"><i class="fas fa-bell"></i>
                </li>

                <!-- 알림 모달 -->
                <div id="notification-modal" class="modal">
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <h2>알림 설정된 이벤트</h2>
                        <div id="notification-list"> 
                              <%!
                          SimpleDateFormat inputFormat2 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                          SimpleDateFormat outputFormat2 = new SimpleDateFormat("yyyy-MM-dd a hh:mm");
                  
                          String formatDateString(String input) {
                              try {
                                  Date date = inputFormat2.parse(input);
                                  return outputFormat2.format(date);
                              } catch (Exception e) {
                                  e.printStackTrace();
                                  return "";
                              }
                          }
                      %>
                            <%
                                MemEventDao notificationDAO = new MemEventDao();
                                List<Event> notifiedEvents = notificationDAO.getNotifiedEventsForUser(user.getUser_no());
                                if (notifiedEvents != null && !notifiedEvents.isEmpty()) {
                                    for (Event event : notifiedEvents) {
                            %>
                                       <div class="notification-item">
                                           <a href="<%= request.getContextPath() %>/user/event/detail?eventNo=<%= event.getEvent_no() %>&eventType=<%= event.getEv_form() %>">
                                               <div id="noti_title"><%= event.getEv_title() %></div>
                                               <div id="noti_date"><%= formatDateString(event.getEv_start()) %> ~ <%= formatDateString(event.getEv_end()) %></div>
                                           </a>
                                       </div>
                            <% 
                                    }
                                } else {
                            %>
                                    <p id="no_events">알림 설정된 이벤트가 없습니다.</p>
                            <% 
                                } 
                            %>
                        </div>
                    </div>
                </div>
            </ul>
                   <%
                       }
                   %>

            </div>
        </nav>
    </header>
</section>
<script>
$(document).ready(function() {
    var modal = $("#notification-modal");
    var icon = $("#notification-icon");
    var closeBtn = $(".close");

    icon.click(function() {
        modal.css("display", "block");
    });

    closeBtn.click(function() {
        modal.css("display", "none");
    });

    $(window).click(function(event) {
        if (event.target == modal[0]) {
            modal.css("display", "none");
        }
    });
});
</script>
