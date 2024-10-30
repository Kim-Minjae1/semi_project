package com.book.admin.sg.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.admin.sg.dao.BasicReplyDao;
import com.book.admin.sg.vo.Basic;



@WebServlet("/admin/sg/basicEnd")
public class AdmBasicReplyListEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdmBasicReplyListEndServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 기본 답변 텍스트 받아와서 insert
		String basicText = request.getParameter("replyBasic");
		
		Basic b = new Basic();
		b.setBasic_content(basicText);
		
		int result = new BasicReplyDao().addBasic(b);
        
        if(result > 0) {
        	response.sendRedirect(request.getContextPath() + "/admin/sg/basic");
        }
        
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
