package com.book.member.event.controller;

import static com.book.common.sql.JDBCTemplate.getConnection;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.admin.event.dao.EventDao;
 
@WebServlet("/user/event/notification")
public class EventNotificationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EventNotificationServlet() {
        super(); 
    }
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
		int eventNo = Integer.parseInt(request.getParameter("event_no"));
        int userNo = Integer.parseInt(request.getParameter("user_no"));
        String action = request.getParameter("action");
  
        EventDao eventDAO = new EventDao();  

        if ("set".equals(action)) {
            eventDAO.setNotification(eventNo, userNo);
        } else if ("cancel".equals(action)) {
            eventDAO.cancelNotification(eventNo, userNo);
        }

        response.setContentType("text/plain");
        response.getWriter().write("success");
	}
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
		doGet(request, response);
	}

}
