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
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

//임시저장 재저장, 제출
@WebServlet("/user/saveTextEnd")
public class BookTextSaveEndServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    public BookTextSaveEndServlet() {
        super();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        String save_no = request.getParameter("save_no");
        String bk_no = request.getParameter("bk_no");
        String user_no = request.getParameter("user_no");
        String recommendation = request.getParameter("bk_recommendation");
        String bt_start = request.getParameter("bw_start_date");
        String bt_end = request.getParameter("bw_end_date");
        String bt_content = request.getParameter("bw_content");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate startDate = LocalDate.parse(bt_start, formatter);
        LocalDate endDate = LocalDate.parse(bt_end, formatter);

        int saveNo = Integer.parseInt(save_no);
        BookText bt = new BookText();
        bt.setRecommendation_no(Integer.parseInt(recommendation));
        bt.setBook_first_read(startDate);
        bt.setBook_end_read(endDate);
        bt.setBook_content(bt_content);
        bt.setBook_no(Integer.parseInt(bk_no));
        bt.setUser_no(Integer.parseInt(user_no));

        int result =0;
        int result2 = 0;
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter writer = response.getWriter();
        if ("submit".equals(action)) {
            result = new BookTextDao().inputBookText(bt);
            result2 = new BookTextDao().deleteSaveInfo(saveNo);
            if (result > 0 && result2 > 0) {
                writer.println("<script>alert('제출되었습니다.'); location.href='/user/textList';</script>");
            } else {
                writer.println("<script>alert('오류가 발생했습니다.'); location.href='/user/saveTextList';</script>");
            }
        } else if ("save".equals(action)) {
             result = new BookTextDao().updateSaveInfo(saveNo, bt);
            if (result > 0) {
                writer.println("<script>alert('저장되었습니다.'); location.href='/user/saveTextList';</script>");
            } else {
                writer.println("<script>alert('오류가 발생했습니다.'); location.href='/user/saveTextList';</script>");
            }
        }else if ("delete".equals(action)) {
            result = new BookTextDao().deleteSaveInfo(saveNo);
            if (result > 0) {
                writer.println("<script>alert('삭제되었습니다.'); location.href='/user/saveTextList';</script>");
            } else {
                writer.println("<script>alert('오류가 발생했습니다.'); location.href='/user/saveTextList';</script>");
            }
        }else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }


       
        writer.close();


    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        doGet(request, response);

    }
}
