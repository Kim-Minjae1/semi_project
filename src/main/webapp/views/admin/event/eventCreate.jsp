<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        height: 35px;  
        width : 160px; 
    }

    select:focus {
        outline: none;
        border-color: #A5A5A5;
        box-shadow: 0 0 5px rgba(165, 165, 165, 0.5);
    }
    
   .form-section {
       display: none;
   }
   
   #form-section1 {
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
       display: none;
   }
   
   .image-box.default::before {
       content: "JPG / JPEG / PNG";
       position: absolute;
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
    <section>
    	<main>    
	   <form name="create_event_form" action="/event/createEnd" method="post" enctype="multipart/form-data">
	        <div class="form-group">
	            <label for="eventType">이벤트 유형</label>
	            <select id="eventType" name="eventType" onchange="showFormSection()"> 
	                <option value="1" selected>기본 이벤트</option>
	                <option value="2">선착순 이벤트</option> 
	            </select>
	        </div>
	
	        <div id="form-section1" class="form-section">
	           <div class="form-group">
	              <label for="eventCategory1">카테고리</label>
	              <select id="eventCategory1" name="eventCategory1"> 
	                  <option value="1" selected>신간 도서</option>
	                  <option value="2">독서 마라톤</option>
	                  <option value="3">챌린지</option>
	                  <option value="4">작가 초청</option> 
	              </select>
	             </div>
	             
				<div class="form-group">
				    <label for="eventTitle1">제목</label>
				    <input type="text" id="eventTitle1" name="eventTitle1" maxlength="40" onkeyup="updateCounter(1)">
				    <span style="color:#aaa;" id="counter1">(0 / 40)</span>
				</div>
	            <div class="form-group">
	                <label for="startDate1">기간</label>
	                <div>
	                    <input type="date" id="startDate1" name="startDate1" onchange="toggleEndDate(1)"><br>
	                    <input type="date" id="endDate1" name="endDate1" disabled>
	                </div>
	            </div>
	            <div class="form-group">
	                <label for="eventContent1">내용</label>
	                <textarea id="eventContent1" name="eventContent1" wrap="hard"></textarea>
	            </div>
	            <div class="form-group">
	                <label for="eventimage1">이미지</label>
	                <div>
	                    <div class="image-box default" id="imageBox1" onclick="document.getElementById('eventimage1').click()">
	                        <img id="imagePreview1" alt="Image Preview">
	                    </div>
	                    <div class="delete-button" id="deleteButton1" onclick="deleteImage(1)">이미지 삭제</div>
	                    <input type="file" id="eventimage1" name="eventimage1"  accept=".png,.jpg,.jpeg" onchange="previewImage(event, 1)">
	                </div>
	            </div>  
	            <button id="eventCancelBtn" onclick="eventCancelBtn();">취소</button>
	            <button id="eventInsertBtn"  onclick="eventInsertBtn(); disabled">등록</button>
	        </div>
	
	        <div id="form-section2" class="form-section">
	            <div class="form-group">
	                <label for="eventCategory2">카테고리</label>
	                <select id="eventCategory2" name="eventCategory2"> 
	                    <option value="1" selected>신간 도서</option>
	                    <option value="2">독서 마라톤</option>
	                    <option value="3">챌린지</option>
	                    <option value="4">작가 초청</option> 
	                </select>
	            </div>
				<div class="form-group">
				    <label for="eventTitle2">제목</label>
				    <input type="text" id="eventTitle2" name="eventTitle2" maxlength="40" onkeyup="updateCounter(2)">
				    <span style="color:#aaa;" id="counter2">(0 / 40)</span>
				</div>
	            <div class="form-group">
	                <label for="startDate2">모집 기간</label>
	                <input type="datetime-local" id="startDate2" name="startDate2" onchange="setMinValue()">
	                <input type="datetime-local" id="endDate2" name="endDate2" disabled onchange="setMinValue()">
	            </div>
	            <div class="form-group">
	                <label for="progressDate2">이벤트 진행일</label>
	                <input type="date" id="progressDate2" name="progressDate2" disabled><br>
	            </div>
	            <div class="form-group">
	                <label for="eventQuota2">정원</label>
	                <input type="number" id="eventQuota2" name="eventQuota2" min="1"><br>
	            </div> 
	            <div class="form-group">
	                <label for="eventContent2">내용</label>
	                <textarea id="eventContent2" name="eventContent2" wrap="hard"></textarea>
	            </div>
	            <div class="form-group">
	                <label for="eventimage2">이미지</label>
	                <div>
	                    <div class="image-box default" id="imageBox2" onclick="document.getElementById('eventimage2').click()">
	                        <img id="imagePreview2" alt="Image Preview">
	                    </div>
	                    <div class="delete-button" id="deleteButton2" onclick="deleteImage(2)">이미지 삭제</div>
	                    <input type="file" id="eventimage2" name="eventimage2"  accept=".png,.jpg,.jpeg" onchange="previewImage(event, 2)">
	                </div>
	            </div>
	            <button id="eventCancelBtn" onclick="eventCancelBtn();">취소</button>
	            <button id="eventInsertBtn2" onclick="eventInsertBtn(); disabled">등록</button>
	        </div> 
	    </form>
	</main>
	</section>
    <script src="../../../resources/js/eventCreate.js"></script> 
    <script>   
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
	            const startDate = new Date(startDate2.value);
	            startDate.setDate(startDate.getDate() + 1); // 다음 날로 설정
	            const minEndDate = startDate.toISOString().slice(0, 16);  
	
	            endDate2.min = minEndDate;
	             
	            endDate2.addEventListener('change', function() {
	                if (endDate2.value) {
	                    const endDate = new Date(endDate2.value);
	                    endDate.setDate(endDate.getDate() + 1);
	                    const dayAfterEnd = endDate.toISOString().slice(0, 10); 
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
	            const endDate = document.getElementById('endDate1').value.trim();
	            const content = document.getElementById('eventContent1').value.trim();
	            const image = document.getElementById('eventimage1').value.trim();
	
	            if (!title || !startDate || !endDate || !content || !image) {
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
	
	        const insertBtn = document.getElementById('eventInsertBtn');
	        if (isValid) {
	            insertBtn.disabled = false;
	            insertBtn.classList.add('enabled');
	        } else {
	            insertBtn.disabled = true;
	            insertBtn.classList.remove('enabled');
	        }
	
	        const insertBtn2 = document.getElementById('eventInsertBtn2');
	        if (isValid) {
	            insertBtn2.disabled = false;
	            insertBtn2.classList.add('enabled');
	        } else { 
	            insertBtn2.disabled = true;
	            insertBtn2.classList.remove('enabled');
	        }
	    }
	
	    function eventInsertBtn() {
	        const form = document.create_event_form;
	        form.submit();
	    }
	    
	    $(document).ready(function() {
            $('#eventTitle1').on('keyup', function() {
                var content = $(this).val();
                var maxLength = $(this).attr('maxlength');
                
                if (content.length > maxLength) {
                    alert("최대 40자까지 입력 가능합니다.");
                    $(this).val(content.substring(0, maxLength));
                }

                $('#counter1').text("(" + $(this).val().length + " / " + maxLength + ")");
            });
        });
	    
	    $(document).ready(function() {
            $('#eventTitle2').on('keyup', function() {
                var content = $(this).val();
                var maxLength = $(this).attr('maxlength');
                
                if (content.length > maxLength) {
                    alert("최대 40자까지 입력 가능합니다.");
                    $(this).val(content.substring(0, maxLength));
                }

                $('#counter2').text("(" + $(this).val().length + " / " + maxLength + ")");
            });
        });
 
</script>

</body>
</html>
