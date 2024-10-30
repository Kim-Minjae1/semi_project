package com.book.member.book.controller;

import com.book.member.book.dao.ApplyBookDao;
import com.book.admin.book.vo.ApplyBook;
import com.book.member.user.vo.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

//도서신청완료
@WebServlet("/book/applyEnd")
public class ApplyBookEndServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    public ApplyBookEndServlet() {
        super();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user_apply = (User) session.getAttribute("user");

            String title = request.getParameter("apply_bk_title");
            String publisher = request.getParameter("apply_bk_publisher");
            String author = request.getParameter("apply_bk_author");

            int userNo = user_apply.getUser_no();

            ApplyBook ab = new ApplyBook();
            ab.setApply_bk_title(title);
            ab.setApply_bk_publisher(publisher);
            ab.setApply_bk_author(author);
            ab.setAp_user_no(userNo);

            int result = new ApplyBookDao().inputApply(ab);
          
            if (result > 0) {
                // 성공 시 alert 창 띄우고 리디렉션
                response.setContentType("text/html; charset=UTF-8");
                PrintWriter writer = response.getWriter();
                writer.println("<script>alert('도서신청이 완료되었습니다.'); location.href='/book/applyList';</script>");
                writer.close();
            } else {
                response.setContentType("text/html; charset=UTF-8");
                PrintWriter writer = response.getWriter();
                writer.println("<script>alert('이미 신청된 도서이거나 존재하는 도서입니다.'); location.href='/book/apply';</script>");
                writer.close();
            }
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        doGet(request, response);

    }
}