package com.book.member.user.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.member.user.dao.UserDao;

@WebServlet(name="userchanagepwEnd",urlPatterns="/user/changepw")
public class UserChangepwEndServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
   
    public UserChangepwEndServlet() {
        super();
    }

   
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      HttpSession session = request.getSession(false); 
      response.setContentType("text/html; charset=UTF-8");
      PrintWriter writer = response.getWriter();
      String id = (String) session.getAttribute("user_id");
      String pw = request.getParameter("pw");
      int result = new UserDao().changepw(id,pw);
      RequestDispatcher dispatcher = null;
     
      if(result > 0) {
         session.removeAttribute("user");
         session.invalidate();
         dispatcher = request.getRequestDispatcher("/");
      }else {
         writer.println("<script>alert('변경실패 다시 시도해주세요.');location.href='/user/findpw';</script>");
           writer.flush(); 
           return;
      }
      dispatcher.forward(request, response);
   }
      

   
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      doGet(request, response);
   }

}