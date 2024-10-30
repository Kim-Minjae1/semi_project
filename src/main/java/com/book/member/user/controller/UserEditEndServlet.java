package com.book.member.user.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.member.user.dao.UserDao;
import com.book.member.user.vo.User;

@WebServlet(name="userEditEnd",urlPatterns="/user/editEnd")
public class UserEditEndServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
   
    public UserEditEndServlet() {
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
      String name = request.getParameter("name");
      String nickname = request.getParameter("nickname");
      String email_prefix = request.getParameter("email_prefix");
       String email_domain = request.getParameter("email_domain");
       String email = email_prefix + "@" + email_domain;
      
      int result = new UserDao().editUser(no,pw,name,nickname,email);
      response.setContentType("text/html; charset=UTF-8");
      PrintWriter writer = response.getWriter();
      if (result == -1) {
         
           writer.println("<script>alert('해당 이메일로는 더 이상 계정을 생성할 수 없습니다. (최대 3개)');location.href='/views/member/user/edit.jsp';</script>");
           writer.flush(); 
           return;
        } else if (result > 0) {
        	User updatedUser = new UserDao().getUserById(no);
            session.setAttribute("user", updatedUser);
            writer.println("<script>alert('회원정보가 정상적으로 수정되었습니다.');location.href='/';</script>");
           writer.flush(); 
           return;
        } else if(result == -2) {
           writer.println("<script>alert('이미 사용 중인 닉네임입니다. 다른 닉네임을 선택해주세요.');location.href='/views/member/user/edit.jsp';</script>");
           writer.flush(); 
           return;
        }else {
           writer.println("<script>alert('회원정보 수정에 실패했습니다.');location.href='/views/member/user/edit.jsp';</script>");
           writer.flush(); 
           return;
        }
   }
   
   
      

   
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      doGet(request, response);
   }

}