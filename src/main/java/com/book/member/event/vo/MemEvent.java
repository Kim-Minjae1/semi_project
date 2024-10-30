package com.book.member.event.vo;

import com.book.common.Paging;

public class MemEvent extends Paging{
    private int eventNo;
    private String evTitle;
    private String evContent;
    private String evRegdate;
    private int evForm;
    private int evCategoryName; 
    private int evProgress;
    private int evStart;
    private int evEnd;
    private int eventQuota;
    private int userNo;
	
	public MemEvent() {
		super(); 
	}

	public MemEvent(int eventNo, String evTitle, String evContent, String evRegdate, int evForm, int evCategoryName,
			int evProgress, int evStart, int evEnd, int eventQuota, int userNo) {
		super();
		this.eventNo = eventNo;
		this.evTitle = evTitle;
		this.evContent = evContent;
		this.evRegdate = evRegdate;
		this.evForm = evForm;
		this.evCategoryName = evCategoryName; 
		this.evProgress = evProgress;
		this.evStart = evStart;
		this.evEnd = evEnd;
		this.eventQuota = eventQuota;
		this.userNo = userNo;
	}

	public int getEventNo() {
		return eventNo;
	}

	public String getEvTitle() {
		return evTitle;
	}

	public String getEvContent() {
		return evContent;
	}

	public String getEvRegdate() {
		return evRegdate;
	}

	public int getEvForm() {
		return evForm;
	}

	public int getEvCategoryName() {
		return evCategoryName;
	} 

	public int getEvProgress() {
		return evProgress;
	}

	public int getEvStart() {
		return evStart;
	}

	public int getEvEnd() {
		return evEnd;
	}

	public int getEventQuota() {
		return eventQuota;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setEventNo(int eventNo) {
		this.eventNo = eventNo;
	}

	public void setEvTitle(String evTitle) {
		this.evTitle = evTitle;
	}

	public void setEvContent(String evContent) {
		this.evContent = evContent;
	}

	public void setEvRegdate(String evRegdate) {
		this.evRegdate = evRegdate;
	}

	public void setEvForm(int evForm) {
		this.evForm = evForm;
	}

	public void setEvCategoryName(int evCategoryName) {
		this.evCategoryName = evCategoryName;
	} 

	public void setEvProgress(int evProgress) {
		this.evProgress = evProgress;
	}

	public void setEvStart(int evStart) {
		this.evStart = evStart;
	}

	public void setEvEnd(int evEnd) {
		this.evEnd = evEnd;
	}

	public void setEventQuota(int eventQuota) {
		this.eventQuota = eventQuota;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	@Override
	public String toString() {
		return "MemEvent [eventNo=" + eventNo + ", evTitle=" + evTitle + ", evContent=" + evContent + ", evRegdate="
				+ evRegdate + ", evForm=" + evForm + ", evCategoryName=" + evCategoryName + ", evProgress=" + evProgress
				+ ", evStart=" + evStart + ", evEnd=" + evEnd + ", eventQuota=" + eventQuota + ", userNo=" + userNo
				+ "]";
	}
 
}

