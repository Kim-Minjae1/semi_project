package com.book.admin.book.controller;


import com.book.admin.book.dao.BookDao;
import com.book.admin.book.vo.Book;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

//관리자 도서 목록
@WebServlet("/book/list")
public class BookListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public BookListServlet() {
        super();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String content = request.getParameter("bk_content");

        if (content == null) {
            content = "";
        }

       
        Book b = new Book();
        String nowPage = request.getParameter("nowPage");
        if (nowPage != null) {
            b.setNowPage(Integer.parseInt(nowPage));
        }

       
        b.setTotalData(new BookDao().selectBoardCount(b, content));

        List<Map<String, String>> list = new BookDao().selectBook(b, content);
   
        request.setAttribute("paging", b);
        request.setAttribute("resultList", list);
        request.setAttribute("searchContent", content); 
        RequestDispatcher rd = request.getRequestDispatcher("/views/admin/book/book_list.jsp");
        rd.forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}