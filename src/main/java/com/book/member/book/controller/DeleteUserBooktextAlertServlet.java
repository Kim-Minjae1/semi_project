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
@WebServlet("/user/textDelete")
public class DeleteUserBooktextAlertServlet  extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DeleteUserBooktextAlertServlet() {
        super();

    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bt_no = request.getParameter("bt_no");

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter writer = response.getWriter();

        writer.println("<script>");
        writer.println("if (confirm('정말 삭제하시겠습니까?')) {");
        writer.println("  location.href='/user/deleteBooktextConfirmed?bt_no=" + bt_no + "';");
        writer.println("} else {");
        writer.println("  alert('삭제가 취소되었습니다.');");
        writer.println("  location.href='/user/textList';");
        writer.println("}");
        writer.println("</script>");
        writer.close();

    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);

    }
}



