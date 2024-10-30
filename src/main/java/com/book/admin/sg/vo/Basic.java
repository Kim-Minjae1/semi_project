package com.book.admin.sg.vo;

public class Basic {

	private int basic_no;
	private int user_no;
	private String basic_content;
	
	public Basic() {
		super();
	}

	public Basic(int basic_no, int user_no,String basic_content) {
		super();
		this.basic_no = basic_no;
		this.user_no = user_no;
		this.basic_content = basic_content;
	}

	public int getBasic_no() {
		return basic_no;
	}

	public void setBasic_no(int basic_no) {
		this.basic_no = basic_no;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getBasic_content() {
		return basic_content;
	}

	public void setBasic_content(String basic_content) {
		this.basic_content = basic_content;
	}

	@Override
	public String toString() {
		return basic_no + " || " + user_no + " || " +  basic_content;
	}
	
	
	
	
}
