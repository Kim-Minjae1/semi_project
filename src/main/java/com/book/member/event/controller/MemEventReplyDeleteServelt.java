package com.book.member.event.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.member.event.dao.EventReplyDao;

@WebServlet("/member/event/deleteReply")
public class MemEventReplyDeleteServelt extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemEventReplyDeleteServelt() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int eventTypeNo = Integer.parseInt(request.getParameter("eventType"));
		int eventNo = Integer.parseInt(request.getParameter("event_no"));
		
		int eventReplyNo = Integer.parseInt(request.getParameter("er_reply_no"));
		
		int result = new EventReplyDao().replyDelete(eventReplyNo);
		if(result > 0) {
			response.sendRedirect(request.getContextPath() + "/user/event/detail?eventNo="+eventNo+"&eventType="+eventTypeNo);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
