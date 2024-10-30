package com.book.member.book.controller;

import com.book.member.book.dao.BookTextDao;
import com.book.member.book.vo.BookText;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

//사용자이 작성한 독후감 전체목록
@WebServlet("/book/textList")
public class BookTextListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public BookTextListServlet() {
        super();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String content = request.getParameter("bw_content");


        String recommendation = request.getParameter("recommendation");

        if (content == null) {
            content = "";
        }

        if (recommendation == null || recommendation.isEmpty()) {
            recommendation = "0"; // 기본값
        }


        BookText bt = new BookText();
        String nowPage = request.getParameter("nowPage");
        if (nowPage != null) {
            bt.setNowPage(Integer.parseInt(nowPage));
        }


        bt.setTotalData(new BookTextDao().selectBoardCount(bt, content, recommendation));

        List<Map<String, String>> list = new BookTextDao().selectBooktext(bt, content, recommendation);

        request.setAttribute("paging", bt);
        request.setAttribute("resultList", list);
        request.setAttribute("searchContent", content);
        request.setAttribute("selectedRecommendation", recommendation); 


        RequestDispatcher rd = request.getRequestDispatcher("/views/member/book/booktextList.jsp");
        rd.forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}