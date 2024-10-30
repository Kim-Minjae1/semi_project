<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="com.book.member.user.vo.User" %> 
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
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
            margin-top: 20px;
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
            text-decoration: none;
            border-radius: 5px;
        }
        .pagination a.active {
            background-color: rgb(224, 195, 163);
            color: white;
            border-color: rgb(224, 195, 163);
        }
        .pagination a:hover {
            background-color: #c7ad91;
            color: white;
        }
        #section_wrap .search input[type='text'] {
           width: 500px;
           padding: 10px;
           border: 1px solid #adadad;
           border-radius: 5px;
        }
        #section_wrap .search input[type='submit'] {
           width: 80px;
           padding: 10px;
           border: 1px solid #adadad;
           border-radius: 5px;
           cursor: pointer;
        }
    </style>
    
</head>
<body>
<%@ include file="../../include/header.jsp" %>
<section>
    <div id="section_wrap" class="container">
      <form action="check_table" name="search_name_form" method="get" class="search">
          <input type="text" name="user_name" placeholder="검색하고자하는 사용자 이름을 입력하세요." value="<%=request.getParameter("user_name") != null ? request.getParameter("user_name") : "" %>">
          <input type="submit" value="검색">
      </form> 
        <div class="book_list">
            <label for="numPerPage">목록 개수:</label>
            <% 
                User paging = (User) request.getAttribute("paging");
                if (paging == null) {
                    paging = new User(); 
                    paging.setNumPerPage(5); 
                }
            %>
            <select id="numPerPage" name="numPerPage" onchange="setNumPerPage();">
                <option value="5" <%= paging != null && paging.getNumPerPage() == 5 ? "selected" : "" %>>5개</option>
                <option value="10" <%= paging != null && paging.getNumPerPage() == 10 ? "selected" : "" %>>10개</option>
                <option value="15" <%= paging != null && paging.getNumPerPage() == 15 ? "selected" : "" %>>15개</option>
            </select>

            <table class="book_table">
                <select id="order_select" name="order_select" onchange="setOrder();">
                    <option value="">정렬</option>
                    <option value="user_name" <%= "user_name".equals(request.getParameter("order")) ? "selected" : "" %>>이름</option>
                    <option value="user_nickname" <%= "user_nickname".equals(request.getParameter("order")) ? "selected" : "" %>>닉네임</option>
                    <option value="user_email" <%= "user_email".equals(request.getParameter("order")) ? "selected" : "" %>>이메일</option>
                    <option value="user_create" <%= "user_create".equals(request.getParameter("order")) ? "selected" : "" %>>회원가입 일시</option>
                    <option value="user_active" <%= "user_active".equals(request.getParameter("order")) ? "selected" : "" %>>비활성화 여부</option>
                </select>
                <thead>
                    <tr>
                        <th>이름</th>
                        <th>닉네임</th>
                        <th>아이디</th>
                        <th>이메일</th>
                        <th>회원가입 일시</th>
                        <th>비활성화 여부</th>
                    </tr>
                </thead>
               <tbody>
             <% 
                 DateTimeFormatter chtab_outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                 List<User> resultList = ((List<User>)request.getAttribute("resultList"));
                 if (resultList != null) {
                     for (User row : resultList) { 
             %>
             <tr>
                 <td><%= row.getUser_name() %></td>
                 <td><%= row.getUser_nickname() %></td>
                 <td><%= row.getUser_id() %></td>
                 <td><%= row.getUser_email() %></td>
                 <td><%= row.getUser_create().format(chtab_outputFormatter) %></td>
                 <td><%= row.getUser_active() == 1 ? "회원" : "비회원" %></td>
             </tr>
             <% 
                     } 
                 } else { 
             %>
             <tr>
                 <td colspan="6" style="text-align: center;">No data found.</td>
             </tr>
             <% 
                 } 
             %>
         </tbody>
            </table>
        </div>
    </div>
</section>
<section id="paging">
    <% 
    String orderParam = request.getParameter("order");
    String numPerPageParam = request.getParameter("numPerPage"); 
    String userNameParam = request.getParameter("user_name");  
    %>

    <% if (paging != null) { %>
    <div class = "center">
        <div class="pagination">
            <% if (paging.isPrev()) { %>
            <a href="/user/check_table?nowPage=<%=(paging.getPageBarStart() - 1)%>&numPerPage=<%=numPerPageParam%>&order=<%=orderParam%>&user_name=<%=userNameParam != null ? userNameParam : "" %>">&laquo;</a>
            <% } %>
            <% for (int i = paging.getPageBarStart(); i <= paging.getPageBarEnd(); i++) { %>
            <a href="/user/check_table?nowPage=<%=i%>&numPerPage=<%=numPerPageParam%>&order=<%=orderParam%>&user_name=<%=userNameParam != null ? userNameParam : "" %>" <%=paging.getNowPage() == i ? "class='active'" : ""%>><%=i%></a>
            <% } %>
            <% if (paging.isNext()) { %>
            <a href="/user/check_table?nowPage=<%=(paging.getPageBarEnd() + 1)%>&numPerPage=<%=numPerPageParam%>&order=<%=orderParam%>&user_name=<%=userNameParam != null ? userNameParam : "" %>">&raquo;</a>
            <% } %>
        </div>
    </div>
    <% } %>
</section>


<script>
function setNumPerPage() {
    const numPerPageSelect = document.getElementById('numPerPage');
    const numPerPageValue = numPerPageSelect.value;

    const currentUrl = new URL(window.location.href);
    currentUrl.searchParams.set('numPerPage', numPerPageValue);  

    // 현재 페이지 유지
    const nowPage = currentUrl.searchParams.get('nowPage') || 1;  
    currentUrl.searchParams.set('nowPage', nowPage);

    // 검색어 유지
    const userName = document.querySelector('input[name="user_name"]').value;
    if (userName) {
        currentUrl.searchParams.set('user_name', userName);
    }

    // 정렬 상태 유지
    const orderSelect = document.getElementById('order_select');
    const orderValue = orderSelect.value;
    if (orderValue) {
        currentUrl.searchParams.set('order', orderValue);
    }

    // 페이지 이동
    window.location.href = currentUrl.toString();
}




function setOrder() {
    const orderSelect = document.getElementById('order_select');
    const orderValue = orderSelect.value;

    const currentUrl = new URL(window.location.href);
    currentUrl.searchParams.set('order', orderValue);  

    const numPerPage = currentUrl.searchParams.get('numPerPage') || 10;  
    currentUrl.searchParams.set('numPerPage', numPerPage);

    const userName = document.querySelector('input[name="user_name"]').value;  
    if (userName) {
        currentUrl.searchParams.set('user_name', userName);
    }

    window.location.href = currentUrl.toString(); 
}

</script>
</body>
</html>
