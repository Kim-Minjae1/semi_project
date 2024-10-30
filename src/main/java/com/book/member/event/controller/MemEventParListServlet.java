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

import com.book.admin.event.dao.EventDao;
import com.book.admin.event.vo.Event;
import com.book.member.event.dao.MemEventDao;
import com.book.member.user.vo.User;
 
@WebServlet("/user/event/parList")
public class MemEventParListServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
        
    public MemEventParListServlet() {
        super(); 
    }
 
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
         int userNo = 0;
         User user = null;

         if (session != null) {
             user = (User) session.getAttribute("user");
             if (user != null) {
                 userNo = user.getUser_no();
             }
         }

         int nowPage = 1;
         if (request.getParameter("nowPage") != null) {
             nowPage = Integer.parseInt(request.getParameter("nowPage"));
         }

         String searchKeyword = request.getParameter("searchKeyword");

         int numPerPage = 10;

         Connection conn = getConnection();
         MemEventDao memEventDao = new MemEventDao();

         int totalData = memEventDao.selectParEventCount(userNo, searchKeyword);

         int startRow = (nowPage - 1) * numPerPage;
         int endRow = startRow + numPerPage - 1;
         List<Map<String, String>> userEvents = memEventDao.getUserEventParticipations(userNo, startRow, numPerPage, searchKeyword);

         close(conn);

         Event paging = new Event();
         paging.setNowPage(nowPage);
         paging.setNumPerPage(numPerPage);
         paging.setTotalData(totalData);

         request.setAttribute("paging", paging);
         request.setAttribute("userEvents", userEvents);

         RequestDispatcher rd = request.getRequestDispatcher("/views/member/event/mypageMemPartiList.jsp");
         rd.forward(request, response);
     }

 
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
      doGet(request, response);
   }

}