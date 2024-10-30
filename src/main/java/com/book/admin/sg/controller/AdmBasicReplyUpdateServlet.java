package com.book.admin.sg.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.admin.sg.dao.BasicReplyDao;

@WebServlet("/admin/sg/update")
public class AdmBasicReplyUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdmBasicReplyUpdateServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int basicNo = Integer.parseInt(request.getParameter("basic_no"));
		String updateBs = request.getParameter("updateBasic");
		
		int result = new BasicReplyDao().updateBasic(basicNo,updateBs);
		if(result > 0) {
        	response.sendRedirect(request.getContextPath() + "/admin/sg/basic");
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
