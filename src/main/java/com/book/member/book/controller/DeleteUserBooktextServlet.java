package com.book.member.book.controller;


import com.book.member.book.dao.BookTextDao;
import com.book.member.book.vo.BookText;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

//회원별 본인 독후감 수정
@WebServlet("/user/deleteBooktextConfirmed")
public class DeleteUserBooktextServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DeleteUserBooktextServlet() {
        super();

    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bt_no = request.getParameter("bt_no");

        int result = new BookTextDao().deleteBooktext(bt_no);
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter writer = response.getWriter();

        if (result > 0) {
            writer.println("<script>alert('삭제가 완료되었습니다.'); location.href='/user/textList';</script>");
        } else {
            writer.println("<script>alert('삭제가 불가능합니다. 다시 시도해주세요.'); location.href='/user/textList';</script>");
        }
        writer.close();
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);

    }
}



