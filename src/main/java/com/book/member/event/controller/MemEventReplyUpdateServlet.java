package com.book.member.event.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.member.event.dao.EventReplyDao;

@WebServlet("/member/event/updateReply")
public class MemEventReplyUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemEventReplyUpdateServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int eventTypeNo = Integer.parseInt(request.getParameter("eventType"));
		int eventNo = Integer.parseInt(request.getParameter("event_no"));
		// 업데이트 -> 댓글번호, 댓글내용
		int eventReplyNo = Integer.parseInt(request.getParameter("er_reply_no"));
		String updateContent = request.getParameter("updateContent");
		
		int result = new EventReplyDao().updateReply(eventReplyNo,updateContent);
		if(result > 0) {
			response.sendRedirect(request.getContextPath() + "/user/event/detail?eventNo="+eventNo+"&eventType="+eventTypeNo);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
