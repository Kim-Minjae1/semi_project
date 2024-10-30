package com.book.member.user.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.member.user.dao.AttendDao;
import com.book.member.user.dao.UserDao;
import com.book.member.user.vo.User;

@WebServlet(name="userLoginEnd",urlPatterns="/user/loginEnd")
public class UserLoginEndServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
        
    public UserLoginEndServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        
        int attendResult = 0;
        
        User u = new UserDao().loginUser(id, pw);
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter writer = response.getWriter();
        HttpSession session = request.getSession();
        
        if (u != null) {
            if (u.getUser_active() == 0) {
                writer.println("<script>alert('탈퇴한 회원입니다. 다시 로그인해주세요.');location.href='/user/login';</script>");
                writer.close();
                return;
            }
            
            if(u.getUser_no() != 1) {
                attendResult = new AttendDao().attendUser(u.getUser_no());
            }
             
            if (session.isNew() || session.getAttribute("user") == null) {
                session.setAttribute("user", u);
                session.setMaxInactiveInterval(60 * 30);
            }

            if (u.getUser_no() == 1) { 
                response.sendRedirect("/views/admin/admin.jsp");
            } else { 
                response.sendRedirect("/");
            }
        } else {
            Integer loginFailCount = (Integer) session.getAttribute("loginFailCount");
            if (loginFailCount == null) {
                loginFailCount = 0;
            }
            loginFailCount++;
            session.setAttribute("loginFailCount", loginFailCount);
            if (loginFailCount >= 3) {
                writer.println("<script>if(confirm('로그인 시도가 3회 실패했습니다. 아이디를 찾으시겠습니까?')){ location.href='/user/findid'; } else { location.href='/user/login'; }</script>");
                session.setAttribute("loginFailCount", 0); 
            } else {
                writer.println("<script>alert('아이디 또는 비밀번호가 잘못 되었습니다. 아이디와 비밀번호를 정확히 입력해 주세요.');location.href='/user/login';</script>");
            }
            writer.close();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}