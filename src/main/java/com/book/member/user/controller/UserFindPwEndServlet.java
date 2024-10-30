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
import com.book.member.user.vo.User;

@WebServlet("/user/findpwend")
public class UserFindPwEndServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/user/findpw.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String email = request.getParameter("email");

        HttpSession session = request.getSession();
        String sessionCode = (String) session.getAttribute("verificationCode");
        String inputCode = request.getParameter("email_number");
        response.setContentType("text/html; charset=UTF-8");
      PrintWriter writer = response.getWriter();
      
      if (sessionCode != null && sessionCode.equals(inputCode)) {
            User user = new UserDao().findpw(id, email);
            if (user != null) {
                if (user.getUser_active() == 0) {
                    writer.println("<script>alert('탈퇴한 회원입니다.');location.href='/views/member/user/findpw.jsp';</script>");
                    writer.flush();
                    return;
                }
                session.setAttribute("user_id", user.getUser_id());
                response.sendRedirect("/views/member/user/changepw.jsp");
            } else {
               writer.println("<script>alert('아이디 또는 이메일이 잘못 되었습니다.                                     아이디와 이메일을 정확히 입력해 주세요.');location.href='/views/member/user/findpw.jsp';</script>");
                writer.flush();
                return;
            }
        } else {
           writer.println("<script>alert('아이디 또는 이메일이 잘못 되었습니다.                                     아이디와 이메일을 정확히 입력해 주세요.');location.href='/views/member/user/findpw.jsp';</script>");
            writer.flush();
            return;
        }
    }
}