package com.book.member.book.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import com.book.member.book.dao.BookTextDao;
import com.book.member.book.vo.BookText;
import com.book.member.user.vo.User;

//작성한 독후감 저장
@WebServlet("/book/textEnd")
public class BookTextEndServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    public BookTextEndServlet() {
        super();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user_btend = (User) session.getAttribute("user");

            int book_no = Integer.parseInt(request.getParameter("bk_no"));
            String start = request.getParameter("bw_start_date");
            String end = request.getParameter("bw_end_date");
            String content = request.getParameter("bw_content");
            int recommendation_no = Integer.parseInt(request.getParameter("bk_recommendation"));
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate startDate = LocalDate.parse(start, formatter);
            LocalDate endDate = LocalDate.parse(end, formatter);

            BookText bt = new BookText();
            bt.setBook_first_read(startDate);
            bt.setBook_end_read(endDate);
            bt.setBook_content(content);
            bt.setRecommendation_no(recommendation_no);
            bt.setBook_no(book_no);
            bt.setUser_no(user_btend.getUser_no()); 

            int result = new BookTextDao().inputBookText(bt);

            response.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = response.getWriter();
            if (result > 0) {

                writer.println("<script>alert('독후감 작성이 완료되었습니다.'); location.href='/user/textList';</script>");
            } else {
                writer.println("<script>alert('오류가 발생했습니다.'); location.href='/user/bookList';</script>");
            }
            writer.close();
        } else {

            response.sendRedirect("/views/member/user/login.jsp");
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        doGet(request, response);

    }
}
