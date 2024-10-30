package com.book.member.sg.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.member.sg.dao.SgMemDao;
import com.book.member.sg.vo.Suggestion;

@WebServlet("/member/sg/delete")
public class SgDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SgDeleteServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// ?뒤에 값을 받아온다
		int sgNo = Integer.parseInt(request.getParameter("sg_no"));
	
		Suggestion sg = new Suggestion();
		sg.setSg_no(sgNo);
		
		 int result = new SgMemDao().deleteSg(sg);
		 if(result > 0) {
			 response.setContentType("text/html; charset=UTF-8");
			 PrintWriter writer = response.getWriter();
			 writer.println("<script>alert('삭제 되었습니다!'); location.href='/member/sg/list';</script>");
			 writer.close();
		 }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
