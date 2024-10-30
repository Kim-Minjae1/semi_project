package com.book.admin.book.vo;

import com.book.common.Paging;

public class ApplyBook extends Paging {
    private int apply_no;
    private String apply_bk_title;
    private String apply_bk_author;
    private String apply_bk_publisher;
    private int ap_user_no;

    public ApplyBook() {

    }

    public ApplyBook(int apply_no, String apply_bk_title, String apply_bk_author, String apply_bk_publisher, int ap_user_no) {
        this.apply_no = apply_no;
        this.apply_bk_title = apply_bk_title;
        this.apply_bk_author = apply_bk_author;
        this.ap_user_no = ap_user_no;
        this.apply_bk_publisher = apply_bk_publisher;
    }

    public String getApply_bk_title() {
        return apply_bk_title;
    }

    public void setApply_bk_title(String apply_bk_title) {
        this.apply_bk_title = apply_bk_title;
    }

    public String getApply_bk_author() {
        return apply_bk_author;
    }

    public void setApply_bk_author(String apply_bk_author) {
        this.apply_bk_author = apply_bk_author;
    }

    public String getApply_bk_publisher() {
        return apply_bk_publisher;
    }

    public void setApply_bk_publisher(String apply_bk_publisher) {
        this.apply_bk_publisher = apply_bk_publisher;
    }

    public int getAp_user_no() {
        return ap_user_no;
    }

    public void setAp_user_no(int ap_user_no) {
        this.ap_user_no = ap_user_no;
    }

    public int getApply_no() {
        return apply_no;
    }

    public void setApply_no(int apply_no) {
        this.apply_no = apply_no;
    }

    @Override
    public String toString() {
        return "ApplyBook{" +
                "apply_no=" + apply_no +
                ", apply_bk_title='" + apply_bk_title + '\'' +
                ", apply_bk_author='" + apply_bk_author + '\'' +
                ", apply_bk_publisher='" + apply_bk_publisher + '\'' +
                ", ap_user_no=" + ap_user_no +
                '}';
    }
}
