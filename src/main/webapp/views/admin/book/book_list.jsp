<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Knock Book</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }
    .container {
        width: 80%;
        margin: 20px auto;
        background-color: #fff;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    .search {
        margin-bottom: 20px;
    }
    .search input[type="text"] {
        width: 80%;
        padding: 10px;
        margin-right: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }
    .search input[type="submit"] {
        padding: 10px 20px;
        border: none;
        background-color: rgb(224, 195, 163);
        color: white;
        border-radius: 5px;
        cursor: pointer;
    }
    .search input[type="submit"]:hover {
        background-color: #c7ad91;
    }
    .book_list {
        margin-top: 20px;
    }
    .book_table {
        width: 100%;
        border-collapse: collapse;
    }
    .book_table th, .book_table td {
        padding: 10px;
        border: 1px solid #ddd;
        text-align: left;
    }
    .book_table th {
        background-color: #f8f8f8;
    }
    .center {
        display : flex;
        text-align: center;
        justify-content : center;
        margin-top: 20px;
    }
    .pagination a {
        padding: 10px 15px;
        margin: 0 5px;
        border: 1px solid #ddd;
        color: #333;
        text-decoration: none;
        border-radius: 5px;
    }
    .pagination a.active {
        background-color: rgb(224, 195, 163);;
        color: white;
        border-color: rgb(224, 195, 163);;
    }
    .pagination a:hover {
        background-color: #c7ad91;
        color: white;
    }
</style>
</head>
<body>

<% Boolean success = (Boolean) request.getAttribute("success"); %>
<% if (success != null && success) { %>
    <script type="text/javascript">
        alert("작성이 완료되었습니다.");
    </script>
<% } %>

 <%@ include file="../../include/header.jsp" %>
<section>
    <div id="section_wrap" class="container">
        <div class="search">
            <form action="/book/list" name="search_board_form" method="get" class="search_board_form">
                <input type="text" name="bk_content" placeholder="검색하고자 하는 도서 이름을 검색하세요.">
                <input type="submit" value="검색">
            </form>
        </div>
        <div class="book_list">
            <table class="book_table">
                <thead>
                    <tr>
                        <th>이미지</th>
                        <th>도서명</th>
                        <th>저자</th>
                        <th>출판사</th>
                        <th>카테고리</th>
                         <th>수정</th>
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody>
                    <%@page import="com.book.admin.book.vo.Book, java.util.*" %>
                    <% List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("resultList");
                       if (list != null) {
                           for (Map<String, String> row : list) { %>
                            <tr>
                                <td><img src="<%= row.get("books_img") %>" alt="책 이미지" width="100vw"></td>
                                <td><%= row.get("books_title") %></td>
                                <td><%= row.get("books_author") %></td>
                                <td><%= row.get("books_publisher_name") %></td>
                                <td><%= row.get("books_category") %></td>
                               <td><form action="/book/bookCheck" method="post">
										<input type="hidden" name="books_no" value="<%= row.get("books_no") %>">
	                                	<input type="submit" value="수정">
	                                </form>
                              	</td>
                                <td><form action="/book/delete" method="post">
		                            	<input type="hidden" name="books_no" value="<%= row.get("books_no") %>">
		                            	<input type="submit" value="삭제">
		                            </form>
	                           </td>
                            </tr>
                        <% }
                       } else { %>
                        <div class="no-results">검색한 결과가 없습니다.</div>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</section>

<% Book paging = (Book)request.getAttribute("paging");%>
<% if(paging != null){ %>
    <div class="center">
        <div class="pagination">
            <% if(paging.isPrev()){ %>
                <a href="/book/list?nowPage=<%=(paging.getPageBarStart()-1)%>">&laquo;</a>
            <%}%>
            <% for(int i = paging.getPageBarStart() ; i <= paging.getPageBarEnd() ; i++) {%>
                <a href="/book/list?nowPage=<%=i%>"
                   <%=paging.getNowPage() == i ? "class='active'" : ""%>>
                    <%=i%>
                </a>
            <%}%>
            <% if(paging.isNext()){%>
                <a href="/book/list?nowPage=<%=(paging.getPageBarEnd()+1)%>">&raquo;</a>
            <%}%>
        </div>
    </div>
<% } %>
</body>
</html>
