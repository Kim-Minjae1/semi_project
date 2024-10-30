<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Knock Book</title>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
          crossorigin="anonymous"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
       <link rel="stylesheet"
     href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
		body { 
		    -ms-overflow-style: none;
		}
		
		::-webkit-scrollbar {
			display: none;
		} 
	

        .center {
            text-align: center;
        }

        .pagination {
            display: inline-block;
            justify-content: center;
            background-color: white;
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

        .search {
            margin-bottom: 20px;
            text-align: center;
        }

        .search input[type="text"] {
            padding: 0.8vw;
            width: 5vw;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .search input[type="submit"] {
            background-color: rgb(224, 195, 163);
            color: white;
            border: none;
            padding: 8px 16px;
            text-decoration: none;
            margin-left: 5px;
            cursor: pointer;
            border-radius: 4px;
        }

        .search input[type="submit"]:hover {
            background-color: gray;
        }

        a {
            text-decoration: none;
            color: black;
            background-color: rgba(0, 0, 0, 0);
            transition: color 0.3s;
        }


        .book_image {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            background-color: white;
            gap: 20px;
        }

        .ele_bw {
		    width: calc(25% - 20px);
		    padding: 10px;
		    border: 1px solid #ddd;
		    border-radius: 5px;
		    background-color: white;
		    cursor: pointer; 
		    transition: box-shadow 0.3s ease;  
		}
		
		.ele_bw:hover {
		    box-shadow: 0 0 10px rgba(0,0,0,0.1);  
		}

        .ele_bw > div > img {
            width: 10vw;
        }

        .ele_bw > div {
            text-align: center;
            background-color: white;
        }

        .ele_bw a {
            display: block;
            margin-top: 1vw;
        }

        .search {
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
            background-color: white;
        }

        .search_board_form {
            display: flex;
            gap: 10px;
            align-items: center;
            width: 40vw;
            background-color: white;
        }

        .search input[type="text"] {
            padding: 10px;
            width: 30vw;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .search select {
            padding: 10px;
            margin-left: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            width: 8vw;
        }

        .search input[type="submit"] {
            background-color: rgb(224, 195, 163);
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 4px;
       
        }

        .search input[type="submit"]:hover {
            background-color: gray;
        }

        @media (max-width: 768px) {
            .ele_bw {
                width: calc(50% - 20px);
            }
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.8);
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fff;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }

        .modal-body {
            text-align: center;
            display:flex;
            width:100%;
        }

        .modal-body img {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
        }

        .modal-body h2 {
            margin-top: 20px;
            font-size: 24px;
        }

        .modal-body p {
            font-size: 16px;
            margin: 10px 0;
        }

        .modal-footer {
            margin-top: 20px;
            text-align: right;
        }

        .modal-footer button {
            background-color: rgb(224, 195, 163);
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 4px;
        }

        .modal-footer button:hover {
            background-color: gray;
        }
        .modal-image {
            width:50%;

        }
        .modal-info {
            width : 50%;

        }
        .container {
            display : flex;
            flex-direction : column;
        }
        .addBook {
            text-align : right;
            background-color:white;
            padding: 10px;
          
        }
          .addBook > a {
 			padding: 10px;
            border : 1px solid gray;
            border-radius :20px;
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
	}
    .bk_img {
        background-color: #f0f0f0;
        height: 150px;
        width: 100%;
        margin-bottom: 10px;
        border-radius: 10px;
        overflow: hidden;
    }

    .bk_img img {
        width: 100%;
        height: 100%;
        object-fit: contain;
    }
    </style>
 
</head>
<body>
<%@ include file="../../include/header.jsp" %>
<section class ="holeList">
        <div class="word">
	                <h3>도서 목록</h3>
	            </div>
        <div class="search">
            <form action="/user/bookList" name="search_board_form" method="get" class="search_board_form">
                <input type="text" name="bk_content" value="<%= request.getAttribute("searchContent") %>" placeholder="검색하고자 하는 도서 이름을 검색하세요.">
                <input type="submit" value="검색">
            </form>
        </div>
          <% User user_bt=(User)session.getAttribute("user");
            if(user_bt != null){ %>
             <div class="addBook">
               <a href="/book/apply"><i class="fa-solid fa-plus">도서추가</i></a>
             </div>
          <% } %>

        <div class="book_list">
            <div class="book_image">
                <%@ page import="com.book.admin.book.vo.Book, java.util.*" %>
                <% List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("resultList");
                   if (list != null && !list.isEmpty()) {
                   for (Map<String, String> row : list) { %>
                    <div class="ele_bw" onclick='showModal({
					    img: "<%= row.get("books_img") %>",
					    title: "<%= row.get("books_title") %>",
					    author: "<%= row.get("books_author") %>",
					    publisher: "<%= row.get("books_publisher") %>",
					    category: "<%= row.get("books_category") %>",
					    id: "<%= row.get("books_no") %>"
					})'>
					    <div class="bk_img"><img src="<%= row.get("books_img") %>" alt="책 이미지"></div>
					    <div><%= row.get("books_title") %></div>
					</div>
                <% }
                }else {%>
                    <div class="no-results">검색한 결과가 없습니다.</div>
            <% } %>
            </div>
        </div>
   

<% Book paging = (Book)request.getAttribute("paging"); %>
<% if(paging != null) { %>
    <div class="center">
        <div class="pagination">
            <% if(paging.isPrev()) { %>
                <a href="/user/bookList?nowPage=<%= (paging.getPageBarStart() - 1) %>">&laquo;</a>
            <% } %>
            <% for(int i = paging.getPageBarStart(); i <= paging.getPageBarEnd(); i++) { %>
                <a href="/user/bookList?nowPage=<%= i %>" <%= paging.getNowPage() == i ? "class='active'" : "" %>><%= i %></a>
            <% } %>
            <% if(paging.isNext()) { %>
                <a href="/user/bookList?nowPage=<%= (paging.getPageBarEnd() + 1) %>">&raquo;</a>
            <% } %>
        </div>
    </div>
<% } %>
</section>
<!-- 모달 창 -->
<div id="bookModal" class="modal">
    <div class="modal-content">
        <div class="modal-title">
            <div class="modal-body">
                <div class="modal-image">
                    <img id="modalBookImg" src="" alt="책 이미지" width="50%">
                </div>
                <div class="modal-info">
                    <h2 id="modalBookTitle"></h2>
                    <p><strong>저자:</strong> <span id="modalBookAuthor"></span></p>
                    <p><strong>출판사:</strong> <span id="modalBookPublisher"></span></p>
                    <p><strong>카테고리:</strong> <span id="modalBookCategory"></span></p>
                      <input type="hidden" id="modalBookId" value="">
                </div>

            </div>
            <div class="modal-footer">
                <button onclick="closeModal()">닫기</button>
                <%
                    if(user_bt != null){ %>
                       <button onclick="writeBook()">작성</button>
                    <% } %>
            </div>
        </div>
    </div>
</div>  
   <script>
        function showModal(book) {
            var modal = document.getElementById("bookModal");
            modal.style.display = "block";

            document.getElementById("modalBookImg").src = book.img;
            document.getElementById("modalBookTitle").innerText = book.title;
            document.getElementById("modalBookAuthor").innerText = book.author;
            document.getElementById("modalBookPublisher").innerText = book.publisher;
            document.getElementById("modalBookCategory").innerText = book.category;
            document.getElementById("modalBookId").value = book.id;
        }

        function closeModal() {
            var modal = document.getElementById("bookModal");
            modal.style.display = "none";
        }

        window.onclick = function(event) {
            var modal = document.getElementById("bookModal");
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
        function writeBook() {
            var id = document.getElementById("modalBookId").value;
            // URL 매개변수로 도서 정보 전달

            var url = "/book/textCheck?"+
                       "&id=" + encodeURIComponent(id); // ID를 URL에 추가
            window.location.href = url;
        }
    </script>
</body>
</html>