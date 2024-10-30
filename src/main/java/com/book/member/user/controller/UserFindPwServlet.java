package com.book.member.user.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/user/findpw")
public class UserFindPwServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UserFindPwServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/member/user/findpw.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        EmailSender emailSender = new EmailSender();
        UserSendVerificationEndCodeServlet verification = new UserSendVerificationEndCodeServlet();
        String code = verification.generateVerificationCode();
        emailSender.sendEmail(email, "인증 코드", "인증 코드는 " + code + " 입니다.");
        
    }
}