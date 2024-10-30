package com.book.member.book.controller;


import com.book.member.book.dao.BookTextDao;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

//독후감 수정 전 정보 전달
@WebServlet("/user/editCheck")
public class UpdateCheckServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    public UpdateCheckServlet() {
        super();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("bt_no");
     
        List<Map<String, String>> list = new BookTextDao().checkInfo(id);
        request.setAttribute("resultList", list);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/member/book/booktextUpdate.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        doGet(request, response);

    }
}
