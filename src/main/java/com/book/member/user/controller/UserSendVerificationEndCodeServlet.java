package com.book.member.user.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/user/sendVerificationCode")
public class UserSendVerificationEndCodeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        EmailSender emailSender = new EmailSender();
        String code = generateVerificationCode();
        emailSender.sendEmail(email, "인증 코드", "인증 코드는 " + code + " 입니다.");
        
        request.getSession().setAttribute("verificationCode", code);
        response.getWriter().write("success");
    }

    String generateVerificationCode() {
        int code = (int) (Math.random() * 900000) + 100000;
        return String.valueOf(code);
    }
}

