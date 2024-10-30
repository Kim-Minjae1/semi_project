<%@page import="com.book.common.Paging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="com.book.admin.event.vo.Event" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Knock Book</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<style>
    body {
        font-family: 'LINESeedKR-Bd';
        background-color: rgb(247, 247, 247);
    }

    main {
        max-width: 900px;
        margin: 2rem auto;
        padding: 1rem 1rem;
        background-color: white;
        box-shadow: 0 5px 7px rgba(0, 0, 0, 0.1);
        border-radius: 20px;
    }

    .word h3 {
         margin: 30px 0px;
         text-align: center;
         font-size: 30px;
    }

	#evPar_Btn { 
		background-color: rgb(224, 195, 163);
	}
	
	#evPar_Btn:hover { 
		background-color: #c7ad91;
	}
	 
    .event_list_table {
      margin-top :30px;
      width: 100%;
      border-collapse: collapse;
      border-top: 2px solid #000;
    }

    .event_list_table th,
    .event_list_table td {
      padding: 15px 0;
      text-align: center;
      font-size: 1rem;
      border-bottom: 1px solid #ddd;
    }

    .event_list_table thead tr {
      border-bottom: 1px solid #999;
    }

    .event_list_table th {
      font-weight: 600;
      background: rgba(250, 237, 177, 0.6);
    }

    .event_list_table .num {
      width: 10%;
    }

    .event_list_table .title {
      width: 60%;
      text-align: left;
    }
    .event_list_table .title a {
      color: #2c2c2c;
      text-decoration: none;
    }

    .event_list_table thead .title {
      text-align: center;
    }

    .event_list_table .date {
      width: 10%;
    }

    .event_list_table .status {
      width: 10%;
    }

    select {
        padding: 5px 12px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 16px;
        margin-right: 10px;
        background-color: #fff;
        color: #333;
        height: 37px;
        width : 400px;
    }

    #search_area_ev {
        margin-bottom: 20px;
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
        padding: 8px 16px;
        text-decoration: none;
        transition: background-color .3s;
        margin: 0 4px;
    }

    .pagination a.active {
        background-color: rgb(224, 195, 163);
        color: white;
        border: 1px solid rgb(224, 195, 163);
    }

    .pagination a:hover:not(.active) {
        background-color: #ddd;
    }

    #list_empty {
        text-align: center;
        padding : 10%;
    }

    .event_info {
        background-color: #f0f0f0;
        padding: 15px;
        border-radius: 10px;
        margin-bottom: 20px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    .info_div {
        padding : 5px 0 0 230px;
    }

    .info_span1 {
        margin-left : 40px;
    }

    .info_span {
        margin-left : 54px;
    }
</style>

<body>
<%@ include file="../../include/header.jsp" %>
    <section>
        <main>
            <div id="section_wrap" class="container">
                <div class="word">
                    <h3>사용자 이벤트 참여 내역</h3>
                </div>
                <br>

                <div id="search_area_ev">
                    <form action="/event/parList" method="post">
                        <select name="eventTitle" id="eventTitle">
                            <option value="">전체</option>
                            <% 
                                LocalDate currentDate = LocalDate.now();
                                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                                List<Map<String, String>> eventTitles = (List<Map<String, String>>) request.getAttribute("eventTitles");
                                String selectedTitle = request.getParameter("eventTitle");
                                for (Map<String, String> event : eventTitles) {
                                    LocalDate eventDate = LocalDate.parse(event.get("event_progress").substring(0, 10), formatter);
                                    if (eventDate.isAfter(currentDate) || eventDate.isEqual(currentDate)) {
                            %>
                            <option value="<%=event.get("event_title")%>" <%= event.get("event_title").equals(selectedTitle) ? "selected" : "" %>><%=event.get("event_title")%></option>
                            <%  
                                    }
                                }
                            %>
                        </select>
                        <input class="btn" id="evPar_Btn" type="submit" value="검색">
                    </form>
                </div>

                <div class="event_info">
                    <% if (request.getAttribute("selectedEvent") != null) { %>
                        <% Map<String, String> selectedEvent = (Map<String, String>) request.getAttribute("selectedEvent"); %>
                        <div class="info_div">이벤트 제목<span class="info_span1"><%= selectedEvent.get("event_title") %></span></div>
                        <div class="info_div">모집 기간<span class="info_span"><%= selectedEvent.get("event_start").substring(0, 10) %> ~ <%= selectedEvent.get("event_end").substring(0, 10) %></span></div>
                        <div class="info_div">참여 현황<span class="info_span"><%= selectedEvent.get("event_registered") %> / <%= selectedEvent.get("event_quota") %></span></div>
                        <div class="info_div">대기 인원<span class="info_span"><%= selectedEvent.get("event_waiting") %></span></div>
                    <% } %>
                </div>

                <div class="event_list">
                    <% if (request.getAttribute("userEvents") == null || ((List<Map<String, String>>) request.getAttribute("userEvents")).isEmpty()) { %>
                        <p id="list_empty">참여자가 존재하지 않습니다.</p>
                    <% } else { %>
                        <table class="event_list_table">
                            <thead class="table-light">
                                <tr>
                                    <th scope="col">번호</th>
                                    <th scope="col">이름</th>
                                    <th scope="col">제목</th>
                                    <th scope="col">진행일</th>
                                    <th scope="col">참여 등록일</th>
                                    <th scope="col">등록 상태</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
	                                List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("userEvents");
	                                Paging paging = (Paging) request.getAttribute("paging");
	                                int startNum = (paging.getNowPage() - 1) * paging.getNumPerPage() + 1;
	                                for (int i = 0; i < list.size(); i++) {
	                                    Map<String, String> row = list.get(i);
                                %>
                                <tr style="cursor: pointer;" onclick="location.href='/event/detail?eventNo=<%=row.get("event_no")%>&eventType=<%=row.get("event_form")%>'">
                                    <td><%=startNum + i%></td>
                                    <td><%=row.get("user_name")%></td>
                                    <td><%=row.get("event_title")%></td>
                                    <td><%=row.get("event_progress").substring(0, 10)%></td>
                                    <td><%=row.get("participate_date")%></td>
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
            </div>
          </main>
    </section>
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
                <a href="/event/parList?nowPage=<%= startPage - 1 %>">&laquo;</a> 
            <% } %>
            <% for (int i = startPage; i <= endPage; i++) { %>
                 <a href="/event/parList?nowPage=<%= i %>" <%=paging.getNowPage() == i ? "class='active'" : ""%>> <%=i%>
                </a> 
            <% } %>
            <% if (endPage < totalPage) { %> 
                <a href="/event/parList?nowPage=<%= endPage + 1 %>">&raquo;</a> 
            <% } %>
            <% } %>
        </div>
    </div>
</body>
</html>
