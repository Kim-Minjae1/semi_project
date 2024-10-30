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
        background-color: #4cae4c;
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
        text-align: center;
        margin-top: 20px;
    }
     .pagination {
            display: inline-block;
            justify-content: center;
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
            background-color: #A5A5A5;
            color: white;
            border: 1px solid #A5A5A5;
        }
        .pagination a:hover:not(.active) {
            background-color: #ddd;
        }
         .holeList {
        font-family: 'LINESeedKR-Bd'; 
        max-width: 1000px;
        margin: 2rem auto;
        padding: 1rem 1rem;
        background-color: white;
        box-shadow: 0 5px 7px rgba(0, 0, 0, 0.1);
        border-radius: 20px;
      }
        .center {
        text-align: center;
        margin-top: 20px;
    }
    	.word h3 {
         margin: 30px 0px;
         text-align: center;
         font-size: 30px;
           font-weight: bold;
	}
</style>
</head>
<body>
<%@ include file="../../include/header.jsp" %>
<section class="holeList">
 <div class="word">
	       <h3>임시저장</h3>
	  </div>
    <div class="search">
        <form action="/user/saveTextList" name="search_board_form" method="get" class="search_board_form">
            <input type="text" name="bk_content" placeholder="검색하고자 하는 도서 이름을 검색하세요.">
            <input type="submit" value="검색">
        </form>
    </div>
    <div class="book_list">
        <%@ page import="com.book.member.book.vo.BookText, java.util.*" %>
        <% 
            List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("resultList");
            if (list != null && !list.isEmpty()) { 
        %>
            <table class="book_table">
                <thead>
                    <tr>
                        <th>이미지</th>
                        <th>도서명</th>
                        <th>저자</th>
                        <th>출판사</th>
                        <th>업로드(수정일)</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Map<String, String> row : list) { %>
                        <tr>
                            <td><a href="/user/saveEditCheck?save_no=<%= row.get("save_no") %>"><img src="<%= row.get("bk_img") %>" alt="책 이미지" width="100vw"></a></td>
                            <td><%= row.get("bk_title") %></td>
                            <td><%= row.get("bt_writer") %></td>
                            <td><%= row.get("bk_publisher_name") %></td>
                            <td><%= row.get("upload") %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <div class="no-results">검색한 결과가 없습니다.</div>
        <% } %>
    </div>

<% BookText paging = (BookText)request.getAttribute("paging");%>

<% if(paging != null){ %>
    <div class="center">
        <div class="pagination">
            <% if(paging.isPrev()){ %>
                <a href="/user/saveTextList?nowPage=<%=(paging.getPageBarStart()-1)%>">&laquo;</a>
            <%}%>
            <% for(int i = paging.getPageBarStart() ; i <= paging.getPageBarEnd() ; i++) {%>
                <a href="/user/saveTextList?nowPage=<%=i%>"
                   <%=paging.getNowPage() == i ? "class='active'" : ""%>>
                    <%=i%>
                </a>
            <%}%>
            <% if(paging.isNext()){%>
                <a href="/user/saveTextList?nowPage=<%=(paging.getPageBarEnd()+1)%>">&raquo;</a>
            <%}%>
        </div>
    </div>
<% } %>
</section>
</body>
</html>
