package com.book.member.user.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/user/verifyCode")
public class UserVerifyEndServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inputCode = request.getParameter("code");
        String sessionCode = (String) request.getSession().getAttribute("verificationCode");

        if (inputCode.equals(sessionCode)) {
            response.getWriter().write("success");
        } else {
            response.getWriter().write("fail");
        }
    }
}