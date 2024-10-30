<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.book.admin.book.vo.Book"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 도서 등록</title> 
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f7f7f7;
    }

    #right {
        margin-left: 350px;
        width: 60%;
        padding: 40px;
        box-sizing: border-box;
    }

    .book_icon {
        background-color: #e0e0e0;
        padding: 20px;
        border-radius: 10px;
    }

    .book {
        background-color: #ffffff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        position: relative; /* 버튼을 절대 위치로 배치하기 위해 추가 */
    }

    .book h2 {
        margin-top: 0;
    }

    .book form {
        display: flex;
        flex-direction: column;
    }

    .book label {
        margin-top: 10px;
    }

    .book input[type="text"],
    .book select {
        margin-top: 5px;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    .book .form-group {
        margin-top: 10px;
    }

    .book .buttons {
        position: absolute;
        right: 20px;
        bottom: 20px;
        display: flex;
        gap: 10px;
    }

    .book .buttons input[type="button"] {
        padding: 8px 12px; /* 버튼의 크기를 줄임 */
        border: none;
        border-radius: 4px;
        background-color: #007BFF;
        color: white;
        font-size: 14px; /* 버튼 글자 크기를 줄임 */
        cursor: pointer;
    }

    .book .buttons input[type="button"]:last-child {
        background-color: #dc3545;
    }

    .book .buttons input[type="button"]:hover {
        opacity: 0.8;
    }
</style>
</head>
<body>
    <%@ include file="../../include/header.jsp" %>
    <%@ page import="com.book.admin.book.vo.Book, java.util.*" %>
    <section id="right">
        <div class="book_icon">
            <div class="book">
                <% 
                    List<Map<String, String>> resultList = (List<Map<String, String>>) request.getAttribute("resultList");
                    Map<String, String> book = null;
                    if (resultList != null && !resultList.isEmpty()) {
                        book = resultList.get(0);
                    %>
                    <form action="/book/edit" name="book_edit_form" method="post">
                        <input type="hidden" name="books_no" id="books_no" value="<%= book.get("books_no") %>">
                        <label for="book_img">이미지 등록</label>
                        <input type="text" name="books_img" id="book_img" value="<%= book.get("books_img") %>">
                        <hr>
                        <label for="book_title">도서명</label>
                        <input type="text" name="books_title" id="book_title" value="<%= book.get("books_title") %>">
                        <hr>
                        <label for="books_author">저자</label>
                        <input type="text" name="books_author" id="book_author" value="<%= book.get("books_author") %>">
                        <hr>
                        <label for="books_publisher_name">출판사</label>
                        <input type="text" name="books_publisher_name" id="books_publisher_name" value="<%= book.get("books_publisher_name") %>">
                        <hr>
                        <label for="books_category_no">카테고리</label>
                        <select name="books_category_no" id="books_category_no">
                            <option value="0">선택안함</option>
                            <option value="1" <%= "1".equals(book.get("books_category_no")) ? "selected" : "" %>>총류</option>
                            <option value="2" <%= "2".equals(book.get("books_category_no")) ? "selected" : "" %>>철학</option>
                            <option value="3" <%= "3".equals(book.get("books_category_no")) ? "selected" : "" %>>종교</option>
                            <option value="4" <%= "4".equals(book.get("books_category_no")) ? "selected" : "" %>>사회과학</option>
                            <option value="5" <%= "5".equals(book.get("books_category_no")) ? "selected" : "" %>>순수과학</option>
                            <option value="6" <%= "6".equals(book.get("books_category_no")) ? "selected" : "" %>>기술과학</option>
                            <option value="7" <%= "7".equals(book.get("books_category_no")) ? "selected" : "" %>>예술</option>
                            <option value="8" <%= "8".equals(book.get("books_category_no")) ? "selected" : "" %>>언어</option>
                            <option value="9" <%= "9".equals(book.get("books_category_no")) ? "selected" : "" %>>문학</option>
                            <option value="10" <%= "10".equals(book.get("books_category_no")) ? "selected" : "" %>>역사</option>
                        </select>
                        <hr>
                        <input type="submit" value="수정" onclick="return book_update();"> 
                    </form>
                    <input type="button" value="초기화" onclick="book_reset();">
                <% } else { %>
                <p>도서 정보를 불러올 수 없습니다.</p>
                <% } %>
            </div>
        </div>
    </section>
</body>
<script>
function book_update() {
    const form = document.book_edit_form;
    let valid = true;
    let errorMessage = "";

    if (!form.books_img.value) {
        errorMessage += "이미지주소를 입력하세요.\n";
        valid = false;
    }
    if (!form.books_title.value) {
        errorMessage += "도서명을 입력하세요.\n";
        valid = false;
    }
    if (!form.books_author.value) {
        errorMessage += "저자명을 입력하세요.\n";
        valid = false;
    }
    if (!form.books_publisher_name.value) {
        errorMessage += "출판사를 입력하세요.\n";
        valid = false;
    }
    if (form.books_category_no.value == "0") {
        errorMessage += "카테고리를 선택해주세요.\n";
        valid = false;
    }
    if (!valid) {
        alert(errorMessage);
        return false; 
    }

    alert("수정되었습니다.");
    return true;  
}

function book_reset() {
    const form = document.book_edit_form;
    form.books_img.value = '';  
    form.books_title.value = '';  
    form.books_author.value = '';  
    form.books_publisher_name.value = ''; 
    form.books_category_no.selectedIndex = 0;  
}
</script>
</html>
