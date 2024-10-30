package com.book.member.event.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.admin.event.dao.EventDao;
 
@WebServlet("/user/event/checkNotification")
public class CheckNotificationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
        
    public CheckNotificationServlet() {
        super(); 
    }
 
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int eventNo = Integer.parseInt(request.getParameter("event_no"));
        int userNo = Integer.parseInt(request.getParameter("user_no"));

        EventDao eventDAO = new EventDao();
        boolean isNotificationSet = eventDAO.checkNotification(eventNo, userNo);

        response.setContentType("text/plain");
        response.getWriter().write(String.valueOf(isNotificationSet));
    }
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
		doGet(request, response);
	}

}
