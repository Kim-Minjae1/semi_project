<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Knock Book</title>
<style>  
	::-webkit-scrollbar {
		display: none;
	}  

    body {
        font-family: 'Noto Sans KR', sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f6f8;
        color: #333; 
        align-items: center;
        marign-left : 150px;
        -ms-overflow-style: none;
    } 
    
    main {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100%;
        margin-left : 550px;
    }
    
    #right { 
        width: 100%;
        max-width: 900px;
        padding: 40px; 
    }
    
    .book { 
        background-color: #ffffff;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }
    
    .book h2 {
        margin-top: 0;
        margin-bottom: 25px;
        color: #2c3e50;
        font-size: 24px;
    }
    
    .book form {
        display: flex;
        flex-direction: column;
    }
    
    .book label {
        margin-top: 5px;
        font-weight: 500;
        color: #34495e;
    }
    
    .book input[type="text"],
    .book select {
        margin-top: 8px;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 6px;
        font-size: 16px;
        transition: border-color 0.3s;
    }
    
    .book input[type="text"]:focus,
    .book select:focus {
        outline: none;
        border-color: #3498db;
    }
    
    .book hr {
        margin: 20px 0;
        border: none;
        border-top: 1px solid #eee;
    }
    
    .book .buttons {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
        width : 
        margin-top: 25px;
    }
    
    .book .buttons input[type="button"] {
        padding: 12px 20px;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    
    .book .buttons input[type="button"]:first-child {
        background-color: #3498db;
        color: white;
    }
    
    .book .buttons input[type="button"]:last-child {
        background-color: #e74c3c;
        color: white;
    }
    
    .book .buttons input[type="button"]:hover {
        opacity: 0.9;
    }
</style>
<body>
 <%@ include file="../../include/header.jsp" %>
<main>
    <section id="right">
        <div class="book_icon">
            <div class="book">
                <form action="/book/createEnd" name="book_request_form" method="post">

                    <label for="img_up">이미지 등록</label>
                    <input type="text" name="img_up" placeholder="이미지url을 입력하세요">
                    <hr>
                    <label for="book_title">도서명</label>
                    <input type="text" name="book_title" id="book_title" placeholder="도서명을 입력하세요">
                    <hr>
                    <label for="book_author">저자</label>
                    <input type="text" name="book_author" id="book_author" placeholder="저자를 입력하세요">
                    <hr>
                    <label for="book_publihser">출판사</label>
                    <input type="text" name="book_publihser" id="book_publihser" placeholder="출판사를 입력하세요">
                    <hr>
                    <label for="book_category">카테고리</label>
                    <select name="book_category" id="book_category">
                        <option value="0">선택안함</option>
                        <option value="1">총류</option>
                        <option value="2">철학</option>
                        <option value="3">종교</option>
                        <option value="4">사회과학</option>
                        <option value="5">순수과학</option>
                        <option value="6">기술과학</option>
                        <option value="7">예술</option>
                        <option value="8">언어</option>
                        <option value="9">문학</option>
                        <option value="10">역사</option>
                    </select>
                    <hr>
                    <div class="buttons">
                        <input type="button" value="등록" onclick="book_plus();">
                        <input type="button" value="초기화" onclick="book_reset();">
                    </div> 
                </form>
            </div>
        </div>
    </section>
</main>
<script>
function book_plus() {
    const form = document.book_request_form;
    if (!form.img_up.value) {
        alert("이미지주소를 입력하세요");
    } else if (!form.book_title.value) {
        alert("도서명을 입력하세요");
    } else if (!form.book_author.value) {
        alert("저자명을 입력하세요");
    } else if (!form.book_publihser.value) {
        alert("출판사를 입력하세요");
    }else if (form.book_category.value == 0) {
        alert("카테고리를 선택해주세요");
    } 
    else {
        alert("등록되었습니다!");
        form.submit();
    };
}

function book_reset() {
    const form = document.book_edit_form;
    form.img_up.value = '';
    form.book_title.value = '';
    form.book_author.value = '';
    form.book_publisher.value = '';
    form.book_category.selectedIndex = 0;  
}
</script>
</body>
</html>