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



@WebServlet(name="usercreateEnd",urlPatterns="/user/createEnd")
public class UserCreateEndServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String email_prefix = request.getParameter("email_prefix");
        String email_domain = request.getParameter("email_domain");
        String email = email_prefix + "@" + email_domain;
        String nickname = request.getParameter("nickname");

        HttpSession session = request.getSession();
        String sessionCode = (String) session.getAttribute("verificationCode");
        String inputCode = request.getParameter("email_number");
        response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();

        if (sessionCode != null && sessionCode.equals(inputCode)) {
            User user = new User();
            user.setUser_name(name);
            user.setUser_id(id);
            user.setUser_pw(pw);
            user.setUser_email(email);
            user.setUser_nickname(nickname);
            int result = new UserDao().createUser(user);

            if (result == -1) {
            
            	writer.println("<script>alert('해당 이메일로는 더 이상 계정을 생성할 수 없습니다. (최대 3개)');location.href='/views/member/user/create.jsp';</script>");
    	        writer.flush(); 
    	        return;
            } else if (result > 0) {
                response.sendRedirect("/views/member/user/create_success.jsp");
            } else if(result == -2) {
            	writer.println("<script>alert('이미 사용 중인 닉네임입니다. 다른 닉네임을 선택해주세요.');location.href='/views/member/user/create.jsp';</script>");
    	        writer.flush(); 
    	        return;
            }else {
            	writer.println("<script>alert('회원가입에 실패했습니다.');location.href='/views/member/user/create.jsp';</script>");
    	        writer.flush(); 
    	        return;
            }
        }
    }
}