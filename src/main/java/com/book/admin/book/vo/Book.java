package com.book.admin.book.vo;

import com.book.common.Paging;

public class Book extends Paging {

    private int books_no;
    private String books_title;
    private String books_author;
    private int books_category_no;
    private String books_publisher_name;
    private String books_image;

    public Book() {

    }
    public Book(String books_image, String books_publisher_name, int books_category_no, String books_title, String books_author, int books_no) {
        this.books_image = books_image;
        this.books_publisher_name = books_publisher_name;
        this.books_category_no = books_category_no;
        this.books_title = books_title;
        this.books_author = books_author;
        this.books_no = books_no;
    }

    public String getBooks_author() {
        return books_author;
    }

    public void setBooks_author(String books_author) {
        this.books_author = books_author;
    }

    public int getBooks_no() {
        return books_no;
    }

    public void setBooks_no(int books_no) {
        this.books_no = books_no;
    }

    public String getBooks_title() {
        return books_title;
    }

    public void setBooks_title(String books_title) {
        this.books_title = books_title;
    }

    public int getBooks_category_no() {
        return books_category_no;
    }

    public void setBooks_category_no(int books_category_no) {
        this.books_category_no = books_category_no;
    }

    public String getBooks_image() {
        return books_image;
    }

    public void setBooks_image(String books_image) {
        this.books_image = books_image;
    }

    public String getBooks_publisher_name() {
        return books_publisher_name;
    }

    public void setBooks_publisher_name(String books_publisher_name) {
        this.books_publisher_name = books_publisher_name;
    }

    @Override
    public String toString() {
        return "Book{" +
                "books_no=" + books_no +
                ", books_title='" + books_title + '\'' +
                ", books_author='" + books_author + '\'' +
                ", books_category_no=" + books_category_no +
                ", books_publisher_name='" + books_publisher_name + '\'' +
                ", books_image='" + books_image + '\'' +
                '}';
    }
}