package com.book.member.user.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.member.user.dao.UserDao;
import com.book.member.user.vo.User;

@WebServlet("/user/check_table")
public class UserCheckTableServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UserCheckTableServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User u = new User();
        String nowPage = request.getParameter("nowPage");
        String order = request.getParameter("order");
        String name = request.getParameter("user_name");
        String numPerPageStr = request.getParameter("numPerPage");

        // 페이지당 개수 설정
        if (numPerPageStr != null) {
            u.setNumPerPage(Integer.parseInt(numPerPageStr));  // numPerPage 값 설정
        } else {
            u.setNumPerPage(10);  // 기본값 10
        }

        // 현재 페이지 설정
        if (nowPage != null) {
            u.setNowPage(Integer.parseInt(nowPage));
        }

        // 전체 데이터 개수 설정
        u.setTotalData(new UserDao().selectBoardCount(u));

        // 데이터 목록 조회
        List<User> list = new UserDao().selectBoardList(u, order);

        // JSP에 필요한 데이터 설정
        request.setAttribute("paging", u);
        request.setAttribute("resultList", list);

        RequestDispatcher view = request.getRequestDispatcher("/views/member/user/check_table.jsp");
        view.forward(request, response);
    }
}