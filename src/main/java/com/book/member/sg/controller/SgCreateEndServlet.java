package com.book.member.sg.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.book.member.sg.dao.SgMemDao;
import com.book.member.sg.vo.Suggestion;
import com.book.member.user.vo.User;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/member/sg/createEnd")
public class SgCreateEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SgCreateEndServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(ServletFileUpload.isMultipartContent(request)) {

			String dir = request.getServletContext().getRealPath("/upload/sg");
			int maxSize = 1024 * 1024 * 10;
			String encoding = "UTF-8";
			DefaultFileRenamePolicy dfr = new DefaultFileRenamePolicy();
			MultipartRequest mr = new MultipartRequest(request, dir,maxSize,encoding,dfr);
			String title = mr.getParameter("sg_title");
			String content = mr.getParameter("sg_content");
			String oriName1 = mr.getOriginalFileName("sg_file1");
			String reName1 = mr.getFilesystemName("sg_file1");
			String oriName2 = mr.getOriginalFileName("sg_file2");
			String reName2 = mr.getFilesystemName("sg_file2");
			String oriName3 = mr.getOriginalFileName("sg_file3");
			String reName3 = mr.getFilesystemName("sg_file3");
			int userNo = Integer.parseInt(mr.getParameter("user_no"));

			Suggestion sg = new Suggestion();
		      sg.setSg_title(title);
		      sg.setSg_content(content);
		      sg.setOri_img1(oriName1);
		      sg.setNew_img1(reName1);
		      sg.setOri_img2(oriName2);
		      sg.setNew_img2(reName2);
		      sg.setOri_img3(oriName3);
		      sg.setNew_img3(reName3);
		      sg.setUser_no(userNo);

		      int result = new SgMemDao().createSg(sg);
		      
		      if(result > 0) {
		       
		         response.sendRedirect(request.getContextPath() + "/member/sg/list");
		      }
			
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
