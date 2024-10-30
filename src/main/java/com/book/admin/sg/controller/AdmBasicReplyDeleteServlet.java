package com.book.admin.sg.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.admin.sg.dao.BasicReplyDao;

@WebServlet("/admin/sg/delete")
public class AdmBasicReplyDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdmBasicReplyDeleteServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 기본 답변 추가 페이지에서 삭제
		// ?basic_no 받아서 삭제
		int basicNo = Integer.parseInt(request.getParameter("basic_no"));
		
		int result = new BasicReplyDao().deleteBasic(basicNo);
		
		if(result > 0 ) {
			response.setContentType("text/html; charset=UTF-8");
			 PrintWriter writer = response.getWriter();
			 writer.println("<script>alert('삭제 되었습니다!'); location.href='/admin/sg/basic?user_no=1';</script>");
			 writer.close();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
