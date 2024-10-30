package com.book.admin.sg.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.admin.sg.dao.SgAdmDao;

@WebServlet("/admin/sg/replyUpdate")
public class AdmSgReplyUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdmSgReplyUpdateServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			// 관리자 문의사항 답변 삭제
				int replyNo = Integer.parseInt(request.getParameter("sg_reply_no"));
				int sgNo = Integer.parseInt(request.getParameter("sg_no"));
				String sgReply = request.getParameter("sgReply");
				
				int result = new SgAdmDao().updateReply(replyNo,sgReply);
				
				if(result > 0) {
					
					response.sendRedirect(request.getContextPath() + "/admin/sg/detail?sg_no=" + sgNo);
				}
				
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
