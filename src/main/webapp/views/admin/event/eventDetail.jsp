<%@page import="com.book.common.Paging"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.book.admin.event.vo.Event" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Knock Book</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <style>   
        body {
            font-family: 'LINESeedKR-Bd';
            background-color: rgb(247, 247, 247);
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

        .event_details { 
            margin-bottom: 3%; 
        }

        .event_details .item {
            margin-bottom: 10px; 
        }
        
        .details_content { 
           margin-left:10%;
        }
        
        .details_content3 { 
           margin-left:6%;
        }
        
        .event_content {
            margin-top: 5%;   
            text-align : center; 
        }

        .event-image {
           width: 30vw; 
          height:25vw;
            display: block;
            margin: 5% auto 5% auto; 
            height: auto;
        } 

        .btn {
            margin-right: 10px;
        }
        
        #content_area {  
           font-size : 17px;  
           font-family: 'LINESeedKR-Bd';
        }
         
        .partic_list { 
           text-align : center; 
        }
        
      /* paging */
      @charset "UTF-8";
      
       .center {
        display : flex;
        text-align: center;
        justify-content : center;
        margin-top: 20px;
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
      
      /* 댓글 */
      
      .replyContainer {
         width: 800px;
         margin: auto;
         overflow: hidden;
         padding: 20px;
         position: relative; 
         border-top:solid 1px;
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
                        Event event = (Event)request.getAttribute("event");  
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
                    <div class="item">
                        이벤트 진행일<span class="details_content3"><%= event.getEv_progress() %></span>
                    </div>
                    <div class="item">참여 현황<span class="details_content"><%= event.getEvent_registered() %> / <%= event.getEvent_quota() %></span></div>
                    <div class="item">대기 인원<span class="details_content"><%= event.getEvent_waiting() %></span></div>
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
                </div>
 
                <!-- 수정, 삭제 버튼 --> 
                   <button class="btn btn-outline-danger" onclick="deleteEvent(<%= event.getEvent_no() %>)">삭제</button> 
                   <button class="btn btn-outline-primary" onclick="location.href='/event/update?eventNo=<%= event.getEvent_no() %>&eventType=<%= event.getEv_form() %>'">수정</button>
                 <a href="/event/list" class="btn btn-outline-primary" id="eventListPageBtn">목록</a>
            </div>
        </main>
    </section>
    <% if (event.getEv_form() == 2) { %>
          <main id="parUser_box"> 
           <div class="partic_list">
               <% 
                 List<Map<String, String>> parUserList = (List<Map<String, String>>) request.getAttribute("parUserList");
                 if (parUserList == null || parUserList.isEmpty()) { 
             %>
              <p id="list_empty">참여자가 존재하지 않습니다.</p>
               <% } else { %>
                   <table class="table table-striped table-bordered">
                       <thead class="table-light">
                           <tr>
                               <th scope="col">번호</th>
                               <th scope="col">이름</th>  
                               <th scope="col">참여 등록일</th>
                               <th scope="col">등록 상태</th>
                           </tr>
                       </thead>
                       <tbody> 
                           <% 
                               List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("parUserList"); 
                               int pageSize = 10; // 한 페이지에 표시할 항목 수
                               int nowPage = request.getParameter("nowPage") == null ? 1 : Integer.parseInt(request.getParameter("nowPage"));
                               int startNo = (nowPage - 1) * pageSize + 1;
                               for (int i = 0; i < list.size(); i++) {
                                   Map<String, String> row = list.get(i);
                           %>
                           <tr>
                               <td><%= startNo + i %></td>
                               <td><%= row.get("user_name") %></td> 
                               <td><%= row.get("participate_date") %></td>
                               <td>
                                   <%
                                       String participateState = row.get("participate_state");
                                       if ("0".equals(participateState)) {
                                           out.print("등록");
                                       } else if ("1".equals(participateState)) {
                                           out.print("대기");
                                       }  
                                   %>
                               </td>
                           </tr>
                           <% } %>
                       </tbody>
                   </table>
               <% } %>
           </div>  
           <div class="center">
               <div class="pagination">
                   <% 
                       Paging paging = (Paging) request.getAttribute("paging");
                       if (paging != null) {
                           int nowPage = paging.getNowPage();
                           int totalPage = paging.getTotalPage();
                           int pageBlock = 5;  
                           int startPage = ((nowPage - 1) / pageBlock) * pageBlock + 1;
                           int endPage = startPage + pageBlock - 1;
                           if (endPage > totalPage) {
                               endPage = totalPage;
                           }
                   %> 
                   <% if (startPage > 1) { %> 
                       <a href="/event/detail?eventNo=<%= request.getParameter("eventNo") %>&eventType=<%= request.getParameter("eventType") %>&nowPage=<%= startPage - 1 %>">&laquo;</a> 
                   <% } %>
                   <% for (int i = startPage; i <= endPage; i++) { %>
                       <a href="/event/detail?eventNo=<%= request.getParameter("eventNo") %>&eventType=<%= request.getParameter("eventType") %>&nowPage=<%= i %>"
                          <%= paging.getNowPage() == i ? "class='active'" : "" %>> <%= i %>
                       </a> 
                   <% } %>
                   <% if (endPage < totalPage) { %> 
                       <a href="/event/detail?eventNo=<%= request.getParameter("eventNo") %>&eventType=<%= request.getParameter("eventType") %>&nowPage=<%= endPage + 1 %>">&raquo;</a> 
                   <% } %>
                   <% } %>
               </div> 
           </div> 
      </main>
       <% } %> 
<!-- 댓글 컨테이너 -->
   <section class="replyContainer">
       <% Integer replyCnt = (Integer) request.getAttribute("admReplyCnt"); %>
       <div id="replyCount">댓글 수 : <%= (replyCnt != null ? replyCnt : 0) %></div><br>
       
       <% 
       // 댓글 리스트 가져오기
       List<Map<String, String>> erReplyList = (List<Map<String, String>>) request.getAttribute("admReplyList");
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
           <% } %>
       <% } else { %> 
           <!-- 등록된 댓글이 없다면 -->
           <div class="replyContent">등록된 댓글이 없습니다.</div>
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
        function deleteEvent(eventNo) { 
            if (confirm('이벤트를 삭제하시겠습니까?')) {
                location.href = '/event/delete?eventNo=' + eventNo;
            }
        }
    </script>
</body>
</html>