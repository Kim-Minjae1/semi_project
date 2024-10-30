<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <style>
   
        .write_container {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 2vw;
        }

        .input-field {
            height: 50px;
            border-radius: 10px;
            border: 2px solid #3232321f;
            padding: 0 10px;
            width: 100%;
        }
        textarea {
            width: 100%;
            height: 20rem;
            border-radius: 10px;
            border: 2px solid #3232321f;
            resize: none;
            padding: 10px;
        }
        .bw_btn {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-top: 20px;
            width: 100%;
        }
        .btn {
            padding: 10px 20px;
            font-size: 16px;
            width: 100%;
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
	.form_first {
	 display:flex;
	 gap: 2vw;
	}
	.form_second {
	 display:flex;
	 gap: 2vw;
	}
	.form_left {
		gap:1vw;
		display : flex;
		flex-direction : column;
		
	}
	.form_right {
		margin-top : 20px;
		
	}
	.form_write{
		gap: 1.5vw;
		display : flex;
		flex-direction : row;
	}

    </style>
</head>
<body>

<%@ include file="../../include/header.jsp" %>
<%@ page import="java.util.*" %>
<section class ="holeList">
       <div class="word">
	       <h3>독후감 작성</h3>
	  </div>
    <form class="form_write" name="create_account_form" id="create_account_form" method="post">
        <div class ="form_left">
	        <div class="form_first">
	        
	            <%
	            List<Map<String, String>> resultList = (List<Map<String, String>>) request.getAttribute("resultList");
	            Map<String, String> book = null;
	            if (resultList != null && !resultList.isEmpty()) {
	                book = resultList.get(0);
	            %>
	        	 	<input type="hidden" name="bk_no" id="bk_no" value="<%= book.get("books_no")%>"/>
	        	<div>	
	            	<label for = "bk_title">도서이름</label>
		            <input type="text" name="bk_title" id="bk_title" value="<%= book.get("books_title") %>" class="input-field" readonly />
	        	</div>
	           <div>
		            <label for = "bk_author">저자</label>
		            <input type="text" id="bk_author" name="bk_author" value="<%= book.get("books_author") %>" class="input-field"readonly />
	           </div>
	           <div>
		            <label for = "bk_publisher_name">출판사</label>
		            <input type="text" id="bk_publisher_name" name="bk_publisher_name" value="<%= book.get("books_publisher_name") %>" class="input-field" readonly />
	           </div>
	           <div>
		            <label for = "bk_category">카테고리</label>
		            <input type="text" id="bk_category" name="bk_category" value="<%= book.get("books_category") %>" class="input-field" readonly />
	           </div>
	       </div>
	      	<div class ="form_second">
	           <div>
		            <label for = "bk_recommendation">추천도</label>
		            <select name="bk_recommendation" id="bk_recommendation" class="input-field" required>
		                <option value="">추천도</option>
		                <option value="1">별로</option>
		                <option value="2">나쁘지 않음</option>
		                <option value="3">보통</option>
		                <option value="4">좋음</option>
		                <option value="5">매우좋음</option>
		            </select>
	           </div>
	           <div>
		             <label for = "bk_recommendation">읽기시작</label>
		            <input type="date" id="bw_start_date" name="bw_start_date" class="input-field" required/>
	           </div>
	           <div>
		             <label for = "bk_recommendation">읽기종료</label>
		            <input type="date" id="bw_end_date" name="bw_end_date" class="input-field" required/>
	           </div>
	            <% } %>
	        </div>           
	        <div class="form_third">
	        	<label for = "bw_content">내용</label>
	            <textarea name="bw_content" required ></textarea>
	        </div>
        </div>

        <div class="form_right">
            <% if (book != null) { %>
                <img src="<%= book.get("books_img") %>" alt="Book Image" />
            <% } %>
            <div class="bw_btn">

                        <button type="button" class="btn btn-secondary" onclick="saveDraft();">임시저장</button>
                        <button type="button" class="btn btn-secondary" onclick="submitForm();">제출</button>
            </div>
        </div>
    </form>


    </section>
<script>
    document.addEventListener('DOMContentLoaded', function() {
                var today = new Date();

                var year = today.getFullYear();
                var month = (today.getMonth() + 1).toString().padStart(2, '0'); // 월은 0부터 시작하므로 +1
                var day = today.getDate().toString().padStart(2, '0');

                var formattedDate = year + '-' + month + '-' + day;

                document.getElementById('bw_start_date').value = formattedDate;
                document.getElementById('bw_end_date').value = formattedDate;
            });
            function validateForm() {
                var form = document.getElementById('create_account_form');
                var inputs = form.querySelectorAll('input[required], select[required], textarea[required]');
                for (var i = 0; i < inputs.length; i++) {
                    if (!inputs[i].value) {
                        alert('모든 필드를 작성해 주세요.');
                        return false;
                    }
                }
                return true;
            }
        function saveDraft() {
            var form = document.getElementById('create_account_form');
            form.action = '/book/saveDraft';
            form.submit();
        }
        function submitForm() {
          if (validateForm()) {
               var form = document.getElementById('create_account_form');
               form.action = '/book/textEnd';
               form.submit();
           }
        }
</script>
</body>
</html>
