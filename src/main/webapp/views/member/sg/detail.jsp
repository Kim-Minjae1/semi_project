<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.book.member.sg.vo.Suggestion, java.util.*,com.book.admin.sg.vo.SuggestionReply"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Knock Book</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
    crossorigin="anonymous" />
<style>

body {
    height: 100%;
    line-height: 1.6;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
}

.sg_post_detail {
    width: 100%;
    padding: 20px;
    margin-bottom: 20px;
    border-radius: 5px;
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

.replyList {
    width: 100%;
    padding: 30px;
}

.replyContent {
    width: 95%;
    padding: 10px;
    border-radius: 5px;
    border: 1px solid #ccc;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    resize: none;
    overflow: auto;
}

.btn_container {
    display: flex;
    justify-content: space-between;
    margin-left:20px;
    margin-right:20px;
}

.back_btn, .delete_btn {
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

.back_btn:hover, .delete_btn:hover {
    background: #18283235;
}
</style>

</head>

<body>

    <div class="sg_post_detail">
    <%
    // getAttribute로 정보 가져오기
    Suggestion sg = (Suggestion) request.getAttribute("sgDetail");
    String img1 = sg.getNew_img1();
    String img2 = sg.getNew_img2();
    String img3 = sg.getNew_img3();
    // 이미지가 널값리면 빈 문자열로 
    String imgSrc1 = (img1 != null && !img1.isEmpty()) ? request.getContextPath() + "/upload/sg/" + img1 : "";
    String imgSrc2 = (img2 != null && !img2.isEmpty()) ? request.getContextPath() + "/upload/sg/" + img2 : "";
    String imgSrc3 = (img3 != null && !img3.isEmpty()) ? request.getContextPath() + "/upload/sg/" + img3 : "";
    // 날짜 포맷
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");%>
    <!-- 문의사항 상세 -->
    <h2 id="sg_post_title"><%=sg.getSg_title()%></h2>
    <p class="sg_post_info">
       <span id="sg_post_date">작성일: <%=formatter.format(sg.getSg_mod_date())%></span>
    </p>
    
    <% if (!imgSrc1.isEmpty() || !imgSrc2.isEmpty() || !imgSrc3.isEmpty()) { %>
    <div class="imgContain">
        <% if (!imgSrc1.isEmpty()) { %>
        <img src="<%=imgSrc1%>" alt="이미지 1" class="sg_image" width="300">
        <% } %>
        <% if (!imgSrc2.isEmpty()) { %>
        <img src="<%=imgSrc2%>" alt="이미지 2" class="sg_image" width="300">
        <% } %>
        <% if (!imgSrc3.isEmpty()) { %>
        <img src="<%=imgSrc3%>" alt="이미지 3" class="sg_image" width="300">
        <% } %>
    </div>
    <% } %>
    
    <div id="sg_post_content"><%=sg.getSg_content()%></div>
    </div>

    <div class="btn_container">
    <a href="/member/sg/list" class="back_btn">목록</a>
    <form id="deleteForm" action="/member/sg/delete?sg_no=<%=sg.getSg_no()%>" method="POST">
    <button class="delete_btn" type="submit" onclick="return confirmDelete();">삭제</button>
    </form>
    </div>
    <div class="replyList">
    <!-- 답변 -->
    <% 
    SuggestionReply sr = (SuggestionReply) request.getAttribute("sgReply");
    if (sr != null ) {
        System.out.println("reply");%>
        <div class="replyContent"><%=sr.getSg_reply_content()%></div>
        <%  } else { %>
        <div class="replyContent">관리자가 빠른 시일 내에 답변을 드릴거에요 :)</div>
        <% } %>
    </div>

<script type="text/javascript">
        
// 삭제할 때 confirm 
deleteForm.addEventListener('submit', function(e) {
    e.preventDefault();
    
    const confirmDelete = confirm('정말로 삭제하시겠습니까?');
    
    if (confirmDelete) {
        this.submit(); // 폼 제출
    } else {
        alert('삭제가 취소되었습니다.');
    }
});

</script>
</body>
</html>
