package com.book.member.book.vo;


public class Like {

    private int like_no;
    private int user_no;
    private int book_category_no;
    private int booktext_no;

    public Like() {

    }

    public Like(int like_no, int user_no, int book_category_no, int booktext_no) {
        super();
        this.like_no = like_no;
        this.user_no = user_no;
        this.book_category_no = book_category_no;
        this.booktext_no = booktext_no;
    }

    public int getLike_no() {
        return like_no;
    }

    public void setLike_no(int like_no) {
        this.like_no = like_no;
    }

    public int getUser_no() {
        return user_no;
    }

    public void setUser_no(int user_no) {
        this.user_no = user_no;
    }

    public int getBook_category_no() {
        return book_category_no;
    }

    public void setBook_category_no(int book_category_no) {
        this.book_category_no = book_category_no;
    }

    public int getBooktext_no() {
        return booktext_no;
    }

    public void setBooktext_no(int booktext_no) {
        this.booktext_no = booktext_no;
    }

    @Override
    public String toString() {
        return "Like{ like_no=" + like_no +
                ", user_no=" + user_no +
                ", book_category_no=" + book_category_no+
                ", booktext_no=" + booktext_no + "}";
    }


}