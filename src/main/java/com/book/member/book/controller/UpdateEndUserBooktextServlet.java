package com.book.member.book.controller;

import com.book.member.book.dao.BookTextDao;
import com.book.member.book.vo.BookText;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

//독후감 수정완료
@WebServlet("/user/textEditEnd")
public class UpdateEndUserBooktextServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    public UpdateEndUserBooktextServlet() {
        super();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bt_no = request.getParameter("bt_no");
        String recommendation = request.getParameter("bk_recommendation");
        String bt_start = request.getParameter("bw_start_date");
        String bt_end = request.getParameter("bw_end_date");
        String bt_content = request.getParameter("bw_content");
       
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate startDate = LocalDate.parse(bt_start, formatter);
        LocalDate endDate = LocalDate.parse(bt_end, formatter);
    
        BookText bt = new BookText();
        bt.setBooktext_no(Integer.parseInt(bt_no));
        bt.setRecommendation_no(Integer.parseInt(recommendation));
        bt.setBook_first_read(startDate);
        bt.setBook_end_read(endDate);
        bt.setBook_content(bt_content);
        int result = new BookTextDao().updateInfo(bt);
    
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = response.getWriter();
            if (result > 0) {
                writer.println("<script>alert('독후감 수정이 완료되었습니다.'); location.href='/user/textList';</script>");
            } else {
                writer.println("<script>alert('오류가 발생했습니다.'); location.href='/user/textList';</script>");
            }
            writer.close();


    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        doGet(request, response);

    }


}
