package com.book.admin.book.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.admin.book.dao.BookDao;
import com.book.admin.book.vo.Book;



@WebServlet("/book/edit")
public class EditBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public EditBookServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String bookimg = request.getParameter("books_img");
		String booktitle = request.getParameter("books_title");
		String bookauthor = request.getParameter("books_author");
		String bookpublisher = request.getParameter("books_publisher_name");
		int bookcategory = Integer.parseInt(request.getParameter("books_category_no"));
		int bookno = Integer.parseInt(request.getParameter("books_no"));

		Book bk = new Book();
		bk.setBooks_image(bookimg);
		bk.setBooks_title(booktitle);
		bk.setBooks_author(bookauthor);
		bk.setBooks_publisher_name(bookpublisher);
		bk.setBooks_category_no(bookcategory);
		bk.setBooks_no(bookno);
		
		int result = new BookDao().editBook(bk);

		RequestDispatcher view = null;
			view = request.getRequestDispatcher("/book/list");
			view.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
		doGet(request, response);
	}

}
