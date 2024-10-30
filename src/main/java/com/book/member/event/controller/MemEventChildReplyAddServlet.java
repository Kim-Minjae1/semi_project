package com.book.member.event.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.member.event.dao.EventReplyDao;

@WebServlet("/member/event/childReply")
public class MemEventChildReplyAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemEventChildReplyAddServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int eventTypeNo = Integer.parseInt(request.getParameter("eventType"));
		// 댓글작성유저번호, 이벤트번호, 부모번호,댓글내용
		int userNo = Integer.parseInt(request.getParameter("er_user_no"));
		int eventNo = Integer.parseInt(request.getParameter("event_no"));
		int parentNo = Integer.parseInt(request.getParameter("er_parent"));
		String erReply = request.getParameter("er_content");
		int result = new EventReplyDao().childReplyAdd(userNo,eventNo,parentNo,erReply);
		
		if(result > 0) {
			
			response.sendRedirect(request.getContextPath() + "/user/event/detail?eventNo="+eventNo+"&eventType="+eventTypeNo);
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
