package com.book.member.book.controller;
import com.book.member.book.dao.ApplyBookDao;
import com.book.admin.book.vo.ApplyBook;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

//사용자 도서신청 목록
@WebServlet("/book/applyList")
public class ApplyBookListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public ApplyBookListServlet() {
        super();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("apply_bk_title");

        ApplyBook ab = new ApplyBook();

        String nowPage = request.getParameter("nowPage");

        if (nowPage != null) {
            ab.setNowPage(Integer.parseInt(nowPage));
        }
        // 전체 목록 개수 -> 페이징바 구성
        ab.setTotalData(new ApplyBookDao().selectBoardCount(ab, title));

        List<Map<String,String>> list = new ApplyBookDao().selectApplyList(ab, title);
        request.setAttribute("paging", ab);
        request.setAttribute("resultList", list);

        RequestDispatcher rd = request.getRequestDispatcher("/views/member/book/applyBookList.jsp");
        rd.forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}