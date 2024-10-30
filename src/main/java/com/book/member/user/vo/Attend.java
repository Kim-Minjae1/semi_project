package com.book.member.user.vo;


import java.time.LocalDate;

public class Attend {

    private int attend_no;
    private int user_no;
    private LocalDate attend_date;

    public Attend() {
        super();
    }

    public Attend(int attend_no, int user_no, LocalDate attend_date) {
        super();
        this.attend_no = attend_no;
        this.user_no = user_no;
        this.attend_date = attend_date;
    }

    public int getAttend_no() {
        return attend_no;
    }

    public void setAttend_no(int attend_no) {
        this.attend_no = attend_no;
    }

    public int getUser_no() {
        return user_no;
    }

    public void setUser_no(int user_no) {
        this.user_no = user_no;
    }

    public LocalDate getAttend_date() {
        return attend_date;
    }

    public void setAttend_date(LocalDate attend_date) {
        this.attend_date = attend_date;
    }

    @Override
    public String toString() {
        return "Attend [attend_no=" + attend_no + ", user_no=" + user_no + ", attend_date=" + attend_date + "]";
    }

}