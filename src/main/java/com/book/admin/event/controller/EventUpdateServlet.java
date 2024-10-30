package com.book.admin.event.controller;

import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.commit;
import static com.book.common.sql.JDBCTemplate.getConnection;
import static com.book.common.sql.JDBCTemplate.rollback;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.admin.event.dao.EventDao;
import com.book.admin.event.vo.Event;

@WebServlet("/event/update")
public class EventUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public EventUpdateServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int eventNo = Integer.parseInt(request.getParameter("eventNo"));
        Connection conn = getConnection();
        Event event = new EventDao().selectEventByNo(eventNo, conn);
        close(conn);

        request.setAttribute("event", event);

        RequestDispatcher rd = request.getRequestDispatcher("/views/admin/event/eventUpdate.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
 
        int eventNo = Integer.parseInt(request.getParameter("eventNo"));
        String title = request.getParameter("eventTitle");
        String content = request.getParameter("eventContent");
        int form = Integer.parseInt(request.getParameter("eventForm"));
        String progress = request.getParameter("eventProgress");
        String start = request.getParameter("eventStart");
        String end = request.getParameter("eventEnd");
        String oriImage = request.getParameter("oriImage");
        String newImage = request.getParameter("newImage");
        int category = Integer.parseInt(request.getParameter("eventCategory"));
        int quota = 0;
        if (form == 2) {
            quota = Integer.parseInt(request.getParameter("eventQuota"));
        } 
        
        Event event = new Event(eventNo, category, title, content, form, progress, start, end, oriImage, newImage, quota);
 
        Connection conn = getConnection();
        int result = new EventDao().updateEvent(event, conn);
 
        if (result > 0) {
            commit(conn);
        } else {
            rollback(conn);
        }
        close(conn);
 
        response.sendRedirect(request.getContextPath() + "/event/detail?eventNo=" + eventNo);
    }

}
