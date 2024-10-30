package com.book.member.book.controller;

import com.book.member.book.dao.UserBookDao;
import com.book.admin.book.vo.Book;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

//사용자들이 보는 도서 전체 목록
@WebServlet("/user/bookList")
public class UserBookListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UserBookListServlet() {
        super();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String content = request.getParameter("bk_content");

        if (content == null) {
            content = "";
        }

        Book b = new Book();
        String nowPage = request.getParameter("nowPage");
        if (nowPage != null) {
            b.setNowPage(Integer.parseInt(nowPage));
        }

        b.setTotalData(new UserBookDao().selectBoardCount(b, content));

        List<Map<String, String>> list = new UserBookDao().selectBookAll(b, content);

        request.setAttribute("paging", b);
        request.setAttribute("resultList", list);
        request.setAttribute("searchContent", content);

        RequestDispatcher rd = request.getRequestDispatcher("/views/member/book/userBookList.jsp");
        rd.forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}