package com.book.member.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.member.user.dao.UserDao;
import com.book.member.user.vo.User;

@WebServlet(name="userCheckpwEnd",urlPatterns="/user/checkpwEnd")
public class UserCheckpwEndServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    
    public UserCheckpwEndServlet() {
        super();
        
    }

   
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  
      String pw = request.getParameter("pw");
      
      User u = new UserDao().checkpw(pw);
      HttpSession session = request.getSession(false);
      User sessionUser = (User) session.getAttribute("user");
      
      
      if(u != null && sessionUser.getUser_pw().equals(pw)) {
         if(session.isNew() || session.getAttribute("user")==null) {
            session.setAttribute("user", u);
            session.setMaxInactiveInterval(60*30);
         }
     
         
         response.sendRedirect("/views/member/user/myProfileEdit.jsp");
      }else {
         response.sendRedirect("/views/member/user/checkpw_fail.jsp");
        
      }
   }

   
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
      doGet(request, response);
   }

}
