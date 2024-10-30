<%-- <%@page import="com.book.member.user.dao.PopularBookDao"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.book.admin.event.vo.Event"%>
<%@ page import="com.book.admin.event.dao.EventDao" %>
<%@ page import="java.util.Map" %> 
<%@ page import="java.util.Date"%>
<%@ page import="com.book.member.user.dao.PopularBookDao" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Knock Book</title> 
<style>
@charset "UTF-8";
	 body { 
	    -ms-overflow-style: none;
	}
	
	::-webkit-scrollbar {
		display: none;
	} 
	main {
	    max-width: 1200px;
	    margin: 2rem auto;
	    padding: 0 1rem; 
	}
	
	.search_section {
	    margin-top: 50px;
	    text-align: center;
	}
	
	.search_title {
	    font-size: 28px;
	    font-weight: 600;
	    color: #2c2c2c;
	    margin-bottom: 30px;
	    font-family: 'Freesentation-9Black';
	}
	
	.search_board_form {
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    max-width: 1200px;
	    margin: 0 auto;
	}
	
	.search_input {
	    width: 100%;
	    padding: 15px 24px;
	    font-size: 16px;
	    color: #575756;
	    background-color: #f5f5f5;
	    border: 2px solid #ddd;
	    border-radius: 30px;
	    transition: all 0.3s ease-in-out;
	}
	
	.search_input:focus {
	    outline: none;
	    border-color: #4a90e2;
	    box-shadow: 0 0 8px rgba(74, 144, 226, 0.3);
	}
	
	.search_submit {
	    background-color: rgb(224, 195, 163);
	    color: white;
	    border: none;
	    padding: 15px 30px;
	    font-size: 16px;
	    border-radius: 30px;
	    margin-left: 10px;
	    cursor: pointer;
	    transition: background-color 0.3s ease-in-out;
	}
	
	.search_submit:hover {
	    background-color: rgb(189, 167, 143);
	}
	
	.slide-image-container {
	    width: 40%;
	    height: 90%; 
	    border-radius: 30px;
	    background-color: rgba(181, 181, 181, 0); 
	}
	
	.slide-image {
	    width: 80%;
	    height: 100%;
	    object-fit: cover;
	    border-radius: 18px;
	    margin-top: 4%;
	    margin-bottom: 3%;
	    margin-left: 5%;
	}
	
	.event-section {
    	margin-top: 40px; 
	    position: relative;
	    max-width: 1200px;
	    margin-left: auto;
	    margin-right: auto;
	}

	.event_container {  
	    max-width: 100%; 
	    overflow: hidden;
	    height : 280px;
	}
	
	.slide {
	    display: none;
	    width: 100%;
	    height: 100%;
	    display: flex;
	    position: relative;
	    background-color: rgba(237, 237, 233);
	    border-radius: 30px;
	}
	
	.prev, .next {
	    cursor: pointer;
	    position: absolute;
	    top: 50%;
	    width: 30px;
	    height: 30px;
	    margin-top: -15px;  
	    color: rgb(56, 56, 56,0.3);
	    font-weight: lighter;
	    font-size: 18px;
	    border-radius: 50%; 
	    text-align: center;
	    line-height: 30px;
	    user-select: none;
	    border: 1px solid rgb(56, 56, 56,0.3);
	    text-decoration: none;
	    z-index: 10; 
	}
	
	.next {
	    right: -15px; 
	}
	
	.prev {
	    left: -15px;  
	}
	 
	@media (max-width: 768px) {
	    .event_container {
	        height: 200px; 
	    }
	    
	    .prev, .next {
	        width: 25px;
	        height: 25px;
	        font-size: 16px;
	        line-height: 25px;
	    }
	}
	
	@media (max-width: 480px) {
	    .event_container {
	        height: 150px;  
	    }
	    
	    .prev, .next {
	        width: 20px;
	        height: 20px;
	        font-size: 14px;
	        line-height: 20px;
	    }
	}
	
	.fade {
	    animation-name: fade;
	    animation-duration: 7s;
	}
	
	@keyframes fade {
	    from {opacity: .4}
	    to {opacity: 1}
	}
	
	.event_content {
	    position: absolute;
	    right: 5%;
	    top: 50%;
	    transform: translateY(-50%); 
	    padding: 20px;
	    border-radius: 10px;
	    width: 50%;  
	    color: rgb(0, 0, 0);
	    display: flex;
	    flex-direction: column;
	    justify-content: center;
	    background-color: rgba(255, 255, 255, 0);
	    align-items: center;  
	    text-align: center; 
	}
	
	.event_title {
	    font-size: 34px;
	    font-weight: bold;
	    margin-bottom: 10px;
	    color: rgb(0, 0, 0);
	    background-color: rgba(255, 255, 255, 0);
	    font-family: 'LeferiPoint-BlackA';
	}
	
	.event_form {
	    display: flex;
	    align-items: center;
	    justify-content: center;
	}
	
	.event_form_text {
	    background-color: rgba(248, 224, 119, 0.65);
	    font-family: 'LeferiPoint-BlackA';
	    font-size: 20px;
	    padding: 7px 7px 0px 7px;
	}
	
	.event-dday {
	    font-weight: bold;
	    font-size: 20px;
	    color: #edbb45;
	    margin-left: 15px;  
	} 
	
	.event_date {
	    margin-top: 5%;
	    font-size: 20px;
	    color: rgb(0, 0, 0);
	    background-color: rgba(255, 255, 255, 0);
	    font-family: 'LeferiPoint-BlackA';
	}
	
	.main {
	    margin-top: 50px;  
	}
	
	.recoBook {
    	margin-top: 50px;
	}
	
	.pRecoB {
	    font-size: 24px;
	    font-weight: bold;
	    text-align: center;
	    margin-bottom: 20px;
	    font-family: 'LeferiPoint-BlackA';
	}
	
	.book-container {
	    display: flex;
	    justify-content: center;
	    flex-wrap: wrap;
	    gap: 20px;
	}
	
	.bDiv {
	    text-align: center;
	    width: calc(50% - 10px);   
	    max-width: 300px;
	}
	
	.bTitle {
	    font-size: 16px;
	    margin-bottom: 10px;
	    font-family: 'LeferiPoint-BlackA';
	    height: 40px;   
	    overflow: hidden;
	    display: -webkit-box;
	    -webkit-line-clamp: 2;
	    -webkit-box-orient: vertical;
	}
	
	.bImg {
	    width: 100%;
	    height: auto;
	    border-radius: 10px;
	    max-width: 150px;
	}
	
	.mainPageAllArea {
        max-width: 1000px;
        margin: 2rem auto;
        padding: 1rem 3rem;
        background-color: white;
        box-shadow: 0 5px 7px rgba(0, 0, 0, 0.1);
        border-radius: 20px;
	}
</style>

</head>
<body>
    <%@ include file="views/include/header.jsp" %> 
    <section class ="mainPageAllArea">
        <main>
		    <!-- 검색 -->
            <section class="search_section">
			    <div class="search_container">
			        <h2 class="search_title">
			            Welcome to Knock Book!<br>Knock the door to endless stories.
			        </h2>
			        <form action="/user/bookList" name="search_board_form" method="get" class="search_board_form">
			            <input class="search_input" type="text" name="bk_content" placeholder="독후감을 작성할 도서를 검색해 보세요!">
			            <input class="search_submit" type="submit" value="검색">
			        </form>
			    </div>
			</section>
          
            <!-- 이벤트 -->
            <section class="event-section">
		        <div class="event_container">
		            <% 
		                boolean isAdmin = user != null && user.getUser_no() == 1;
		                List<Map<String, String>> events = EventDao.getAllEvents();
		                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				        Date now = new Date(); 
		                if (events != null && !events.isEmpty()) {
		                    for (int i = 0; i < events.size(); i++) {
		                    	Map<String, String> event = events.get(i);
		                        String eventNo = event.get("event_no");
		                        String imageUrl = request.getContextPath() + "/upload/event/" + event.get("event_new_image");
		                        String eventTitle = event.get("event_title");
		                        String eventStart = event.get("event_start").substring(0, 10);
		                        String eventEnd = event.get("event_end").substring(0, 10);
		                        String eventForm = event.get("event_form");
		                        String detailUrl = isAdmin ? request.getContextPath() + "/event/detail?eventNo=" + eventNo + "&eventType=" + eventForm
		                                                   : request.getContextPath() + "/user/event/detail?eventNo=" + eventNo + "&eventType=" + eventForm;
		                        Date eventEndDate = format.parse(eventEnd);
		                        long daysRemaining = (eventEndDate.getTime() - now.getTime()) / (1000 * 60 * 60 * 24);
		                        String dday = (daysRemaining > 0) ? "D-" + daysRemaining : (daysRemaining == 0) ? "모집중" : "모집 기간 종료";
		            %>  
					        <div class="slide">
					            <a href="<%= detailUrl %>">
					                <div class="slide-image-container"> 
					                    <img src="<%= imageUrl %>" alt="Image <%= i + 1 %>" class="slide-image">
					                </div>
					                <div class="event_content">
					                    <div class="event_title"><%= eventTitle %></div>
					                    <% if ("2".equals(eventForm)) { %>
					                        <div class="event_form">
					                            <span class="event_form_text">선착순 모집</span>
					                            <span class="event-dday"><%= dday %></span>
					                        </div>
					                    <% } %>
					                    <div class="event_date">
					                        <%= eventStart.equals(eventEnd) ? eventStart : eventStart + " ~ " + eventEnd %>
					                    </div> 
					                </div>
					            </a>
					        </div>
		            <%
		                    }  
		                } else {
		            %>
		                    <p>진행 중인 이벤트가 없습니다.</p>
		            <%
		                }
		            %>
		            <a class="prev" onclick="plusSlides(-1)">&#60;</a>
		            <a class="next" onclick="plusSlides(1)">&#62;</a>
		        </div>
		    </section>
		    
		   <!-- 추천 도서 -->
 			<%
 			    List<Map<String, String>> pblist = new PopularBookDao().popularBookList();
 			%>	
		    <div class="recoBook">
			    <div class="pRecoB">추천 도서</div> 
			    <div class="book-container">
			        <% for(Map<String, String> pbMap : pblist) { %>
			            <div class="bDiv">
			                <p class="bTitle"><%= pbMap.get("titles") %></p>
			                <img src="<%= pbMap.get("images") %>" 
			                    alt="<%= pbMap.get("titles") %>" class="bImg">
			            </div>
			        <% } %>
			    </div>
			</div>
        </main>
    </section>
    
    <script> 
	    let slideIndex = 0;
	    let slides = document.getElementsByClassName("slide");
	    let intervalId;
	
	    function startSlideShow() {
	        showSlides(slideIndex);
	        intervalId = setInterval(() => {
	            slideIndex++;
	            showSlides(slideIndex);
	        }, 3000);
	    }
	
	    function showSlides(n) {
	        if (n >= slides.length) {
	            slideIndex = 0;
	        } else if (n < 0) {
	            slideIndex = slides.length - 1;
	        }
	
	        for (let i = 0; i < slides.length; i++) {
	            slides[i].style.display = "none";
	        }
	
	        slides[slideIndex].style.display = "block";
	    }
	
	    function plusSlides(n) {
	        clearInterval(intervalId);
	        let newIndex = slideIndex + n;
	
	        if (newIndex >= slides.length) {
	            slideIndex = 0;
	        } else if (newIndex < 0) {
	            slideIndex = slides.length - 1;
	        } else {
	            slideIndex = newIndex;
	        }
	
	        showSlides(slideIndex);
	        startSlideShow();  
	    }
	
	    startSlideShow();
	     
    </script>
</body>
</html>
