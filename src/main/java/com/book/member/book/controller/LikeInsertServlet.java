package com.book.member.book.controller;


import com.book.member.book.dao.LikeDao;
import com.book.member.book.vo.Like;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name="insertLike", urlPatterns="/like/insert")
public class LikeInsertServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LikeInsertServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
        String color = request.getParameter("color");
        int userNo = Integer.parseInt(request.getParameter("userNo"));
        int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
        int booktextNo = Integer.parseInt(request.getParameter("booktextNo"));
       
        Like lk = new Like();
        lk.setUser_no(userNo);
        lk.setBook_category_no(categoryNo);
        lk.setBooktext_no(booktextNo);
      
        if(color.equals("gray")) {
           
            new LikeDao().insertLike(lk);
     
            color = "red";
         
        } else {
           
            new LikeDao().deleteLike(lk);
            color = "gray";
        }
      
        int lkCnt = new LikeDao().countLike(booktextNo);

        request.setAttribute("color", color);
        request.setAttribute("lkCnt", lkCnt);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}