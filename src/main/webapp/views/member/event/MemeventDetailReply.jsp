<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.book.admin.event.vo.Event"%>
<%@ page import="com.book.member.user.vo.User"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Knock Book</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: 'LINESeedKR-Bd';
            background-color: rgb(247, 247, 247);
            margin : 0;
        }

        main {
            max-width: 800px;
            margin: 2rem auto;
            padding: 1rem 1rem;
            background-color: white;
            box-shadow: 0 5px 7px rgba(0, 0, 0, 0.1);
            border-radius: 20px;
        }

        #event_Type {
            background-color: rgb(255, 232, 186);
            border-radius: 15px;
            padding: 1% 1.2% 0.7% 1.5%;
            margin-right: 2%;
        } 
        
        .eventDeatil_main {
            padding: 2% 4%; 
        }

        #event_title {
            text-align: center;
            margin-bottom: 1rem; 
        }

        .event_header {
            text-align: center;
            margin-bottom: 3%; 
        }

        #event_regdate {
            text-align: right;
            margin-bottom: 3%;
            font-size: 85%;
            color : rgba(28, 28, 28, 1); 
        } 

      .event_details .item {
          margin-bottom: 8px;  
      }
      
        .event_details .item2 {
          margin-bottom: 10px; 
          display: flex;
          align-items: center; 
      }
        
        .details_content { 
           margin-left:10%;
        } 
        
        .details_content2 { 
           margin-left:6%;
        } 
        
        .event_content {
            margin-top: 5%;   
            text-align : center; 
        }

       #noti_btn {
          text-align: right; 
       }
        .event-image {
           width: 30vw; 
          height:25vw;
            display: block;
            margin: 5% auto 5% auto; 
            height: auto;
        }  
        
        #content_area {  
           font-size : 17px;  
           font-family: 'LINESeedKR-Bd';
        } 
        
      /* paging */
      @charset "UTF-8";
      
      .center {
          text-align: center; s
      }
      
      .pagination {
          display: inline-block; 
      }
      
      .pagination a {
          color: black;
          float: left;
          padding: 8px 15px 6px 15px;
          text-decoration: none;
          transition: background-color .3s;
          margin: 2px 4px 0px 4px; 
      }
      
      .pagination a.active {
          background-color: #A5A5A5;
          color: white;
          border: 1px solid #A5A5A5;
      }
      
      .pagination a:hover:not(.active) {
          background-color: #ddd;
      }
      
      #list_empty {
          text-align: center;
          padding-top: 60px;
          background-color: white;
      }
      
      #event_btn {
            width: 100%;
            display: block;
            margin: 0 auto;
            padding: 10px 20px;
            font-size: 17px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            box-sizing: border-box;
        }

        #event_btn:hover {
            background-color: #0056b3;
        }
        
        #notification_btn {
          background-color: transparent;
          border: none;
          font-size: 1.5rem;
          cursor: pointer;
          transition: color 0.3s;
          align-self: flex-end;
          margin-left: auto;
      }

      #notification_btn:hover {
          color: #ffd700;
      }
      
      #notification_btn.active {
          color: #ffd700;
      }
      
      /* 툴팁 스타일 */
      #notification_btn {
          position: relative;
      }
      
      #notification_btn::after {
          content: attr(title);
          position: absolute;
          bottom: 100%;
          left: 50%;
          transform: translateX(-50%);
          background-color: rgba(0, 0, 0, 0.8);
          color: white;
          padding: 5px 10px;
          border-radius: 4px;
          font-size: 12px;
          white-space: nowrap;
          opacity: 0;
          visibility: hidden;
          transition: opacity 0.3s, visibility 0.3s;
      }
      
      #notification_btn:hover::after {
          opacity: 1;
          visibility: visible;
      }
      
      #eventListPageBtn {
         margin-top : 20px;
      }
      
      /* 댓글 */
      
      .replyContainer {
         width: 800px;
         margin: auto;
         overflow: hidden;
         padding: 20px;
         position: relative;
      }
      
      .replyDiv {
         width: 900px;
         height: 200px;
      }
      
      .nickname{
      margin-top:15px
      }
      
      .parentReply{
      border-top:1px solid #ddd;
      }
      
      .childReply{
      margin-left: 50px;
      border-top:1px solid #ddd;
      }
      
      .replyCount{
      margin-bottom: 20px;
      }
      
      .write {
         width: 95%;
         padding: 20px;
         border-radius: 5px;
         border: 1px solid #ccc;
         box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
         resize: none;
         margin-top: 20px
      }
      
      .write:focus {
         outline: none;
         border: none;
      }
      
      .replyContent {
         width: 95%;
         height: 100px;
         padding: 10px;
         resize: none;
         margin-top: 10px;
      }
      
      #reBtn{
      border:none;
      margin-bottom: 10px;
      display:flex;
      justify-content:right;
      }
      
      .replyBtns {
         margin-left: 10px;
         width: 50px;
         height: 30px;
         border-radius: 15%;
         text-align: center;
         background: #575756;
         color: #fffbfb;
         font-size: 14px;
         justify-content: center;
         align-items: center;
         cursor: pointer;
         text-decoration: none;
         border: none;
      }
      
      .btn_gr {
         margin-top: 10px;
         display: flex;
         justify-content: flex-end;
         margin-bottom: 10px;
      }
      
      
      .replyBtns:hover {
         background-color: #e0e0e0;
      }

    </style>
</head>
<body>
    <%@ include file="../../include/header.jsp" %>

    <section id="detail_box">
        <main>
            <div class="eventDeatil_main">
                <span id="event_Type">
                    <% 
                        Event event = (Event) request.getAttribute("event");  
                        User user_event = (User) session.getAttribute("user");
                        boolean isRegistered = (boolean) request.getAttribute("isRegistered");
                        int registeredCount = event.getEvent_registered();
                        int participateState = (int) request.getAttribute("participateState");  
                    %>
                    <% if (event.getEv_form() == 1) { %>
                         기본
                     <% } else if (event.getEv_form() == 2) { %>
                         선착순
                     <% } %>
                </span>
                <span id="event_category"><%= event.getEv_category_name() %></span>

                <div class="event_header">
                    <h2 id="event_title"><%= event.getEv_title() %></h2>
                    <p id="event_regdate">등록 &nbsp&nbsp <%= event.getEv_regdate().substring(0, 10) %></p>
                </div>
                 
                <% if (event.getEv_form() == 2) { %>
                    <div class="event_details">
                   <div class="item">
                       모집 인원<span class="details_content"><%= event.getEvent_quota() %> 명</span>
                   </div>
                   <div class="item">
                       모집 기간<span class="details_content"><%= formatDateString(event.getEv_start()) %> ~ <%= formatDateString(event.getEv_end()) %></span>
                   </div>
                   <div class="item2">
                       이벤트 진행일<span class="details_content2"><%= event.getEv_progress() %></span>
                   </div>
                        <div class="item">참여 현황<span class="details_content"><%= event.getEvent_registered() %> / <%= event.getEvent_quota() %></span></div>
                        <div class="item">대기 인원<span class="details_content"><%= event.getEvent_waiting() %></span></div>
                    <div id="noti_btn">
                       <!-- 알림 버튼 -->
                       <% if (user_event != null && event.getEv_form() == 2) { %>
                           <button id="notification_btn" type="button" onclick="toggleNotification(<%= event.getEvent_no() %>, <%= user_event.getUser_no() %>);" title="선착순 오픈 1시간 전 이메일 알림이 발송됩니다.">
                               <i id="bell_icon" class="fa-regular fa-bell"></i>
                           </button>
                       <% } %>
                    </div>
               </div>
                <% } else { %>
                <div class="event_details">
                    <div class="event_start">진행 기간 &nbsp&nbsp&nbsp&nbsp
                        <% 
                            if (event.getEv_start().equals(event.getEv_end())) {
                                out.print(event.getEv_start());
                            } else {
                                out.print(event.getEv_start() + " ~ " + event.getEv_end());
                            }
                        %> 
                    </div>
                </div>
                <% } %> 
                <hr>
                <div class="event_content"> 
                    <pre id="content_area"><%= event.getEv_content() %></pre>
                    <img src="<%= request.getContextPath() %>/upload/event/<%= event.getNew_image() %>" alt="새 이미지" class="event-image">
                 
                    <!-- 참여 버튼 --> 
                    <% if (user_event != null && event.getEv_form() == 2) { %>
                        <button id="event_btn" type="button"
                            <% if (isRegistered) { %>
                                style="display:block;"
                            <% } else if (registeredCount >= event.getEvent_quota() && participateState == 1) { %>
                                style="display:block;"
                            <% } else { %>
                                style="display:block;"
                            <% } %>
                                onclick="toggleRegistration(<%= event.getEvent_no() %>, <%= user_event.getUser_no() %>, <%= participateState %>);">
                            <% if (participateState == 0) { %>
                                참여 취소
                            <% } else if (participateState == 1) { %>
                                대기 취소
                            <% } else if (registeredCount >= event.getEvent_quota()) { %>
                                대기
                            <% } else { %>
                                참여
                            <% } %>
                        </button>
                    <% } %> 
                </div>
                <a href="/user/event/list?status=ongoing" class="btn btn-outline-primary" id="eventListPageBtn">목록</a>
            </div> 
        </main>
    </section>
     
   <!-- 댓글 컨테이너 -->
   <section class="replyContainer">
       <% Integer replyCnt = (Integer) request.getAttribute("erReplyCnt"); %>
       <div id="replyCount">댓글 수 : <%= (replyCnt != null ? replyCnt : 0) %></div><br>
       
       <% 
       // 댓글 리스트 가져오기
       List<Map<String, String>> erReplyList = (List<Map<String, String>>) request.getAttribute("erReplyList");
       // 세션에서 사용자 정보 가져오기
       User evReuserNo = (User) session.getAttribute("user");
       int userNo = (evReuserNo != null) ? evReuserNo.getUser_no() : -1;  // 사용자 번호를 가져오되, 세션이 없으면 -1로 설정
       
       boolean isLoggedIn = evReuserNo != null;
       boolean isNotUserOne = userNo != 1;
       
       if (erReplyList != null && !erReplyList.isEmpty()) {
           for (int i = 0; i < erReplyList.size(); i++) {
               Map<String, String> ver = erReplyList.get(i);
               String erReply = (ver.get("er_delete").equals("1")) ? "삭제된 댓글입니다." : ver.get("er_content");
               int erParentNo = Integer.parseInt(ver.get("er_parent"));
               String erReplyNo = ver.get("er_no");
               String nickname = ver.get("er_userNickName");
               String erRegDate = ver.get("er_regDate");
               String erModDate = ver.get("er_modDate");
               int replyUserNo = Integer.parseInt(ver.get("er_user_no"));
               String parentClass = erParentNo == 0 ? "parentReply" : "childReply";
       %>  
       <!-- 하나의 댓글 시작 -->  
       <div id="allreply" class="<%= parentClass %>">
           <div id="reply_<%= erReplyNo %>">
               <div class="nickname" style="display: flex; justify-content: space-between;">
                   <span><%= nickname %></span>
                   <div style="text-align: right;">
                       <span style="font-size:15px"><%= erRegDate %></span>
                       <% if (!erModDate.equals(erRegDate)) { %>
                           <span style="font-size:15px">수정됨(<%= erModDate %>)</span>
                       <% } %>
                   </div>
               </div>
           </div>
           <!-- 댓글 내용 -->
           <div id="replyContent_<%= erReplyNo %>" class="replyContent"><%= erReply %></div>
           <!-- 수정버튼 눌렀을 때 ( 등록폼 display none ) -->
           <form id="updateForm_<%= erReplyNo %>" class="updateForm" action="/member/event/updateReply" method="post" style="display:none;">
               <input type="hidden" name="event_no" value="<%= event.getEvent_no() %>">
               <input type="hidden" name="eventType" value="<%= event.getEv_form() %>">
               <input type="hidden" name="er_reply_no" value="<%= erReplyNo %>">
               <input type="hidden" name="er_user_no" value="<%= userNo %>">
               <input class="replyContent" id="replyUpdate_<%= erReplyNo %>" name="updateContent" type="text" value="<%= erReply %>">
               <!-- 로그인한 유저와 댓글을 등록한 유저의 번호가 같거나 // 댓글이 삭제가 안되었을 경우 
                    버튼이 보이도록 -->
               <% if (userNo == replyUserNo && !ver.get("er_delete").equals("1")) { %>
                   <div class="btn_gr">
                       <input type="submit" id="update_<%= erReplyNo %>" class="replyBtns" value="등록">
                       <input type="button" id="cancel_<%= erReplyNo %>" class="replyBtns" value="취소" onclick="cancelReplyForm('<%= erReplyNo %>')">
                   </div>
               <% } %>
           </form>
           <!-- 삭제 폼 -->
          <% if (userNo == replyUserNo && !ver.get("er_delete").equals("1")) { %>
           <form action="/member/event/deleteReply" method="post" style="display: inline;">
               <input type="hidden" name="event_no" value="<%= event.getEvent_no() %>">
               <input type="hidden" name="eventType" value="<%= event.getEv_form() %>">
               <input type="hidden" name="er_reply_no" value="<%= erReplyNo %>">
               <input type="hidden" name="er_user_no" value="<%= userNo %>">
               <!-- 로그인한 유저와 댓글을 등록한 유저의 번호가 같거나 // 댓글이 삭제가 안되었을 경우 
                    버튼이 보이도록 -->
                   <div class="btn_gr">
                       <input type="button" id="change_<%= erReplyNo %>" class="replyBtns" value="수정" onclick="changeReplyForm('<%= erReplyNo %>')">
                       <input class="replyBtns" type="submit" id="delete_<%= erReplyNo %>" value="삭제">
                   </div>
               </form>
               <% } %>
               <!-- 부모의 번호가 0번이거나 // 삭제가 안되었을 경우
                   답글하기가 보이도록 -->
               <% if (erParentNo == 0 && !ver.get("er_delete").equals("1")) { %>
                   <% if (isLoggedIn && isNotUserOne) { %> <!-- 로그인 상태이고 사용자 번호가 1이 아닌 경우만 보이도록 수정 -->
                       <div class="btn_gr">
                           <button type="button" id="reBtn" onclick="showReplyForm('<%= erReplyNo %>')">답글하기</button>
                       </div>
                   <% } %>
               <% } %>
               <!-- 답글하기를 눌렀을 때 나오는 답글 폼 -->
               <div id="replyForm_<%= erReplyNo %>" class="reply-form" style="display:none;">
                   <form action="/member/event/childReply" method="post">
                       <input type="hidden" name="event_no" value="<%= event.getEvent_no() %>">
                       <input type="hidden" name="eventType" value="<%= event.getEv_form() %>">
                       <input type="hidden" name="er_parent" value="<%= erReplyNo %>">
                       <input type="hidden" name="er_user_no" value="<%= userNo %>">
                       <textarea class="write" name="er_content" placeholder="답글을 입력해주세요."></textarea>
                       <div class="btn_gr">
                           <input class="replyBtns" type="submit" value="등록">
                           <input class="replyBtns" type="button" value="취소" onclick="hideReplyForm('<%= erReplyNo %>')">
                       </div>
                   </form>
               </div>
           </div>
           <% } %>
       <% } else { %> 
           <!-- 등록된 댓글이 없다면 -->
           <div class="replyContent">등록된 댓글이 없습니다.</div>
       <% } %>
       
       <!-- 새 댓글 작성 폼 (부모 댓글) -->
       <% if (isLoggedIn && isNotUserOne) { %> <!-- 로그인 상태이고 사용자 번호가 1이 아닌 경우만 보이도록 수정 -->
           <form action="/member/event/addReply" method="post">
               <div id="replyDiv">
                   <input type="hidden" name="event_no" value="<%= event.getEvent_no() %>">
                   <input type="hidden" name="eventType" value="<%= event.getEv_form() %>">
                   <input type="hidden" name="er_user_no" value="<%= userNo %>">
                   <textarea class="write" name="er_content" placeholder="댓글을 입력해주세요."></textarea>
                   <div class="btn_gr">
                       <input class="replyBtns" type="submit" value="등록">
                       <input class="replyBtns" type="button" value="취소" onclick="clearReplyForm()">
                   </div>
               </div>
           </form>
       <% } %>
   </section>


 
    <%!
        SimpleDateFormat inputFormat1 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        SimpleDateFormat outputFormat1 = new SimpleDateFormat("yyyy-MM-dd a hh:mm");

        String formatDateString1(String input) {
            try {
                Date date = inputFormat1.parse(input);
                return outputFormat1.format(date);
            } catch (Exception e) {
                e.printStackTrace();
                return "";
            }
        }
    %>

    <script>
        // 참여 등록 및 취소 
        function toggleRegistration(eventNo, userNo, participateState) {
          var button = $("#event_btn");
          var action = button.text().trim();
          
          var confirmMessage;
          if (action === "참여" ) {
              confirmMessage = "이벤트에 참여하시겠습니까?";
          } else if (action === "대기") {
              confirmMessage = "이벤트에 대기 등록하시겠습니까?";
          } else if (action === "참여 취소") {
              confirmMessage = "참여를 취소하시겠습니까?";
          } else if (action === "대기 취소") {
              confirmMessage = "대기를 취소하시겠습니까?";
          }else {
              return;  
          }
      
          if (confirm(confirmMessage)) {
              $.ajax({
                  type: "POST",
                  url: "<%=request.getContextPath()%>/user/event/par",
                  data: { 
                      "event_no": eventNo, 
                      "user_no": userNo, 
                      "action": action,
                      "participate_state": participateState 
                  },
                  success: function(response) {
                      // 버튼 상태 업데이트
                      if (action === "참여") {
                          button.text("참여 취소");
                          alert("이벤트 참여가 완료되었습니다.");
                      } else if (action === "참여 취소") {
                          button.text("참여");
                          alert("이벤트 참여가 취소되었습니다.");
                      } else if (action === "대기") {
                          button.text("대기 취소");
                          alert("대기 신청이 완료되었습니다.");
                      } else if (action === "대기 취소") {
                          button.text("대기");
                          alert("대기 신청이 취소되었습니다.");
                      }
                      location.reload();  
                  }
              });
          }
      }

        jQuery.noConflict();
        $(document).ready(function() {  
            var eventStart = new Date("<%= event.getEv_start() %>");
            var eventEnd = new Date("<%= event.getEv_end() %>");
            var currentDate = new Date();
 
            var eventButton = $("#event_btn");
            var notificationButton = $("#notification_btn");
            
            // 이벤트 시작 1시간 전 시간 계산
            var oneHourBeforeStart = new Date(eventStart.getTime() - (60 * 60 * 1000));

            if (currentDate < eventStart) {
                eventButton.text("모집 예정");
                eventButton.prop("disabled", true);
                
                if (currentDate < oneHourBeforeStart) {
                    notificationButton.show();
                } else {
                    notificationButton.hide();
                }
            } else if (currentDate > eventEnd) {
                eventButton.text("모집 종료");
                eventButton.prop("disabled", true);
                notificationButton.hide();
            } else if (currentDate >= eventStart && currentDate <= eventEnd) {
                if (<%= event.getEv_form() %> === 2) {
                    eventButton.show();
                }
                notificationButton.hide();
            }
            
            /* 알림 버튼 상태 확인 */ 
            if (<%= user_event != null %> && currentDate < oneHourBeforeStart) {
                $.ajax({
                    type: "GET",
                    url: "<%=request.getContextPath()%>/user/event/checkNotification",
                    data: { 
                        "event_no": <%= event.getEvent_no() %>, 
                        "user_no": <%= user_event != null ? user_event.getUser_no() : 0 %>
                    },
                    success: function(response) {
                        if (response === "true") {
                            $("#bell_icon").removeClass("fa-regular").addClass("fa-solid");
                            $("#notification_btn").addClass("active");
                        } else {
                            $("#bell_icon").removeClass("fa-solid").addClass("fa-regular");
                            $("#notification_btn").removeClass("active");
                        }
                    } 
                });
            }
        });

        /* 알림 버튼 */
        function toggleNotification(eventNo, userNo) {
            var bellIcon = $("#bell_icon");
            var notificationBtn = $("#notification_btn");
            var action = bellIcon.hasClass("fa-regular") ? "set" : "cancel";

            $.ajax({
                type: "POST",
                url: "<%=request.getContextPath()%>/user/event/notification",
                data: { 
                    "event_no": eventNo, 
                    "user_no": userNo, 
                    "action": action
                },
                success: function(response) {
                    if (action === "set") {
                        bellIcon.removeClass("fa-regular").addClass("fa-solid");
                        notificationBtn.addClass("active");
                        alert("알림이 설정되었습니다. 모집 1시간 전 이메일로 알려드릴게요!");
                    } else {
                        bellIcon.removeClass("fa-solid").addClass("fa-regular");
                        notificationBtn.removeClass("active");
                        alert("알림이 취소되었습니다.");
                    }
                } 
            });
        }
        
        
        /* 댓글 */
        function showReplyForm(replyId) {
          document.getElementById('replyForm_' + replyId).style.display = 'block';
           document.getElementById('delete_' + replyId).style.display = 'none';
           document.getElementById('change_' + replyId).style.display = 'none';
      }
      
      function hideReplyForm(replyId) {
          document.getElementById('replyForm_' + replyId).style.display = 'none';
          document.getElementById('change_' + replyId).style.display = 'inline-block';
           document.getElementById('delete_' + replyId).style.display = 'inline-block';
      }
      
      function clearReplyForm() {
          document.querySelector('#replyDiv .write').value = '';
      }
      
      function changeReplyForm(replyId) {
          document.getElementById('replyContent_' + replyId).style.display = 'none';
          document.getElementById('updateForm_' + replyId).style.display = 'block';
          document.getElementById('change_' + replyId).style.display = 'none';
          document.getElementById('cancel_' + replyId).style.display = 'inline-block';
          document.getElementById('delete_' + replyId).style.display = 'none';
          
      }
      
      function cancelReplyForm(replyId) {
          document.getElementById('replyContent_' + replyId).style.display = 'block';
          document.getElementById('updateForm_' + replyId).style.display = 'none';
          document.getElementById('change_' + replyId).style.display = 'inline-block';
          document.getElementById('cancel_' + replyId).style.display = 'none';
          document.getElementById('delete_' + replyId).style.display = 'inline-block';
          
      }

    </script>  
</body>
</html>