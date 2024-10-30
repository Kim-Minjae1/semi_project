<%@page import="com.book.admin.event.vo.Event"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Knock Book</title>
<style>
    body {
        background-color: rgb(247, 247, 247);
        -ms-overflow-style: none;
    }
    ::-webkit-scrollbar {
     	display: none;
    } 
	
	a:hover {
		text-decoration: none;
	}
    main {
        font-family: 'LINESeedKR-Bd'; 
        max-width: 1000px;
        margin: 2rem auto;
        padding: 1rem 1rem;
        background-color: white;
        box-shadow: 0 5px 7px rgba(0, 0, 0, 0.1);
        border-radius: 20px;
    }
    
    a {
       text-decoration: none;
       color : black;
    }
    .header { 
        align-items: center;  
    }

    #memeventListTitle {
         margin: 30px 0px;
         text-align: center;
         font-size: 30px;
    }
    
    #header_button{
       text-align: center;
       margin-bottom: 30px;
       
    }
    
    .filter-button {
       font-family: 'LINESeedKR-Bd';
       width: 480px; 
       padding : 20px 30px;
        background-color: #f0f0f0;
        border: none;
        cursor: pointer; 
        border-radius: 5px;
        font-size:18px;
        margin:0;
    }

    .filter-button.active {
        background-color: #edd395;
        color: black;
    }

    .event-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 20px; 
    }

    .event-item {
        border: 1px solid #ccc;
        padding: 10px;
        border-radius: 10px;
        background-color: #fff;
         margin-bottom: 20px;
    }

    .event-image {
        background-color: #f0f0f0;
        height: 150px;
        width: 100%;
        margin-bottom: 10px;
        border-radius: 10px;
        overflow: hidden;
    }

    .event-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    .event-details {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
    }
    
    .event_form {
       font-size : 15px;
       border : 1px solid black;
       padding : 5px 10px; 
       border-radius: 15px;
       border: 1px solid #858585;
    }

   .event-dday {
      font-size : 18px;
      color : #edbb45;
   }
   
    .event-title {
        font-weight: bold;
        margin-top:10px;
        margin-bottom: 5px;
        font-size: 20px;
    }

    .event-date {
        color: #666;
        font-size:15px;
    }

    .center {
        text-align: center;
        margin-top: 20px;
    }

    .pagination {
        display: inline-block;
        justify-content:center;
    }

    .pagination a {
        color: black;
        float: left;
        padding: 8px 16px;
        text-decoration: none;
        transition: background-color .3s;
        margin: 0 4px;
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
        padding: 10%;
    }
     
    
</style>
</head>
<body>
<%@ include file="../../include/header.jsp" %>
<section id="detail_box">
    <main>
      <div class="header">
         <div id="memeventListTitle">Knock Book 이벤트</div>
         <div id="header_button">
            <button
               class="filter-button <%= "ongoing".equals(request.getParameter("status")) ? "active" : "" %>"
               onclick="location.href='/user/event/list?status=ongoing'">진행중</button>
            <button
               class="filter-button <%= "ended".equals(request.getParameter("status")) ? "active" : "" %>"
               onclick="location.href='/user/event/list?status=ended'">종료</button>
         </div>
      </div>
   
      <div class="event-grid">
         <%
            List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("resultList");
            if (list != null) {
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                Date now = new Date();
            
                for (Map<String, String> row : list) {
                    Date eventStart = format.parse(row.get("event_start"));
                    Date eventEnd = format.parse(row.get("event_end"));
                    boolean isOngoing = !now.before(eventStart) && !now.after(eventEnd);
                    String eventForm = row.get("event_form");
                    long daysRemaining = (eventStart.getTime() - now.getTime()) / (1000 * 60 * 60 * 24);
                    
                    String dday = "";
                    if ("2".equals(eventForm)) { 
                        if (daysRemaining > 0) {
                            dday = "D-" + daysRemaining;
                        } else if (daysRemaining == 0) {
                            dday = "D-DAY";
                        } else if (isOngoing) {
                            dday = "모집 중";
                        } else {
                            dday = "모집 기간 종료";
                        }
                    }
                    String eventNo = row.get("event_no");
                    String eventEndDateStr = format.format(eventEnd);
            %>
         <div class="event-item">
            <a href="javascript:void(0);"
               onclick="return handleEventClick('<%= eventNo %>', '<%= eventEndDateStr %>');"
               style="cursor: pointer;">
               <div class="event-image">
                  <img class="event-image"
                     src="<%= request.getContextPath() %>/upload/event/<%= row.get("event_new_image") %>"
                     alt="이벤트 이미지">
               </div>
               <div class="event-details">   
                  <span class="event_form">
                     <% 
                             if ("1".equals(eventForm)) {
                                 out.print("기본");
                             } else if ("2".equals(eventForm)) {
                                 out.print("선착순");
                             }  
                         %>
                  </span>
                  
                  <div class="event-dday">
                     <%= dday %>
                  </div>
               </div>
               <div class="event-title"><%= row.get("event_title") %></div>
               <div class="event-date">
                  <%= eventStart.equals(eventEnd) ? format.format(eventStart) : format.format(eventStart) + " ~ " + format.format(eventEnd) %>
               </div>
            </a>
         </div>
         <%
           }
       } else {
   %>
         <div id="list_empty">이벤트가 없습니다.</div>
         <%
       }
   %>
      </div>
   
      <%
       Event paging = (Event) request.getAttribute("paging");
       if (paging != null && paging.getTotalData() > 0) {
   %>
      <div class="center">
         <div class="pagination">
            <%
           if (paging.isPrev()) {
           %>
            <a
               href="/user/event/list?status=<%= request.getParameter("status") %>&listCategory=<%= request.getParameter("listCategory") %>&nowPage=<%=(paging.getPageBarStart() - 1)%>">&laquo;</a>
            <%
           }
           for (int i = paging.getPageBarStart(); i <= paging.getPageBarEnd(); i++) {
           %>
            <a
               href="/user/event/list?status=<%= request.getParameter("status") %>&listCategory=<%= request.getParameter("listCategory") %>&nowPage=<%=i%>"
               <%=paging.getNowPage() == i ? "class='active'" : ""%>> <%=i%>
            </a>
            <%
           }
           if (paging.isNext()) {
           %>
            <a
               href="/user/event/list?status=<%= request.getParameter("status") %>&listCategory=<%= request.getParameter("listCategory") %>&nowPage=<%=(paging.getPageBarEnd() + 1)%>">&raquo;</a>
            <%
           }
           %>
         </div>
      </div>
      <%
       }
   %>
</main>
</section>
<script>
   function handleEventClick(eventNo, eventEndDate) { 
       var today = new Date();
       var endDate = new Date(eventEndDate);
    
       var timeDiff = endDate.getTime() - today.getTime();
       var daysDiff = Math.ceil(timeDiff / (1000 * 3600 * 24));
   
       if (daysDiff < -30) {
           alert('종료된 이벤트입니다.');
           return false;  
       } else { 
           window.location.href = '/user/event/detail?eventNo=' + eventNo;
       }
       return false; 
   }
</script>
</body>
</html>
