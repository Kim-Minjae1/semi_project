package com.book.member.book.controller;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.member.book.dao.BookReplyDao;

/**
 * Servlet implementation class ReplyBookTextChildAddServlet
 */
@WebServlet("/member/book/btChildReply")
public class ReplyBookTextChildAddServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ReplyBookTextChildAddServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int btNo = Integer.parseInt(request.getParameter("bt_no"));
        int btUserNo = Integer.parseInt(request.getParameter("bt_user_no"));
        int btParentNo = Integer.parseInt(request.getParameter("br_parent"));
        String btReply = request.getParameter("br_content");

        int result = new BookReplyDao().bkchildReplyAdd(btNo,btUserNo,btParentNo,btReply);

        if(result > 0) {
 response.sendRedirect(request.getContextPath() + "/book/detail?bt_no="+btNo);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}