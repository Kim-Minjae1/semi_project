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
import com.book.admin.sg.dao.SgAdmDao;
import com.book.admin.sg.vo.Basic;
import com.book.admin.sg.vo.SuggestionReply;
import com.book.member.sg.vo.Suggestion;

@WebServlet("/admin/sg/detail")
public class AdmSgDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdmSgDetailServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 문의사항 글 상세 조회
		int sgNo = Integer.parseInt(request.getParameter("sg_no"));
		Suggestion option = new Suggestion();
		option.setSg_no(sgNo);
		// 사용자 문의사항 글
		Suggestion sgDetail = new SgAdmDao().detailSg(option);
		// 관리자 문의사항 댓글
		SuggestionReply sgReply = new SgAdmDao().getReplyList(sgNo);
		// 기본 답변 출력 
		List<Basic> basicList = new BasicReplyDao().selectBasic();
		if (sgDetail != null) {
			request.setAttribute("basicList", basicList);
			request.setAttribute("replyList", sgReply);
			request.setAttribute("sgDetail", sgDetail);
			RequestDispatcher view = request.getRequestDispatcher("/views/admin/sg/detail.jsp");
			view.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
