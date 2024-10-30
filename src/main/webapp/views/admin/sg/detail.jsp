<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.book.member.sg.vo.Suggestion" %>
<%@ page import="com.book.admin.sg.vo.SuggestionReply" %>
<%@ page import="com.book.admin.sg.vo.Basic" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 문의사항 상세 조회</title>
<style>
	body {
	  height: 100%;
	  line-height: 1.6;
	  margin: 0;
	  padding: 0;
	  background-color: #f4f4f4;
	}
	
	.container {
	    width: 60%;
	    margin: auto;
	    overflow: hidden;
	    padding: 80px;
	    position: relative;
	}
	
	.sg_post_detail {
	  width: 100%;
	  background: #ffffff;
	  padding: 20px;
	  margin-bottom: 20px;
	  border-radius: 5px;
	  box-shadow: 0 0 10px rgba(0,0,0,0.1);
	  border: 1px solid #ccc;
	}
	
	#sg_post_title {
	  color: #2c3e50;
	  margin-bottom: 10px;
	  background: transparent;
	}
	
	.sg_post_info {
	  font-size: 16px;
	  color: #7f8c8d;
	  margin-bottom: 20px;
	  background: transparent;
	}
	
	#sg_post_date {
	  border-bottom: 1px solid #e0e0e0;
	  display: block;
	  margin-bottom: 10px;
	  background: transparent;
	}
	
	#sg_post_content {
	  color: #575756;
	  padding-top: 15px;
	  background: transparent;
	}
	
	.replyList {
	    border-top: solid 1px;
	    margin-top: 20px;
	}
	
	.replyContent {
	   width: 95%;
	   padding: 10px;
	   resize: none;
	   margin-top: 10px;
	    margin-bottom: 10px;
	}
	
	.reply{
	  width: 80%;
	  padding: 30px;
	}
	
	.addText{
	   text-align: center;
	}
	
	.write{
	  width: 95%;
	  height: 100px;
	  padding: 20px;
	  border-radius: 5px;
	  border: 1px solid #ccc;
	  box-shadow: 0 0 10px rgba(0,0,0,0.1);
	  resize: none;
	  overflow: auto;
	}
	
	.write:focus {
	  outline: none;
	  border: none;
	}
	
	#replyDate{
	margin-left:30px;
	}
	
	#nickname{
	margin-top:20px;
	}
	
	#btn_gr {
	    gap: 10px;
	    display: flex;
	    justify-content: right;
	    margin-right: 30px;
	}
	
	.imgContain {
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  height: 300px; 
	}
	
	.imgContain img {
	  height: 100%;
	  width: 200px;
	  object-fit: cover;
	  margin: 0 5px;
	}
	
	.listBtn{
	  width: 50px;
	  height: 30px;
	  border-radius: 15%;
	  text-align: center;
	  background: #575756;
	  color: #fffbfb;
	  font-size: 14px;
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  cursor: pointer;
	  text-decoration: none;
	  border: none;
	  float: right;
	}
	
	.sgBtn{
	  width: 50px;
	  height: 30px;
	  border-radius: 15%;
	  text-align: center;
	  background: #575756;
	  color: #fffbfb;
	  font-size: 14px;
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  cursor: pointer;
	  text-decoration: none;
	  border: none;
	}
	
	
	.sgBtn:hover {
	  background: #18283235;
	}
	
	#basicReply{
	   width:130px
	}
</style>
</head>
<body>
<%@ include file="../../include/header.jsp" %>
    <div class="container">
        <div class="detail">
            <div class="sg_post_detail">
                <% Suggestion sg = (Suggestion) request.getAttribute("sgDetail"); 
                String img1 = sg.getNew_img1();
                String img2 = sg.getNew_img2();
                String img3 = sg.getNew_img3();
                String imgSrc1 = (img1 != null && !img1.isEmpty()) ? request.getContextPath() + "/upload/sg/" + img1 : "";
                String imgSrc2 = (img2 != null && !img2.isEmpty()) ? request.getContextPath() + "/upload/sg/" + img2 : "";
                String imgSrc3 = (img3 != null && !img3.isEmpty()) ? request.getContextPath() + "/upload/sg/" + img3 : "";
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                %>
                <h2 id="sg_post_title"><%= sg.getSg_title() %></h2>
                <p class="sg_post_info">
                    <span id="sg_post_date">작성일: <%= formatter.format(sg.getSg_mod_date()) %></span>
                </p>
                <% if (!imgSrc1.isEmpty() || !imgSrc2.isEmpty() || !imgSrc3.isEmpty()) { %>
                <div class="imgContain">
                <% if (!imgSrc1.isEmpty()) { %>
                    <img src="<%= imgSrc1 %>" alt="이미지 1" class="sg_image">
                <% } %>
                <% if (!imgSrc2.isEmpty()) { %>
                    <img src="<%= imgSrc2 %>" alt="이미지 2" class="sg_image">
                <% } %>
                <% if (!imgSrc3.isEmpty()) { %>
                    <img src="<%= imgSrc3 %>" alt="이미지 3" class="sg_image">
                <% } %>
                </div>
                <% } %>
                <div id="sg_post_content"><%= sg.getSg_content() %></div>
            </div>
            <div class="btn_container">
                <a class="listBtn" href="/admin/sg/list">목록</a>
            </div><br>
        </div>
        <div class="replyList">
            <% SuggestionReply sr = (SuggestionReply) request.getAttribute("replyList");
            if (sr != null) {
                int sgReplyNo = sr.getSg_reply_no();
                int sgNo = sr.getSg_no();
                String sgReply = sr.getSg_reply_content();
                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            %>
            <form id="updateSgForm" action="/admin/sg/replyUpdate" method="POST" style="display:none">
                <input type="hidden" name="sg_reply_no" value="<%= sgReplyNo %>">
                <input type="hidden" name="sg_no" value="<%= sgNo %>">
                <input class="replyContent" type="text" name="sgReply" value="<%= sgReply %>"></input>
                <div id="btn_gr">
                <input class="sgBtn" type="submit" value="등록">
                <input class="sgBtn" type="reset" value="취소" onclick="chagneReplyForm()">
                </div>
            </form>
            <div id="replyView">
            <div id="nickname">
               <span>관리자</span>
               <span id="replyDate"><%=dtf.format(sr.getSg_reply_date()) %></span>
            </div>
                <div class="replyContent"><%= sgReply %></div>
                <div id="btn_gr">
                <input class="sgBtn" type="button" value="수정" onclick="chagneReplyForm()">
                <form action="/admin/sg/replyDelete" method="POST" style="display:inline">
                    <input type="hidden" name="sg_reply_no" value="<%= sgReplyNo %>">
                    <input type="hidden" name="sg_no" value="<%= sgNo %>">
                    <input class="sgBtn" type="submit" value="삭제">
                </form>
                </div>
            </div>
            <% } else { %>
            <div class="replyContent">등록된 댓글이 없습니다.</div>
            <% } %>
        </div>
        <% if (sr == null) { %>
        <div class="reply">
            <form action="/admin/sg/reply?sg_no=<%= sg.getSg_no() %>" name="admin_sg_reply" method="POST">
                <div class="addText">
                    <textarea class="write" name="reply" placeholder="관리자님! 답변을 달아주세요."></textarea>
                </div>
                    <div id="btn_gr">
                    <select name="basicReply" id="basicReply" onchange="setBasicReply()">
                        <option value="">기본 답변 선택</option>
                        <% 
                        List<Basic> basicList = (List<Basic>) request.getAttribute("basicList");
                        if (basicList != null && !basicList.isEmpty()) {
                            for (Basic basic : basicList) {
                        %>
                        <option value="<%= basic.getBasic_no() %>"><%= basic.getBasic_content() %></option>
                        <% 
                            }
                        }
                        %>
                    </select>
                    <input class="sgBtn" type="submit" value="등록">
                    <input class="sgBtn" type="reset" value="취소">
                    </div>
            </form>
        </div>
        <% } %>
    </div>
    <script>
    function setBasicReply() {
        const basicReplySelect = document.getElementById("basicReply");
        const selectedOption = basicReplySelect.options[basicReplySelect.selectedIndex];
        const replyTextarea = document.querySelector("textarea[name='reply']");
        replyTextarea.value = selectedOption.text;
    }

    function chagneReplyForm() {
        const replyForm = document.getElementById('updateSgForm');
        const replyView = document.getElementById('replyView');
        if (replyForm.style.display === 'none') {
            replyForm.style.display = 'block';
            replyView.style.display = 'none';
        } else {
            replyForm.style.display = 'none';
            replyView.style.display = 'block';
        }
    }
    </script>
</body>
</html>
