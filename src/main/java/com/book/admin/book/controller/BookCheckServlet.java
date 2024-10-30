package com.book.admin.book.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.admin.book.dao.BookDao;

import javax.servlet.RequestDispatcher;

import java.util.List;
import java.util.Map;

//독후감 작성 전 정보확인
@WebServlet("/book/bookCheck")
public class BookCheckServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    public BookCheckServlet() {
        super();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookNo =Integer.parseInt(request.getParameter("books_no")); 

        List<Map<String, String>> list = new BookDao().checkBook(bookNo);
        request.setAttribute("resultList", list);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/book/book_edit.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        doGet(request, response);

    }
}
