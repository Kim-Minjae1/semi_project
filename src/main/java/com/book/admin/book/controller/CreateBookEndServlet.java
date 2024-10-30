package com.book.admin.book.controller;

import com.book.admin.book.dao.BookDao;
import com.book.admin.book.vo.Book;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet("/book/createEnd")
public class CreateBookEndServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    public CreateBookEndServlet() {
        super();

    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String booktitle = request.getParameter("book_title");
        String bookauthor = request.getParameter("book_author");
        String bookpublisher = request.getParameter("book_publihser");
        int bookcategory = Integer.parseInt(request.getParameter("book_category"));
        String bookimg = request.getParameter("img_up");

        Book bk = new Book();
        bk.setBooks_title(booktitle);
        bk.setBooks_author(bookauthor);
        bk.setBooks_publisher_name(bookpublisher);
        bk.setBooks_category_no(bookcategory);
        bk.setBooks_image(bookimg);

        int result = new BookDao().createBook(bk);
        if (result > 0) {
          
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = response.getWriter();
            writer.println("<script>alert('도서등록이 완료되었습니다.'); location.href='/book/list';</script>");
            writer.close();
        }
        else {
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = response.getWriter();
            writer.println("<script>alert('도서정보를 다시 입력해주세요'); location.href='/book/create';</script>");
            writer.close();
        }
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        doGet(request, response);
    }

}