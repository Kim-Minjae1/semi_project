package com.book.admin.event.controller;

import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.commit;
import static com.book.common.sql.JDBCTemplate.getConnection;
import static com.book.common.sql.JDBCTemplate.rollback;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.book.admin.event.dao.EventDao;
import com.book.admin.event.vo.Event;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/event/updateEnd")
public class EventUpdateEndServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public EventUpdateEndServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { 
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
 
        int eventNo = Integer.parseInt(request.getParameter("eventNo")); 
        String eventType = request.getParameter("eventType");
 
        if (ServletFileUpload.isMultipartContent(request)) {
            String dir = request.getServletContext().getRealPath("/upload/event");
            int maxSize = 1024 * 1024 * 10; 
            String encoding = "UTF-8";
            DefaultFileRenamePolicy dfr = new DefaultFileRenamePolicy();
            MultipartRequest mr = new MultipartRequest(request, dir, maxSize, encoding, dfr);
 
            Event event = new Event();
            event.setEvent_no(eventNo);
            event.setEv_form(Integer.parseInt(eventType));

            if ("1".equals(eventType)) {
                String oriName = mr.getOriginalFileName("eventimage1");
                String reName = mr.getFilesystemName("eventimage1");
                event.setEv_title(mr.getParameter("eventTitle1"));
                event.setEv_start(mr.getParameter("startDate1"));
                event.setEv_end(mr.getParameter("endDate1"));
                event.setEv_content(mr.getParameter("eventContent1"));
                event.setOri_image(oriName);
                event.setNew_image(reName);
                event.setEvent_category(Integer.parseInt(mr.getParameter("eventCategory1")));
            } else if ("2".equals(eventType)) {
                String oriName = mr.getOriginalFileName("eventimage2");
                String reName = mr.getFilesystemName("eventimage2");
                event.setEv_title(mr.getParameter("eventTitle2"));
                event.setEv_start(mr.getParameter("startDate2"));
                event.setEv_end(mr.getParameter("endDate2"));
                event.setEv_progress(mr.getParameter("progressDate2"));
                event.setEv_content(mr.getParameter("eventContent2"));
                event.setOri_image(oriName);
                event.setNew_image(reName);
                event.setEvent_category(Integer.parseInt(mr.getParameter("eventCategory2")));
                event.setEvent_quota(Integer.parseInt(mr.getParameter("eventQuota2")));
            }
 
            Connection conn = getConnection();
            EventDao eventDao = new EventDao();
            int result = eventDao.updateEvent(event, conn);
            close(conn);
 
            if (result > 0) {
                commit(conn); 
                response.sendRedirect(request.getContextPath() + "/event/detail?eventNo=" + eventNo);
            } else {
                rollback(conn); 
                response.sendRedirect(request.getContextPath() + "/event/update?eventNo=" + eventNo + "&eventType=" + eventType);
            }
        } else { 
            response.sendRedirect(request.getContextPath() + "/event/update?eventNo=" + eventNo + "&eventType=" + eventType);
        }
    }
}
