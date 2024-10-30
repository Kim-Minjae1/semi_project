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

//임시저장한 목록 정보 가지고 오기
@WebServlet("/user/saveEditCheck")
public class SaveBooktextCheckServlet  extends HttpServlet {

    private static final long serialVersionUID = 1L;


    public SaveBooktextCheckServlet() {
        super();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String save_no = request.getParameter("save_no");
     
        List<Map<String, String>> list = new BookTextDao().checkSave(save_no);
        request.setAttribute("resultList", list);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/member/book/updateBooktextSave.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        doGet(request, response);

    }
}
