package com.book.member.book.controller;

import com.book.member.book.dao.BookTextDao;
import com.book.member.book.vo.BookText;
import com.book.member.user.vo.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;
//회원별 개인 임시저장 목록
@WebServlet("/user/saveTextList")
public class BookTextSaveListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public BookTextSaveListServlet() {
        super();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
 
            String content = request.getParameter("bk_content");
            User user_saveText = (User) session.getAttribute("user");
       
            String recommendation = request.getParameter("recommendation");

            if (content == null) {
                content = ""; 
            }
   
            if (recommendation == null || recommendation.isEmpty()) {
                recommendation = "0"; 
            }


            BookText bt = new BookText();
            String nowPage = request.getParameter("nowPage");
            if (nowPage != null) {
                bt.setNowPage(Integer.parseInt(nowPage));
            }


            bt.setTotalData(new BookTextDao().saveBooktextCount(user_saveText.getUser_no(),bt, content, recommendation));

          
            List<Map<String, String>> list = new BookTextDao().selectSaveText(user_saveText.getUser_no(), bt, content, recommendation);

            request.setAttribute("paging", bt);
            request.setAttribute("resultList", list);
            request.setAttribute("searchContent", content); 
            request.setAttribute("selectedRecommendation", recommendation); 
     

            RequestDispatcher rd = request.getRequestDispatcher("/views/member/book/booktextSaveList.jsp");
            rd.forward(request, response);
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}
