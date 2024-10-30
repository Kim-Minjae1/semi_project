package com.book.admin.event.controller;

import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.getConnection;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.admin.event.dao.EventDao;
 
@WebServlet("/event/delete")
public class EventDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
    public EventDeleteServlet() {
        super(); 
    }
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String eventNoStr = request.getParameter("eventNo");

	        if (eventNoStr != null && !eventNoStr.isEmpty()) {
	            try {
	                int eventNo = Integer.parseInt(eventNoStr);

	                Connection conn = getConnection();
	                EventDao eventDao = new EventDao();
	                int isDeleted = eventDao.deleteEvent(eventNo, conn);
	                close(conn);
	                if (isDeleted > 0) {   
	                	response.setContentType("text/html; charset=UTF-8");
	                    response.getWriter().write("<script>alert('이벤트가 성공적으로 삭제되었습니다.'); window.location.href = '" + request.getContextPath() + "/event/list';</script>");
	                } else {   
	                    response.sendRedirect(request.getContextPath() + "/event/list");
	                }
	            } catch (Exception e) {  
	                response.sendRedirect(request.getContextPath() + "/event/list");
	            }
	        } else {  
	            response.sendRedirect(request.getContextPath() + "/event/list");
	        } 
	}
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
		doGet(request, response);
	}

}
