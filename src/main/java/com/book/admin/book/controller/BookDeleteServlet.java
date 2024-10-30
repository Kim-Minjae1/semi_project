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



@WebServlet("/book/delete")
public class BookDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public BookDeleteServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		

		int bookno = Integer.parseInt(request.getParameter("books_no")); 
	
		int result = new BookDao().deleteBook(bookno);
	 
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
