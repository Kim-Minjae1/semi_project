<%@page import="com.book.admin.event.vo.Event"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%> 
<%@ page import="com.book.member.user.vo.User"%>
<head>
<meta charset="UTF-8">
<title>Knock Book</title>
<style>   

.container {
    width: 100%;
    max-width: 1300px;  
    margin: 0 auto;
} 
    body {
        background-color: rgb(247, 247, 247);
        -ms-overflow-style: none;
    }
    ::-webkit-scrollbar {
     display: none;
   }
    
    .word h3 {
        font-family: 'LINESeedKR-Bd';
        margin: 30px 0px;
        text-align: center;
        font-size: 2vw;
    }
    #list_empty{
       font-size : 1.4vw;
    }
    .event_list_table {
        margin-top: 30px;
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
    
    .search-container {
       display: flex;
       justify-content: space-between;
       align-items: center;
       margin-bottom: 20px;
   }
   
   .search-form {
       display: flex;
       flex-grow: 1;
       margin-right: 10px;
   }
   
   .search-input {
       flex-grow: 1;
       padding: 10px;
       font-size: 1.3vw;
       border: 1px solid #ccc;
       border-radius: 4px 0 0 4px;
   }
   
   .search-button,
   .all-button {
       padding: 10px 20px;
       font-size: 16px;
       color: #fff;
       background-color: #6c757d;
       border: none;
       cursor: pointer;
       transition: background-color 0.3s ease;
   }
   
   .search-button {
       border-radius: 0 4px 4px 0;
       font-size : 1vw;
   }
   
   .all-button {
       border-radius: 4px;
       font-size : 1vw;
       height : 45px;
   }
   
   .search-button:hover,
   .all-button:hover {
       background-color: #5a6268;
   }

    .center {
       margin-top:50px;
        text-align: center;
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
            <div id="section_wrap" class="container">
                <%
                    User user_nick = (User) session.getAttribute("user");
                %>
                <div class="word">
                    <h3><%= (user_nick != null) ? user_nick.getUser_nickname() : "" %>님의 이벤트 참여 내역</h3>
                </div>
                <br>
            <div class="search-container">
                <form action="/user/event/parList" method="get" class="search-form">
                    <input type="text" class="search-input" name="searchKeyword" placeholder="이벤트 제목 검색">
                    <button type="submit" class="search-button">검색</button>
                </form>
                <form action="/user/event/parList" method="get" class="all-form">
                    <button type="submit" class="all-button">전체</button>
                </form>
            </div> 
                <div class="event_list">
                    <% if (request.getAttribute("userEvents") == null || ((List<Map<String, String>>) request.getAttribute("userEvents")).isEmpty()) { %>
                        <p id="list_empty">참여한 이벤트가 없습니다.</p>
                    <% } else { %>
                        <table class="event_list_table">
                            <thead class="table-light">
                                <tr>
                                    <th scope="col">번호</th>
                                    <th scope="col">제목</th>
                                    <th scope="col">진행일</th>
                                    <th scope="col">참여 등록일</th>
                                    <th scope="col">등록 상태</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("userEvents");
                                    Event paging = (Event) request.getAttribute("paging");
                                    User user_par = (User) session.getAttribute("user");
                                    int userNo = user_par.getUser_no();
                                    int startRow = (paging.getNowPage() - 1) * paging.getNumPerPage();
                                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                    Date currentDate = new Date();
                                    for (int i = 0; i < list.size(); i++) {
                                        Map<String, String> row = list.get(i);
                                        String eventEndDateStr = row.get("event_end");
                                        Date eventEndDate = sdf.parse(eventEndDateStr);
                                        long diffInMillies = Math.abs(currentDate.getTime() - eventEndDate.getTime());
                                        long diffInDays = diffInMillies / (24 * 60 * 60 * 1000);
                                %>
                                <tr style="cursor: pointer;" onclick="checkEventEndDate('<%=row.get("event_no")%>', <%=diffInDays%>)">
                                    <td><%=startRow + i + 1%></td>
                                    <td><%=row.get("event_title")%></td>
                                    <td><%=row.get("event_progress").substring(0, 10)%></td>
                                    <td><%=row.get("participate_date").substring(0, 10)%></td>
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
    <%
        Event paging = (Event) request.getAttribute("paging");
        if (paging != null) {
    %>
    <div class="center">
        <div class="pagination">
            <%
                if (paging.isPrev()) {
            %>
                <a href="/user/event/parList?nowPage=<%=(paging.getPageBarStart() - 1)%>">
                    &laquo;
                </a>
            <%
                }

                for (int i = paging.getPageBarStart(); i <= paging.getPageBarEnd(); i++) {
            %>
                <a href="/user/event/parList?nowPage=<%=i%>"
                    <%=paging.getNowPage() == i ? "class='active'" : ""%>> <%=i%>
                </a>
            <%
                }

                if (paging.isNext()) {
            %>
                <a href="/user/event/parList?nowPage=<%=(paging.getPageBarEnd() + 1)%>">&raquo;</a>
            <%
                }
            %>
        </div>
    </div>
    <%
        }
    %>
        </div> 
    </div>
    <script>
        function checkEventEndDate(eventNo, diffInDays) {
            if (diffInDays > 30) {
                alert("종료된 이벤트입니다.");
            } else {
                location.href = '/user/event/detail?eventNo=' + eventNo;
            }
        }
    </script>