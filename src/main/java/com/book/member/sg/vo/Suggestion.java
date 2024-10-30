package com.book.member.sg.vo;

import java.time.LocalDateTime;

import com.book.common.Paging;

public class Suggestion extends Paging{

	private int sg_no;
	private int user_no;
	private String sg_title;
	private String sg_content;
	private String ori_img1;
	private String new_img1;
	private String ori_img2;
	private String new_img2;
	private String ori_img3;
	private String new_img3;
	private LocalDateTime sg_reg_date;
	private LocalDateTime sg_mod_date;
	private int sg_status;

	public Suggestion() {
		super();
	}

	public Suggestion(int sg_no, int user_no, String sg_title, String sg_content, String ori_img1, String new_img1,
			String ori_img2, String new_img2, String ori_img3, String new_img3, LocalDateTime sg_reg_date,
			LocalDateTime sg_mod_date, int sg_status) {
		super();
		this.sg_no = sg_no;
		this.user_no = user_no;
		this.sg_title = sg_title;
		this.sg_content = sg_content;
		this.ori_img1 = ori_img1;
		this.new_img1 = new_img1;
		this.ori_img2 = ori_img2;
		this.new_img2 = new_img2;
		this.ori_img3 = ori_img3;
		this.new_img3 = new_img3;
		this.sg_reg_date = sg_reg_date;
		this.sg_mod_date = sg_mod_date;
		this.sg_status = sg_status;
	}

	public int getSg_no() {
		return sg_no;
	}

	public void setSg_no(int sg_no) {
		this.sg_no = sg_no;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getSg_title() {
		return sg_title;
	}

	public void setSg_title(String sg_title) {
		this.sg_title = sg_title;
	}

	public String getSg_content() {
		return sg_content;
	}

	public void setSg_content(String sg_content) {
		this.sg_content = sg_content;
	}

	public String getOri_img1() {
		return ori_img1;
	}

	public void setOri_img1(String ori_img1) {
		this.ori_img1 = ori_img1;
	}

	public String getNew_img1() {
		return new_img1;
	}

	public void setNew_img1(String new_img1) {
		this.new_img1 = new_img1;
	}

	public String getOri_img2() {
		return ori_img2;
	}

	public void setOri_img2(String ori_img2) {
		this.ori_img2 = ori_img2;
	}

	public String getNew_img2() {
		return new_img2;
	}

	public void setNew_img2(String new_img2) {
		this.new_img2 = new_img2;
	}

	public String getOri_img3() {
		return ori_img3;
	}

	public void setOri_img3(String ori_img3) {
		this.ori_img3 = ori_img3;
	}

	public String getNew_img3() {
		return new_img3;
	}

	public void setNew_img3(String new_img3) {
		this.new_img3 = new_img3;
	}

	public LocalDateTime getSg_reg_date() {
		return sg_reg_date;
	}

	public void setSg_reg_date(LocalDateTime sg_reg_date) {
		this.sg_reg_date = sg_reg_date;
	}

	public LocalDateTime getSg_mod_date() {
		return sg_mod_date;
	}

	public void setSg_mod_date(LocalDateTime sg_mod_date) {
		this.sg_mod_date = sg_mod_date;
	}

	public int getSg_status() {
		return sg_status;
	}

	public void setSg_status(int sg_status) {
		this.sg_status = sg_status;
	}
	

	@Override
	public String toString() {
		return sg_no + " || " + user_no + " || " + sg_title + " || " + sg_content + " || " + ori_img1 + " || " + new_img1
				+ " || " + ori_img2 + " || " + new_img2 + " || " + ori_img3 + " || " + new_img3 + " || " + sg_reg_date
				+ " || " + sg_mod_date + " || " + sg_status;
	}

}
