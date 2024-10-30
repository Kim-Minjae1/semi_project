<%@ page import="com.book.admin.event.vo.Event" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Knock Book</title>
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
    
  	select, input {
        padding: 5px 12px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 13px;
        margin-right: 10px; 
        background-color: #fff;
        color: #333;
        height: 30px;  
        width : 140px; 
    }

    select:focus {
        outline: none;
        border-color: #A5A5A5;
        box-shadow: 0 0 5px rgba(165, 165, 165, 0.5);
    }
    
    .form-section {
        display: none;
    }
    
    .form-section.active {
        display: block;
    }
    
    .form-group {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
    }
    
    .form-group label {
        width: 150px;  
        text-align: left;
        margin-left: 2%;
        margin-right: 3%; 
    }
    
   #eventTitle1, #eventTitle2 {  
        width : 60%;
   }
   
   #startDate1, #endDate1 {
        margin-bottom: 5px; 
   }
   
   #startDate2, #endDate2 {
        margin-bottom: 5px; 
        width : 25%;
   }
    
   #eventContent1, #eventContent2 {  
       width : 60%;
       height: 15em; 
       resize: none; 
       border: 1px solid #ccc;
	   border-radius: 4px;
	   font-size: 13px;
	   margin-right: 10px; 
	   background-color: #fff;
   } 
    
    .image-box {
        width: 10vw;
        height: 10vw;
        border: 1px solid #ccc;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        overflow: hidden;
        background-color: #f0f0f0;
        position: relative;
        text-align: center;
        font-size: 0.8vw;  
        color: #666;
    }
    
    .image-box img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    input[type="file"] {
        display: none;
    }
    
    .delete-button {
        display: none;
        margin-top: 10px; 
        color: #f44336;  
        cursor: pointer;
        font-size: 12px;
        font-weight: 600;
    }
    
    button {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.3s, color 0.3s;
    }
 
    #eventInsertBtn,
    #eventInsertBtn2 {
        background-color: #4CAF50;  
        color: white;
    }

    #eventInsertBtn:disabled,
    #eventInsertBtn2:disabled {
        background-color: #BDBDBD; 
        color: #9E9E9E; 
        cursor: not-allowed;
    }

    #eventInsertBtn:hover,
    #eventInsertBtn2:hover {
        background-color: #45a049; 
    }
 
    #eventCancelBtn {
        background-color: #f44336; 
        color: white;
        margin-left: 10px;
    }

    #eventCancelBtn:hover {
        background-color: #e53935;  
    }
    
</style>
</head>
<body>
    <%@ include file="../../include/header.jsp" %>
    
    <%
        Event event = (Event) request.getAttribute("event");
        String formAction = "/event/update";
        int eventType = event.getEv_form();  
    %>
    
 <section>
   <main> 
    <form name="update_event_form" action="/event/updateEnd?eventNo=<%= event.getEvent_no() %>&eventType=<%= event.getEv_form() %>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="eventNo" value="<%= event.getEvent_no()%>">
        
        <% if (eventType == 1) { %>
        <div id="form-section1" class="form-section active">
            <div class="form-group">
               <label for="eventCategory1">카테고리</label>
               <select id="eventCategory1" name="eventCategory1"> 
                   <option value="1" <%= event.getEv_category_name().equals("신간 도서") ? "selected" : "" %>>신간 도서</option>
                   <option value="2" <%= event.getEv_category_name().equals("독서 마라톤") ? "selected" : "" %>>독서 마라톤</option>
                   <option value="3" <%= event.getEv_category_name().equals("챌린지") ? "selected" : "" %>>챌린지</option>
                   <option value="4" <%= event.getEv_category_name().equals("작가 초청") ? "selected" : "" %>>작가 초청</option> 
               </select>
            </div>
            <div class="form-group">
                <label for="eventTitle1">제목</label>
                <input type="text" id="eventTitle1" name="eventTitle1" maxlength="40" value="<%= event.getEv_title() %>"> 
            </div>
            <div class="form-group">
                <label for="startDate1">기간</label>
                <div>
                    <input type="date" id="startDate1" name="startDate1" value="<%= event.getEv_start() %>"><br>
                    <input type="date" id="endDate1" name="endDate1" value="<%= event.getEv_end() %>">
                </div>
            </div>
            <div class="form-group">
                <label for="eventContent1">내용</label>
                <textarea id="eventContent1" name="eventContent1" wrap="hard"><%= event.getEv_content() %></textarea>
            </div>
            <div class="form-group">
                <label for="eventimage1">이미지</label>
                <div>
                    <div class="image-box" id="imageBox1" onclick="document.getElementById('eventimage1').click()">
                        <img id="imagePreview1" src="<%= request.getContextPath() %>/upload/event/<%= event.getNew_image() %>" alt="Image Preview">
                    </div>
                    <div class="delete-button" id="deleteButton1" onclick="deleteImage(1)">이미지 삭제</div>
                    <input type="file" id="eventimage1" name="eventimage1" accept=".png,.jpg,.jpeg" onchange="previewImage(event, 1)">
                </div>
            </div>  
            <button type="button" id="eventCancelBtn" onclick=history.back()>취소</button>
            <button id="eventUpdateBtn" type="button" onclick="eventUpdateBtn1();">수정</button>
        </div>
        <% } else if (eventType == 2) { %>
        <div id="form-section2" class="form-section active">
            <div class="form-group">
                <label for="eventCategory2">카테고리</label>
                <select id="eventCategory2" name="eventCategory2"> 
                    <option value="1" <%= event.getEv_category_name().equals("신간 도서") ? "selected" : "" %>>신간 도서</option>
                    <option value="2" <%= event.getEv_category_name().equals("독서 마라톤") ? "selected" : "" %>>독서 마라톤</option>
                    <option value="3" <%= event.getEv_category_name().equals("챌린지") ? "selected" : "" %>>챌린지</option>
                    <option value="4" <%= event.getEv_category_name().equals("작가 초청") ? "selected" : "" %>>작가 초청</option> 
                </select>
            </div>
            <div class="form-group">
                <label for="eventTitle2">제목</label>
                <input type="text" id="eventTitle2" name="eventTitle2" maxlength="40" value="<%= event.getEv_title() %>">  
            </div>
            <div class="form-group">
                <label for="startDate2">모집 기간</label>
                <input type="datetime-local" id="startDate2" name="startDate2" value="<%= event.getEv_start() %>">
                <input type="datetime-local" id="endDate2" name="endDate2" value="<%= event.getEv_end() %>">
            </div>
            <div class="form-group">
                <label for="progressDate2">이벤트 진행일</label>
                <input type="date" id="progressDate2" name="progressDate2" value="<%= event.getEv_progress() %>"><br>
            </div>
            <div class="form-group">
                <label for="eventQuota2">정원</label>
                <input type="number" id="eventQuota2" name="eventQuota2" min="1" value="<%= event.getEvent_quota() %>"><br>
            </div> 
            <div class="form-group">
                <label for="eventContent2">내용</label>
                <textarea id="eventContent2" name="eventContent2" wrap="hard"><%= event.getEv_content() %></textarea>
            </div>
            <div class="form-group">
                <label for="eventimage2">이미지</label>
                <div>
                    <div class="image-box" id="imageBox2" onclick="document.getElementById('eventimage2').click()">
                        <img id="imagePreview2" src="<%= request.getContextPath() %>/upload/event/<%= event.getNew_image() %>" alt="Image Preview">
                    </div>
                    <div class="delete-button" id="deleteButton2" onclick="deleteImage(2)">이미지 삭제</div>
                    <input type="file" id="eventimage2" name="eventimage2" accept=".png,.jpg,.jpeg" onchange="previewImage(event, 2)">
                </div>
            </div>
            <button type="button" id="eventCancelBtn" onclick=history.back()>취소</button>
            <button id="eventUpdateBtn" type="button" onclick="eventUpdateBtn2();">수정</button>
        </div>
        <% } %>
    </form>
 </main>
 </section>
    <script>
	    document.addEventListener('DOMContentLoaded', function() { 
	        setInitialMinValue();
	 
	        document.getElementById('startDate2').addEventListener('change', function() {
	            setMinValue();
	        }); 
	          
	    });
	     
	    function setInitialMinValue() {
	        const startDate2 = document.getElementById('startDate2');
	        const endDate2 = document.getElementById('endDate2');
	        const progressDate2 = document.getElementById('progressDate2');
	
	        const today = new Date();
	        today.setDate(today.getDate() + 1); 

	        const tomorrow = today.toISOString().slice(0, 16);
	
	        startDate2.min = tomorrow; 

	        endDate2.disabled = true;
	        progressDate2.disabled = true;
	    }
	
	    function setMinValue() {
	        const startDate2 = document.getElementById('startDate2');
	        const endDate2 = document.getElementById('endDate2');
	        const progressDate2 = document.getElementById('progressDate2');

	        if (startDate2.value) {
	            endDate2.disabled = false;
	            endDate2.min = startDate2.value;
	
	            endDate2.addEventListener('change', function() {
	                if (endDate2.value) {
	                    const endDate = new Date(endDate2.value);
	                    endDate.setDate(endDate.getDate() + 1);
	                    const dayAfterEnd = endDate.toISOString().slice(0, 10); // YYYY-MM-DD 형식으로 변환
	                    progressDate2.min = dayAfterEnd;
	                    progressDate2.disabled = false;
	                } else {
	                    progressDate2.disabled = true;
	                    progressDate2.value = '';
	                }
	            });
	        } else {
	            endDate2.disabled = true;
	            endDate2.value = '';
	            progressDate2.disabled = true;
	            progressDate2.value = '';
	        }
	
	        validateForm(); 
	    }
	
	    function validateForm() {
	        const eventType = document.getElementById('eventType').value;
	        let isValid = true;
	
	        if (eventType === '1') { // 기본 이벤트
	            const title = document.getElementById('eventTitle1').value.trim();
	            const startDate = document.getElementById('startDate1').value.trim();
	            const content = document.getElementById('eventContent1').value.trim();
	            const image = document.getElementById('eventimage1').value.trim();
	
	            if (!title || !startDate || !content || !image) {
	                isValid = false;
	            }
	        } else if (eventType === '2') { // 선착순 이벤트
	            const title = document.getElementById('eventTitle2').value.trim();
	            const startDate = document.getElementById('startDate2').value.trim();
	            const endDate = document.getElementById('endDate2').value.trim();
	            const progressDate = document.getElementById('progressDate2').value.trim();
	            const quota = document.getElementById('eventQuota2').value.trim();
	            const content = document.getElementById('eventContent2').value.trim();
	            const image = document.getElementById('eventimage2').value.trim();
	
	            if (!title || !startDate || !endDate || !progressDate || !quota || !content || !image) {
	                isValid = false;
	            }
	
	            if (progressDate && endDate && progressDate <= endDate) {
	                isValid = false;
	                alert('이벤트 진행일은 모집 종료일 이후여야 합니다.');
	            }
	        }
	    } 
	    
		function previewImage(event, section) {
	        const inputFile = event.target;
	        const file = inputFile.files[0];
	        const fileType = file.type;
	        const validImageTypes = ['image/jpeg', 'image/png', 'image/jpg'];
	        
	        if (!validImageTypes.includes(fileType)) {
	            alert("JPG, JPEG, PNG 파일만 업로드 가능합니다.");
	            inputFile.value = '';
	            return;
	        }
	
	        const reader = new FileReader();
	        reader.onload = function() {
	            const preview = document.getElementById('imagePreview' + section);
	            preview.src = reader.result;
	            preview.style.display = 'block';
	
	            const imageBox = document.getElementById('imageBox' + section);
	            imageBox.classList.remove('default');
	
	            const deleteButton = document.getElementById('deleteButton' + section);
	            deleteButton.style.display = 'block';
	        };
	        reader.readAsDataURL(file);
	        
	        validateForm();  
	    }
	
	    function deleteImage(section) {
	        const preview = document.getElementById('imagePreview' + section);
	        preview.src = '';
	        preview.style.display = 'none';
	
	        const imageBox = document.getElementById('imageBox' + section);
	        imageBox.classList.add('default');
	
	        const deleteButton = document.getElementById('deleteButton' + section);
	        deleteButton.style.display = 'none';
	
	        const inputFile = document.getElementById('eventimage' + section);
	        inputFile.value = '';
	        
	        validateForm(); 
	    }
	    
	    function eventUpdateBtn1() {
	        let form = document.update_event_form;	
	        if(!form.eventTitle1.value){
	            alert("제목을 입력하세요.");
	            form.eventTitle1.focus();
	        } else if(!form.startDate1.value){
	            alert("모집 기간을 입력하세요.");
	            form.startDate1.focus();
	        } else if(!form.endDate1.value){
	            alert("모집 기간을 입력하세요.");
	            form.endDate1.focus();
	        } else if(!form.eventContent1.value){
	            alert("내용을 입력하세요.");
	            form.eventContent1.focus();
	        } else if (!form.eventimage1.value && !document.getElementById('imagePreview1').src) {
	            alert('이미지 파일을 선택하세요.');
	            form.eventimage1.focus();	
	        } else { 
	            form.submit();
	        }
	    }

	    function eventUpdateBtn2() {
	        let form = document.update_event_form;	
	        if(!form.eventTitle2.value){
	            alert("제목을 입력하세요.");
	            form.eventTitle2.focus();
	        } else if(!form.startDate2.value){
	            alert("모집 기간을 입력하세요.");
	            form.startDate2.focus();
	        } else if(!form.endDate2.value){
	            alert("모집 기간을 입력하세요.");
	            form.endDate2.focus();
	        } else if(!form.progressDate2.value){
	            alert("진행일을 입력하세요.");
	            form.progressDate2.focus();
	        } else if(!form.eventQuota2.value){
	            alert("모집 정원을 입력하세요.");
	            form.eventQuota2.focus();
	        } else if(!form.eventContent2.value){
	            alert("내용을 입력하세요.");
	            form.eventContent2.focus();
	        } else if (!form.eventimage2.value && !document.getElementById('imagePreview2').src) {
	            alert('이미지 파일을 선택하세요.');
	            form.eventimage2.focus();	
	        } else { 
	            form.submit();
	        }
	    }
	     
	   
</script>
</body>
</html>