package com.book.admin.event.vo;

import com.book.common.Paging;

public class Event extends Paging{
	private int event_no;
	private int event_category; 
	private String ev_title;
	private String ev_content;
	private int ev_form;
	private String ev_regdate;
	private String ev_progress;
	private String ev_start;
	private String ev_end;
	private String ori_image;
	private String new_image; 
	private int event_quota;
	private String ev_category_name;
	private int event_registered;
	private int event_waiting;
	private int find_year;
	private int find_month;
	
	public Event() {
		super(); 
	}

	public Event(int event_no, int event_category, String ev_title, String ev_content, int ev_form, String ev_regdate,
			String ev_progress, String ev_start, String ev_end, String ori_image, String new_image, int event_quota,
			String ev_category_name, int event_registered, int event_waiting) {
		super();
		this.event_no = event_no;
		this.event_category = event_category;
		this.ev_title = ev_title;
		this.ev_content = ev_content;
		this.ev_form = ev_form;
		this.ev_regdate = ev_regdate;
		this.ev_progress = ev_progress;
		this.ev_start = ev_start;
		this.ev_end = ev_end;
		this.ori_image = ori_image;
		this.new_image = new_image;
		this.event_quota = event_quota;
		this.ev_category_name = ev_category_name;
		this.event_registered = event_registered;
		this.event_waiting = event_waiting;
	} 
	
	public Event(int event_no, int event_category, String ev_title, String ev_content, int ev_form, String ev_regdate,
			String ev_progress, String ev_start, String ev_end, String ori_image, String new_image, int event_quota,
			String ev_category_name, int event_registered, int event_waiting, int find_year, int find_month) {
		super();
		this.event_no = event_no;
		this.event_category = event_category;
		this.ev_title = ev_title;
		this.ev_content = ev_content;
		this.ev_form = ev_form;
		this.ev_regdate = ev_regdate;
		this.ev_progress = ev_progress;
		this.ev_start = ev_start;
		this.ev_end = ev_end;
		this.ori_image = ori_image;
		this.new_image = new_image;
		this.event_quota = event_quota;
		this.ev_category_name = ev_category_name;
		this.event_registered = event_registered;
		this.event_waiting = event_waiting;
		this.find_year = find_year;
		this.find_month = find_month;
	}

	public Event(int event_no, int event_category, String ev_title, String ev_content, int ev_form,
        String ev_progress, String ev_start, String ev_end, String ori_image, String new_image, int event_quota) {
		super();
		this.event_no = event_no;
		this.event_category = event_category;
		this.ev_title = ev_title;
		this.ev_content = ev_content;
		this.ev_form = ev_form;
		this.ev_progress = ev_progress;
		this.ev_start = ev_start;
		this.ev_end = ev_end;
		this.ori_image = ori_image;
		this.new_image = new_image;
		this.event_quota = event_quota;
		this.ev_category_name = null;
		this.event_registered = 0;
		this.event_waiting = 0;
	}
	public int getEvent_no() {
		return event_no;
	}

	public int getEvent_category() {
		return event_category;
	}

	public String getEv_title() {
		return ev_title;
	}

	public String getEv_content() {
		return ev_content;
	}

	public int getEv_form() {
		return ev_form;
	}

	public String getEv_regdate() {
		return ev_regdate;
	}

	public String getEv_progress() {
		return ev_progress;
	}

	public String getEv_start() {
		return ev_start;
	}

	public String getEv_end() {
		return ev_end;
	}

	public String getOri_image() {
		return ori_image;
	}

	public String getNew_image() {
		return new_image;
	}

	public int getEvent_quota() {
		return event_quota;
	}

	public String getEv_category_name() {
		return ev_category_name;
	}

	public int getEvent_registered() {
		return event_registered;
	}

	public int getEvent_waiting() {
		return event_waiting;
	}

	public void setEvent_no(int event_no) {
		this.event_no = event_no;
	}

	public void setEvent_category(int event_category) {
		this.event_category = event_category;
	}

	public void setEv_title(String ev_title) {
		this.ev_title = ev_title;
	}

	public void setEv_content(String ev_content) {
		this.ev_content = ev_content;
	}

	public void setEv_form(int ev_form) {
		this.ev_form = ev_form;
	}

	public void setEv_regdate(String ev_regdate) {
		this.ev_regdate = ev_regdate;
	}

	public void setEv_progress(String ev_progress) {
		this.ev_progress = ev_progress;
	}

	public void setEv_start(String ev_start) {
		this.ev_start = ev_start;
	}

	public void setEv_end(String ev_end) {
		this.ev_end = ev_end;
	}

	public void setOri_image(String ori_image) {
		this.ori_image = ori_image;
	}

	public void setNew_image(String new_image) {
		this.new_image = new_image;
	}

	public void setEvent_quota(int event_quota) {
		this.event_quota = event_quota;
	}

	public void setEv_category_name(String ev_category_name) {
		this.ev_category_name = ev_category_name;
	}

	public void setEvent_registered(int event_registered) {
		this.event_registered = event_registered;
	}

	public void setEvent_waiting(int event_waiting) {
		this.event_waiting = event_waiting;
	}

	public int getFind_year() {
		return find_year;
	}

	public int getFind_month() {
		return find_month;
	}

	public void setFind_year(int find_year) {
		this.find_year = find_year;
	}

	public void setFind_month(int find_month) {
		this.find_month = find_month;
	}

	@Override
	public String toString() {
		return "Event [event_no=" + event_no + ", event_category=" + event_category + ", ev_title=" + ev_title
				+ ", ev_content=" + ev_content + ", ev_form=" + ev_form + ", ev_regdate=" + ev_regdate
				+ ", ev_progress=" + ev_progress + ", ev_start=" + ev_start + ", ev_end=" + ev_end + ", ori_image="
				+ ori_image + ", new_image=" + new_image + ", event_quota=" + event_quota + ", ev_category_name="
				+ ev_category_name + ", event_registered=" + event_registered + ", event_waiting=" + event_waiting
				+ "]";
	}

	
}