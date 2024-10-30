package com.book.member.user.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.member.user.dao.UserDao;
import com.book.member.user.vo.User;



@WebServlet(name="userdeleteEnd",urlPatterns="/user/deleteEnd")
public class UserDeleteEndServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;

    public UserDeleteEndServlet() {
        super();
    }

   
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      HttpSession session = request.getSession(false); 
      int no = 0;
      User u = new User();
      if(session != null) {
         u =(User)session.getAttribute("user"); 
         no = u.getUser_no();
         }
      String pw = request.getParameter("pw");

      int result = new UserDao().deleteUser(pw,no);
      if(result > 0) {
         session.removeAttribute("user");
         session.invalidate();
 		RequestDispatcher view = request.getRequestDispatcher("/views/member/user/delete_success.jsp");
 		view.forward(request, response);
      }else {
         request.setAttribute("errorMessage", "비밀번호가 올바르지 않거나 탈퇴 처리 중 오류가 발생했습니다.");
      }
   }
      

   
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      doGet(request, response);
   }

}
