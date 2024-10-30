package com.book.member.sg.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.admin.sg.dao.SgAdmDao;
import com.book.admin.sg.vo.SuggestionReply;
import com.book.member.sg.dao.SgMemDao;
import com.book.member.sg.vo.Suggestion;

@WebServlet("/member/sg/detail")
public class SgDetailServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    public SgDetailServlet() {
        super();
    }

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      // ?뒤에 값을 받아온다
      int sgNo = Integer.parseInt(request.getParameter("sg_no"));
      Suggestion sgOp = new Suggestion();
      sgOp.setSg_no(sgNo);
      
       Suggestion sgDetail = new SgMemDao().detailSg(sgOp);
       SuggestionReply sgReply = new SgAdmDao().getReplyList(sgNo);

        if (sgDetail != null) {
            request.setAttribute("sgReply", sgReply);
               request.setAttribute("sgDetail", sgDetail);
               RequestDispatcher view = request.getRequestDispatcher("/views/member/user/mypageSgDetail.jsp");
               view.forward(request, response);
           }
        
   }

   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      doGet(request, response);
   }

}
