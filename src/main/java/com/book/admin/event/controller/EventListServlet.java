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

@WebServlet("/event/list")
public class EventListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public EventListServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { 
    	String evTitle = request.getParameter("evTitle");

        String categoryParam = request.getParameter("listCategory"); 
        int categoryNo = (categoryParam != null && !categoryParam.isEmpty()) ? Integer.parseInt(categoryParam) : 0;

        String yearParam = request.getParameter("year");
        int year = (yearParam != null && !yearParam.isEmpty()) ? Integer.parseInt(yearParam) : 0;

        String monthParam = request.getParameter("month");
        int month = (monthParam != null && !monthParam.isEmpty()) ? Integer.parseInt(monthParam) : 0;

        Event option = new Event();
        option.setEv_title(evTitle);
        option.setEvent_category(categoryNo);
        option.setFind_year(year);
        option.setFind_month(month);
        
        
        Connection conn = getConnection();

        String nowPage = request.getParameter("nowPage");
        if (nowPage != null) {
            option.setNowPage(Integer.parseInt(nowPage));
        }

        option.setTotalData(new EventDao().selectEventCount(option, conn));

        List<Map<String, String>> list = new EventDao().selectEventList(option, conn);

        close(conn);

        request.setAttribute("paging", option);
        request.setAttribute("resultList", list);

        RequestDispatcher rd = request.getRequestDispatcher("/views/admin/event/eventList.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
