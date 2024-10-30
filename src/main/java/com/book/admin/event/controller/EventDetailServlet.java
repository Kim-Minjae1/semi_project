package com.book.admin.event.controller;

import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.getConnection;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.admin.event.dao.EventDao;
import com.book.admin.event.vo.Event;
import com.book.common.Paging;

@WebServlet("/event/detail")
public class EventDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
        
    public EventDetailServlet() {
        super(); 
    } 
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int eventNo = Integer.parseInt(request.getParameter("eventNo"));  
        String nowPageStr = request.getParameter("nowPage");
        int nowPage = nowPageStr == null ? 1 : Integer.parseInt(nowPageStr);
        
		Paging paging = new Paging();
		Connection conn = getConnection();
		
        paging.setNowPage(nowPage);
        paging.setNumPerPage(10); // 페이징당 목록 수 
        
        EventDao eventDao = new EventDao();
        Event event = eventDao.selectEventByNo(eventNo, conn);  
        
        String eventTitle = event.getEv_title(); 
        List<Map<String, String>> parUserList = new EventDao().getEventParticipationsByTitle(eventTitle, paging, conn);
        
        int totalData = new EventDao().selectParEventCount(eventTitle, conn);  
        paging.setTotalData(totalData);
        
        request.setAttribute("parUserList", parUserList);  
        request.setAttribute("paging", paging);
        request.setAttribute("event", event);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/event/eventDetail.jsp");
        dispatcher.forward(request, response);
        close(conn);  
	}
	
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
