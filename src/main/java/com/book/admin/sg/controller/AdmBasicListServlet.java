package com.book.admin.sg.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.admin.sg.dao.BasicReplyDao;
import com.book.admin.sg.vo.Basic;

@WebServlet("/admin/sg/basic")
public class AdmBasicListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdmBasicListServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 첫 출력 list (기본 답변 추가 페이지)  
		List<Basic> basicList = new BasicReplyDao().selectBasic();
		 request.setAttribute("basicList", basicList);
	        RequestDispatcher view = request.getRequestDispatcher("/views/admin/sg/basic.jsp");
	        view.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
