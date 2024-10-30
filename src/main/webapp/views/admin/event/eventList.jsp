<%@page import="java.time.LocalDate"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.book.admin.event.vo.Event" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Knock Book</title>
</head>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
    crossorigin="anonymous">
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
    
	 
	.event_list table tbody td a {
	    text-decoration: none;  
	    color: black;   
	}
	  
	.word h3 {
         margin: 30px 0px;
         text-align: center;
         font-size: 30px;
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
        padding: 8px 12px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 16px;
        margin-right: 10px;
        margin-left : 5px;
        background-color: #fff;
        color: #333;
        height: 40px;  
    }

    select:focus {
        outline: none;
        border-color: #A5A5A5;
        box-shadow: 0 0 5px rgba(165, 165, 165, 0.5);
    }
  
    #evTitle {
        padding: 8px 12px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 16px;
        height: 40px;  
        margin-right: 10px;
    }

    #evTitle:focus {
        outline: none;
        border-color: #A5A5A5;
        box-shadow: 0 0 5px rgba(165, 165, 165, 0.5);
    }
    
    #evList_Btn {
    	background-color: rgb(224, 195, 163);
    }
    
    #evList_Btn:hover {
    	background-color: #c7ad91;
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
</style>
<body>
    <%@ include file="../../include/header.jsp" %> 
    <section>
    	<main>
	        <div id="section_wrap" class="container">
	            <div class="word">
	                <h3>이벤트 목록</h3>
	            </div>
	            <br>
	            <form action="/event/list" method="get"> 
	                <select name="listCategory" id="listCategory">
	                    <option value="">전체</option>
	                    <option value="1" <%= (request.getParameter("listCategory") != null && request.getParameter("listCategory").equals("1")) ? "selected" : "" %>>기본</option>
	                    <option value="2" <%= (request.getParameter("listCategory") != null && request.getParameter("listCategory").equals("2")) ? "selected" : "" %>>선착순</option>
	                    <option value="3" <%= (request.getParameter("listCategory") != null && request.getParameter("listCategory").equals("3")) ? "selected" : "" %>>신간도서</option>
	                    <option value="4" <%= (request.getParameter("listCategory") != null && request.getParameter("listCategory").equals("4")) ? "selected" : "" %>>독서 마라톤</option>
	                    <option value="5" <%= (request.getParameter("listCategory") != null && request.getParameter("listCategory").equals("5")) ? "selected" : "" %>>챌린지</option>
	                    <option value="6" <%= (request.getParameter("listCategory") != null && request.getParameter("listCategory").equals("6")) ? "selected" : "" %>>작가 초청</option>
	                </select>  
	                
	                <label for="year">년도 </label>
				    <select name="year" id="year">
				    	<option value="">전체</option>
				        <% 
				            int currentYear = LocalDate.now().getYear();
				            for (int year = currentYear; year >= 2023; year--) { 
				        %>
				            <option value="<%= year %>" <%= (request.getParameter("year") != null && request.getParameter("year").equals(String.valueOf(year))) ? "selected" : "" %>><%= year %></option>
				        <% } %>
				    </select>
				    <label for="month">월 </label>
				    <select name="month" id="month">
				        <option value="">전체</option>
				        <% 
				            for (int month = 1; month <= 12; month++) { 
				        %>
				            <option value="<%= String.format("%02d", month) %>" <%= (request.getParameter("month") != null && request.getParameter("month").equals(String.format("%02d", month))) ? "selected" : "" %>><%= month %></option>
				        <% } %>
				    </select>
    
	                <input type="text" id="evTitle" name="evTitle">
	                <button type="submit" class="btn" id="evList_Btn">검색</button>
	            </form>
	            <div class="event_list">
	                <% if (request.getAttribute("resultList") == null || ((List<Map<String, String>>) request.getAttribute("resultList")).isEmpty()) { %>
	                    <p id="list_empty">존재하는 이벤트가 없습니다.</p>
	                <% } else { %>
	                    <table class="event_list_table">
	                        <thead class="table-blight">
	                            <tr>
	                                <th scope="col">번호</th>
	                                <th scope="col">제목</th>
	                                <th scope="col">등록일</th>
	                                <th scope="col">유형</th>
	                                <th scope="col">카테고리명</th>
	                                <th scope="col">참여 현황</th>
	                                <th scope="col">대기 인원</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                            <%
	                                List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("resultList");
	                                int pageSize = 10; // 한 페이지에 표시할 항목 수
	                                int nowPage = request.getParameter("nowPage") == null ? 1 : Integer.parseInt(request.getParameter("nowPage"));
	                                int startNo = (nowPage - 1) * pageSize + 1;
	                                for (int i = 0; i < list.size(); i++) {
	                                    Map<String, String> row = list.get(i);
	                            %>
	                            <tr style="cursor: pointer;" onclick="location.href='/event/detail?eventNo=<%=row.get("event_no")%>&eventType=<%=row.get("event_form")%>'">
	                                <td><%=startNo + i%></td>
	                                <td><%=row.get("event_title")%></td>
	                                <td><%=row.get("event_regdate").substring(0, 10)%></td>
	                                
	                                <td>
	                                    <%
	                                        int evForm = Integer.parseInt(row.get("event_form"));
	                                        if (evForm == 1) {
	                                            out.print("기본");
	                                        } else if (evForm == 2) {
	                                            out.print("선착순");
	                                        }
	                                    %>
	                                </td>
	                                <td><%=row.get("event_category_name")%></td>
	                                <% 
									    if (evForm == 1) {
									%>
									    <td>-</td>  
									    <td>-</td>  
									<% } else { %>
									    <td><%=row.get("event_registered")%> / <%=row.get("event_quota")%></td>
									    <td><%=row.get("event_waiting")%></td>
									<% } %>

	                            </tr>
	                            <% } %>
	                        </tbody>
	                    </table>
	                <% } %>
	            </div>
	        </div>
	      </main>
    </section>
    <%
	    Event paging = (Event) request.getAttribute("paging");
	    if (paging != null) {
	%>
	<div class="center">
	    <div class="pagination">
	         <%
                    String listCategory = request.getParameter("listCategory");
                    if (listCategory == null) {
                        listCategory = "";
                    }
 
                    int totalPages = paging.getTotalPage();
                     
                    int pageStart = Math.max(1, paging.getNowPage() - 4);
                    int pageEnd = Math.min(totalPages, paging.getNowPage() + 4);
 
                    if (paging.isPrev()) {
             %>
	            <a href="/event/list?nowPage=<%=(paging.getPageBarStart() - 1)%>">
	                &laquo;
	            </a>
	        <%
	            }
	
	            for (int i = paging.getPageBarStart(); i <= paging.getPageBarEnd(); i++) {
	        %>
	            <a href="/event/list?nowPage=<%=i%>"
	                <%=paging.getNowPage() == i ? "class='active'" : ""%>> <%=i%>
	            </a>
	        <%
	            }
	
	            if (paging.isNext()) {
	        %>
	            <a href="/event/list?nowPage=<%=(paging.getPageBarEnd() + 1)%>">&raquo;</a>
	        <%
	            }
	        %>
	    </div>
	</div>
	<%
	    }
	%>

</body>
</html>
