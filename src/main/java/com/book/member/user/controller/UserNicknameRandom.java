package com.book.member.user.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.member.user.dao.UserDao;



@WebServlet("/user/nicknameRandom")
public class UserNicknameRandom extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDao userDao = new UserDao();
        String adjective = userDao.getRandomAdjective();
        List<String> nouns = userDao.getRandomNouns(3);

        StringBuilder nickname = new StringBuilder();
        nickname.append(adjective).append(" ");
        for (String noun : nouns) {
            nickname.append(noun);
        }

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(nickname.toString());
    }
}