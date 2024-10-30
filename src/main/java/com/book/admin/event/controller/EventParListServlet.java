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
import com.book.common.Paging;
 
@WebServlet("/event/parList")
public class EventParListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
        
    public EventParListServlet() {
        super(); 
    }
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {   
	 	Connection conn = getConnection();
        
        Paging paging = new Paging();
        
        String eventTitle = request.getParameter("eventTitle");
        String nowPageStr = request.getParameter("nowPage");
        int nowPage = nowPageStr == null ? 1 : Integer.parseInt(nowPageStr);

        paging.setNowPage(nowPage);
        paging.setNumPerPage(10); // 페이징당 목록 수 
        
        List<Map<String, String>> eventTitles = new EventDao().getEventTitles(conn);
        List<Map<String, String>> userEvents;
        
        int totalData = new EventDao().selectParEventCount(eventTitle, conn);  
        paging.setTotalData(totalData);
        
        if (eventTitle != null && !eventTitle.isEmpty()) {
            userEvents = new EventDao().getEventParticipationsByTitle(eventTitle, paging, conn);
        } else {
            userEvents = new EventDao().getEventParticipations(paging, conn);
        }

        Map<String, String> selectedEvent = null;
        if (eventTitle != null && !eventTitle.isEmpty()) {
            selectedEvent = new EventDao().getEventInfoByTitle(eventTitle, conn);
        }

        close(conn);

        request.setAttribute("eventTitles", eventTitles);
        request.setAttribute("userEvents", userEvents);
        request.setAttribute("selectedEvent", selectedEvent); 
        request.setAttribute("paging", paging);

        RequestDispatcher rd = request.getRequestDispatcher("/views/admin/event/eventParList.jsp");
        rd.forward(request, response);
	}
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
		doGet(request, response);
	}

}
