package com.book.admin.sg.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.admin.sg.dao.SgAdmDao;
import com.book.member.sg.vo.Suggestion;

@WebServlet("/admin/sg/list")
public class AdmSgListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdmSgListServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 제목과 상태 값을 받아오기
        String title = request.getParameter("sg_title");
        String sgStatus = request.getParameter("sgStatus"); 

        // Suggestion 객체를 생성하고 제목 설정
        Suggestion option = new Suggestion();
        option.setSg_title(title);

        // 현재 페이지 값 처리
        String nowPage = request.getParameter("nowPage");
        if (nowPage != null) {
            option.setNowPage(Integer.parseInt(nowPage));
        }

        // 총 데이터 개수 설정 (필요에 따라 구현)
        option.setTotalData(new SgAdmDao().selectSgCount(option));

        // sgStatus 값을 변환 (null 체크 포함)
        String statusValue = null;
        if ("답변완료".equals(sgStatus)) {
            statusValue = "1";
        } else if ("미답변".equals(sgStatus)) {
            statusValue = "0";
        }

        // list 형태로 값을 조회
        List<Map<String, String>> list = new SgAdmDao().selectSgList(option, statusValue);

        // 속성값에 저장하며 값을 JSP로 전달
        request.setAttribute("paging", option);
        request.setAttribute("resultList", list);

        RequestDispatcher view = request.getRequestDispatcher("/views/admin/sg/list.jsp");
        view.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
