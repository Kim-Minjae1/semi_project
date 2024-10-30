<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <%@ page import="com.book.member.book.vo.BookText, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Knock Book</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
  
    body {
        background-color: rgb(247, 247, 247);
    }
    
 	#book_info_area {
        display: flex;
        flex-direction: column;
        align-items: left;
        max-width: 800px;
        margin: 0 auto;
        padding : 10px;
    }
    
    .book_title {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 30px;
        text-align: center;
    }
    
    .book_content {
        display: flex;
        width: 100%;
    }
    
    .detail_image {
        flex: 0 0 200px;
        margin-right: 30px;
    }
    
    .detail_image img {
        max-width: 100%;
        height: auto;
    }
    
    .book_details {
        flex: 1;
        text-align: left; 
        margin-left : 10px;
    }
    
    .detail_section {
        margin-bottom: 10px;
        display: flex;
        align-items: flex-start;
    }
    
    .detail_section span:first-child {
        font-weight: bold;
        margin-right: 10px;
        min-width: 80px;
    }
    
    .book_description {
        margin-top: 40px;
        text-align: left; 
    }
  
	.button-group {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
        margin : 20px 50px 20px 0; 
    }
    
    .button-group form {
        margin: 0;
    }
    
    .button-group button {
        width: 80px;
    }
    
	.replyCount{
		margin-bottom: 20px;
	}
	
    .bkReplyContainer {
	   width: 900px;
	   margin: auto;
	   overflow: hidden;
	   padding: 20px;
	   position: relative;
	}
	
	.replyDiv {
	   width: 900px;
	   height: 200px;
	}
	
	.btUser{
	margin-top:15px
	}
	
	.btParentReply{
	border-top:1px solid #ddd;
	}
	
	.btChildReply{
	margin-left: 50px;
	border-top:1px solid #ddd;
	}
	
	.write {
	   width: 95%;
	   padding: 20px;
	   border-radius: 5px;
	   border: 1px solid #ccc;
	   box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	   resize: none;
	   margin-top: 20px
	}
	
	.write:focus {
	   outline: none;
	   border: none;
	}
	
	.btReplyContent {
	   width: 95%;
	   height: 100px;
	   padding: 10px;
	   resize: none;
	   margin-top: 10px;
	}
	
	#reBtn{
	border:none;
	margin-bottom: 10px;
	display:flex;
	justify-content:right;
	}
	
	.replyBtns {
	   margin-left: 10px;
	   width: 50px;
	   height: 30px;
	   border-radius: 15%;
	   text-align: center;
	   background: #575756;
	   color: #fffbfb;
	   font-size: 14px;
	   justify-content: center;
	   align-items: center;
	   cursor: pointer;
	   text-decoration: none;
	   border: none;
	}
	
	.btn_gr {
	   margin-top: 10px;
	   display: flex;
	   justify-content: flex-end;
	   margin-bottom: 10px;
	}
	
	
	.replyBtns:hover {
	   background-color: #e0e0e0;
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
	
	.list_under {
		background-color: rgba(194, 194, 194, 0.3);
		text-align: center;
		padding : 3px 2px 1px 1px;
		border-radius: 10px;
	}
	
	.list_under_content {
		background-color: rgba(194, 194, 194, 0.3); 
		padding : 3px 2px 1px 15px;
		border-radius: 10px;
		width : 60px;
		margin-bottom: 15px;
	}
	
	.detail_under { 
		margin-left : 10px;
		padding : 3px 2px 1px 1px;
	}
    </style>
</head>
<body>
<%@ include file="../../../views/include/header.jsp" %>

       <%-- 컨테이너 div --%>
<section class ="holeList">
<div class="form_"> 
            <%@ page import="com.book.member.book.vo.BookText, java.util.*" %>
            <% List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("resultList");
            // for each문 시작
               for (Map<String, String> detail : list) { %>
				<div id="book_info_area">
				    <div class="book_title">
				        <%= detail.get("bk_title") %>
				    </div>
				    <div class="book_content">
				        <div class="detail_image">
				            <img src="<%= detail.get("bk_img") %>" alt="책 이미지">
				        </div>
				        <div class="book_details">
				            <div class="detail_section">
				                <span class="list_under">카테고리</span>
				                <span class="detail_under"><%= detail.get("bk_cate") %></span>
				            </div>
				            <div class="detail_section">
				                <span class="list_under">작성자</span>
				                <span class="detail_under"><%= detail.get("bt_writer") %></span>
				            </div>
				            <div class="detail_section">
				                <span class="list_under">출판사</span>
				                <span class="detail_under"><%= detail.get("bk_publisher") %></span>
				            </div>
				            <div class="detail_section">
				                <span class="list_under">추천도</span>
				                <span class="detail_under"><%= detail.get("recommendation") %></span>
				            </div>
				            <div class="detail_section">
				                <span class="list_under">읽기 시작</span>
				                <span class="detail_under"><%= detail.get("bt_start") %></span>
				            </div>
				            <div class="detail_section">
				                <span class="list_under">읽기 종료</span>
				                <span class="detail_under"><%= detail.get("bt_end") %></span>
				            </div>
				        </div>
				    </div>
				    <div class="book_description"> 
				    	<div class="list_under_content">내용</div>
				        <span><%= detail.get("bt_content") %></span>
				    </div>
				</div>
		</div>
                <% User user_bt = (User) session.getAttribute("user");
                   if (user_bt != null) {
                   int userNumber = user_bt.getUser_no();
                   String a = detail.get("user_no");
                   String str = Integer.toString(user_bt.getUser_no());
                   if (a.equals(str)) { %>
                   <div class="button-group">
                     <form action="/user/editCheck" method="post">
                      <input type="hidden" name="bt_no" value="<%= detail.get("bt_no") %>">
                      <button type="submit" class="btn btn-primary">수정</button>
                     </form>
                     <form action="/user/textDelete" method="post">
                     <input type="hidden" name="bt_no" value="<%= detail.get("bt_no") %>">
                     <button type="submit" class="btn btn-danger">삭제</button>
                  	</form>
                  </div>
                <% } %>
          <% } %>
                <style>
                #heart_area {
                	margin-left: 10%;
                	margin-bottom: 20px;
                }
                  #heart{
                       width: 20px;
	                   background-color: white;
	                   margin-bottom: 8px; 
                  }
                  .red{fill: red;}
                  .gray{fill: gray;}
                  #like_count{
                     font-size: 20px;
                     width: 25px;
                     background-color: white;
                     margin-left: 5px;
                  }
              </style>
              <div style="background-color: white" id="heart_area">
              <%-- 하트의 class명에 받아온 color값을 넣어서 class가 gray냐 red냐에 따라 css로 하트 색 바꿈 --%>
                 <svg id="heart" class="<%= request.getAttribute("color") %>"
                    xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                  <path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7
                     10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68
                     47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6
                     51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5
                     55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/>
                 </svg>
                 <%-- 하트 수 --%>
                  <span id="like_count"><%=request.getAttribute("lkCnt")%></span>
                </div>
                 <%
                 User like_bt = (User) session.getAttribute("user");
                 // 로그인 정보가 있고 관리자가 아닐 경우
                   if (like_bt != null && like_bt.getUser_no() != 1) {
                   int likeNumber = like_bt.getUser_no();
                   %>
              <script type="text/javascript">
                const heartBtn = document.getElementById('heart');
                 heartBtn.addEventListener('click',function(event){
                      var color = "<%= request.getAttribute("color")%>";
                      var userNo = "<%= likeNumber %>";
                      var categoryNo = "<%= detail.get("bk_cate_no")%>";
                      var booktextNo = "<%= detail.get("bt_no") %>";
                   jQuery.noConflict();
                   $.ajax({
                      type : "POST",
                      url : "<%=request.getContextPath()%>/like/insert",
                      data : {
                         "color" : color,
                         "userNo" : userNo,
                         "categoryNo" : categoryNo,
                         "booktextNo" : booktextNo
                      },
                      success: function(response){
                         if(color === "gray"){
                             heartBtn.classList.remove('gray');
                             heartBtn.classList.add('red');
                         } else{
                             heartBtn.classList.remove('red');
                             heartBtn.classList.add('gray');
                         }
                         $('#like_count').text(response.lkCnt);
                         location.reload();
                      },
                    });
                 });
                </script>
                <%-- 비회원인 경우 --%>
                 <%} else { %>
                <script type="text/javascript">
                const heartBtn = document.getElementById('heart');
                 heartBtn.addEventListener('click',function(event){
                   alert("로그인한 사용자만 누를 수 있습니다.");
                });
              </script>
                <% } %>

           <% } %>

      </section>


    <section class="bkReplyContainer">
    <% Integer replyCnt = (Integer) request.getAttribute("btReplyCnt"); %>
   <div id="replyCount">댓글 수 : <%= (replyCnt != null ? replyCnt : 0) %></div><br>

    <%
    // 독후감 댓글 가져오기
    List<Map<String, String>> bkReplyList = (List<Map<String, String>>) request.getAttribute("bkReplyList");
    // 세션에서 가져온 유저 번호
    User bt_userNo = (User) session.getAttribute("user");
    int userNo = (bt_userNo != null) ? bt_userNo.getUser_no() : -1;

    boolean isLoggedIn = bt_userNo != null;
    boolean isNotUserOne = userNo != 1;

    if (bkReplyList != null && !bkReplyList.isEmpty()) {
        for (Map<String, String> bre : bkReplyList) {
           for (Map<String, String> detail : list) {
            String btReplyNo = bre.get("br_no");
            int btReplyUserNo = Integer.parseInt(bre.get("br_user_no"));
            String btNickName = bre.get("br_userNickName");
            String btContent = (bre.get("br_delete").equals("1")) ? "삭제된 댓글입니다." : bre.get("br_content");
            int btParentNo = Integer.parseInt(bre.get("br_parent"));
            String btRegDate = bre.get("br_regDate");
            String btModDate = bre.get("br_modDate");
            String btParentClass = (btParentNo == 0) ? "btParentReply" : "btChildReply";
    %>
    <div id="allreply"  class="<%=btParentClass%>">
    <div id="btReply_<%= btReplyNo %>" >
       <div class="btUser" style="display: flex; justify-content: space-between;">
          <span><%= btNickName %></span>
          <div style="text-align: right;">
          <span style="font-size:15px"><%= btRegDate %></span>
          <% if (!btModDate.equals(btRegDate)) { %>
          <span style="font-size:15px">수정됨(<%= btModDate %>)</span>
          <% } %>
          </div>
       </div>
           </div>
       <div id="btReplyContent_<%= btReplyNo %>" class="btReplyContent"><%= btContent %></div>
       <form action="/member/book/btUpdateReply" id="btUpdateForm_<%= btReplyNo %>" class="btUpdateForm" style="display:none;">
           <!-- 독후감 번호 -->
           <input type="hidden" name="bt_no" value="<%= detail.get("bt_no") %>">
           <!-- 댓글번호 -->
           <input type="hidden" name="bt_reply_no" value="<%= btReplyNo %>">
           <input class="btReplyContent" id="btReplyUpdate_<%= btReplyNo %>" name="btUpdateContent" type="text" value="<%= btContent %>">
           <% if (userNo == btReplyUserNo && !bre.get("br_delete").equals("1")) { %>
               <div class="btn_gr">
                   <input type="submit" id="btUpdate_<%= btReplyNo %>" class="replyBtns" value="등록">
                   <input type="button" id="btCancel_<%= btReplyNo %>" class="replyBtns" value="취소" onclick="btCancelReplyForm('<%= btReplyNo %>')">
               </div>
           <% } %>
       </form>
       <% if (userNo == btReplyUserNo && !bre.get("br_delete").equals("1")) { %>
           <form action="/member/book/btDeleteReply" method="post" style="display: inline;">
               <input type="hidden" name="bt_no" value="<%= detail.get("bt_no") %>">
               <input type="hidden" name="bt_reply_no" value="<%= btReplyNo %>">
               <input type="hidden" name="bt_user_no" value="<%= userNo %>">
               <span class="btn_gr">
                   <input type="button" id="btChange_<%= btReplyNo %>" class="replyBtns" value="수정" onclick="btChangeReplyForm('<%= btReplyNo %>')">
                   <input class="replyBtns" type="submit" id="btDelete_<%= btReplyNo %>" value="삭제">
               </span>
           </form>
       <% } %>
       <% if (btParentNo == 0 && !bre.get("br_delete").equals("1")) { %>
          <% if (isLoggedIn && isNotUserOne) { %>
           <span class="btn_gr">
               <button type="button" id="reBtn" onclick="btShowReplyForm('<%= btReplyNo %>')">답글하기</button>
           </span>
           <% } %>
       <% } %>
       <div id="btReplyForm_<%= btReplyNo %>" class="reply-form" style="display:none;">
           <form action="/member/book/btChildReply" method="post">
               <input type="hidden" name="bt_no" value="<%= detail.get("bt_no")  %>">
               <input type="hidden" name="bt_reply_no" value="<%= btReplyNo %>">
               <input type="hidden" name="bt_user_no" value="<%= userNo %>">
               <input type="hidden" name="br_parent" value="<%= btReplyNo %>">
               <textarea class="write" name="br_content" placeholder="답글을 입력해주세요."></textarea>
               <span class="btn_gr">
                   <input class="replyBtns" type="submit" value="등록">
                   <input class="replyBtns" type="button" value="취소" onclick="btHideReplyForm('<%= btReplyNo %>')">
               </span>
           </form>
       </div>

    </div>
    <%    }
      }
    } else {
    %>
        <div class="replyContent">등록된 댓글이 없습니다.</div>
    <% } %>

   <%
   if(isLoggedIn && isNotUserOne) {
      for (Map<String, String> detail : list) { %>
       <!-- 새 댓글 작성 폼 (부모 댓글) -->
    <form action="/member/book/brAddReply" method="post">
        <div id="replyDiv">
            <input type="hidden" name="bt_no" value="<%= detail.get("bt_no")  %>">
            <input type="hidden" name="bt_user_no" value="<%= userNo %>">
            <textarea class="write" name="br_content" placeholder="댓글을 입력해주세요."></textarea>
            <div class="btn_gr">
                <input class="replyBtns" type="submit" value="등록">
                <input class="replyBtns" type="button" value="취소" onclick="btClearReplyForm()">
            </div>
        </div>
    </form>
    <%}
   }%>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYv5YK4SUWv+gILgOapg2bO9y3PikFNWhs5Ew5fawGr10o57kegBR7MXu" crossorigin="anonymous"></script>
<script>
function btShowReplyForm(btReplyNo) {
    document.getElementById('btReplyForm_' + btReplyNo).style.display = 'block';
    document.getElementById('btDelete_' + btReplyNo).style.display = 'none';
    document.getElementById('btChange_' + btReplyNo).style.display = 'none';
}

function btHideReplyForm(btReplyNo) {
    document.getElementById('btReplyForm_' + btReplyNo).style.display = 'none';
    document.getElementById('btDelete_' + btReplyNo).style.display = 'inline-block';
    document.getElementById('btChange_' + btReplyNo).style.display = 'inline-block';
}

function btClearReplyForm() {
    document.querySelector('#replyDiv .write').value = '';
}

function btChangeReplyForm(btReplyNo) {
    document.getElementById('btReplyContent_' + btReplyNo).style.display = 'none';
    document.getElementById('btUpdateForm_' + btReplyNo).style.display = 'block';
    document.getElementById('btChange_' + btReplyNo).style.display = 'none';
    document.getElementById('btCancel_' + btReplyNo).style.display = 'inline-block';
    document.getElementById('btDelete_' + btReplyNo).style.display = 'none';
}

function btCancelReplyForm(btReplyNo) {
    document.getElementById('btReplyContent_' + btReplyNo).style.display = 'block';
    document.getElementById('btUpdateForm_' + btReplyNo).style.display = 'none';
    document.getElementById('btChange_' + btReplyNo).style.display = 'inline-block';
    document.getElementById('btCancel_' + btReplyNo).style.display = 'none';
    document.getElementById('btDelete_' + btReplyNo).style.display = 'inline-block';
}
</script>
</body>
</html>