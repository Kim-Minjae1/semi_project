package com.book.member.user.controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.book.member.user.vo.User;

@WebServlet("/user/UserCheckTableEndServlet")
public class UserCheckTableEndServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        List<User> userList = (List<User>) session.getAttribute("user");

        if (userList == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "No user data found in session");
            return;
        }

        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<table border='1'>");
        out.println("<tr><th>User No</th><th>User Name</th><th>User ID</th><th>User PW</th><th>User Email</th><th>User Nickname</th><th>User Active</th><th>User Create</th></tr>");
        for (User user : userList) {
            out.println("<tr>");
            out.println("<td>" + user.getUser_no() + "</td>");
            out.println("<td>" + user.getUser_name() + "</td>");
            out.println("<td>" + user.getUser_id() + "</td>");
            out.println("<td>" + user.getUser_pw() + "</td>");
            out.println("<td>" + user.getUser_email() + "</td>");
            out.println("<td>" + user.getUser_nickname() + "</td>");
            out.println("<td>" + user.getUser_active() + "</td>");
            out.println("<td>" + user.getUser_create() + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
        out.println("</body></html>");
        out.flush();
    }
}
