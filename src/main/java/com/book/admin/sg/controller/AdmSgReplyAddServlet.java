package com.book.admin.sg.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.admin.sg.dao.SgAdmDao;
import com.book.admin.sg.vo.SuggestionReply;

@WebServlet("/admin/sg/reply")
public class AdmSgReplyAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdmSgReplyAddServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 답변 페이지에서 답변 등록
		
		// ? 값 뒤에 넣어준 sg_no 댓글 
		int sgNo = Integer.parseInt(request.getParameter("sg_no"));
		// 댓글 reply
		String reply = request.getParameter("reply");
		// 안에 넣어준다
		SuggestionReply sr = new SuggestionReply();
		sr.setSg_no(sgNo);
		sr.setSg_reply_content(reply);
		
		int result = new SgAdmDao().replySg(sr);
		
		if(result > 0) {
		
			response.sendRedirect(request.getContextPath() + "/admin/sg/detail?sg_no=" + sgNo);
		} 
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
