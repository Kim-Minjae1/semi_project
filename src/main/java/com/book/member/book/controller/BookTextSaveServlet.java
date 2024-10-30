package com.book.member.book.controller;

import com.book.member.book.dao.BookTextDao;
import com.book.member.book.vo.BookText;
import com.book.member.user.vo.User;

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
import java.time.format.DateTimeParseException;

//작성한 독후감 임시저장
@WebServlet("/book/saveDraft")
public class BookTextSaveServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    public BookTextSaveServlet() {
        super();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user_btSave = (User) session.getAttribute("user");
            int book_no = Integer.parseInt(request.getParameter("bk_no"));
            int userNo = user_btSave.getUser_no();

            String start = request.getParameter("bw_start_date");
            String end = request.getParameter("bw_end_date");
            String content = request.getParameter("bw_content");
            String recommendation_no = request.getParameter("bk_recommendation");


            int recommendationNo = 5;
            try {
                if (recommendation_no != null && !recommendation_no.trim().isEmpty()) {
                    recommendationNo = Integer.parseInt(recommendation_no);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }

            LocalDate startDate = null;
            LocalDate endDate = null;
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

            endDate = LocalDate.parse(end, formatter);
            startDate =LocalDate.parse(start, formatter);
           
            BookText bt = new BookText();
            bt.setBook_first_read(startDate);
            bt.setBook_end_read(endDate);
            bt.setBook_content(content);
            bt.setRecommendation_no(recommendationNo);
            bt.setBook_no(book_no);
            bt.setUser_no(userNo);

            int result = new BookTextDao().inputSaveBookText(bt);
           
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = response.getWriter();
            if (result > 0) {
            
                writer.println("<script>alert(`임시저장되었습니다. 일주일뒤 자동삭제되는 점 양해부탁드립니다.  임시저장시 추천도는 임의로 저장됩니다.`); location.href='/user/saveTextList?u_id="+userNo+"';</script>");
            } else {
                writer.println("<script>alert('임시저장시 오류가 발생하였습니다.다시 시도해주세요.'); location.href='/user/bookList';</script>");
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
