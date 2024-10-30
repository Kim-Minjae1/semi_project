package com.book.member.event.controller;

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
import javax.servlet.http.HttpSession;

import com.book.admin.event.vo.Event;
import com.book.member.event.dao.EventReplyDao;
import com.book.member.event.dao.MemEventDao;
import com.book.member.user.vo.User;

@WebServlet("/user/event/detail")
public class MemEventDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
        
    public MemEventDetailServlet() {
        super(); 
    }
 
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int eventNo = Integer.parseInt(request.getParameter("eventNo"));
        Connection conn = getConnection();
        MemEventDao memEventDao = new MemEventDao();
        Event event = memEventDao.selectEventByNo(eventNo);
         
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        List<Map<String,String>> list = new EventReplyDao().selectErList(eventNo);
        int erReplyCnt = new EventReplyDao().countReply(eventNo);
        
        boolean isRegistered = false;
        int participateState = -1;
        if (user != null) {
            int userNo = user.getUser_no();
            isRegistered = memEventDao.checkRegistration(eventNo, userNo);
            participateState = memEventDao.getParticipateState(userNo, eventNo);
        }   
        
        request.setAttribute("erReplyCnt", erReplyCnt);
        request.setAttribute("erReplyList", list);
        request.setAttribute("event", event);
        request.setAttribute("isRegistered", isRegistered);
        request.setAttribute("participateState", participateState);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/member/event/MemeventDetailReply.jsp");
        dispatcher.forward(request, response);

        close(conn);
    }
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
