<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.book.admin.sg.vo.Basic, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기본 답변 관리</title>

<style>
* { 
  box-sizing: border-box;
  margin: 0;
} 

.admin_basic {
  width: 80%;
  margin: 50px auto;
  border-collapse: collapse;
  border-top: 2px solid #000;
}
.admin_basic th,
.admin_basic td {
  padding: 12px 10px;
  text-align: center;
  font-size: 16px;
  border-bottom: 1px solid #ddd;
}
.admin_basic thead tr {
  border-bottom: 1px solid #999;
}
.admin_basic th {
  font-weight: 600;
}
.admin_basic td:nth-child(1) { width: 10%; } 
.admin_basic td:nth-child(2) { width: 50%; text-align: left;} 
.admin_basic td:nth-child(3) { width: 20%; } 


/* 추가하는 폼 스타일 */
.basic_form {
  width: 80%;
  max-width: 1000px;
  margin: 20px auto;
  padding: 20px;
  border-top: 2px solid #000;
  background-color: rgb(247, 247, 247);
}

.replyContent{
  width: 100%;
  padding: 12px 10px;
  font-size: 16px;
  border: 1px solid #ddd;
  border-radius: 3px;
  resize: vertical;
  background-color: #fff;
}

.BasicBtns {
  padding: 5px 8px;
  margin-top: 10px;
  border: none;
  background-color: #f0f0f0;
  border-radius: 3px;
  cursor: pointer;
   font-size: 16px;
}

.BasicBtns:hover {
  background-color: #e0e0e0;
}

#basicReplyForm{
  display: flex;
  justify-content: center;
  gap: 10px;
  
}

.hidden {
  display: none;
}
</style>
</head>
<body>
<%@ include file="../../include/header.jsp" %>
<div class="container">
<table class="admin_basic" id="basicTable">
    <thead>
      <tr>
        <th>번호</th>
        <th>기본답변</th>
        <th>관리</th>
      </tr>
    </thead>
    <tbody>
      <%List<Basic> list = (List<Basic>)request.getAttribute("basicList");
      int pageSize = 10;
      int nowPage = request.getParameter("nowPage") == null ? 1 : Integer.parseInt(request.getParameter("nowPage"));
      int startNo = (nowPage - 1) * pageSize + 1;

      if(list != null && !list.isEmpty()) {
          for(int i = 0; i < list.size(); i++) {
          String basicContent = list.get(i).getBasic_content();
          int basicReplyNo = list.get(i).getBasic_no();
          %>
          
        <tr>
           <td><%=startNo + i%></td>
              <td id="replyBasic_<%=basicReplyNo%>"><%=basicContent%></td>
         <td>
          <form id="updateBasic_<%=basicReplyNo%>" action="/admin/sg/update" method="POST" class="hidden">
             <input type="hidden" name="basic_no" value="<%=basicReplyNo%>">
              <input type="text" class="replyContent" name="updateBasic" value="<%=basicContent%>" style="width:535px">
              <input type="submit" class="BasicBtns" value="등록">
              <input type="button" class="BasicBtns" value="취소" onclick="cancelEdit(<%=basicReplyNo%>)">
          </form>
          <input type="button" class="BasicBtns" id="change_<%=basicReplyNo%>" onclick="changeBasicForm(<%=basicReplyNo%>)" value="수정">
          <form id="deleteBasic_<%=basicReplyNo%>" action="/admin/sg/delete" method="POST" style="display:inline;">
              <input type="hidden" name="basic_no" value="<%=basicReplyNo%>">
              <input type="submit" id="delete_<%=basicReplyNo%>" class="BasicBtns" value="삭제" class="hidden">
          </form>
         </td>
        </tr>
      <%}
         } else {%>
       <tr>
           <td colspan="3">관리자님 기본 답변을 입력해주세요 !</td>
       </tr>
      <%}%>
    </tbody>
  </table>
   <form action="/admin/sg/basicEnd" name="basic_add_form" method="post" class="basic_form" >
    <div id="basicReplyForm">
    <input type="text" name="replyBasic" class="replyContent" placeholder="기본 답변 내용을 입력하세요." required style="width:535px"></input>
    <button type="submit" class="BasicBtns" >등록</button>
    <button type="reset" class="BasicBtns" >취소</button>
    </div>
     </form>
  
</div>
<script>
function checkTableRows() {
    const table = document.getElementById('basicTable');
    // 헤더 행을 제외
    const rowCount = table.getElementsByTagName('tr').length - 1; 
    const form = document.querySelector('.basic_form');
    let message = document.getElementById('maxRowsMessage');

    // 기본답변 10개까지 작성 막아놓은 함수
    if (rowCount >= 10) {
       // 10개 이상 넘어가면 등록 폼 display none
        form.style.display = 'none';
        if (!message) {
           // 메시지로 보여주기 
            message = document.createElement('h4'); // h3 대신 h2를 사용하여 크기를 키움
            message.id = 'noAdd';
            message.style.color = 'black';
            message.style.textAlign = 'center'; // 가운데 정렬
            message.style.margin = '20px 0'; // 상하 여백 추가
            message.style.fontSize = '20px'; // 글자 크기 조정 (필요에 따라 조절)
            message.textContent = '최대 10개의 기본 답변만 등록할 수 있습니다!';
            // form 대신 container에 메시지 추가
            document.querySelector('.container').appendChild(message);
        }
    } else {
        form.style.display = 'block';
        if (message) {
            message.remove();
        }
    }
}

// 페이지 로드 시 실행
window.onload = checkTableRows;

// 수정폼 누르면 등록, 취소 버튼 나옴
function changeBasicForm(basicReplyNo) {
    var replyBasic = document.getElementById('replyBasic_' + basicReplyNo);
    var updateForm = document.getElementById('updateBasic_' + basicReplyNo);
    var changeBtn = document.getElementById('change_' + basicReplyNo);
    var deleteForm = document.getElementById('deleteBasic_' + basicReplyNo);

    replyBasic.classList.add('hidden');
    updateForm.classList.remove('hidden');
    changeBtn.classList.add('hidden');
    deleteForm.style.display = 'none';
}

// 취소 버튼 클릭시 
function cancelEdit(basicReplyNo) {
    var replyBasic = document.getElementById('replyBasic_' + basicReplyNo);
    var updateForm = document.getElementById('updateBasic_' + basicReplyNo);
    var changeBtn = document.getElementById('change_' + basicReplyNo);
    var deleteForm = document.getElementById('deleteBasic_' + basicReplyNo);

    replyBasic.classList.remove('hidden');
    updateForm.classList.add('hidden');
    changeBtn.classList.remove('hidden');
    deleteForm.style.display = 'inline';
}
</script>
</body>
</html>
