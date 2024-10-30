<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.book.member.sg.vo.Suggestion, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 문의사항 조회</title>
<style>

	* { 
	  box-sizing: border-box; 
	  margin: 0;
	} 
	
	.search_section {
	  margin-bottom: 20px
	} 
	
	.search_title {
	  font-size: 23px;
	  font-weight: 600;
	  text-align: center;
	  color: #2c2c2c; 
	  margin-bottom: 20px;
	}
	
	.search_input {
	  width: 40%;
	  padding: 15px 24px;
	  height: 30px;
	
	  font-size: 14px;
	  line-height: 18px;
	  
	  color: #575756;
	
	  border-radius: 20px;
	  border: 1px solid #575756;
	}
	
	.search_btn{
	  border: none;
	  background-color: rgb(224, 195, 163);
	  padding : 4px 6px;
	  border-radius: 15px;
	}
	
	.status_btn{
	  border: none;
	  margin-left: 500px;
	  font-size: 16px;
	}
	
	.ans_btn { 
	  border: none; 
	  font-size: 16px;
	  background-color: rgba(0,0,0,0);
	}
	
	#sglist {
	  max-width: 1200px; 
	  margin: 80px auto;
	  padding: 0 20px;
	}
	
	.board_list {
	  width: 100%;
	  border-collapse: collapse;
	  border-top: 2px solid #000;  
	}
	
	.board_list th,
	.board_list td {
	  padding: 15px 0;
	  text-align: center;
	  font-size: 15px;
	  border-bottom: 1px solid #ddd;
	}
	
	.board_list thead tr {
	  border-bottom: 1px solid #999;
	}
	
	.board_list th {
	  font-weight: 600;
	}
	
	.board_list .num {
	  width: 10%;
	}
	
	.board_list .title {
	  width: 60%;
	  text-align: left;
	}
	.board_list .title a {
	  color: #2c2c2c;
	  text-decoration: none;
	}
	
	.board_list thead .title {
	  text-align: center;
	}
	
	.board_list .date {
	  width: 10%;
	}
	
	.board_list .status {
	  width: 10%;
	}
	#paging{
	   width: 100%;
	}
	.center { 
	  text-align: center;
	  margin-top: 20px;
	}
	.pagina {
	  display: inline-block;
	
	}
	.pagina a {
	  color: black;
	  float: left;
	  padding: 8px 16px;
	  text-decoration: none;
	  transition: background-color .3s;
	  margin: 0 4px;
	}
	.pagina a.active {
	  background-color: #A5A5A5;
	  color: white;
	  border: 1px solid #A5A5A5;
	}
	
	.pagina a:hover:not(.active) {background-color: #ddd;} 
</style> 
</head>
<body>
<%@ include file="../../include/header.jsp" %>
<div id="sglist">
  <section class="search_section">
      <form action="/admin/sg/list" name="search_sg_form" method="get">
      <div class="search_container">
          <input class="search_input" name="sg_title" type="text"  placeholder="제목을 입력하세요.">
          <input class="search_btn" type="submit" value="검색" style="font-size:15px">
          <span class="status_btn">
          <input class="ans_btn" type="submit" name="sgStatus" value="미답변">
          <input class="ans_btn" type="submit"  name="sgStatus" value="답변완료">
          </span>
      </div>
      </form>
  </section> 
    <table class="board_list">
      <thead>
        <tr class="top">
          <th class="num">번호</th>
          <th class="title">제목</th>
          <th class="date">사용자</th>
          <th class="date">등록일</th>
          <th class="status">답변여부</th>
        </tr>
      </thead>
      <tbody>
      <!-- 리스트에 넣어준 값을 get 해온다 
         날짜값 보여주기 : DateTimeFormatter (import)
            제목을 눌렀을 때 : 값이 넘어가도록 설정
       -->
          <% List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("resultList");
            int pageSize = 10;
            int nowPage = request.getParameter("nowPage") == null ? 1 : Integer.parseInt(request.getParameter("nowPage"));
            int startNo = (nowPage - 1) * pageSize + 1;
            for (int i = 0; i < list.size(); i++) {
             Map<String, String> row = list.get(i);
             String status = (row.get("sg_status").equals("1")) ? "답변완료" : "미답변";
         %>
         <tr>
             <td class="num"><%=startNo + i%></td> 
          <td class="title"><a href="/admin/sg/detail?sg_no=<%=row.get("sg_no")%>"><%=row.get("sg_title")%></a></td>
          <td class="name"><%=row.get("sg_userName")%></td>
          <td class="date"><%=row.get("regDate")%></td>
          <td class="status"><%=status%></td>
        </tr>
        <%}%>
      </tbody>
    </table>
 <section id="paging">
  <% Suggestion paging = (Suggestion)request.getAttribute("paging"); %>
  <%if(paging != null) {%>
  <div class = "center">
     <div class="pagina">
        <%if(paging.isPrev()){%>
           <a href = "/admin/sg/list?nowPage=<%=(paging.getPageBarStart()-1)%>">&laquo;</a>
        <%}%>
        <%for(int i = paging.getPageBarStart() ; i <= paging.getPageBarEnd() ; i++){ %>
           <a href="/admin/sg/list?nowPage=<%=i%>"<%=paging.getNowPage() == i ? "class='active'" : "" %>>
           <%=i%></a>
        <%}%>
        <%if(paging.isNext()){%>
           <a href="/admin/sg/list?nowPage=<%=(paging.getPageBarEnd()+1)%>">&raquo;</a>
        <%}%>
     </div>
   </div>
  <%}%>  
 </section>  
  </div>
</body>
</html>