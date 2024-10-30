package com.book.admin.book.controller;


import com.book.member.book.dao.ApplyBookDao;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/book/applyStatusEnd")
public class ApplyStatusEndServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public ApplyStatusEndServlet() {
        super();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int applyNo = Integer.parseInt(request.getParameter("apply_no"));
        int status = Integer.parseInt(request.getParameter("status")); 

        int result = new ApplyBookDao().updateApplyStatus(applyNo, status); 

        PrintWriter writer = response.getWriter();
        if (result > 0) {
            // 성공 시 alert 창 띄우고 리디렉션
            writer.println("<script>alert('도서 상태가 변경되었습니다.'); location.href='/book/applyStatusList';</script>");
        } else {
            writer.println("<script>alert('오류가 발생했습니다.'); location.href='/book/applyStatusList';</script>");
        }
        writer.close();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        doGet(request, response);

    }
}
