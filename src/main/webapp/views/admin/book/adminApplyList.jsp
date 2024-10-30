<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Knock Book - 도서 신청 관리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
 	    @font-face {
            font-family: 'BMHANNAPro';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_seven@1.0/BMHANNAPro.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }
        
        body {
            font-family: 'BMHANNAPro;
            background-color: #f8f9fa;
            color: #333;
        }
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        } 
        
        #book_icon {
			width : 10%;
			margin-bottom: 30px;
		}
		
	    #book_apply_title {
	        font-family: 'BMHANNAPro';
	        font-size: 30px;  
	        margin-bottom: 20px;   
	    }
	    
        .search-form {
            margin-bottom: 30px;
        }
        .search-form input {
            border-radius: 20px 0 0 20px;
            border: 1px solid #ced4da;
        }
        .search-form button {
            border-radius: 0 20px 20px 0;
            background-color: rgb(224, 195, 163);
            border: none;
        }
        
        .search-form button:hover {
            border-radius: 0 20px 20px 0;
            background-color: #c7ad91;
            border: none;
        }
        
        .table {
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }
        .table th {
            background-color: #f8f9fa;
            color: #495057;
        }
        .pagination {
            justify-content: center;
            margin-top: 30px;
        }
        .pagination .page-link {
            color: #007bff;
            border-radius: 50%;
            margin: 0 5px;
        }
        .pagination .page-item.active .page-link {
            background-color: rgb(224, 195, 163);
            border-color: rgb(224, 195, 163);
        }
        .btn-sm {
            border-radius: 20px;
            padding: 0.25rem 0.8rem;
        }
        
        .apply_inner {
        	width : 1000px; 
        	margin-left : 50px;
        }
    </style>
</head>
<body>
    <%@ include file="../../include/header.jsp" %>
    <%@page import="com.book.admin.book.vo.ApplyBook, java.util.*" %>

    <div class="container">
        <div class="text-center mb-4">
            <img src="../../resources/book.png" id="book_icon">
            <div id="book_apply_title">도서 신청 관리</div>
        </div>

		<div class="apply_inner"> 
	        <form class="search-form d-flex" action="/book/applyStatusList" method="get">
	            <input class="form-control me-2" type="search" name="apply_bk_title" placeholder="신청 도서 이름을 입력해주세요" aria-label="Search">
	            <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i></button>
	        </form>
	
	        <table class="table table-hover">
	            <thead>
	                <tr>
	                    <th>도서이름</th>
	                    <th>저자</th>
	                    <th>출판사</th>
	                    <th>신청자</th>
	                    <th>신청상태</th>
	                    <th>관리</th>
	                </tr>
	            </thead>
	            <tbody>
	                <% List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("resultList");
	                if (list != null && !list.isEmpty()) {
	                    for (Map<String, String> row : list) { %>
	                        <tr>
	                            <td><%= row.get("apply_bk_title") %></td>
	                            <td><%= row.get("apply_bk_author") %></td>
	                            <td><%= row.get("apply_bk_publisher") %></td>
	                            <td><%= row.get("user_nickname") %></td>
	                            <td>
	                                <%
	                                    int status = Integer.parseInt(row.get("apply_bk_status"));
	                                    String statusText = "";
	                                    String statusClass = "";
	                                    switch (status) {
	                                        case 0:
	                                            statusText = "신청대기";
	                                            statusClass = "text-warning";
	                                            break;
	                                        case 1:
	                                            statusText = "신청완료";
	                                            statusClass = "text-success";
	                                            break;
	                                        case -1:
	                                            statusText = "신청반려";
	                                            statusClass = "text-danger";
	                                            break;
	                                    }
	                                %>
	                                <span class="<%= statusClass %>"><%= statusText %></span>
	                            </td>
	                            <td>
	                                <% if (status == 0) { %>
	                                    <form action="/book/applyStatusEnd" method="post" class="d-inline">
	                                        <input type="hidden" name="apply_no" value="<%= row.get("apply_no") %>">
	                                        <button type="submit" name="status" value="1" class="btn btn-success btn-sm">승인</button>
	                                    </form>
	                                    <form action="/book/applyStatusEnd" method="post" class="d-inline">
	                                        <input type="hidden" name="apply_no" value="<%= row.get("apply_no") %>">
	                                        <button type="submit" name="status" value="-1" class="btn btn-danger btn-sm">반려</button>
	                                    </form>
	                                <% } %>
	                            </td>
	                        </tr>
	                    <% }
	                } else { %>
	                    <tr>
	                        <td colspan="6" class="text-center">신청 결과가 없습니다.</td>
	                    </tr>
	                <% } %>
	            </tbody>
	        </table>
		</div>
        <% ApplyBook paging = (ApplyBook)request.getAttribute("paging");
        if(paging != null){ %>
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <% if(paging.isPrev()){ %>
                        <li class="page-item">
                            <a class="page-link" href="/book/applyStatusList?nowPage=<%=(paging.getPageBarStart()-1)%>" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    <%}%>
                    <% for(int i = paging.getPageBarStart() ; i <= paging.getPageBarEnd() ; i++) {%>
                        <li class="page-item <%= paging.getNowPage() == i ? "active" : "" %>">
                            <a class="page-link" href="/book/applyStatusList?nowPage=<%=i%>"><%=i%></a>
                        </li>
                    <%}%>
                    <% if(paging.isNext()){%>
                        <li class="page-item">
                            <a class="page-link" href="/book/applyStatusList?nowPage=<%=(paging.getPageBarEnd()+1)%>" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    <%}%>
                </ul>
            </nav>
        <% } %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>