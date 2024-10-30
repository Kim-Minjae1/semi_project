package com.book.member.user.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.member.user.dao.UserDao;
import com.book.member.user.vo.User;

@WebServlet("/user/findidend")
public class UserFindIdEndServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/member/user/findid.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        
        HttpSession session = request.getSession();
        String sessionCode = (String) session.getAttribute("verificationCode");
        String inputCode = request.getParameter("email_number");

        if (sessionCode != null && sessionCode.equals(inputCode)) {
            List<User> user = new UserDao().findid(name,email);
            
            if (user != null && !user.isEmpty()) {
            	session.setAttribute("user", user);
            	response.sendRedirect("/views/member/user/findid_success.jsp");
            } else {
            	response.sendRedirect("/views/member/user/findid_fail.jsp");
            }
        } else {
            response.getWriter().write("인증 실패");
        }
    }
}