package com.book.member.event.controller;

import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.getConnection;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.member.event.dao.MemEventDao;
import com.book.member.event.vo.MemEvent;

@WebServlet("/user/event/par")
public class MemEventParServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MemEventParServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException { 
		int eventNo = Integer.parseInt(request.getParameter("event_no"));
		int userNo = Integer.parseInt(request.getParameter("user_no"));
		String action = request.getParameter("action");
 
		MemEvent memevent = new MemEvent();
		memevent.setEventNo(eventNo);
		memevent.setUserNo(userNo); 
		boolean result = false;

		MemEventDao memEventDao = new MemEventDao();
		if ("참여".equals(action)) {
			memEventDao.registerForEvent(eventNo, userNo);
		} else if ("참여 취소".equals(action)) {
			memEventDao.cancelRegistration(eventNo, userNo);
		}else if ("대기".equals(action)) {
            memEventDao.waitForEvent(eventNo, userNo);
        } else if ("대기 취소".equals(action)) {
            memEventDao.cancelWaiting(eventNo, userNo);
        } 

	}
}
