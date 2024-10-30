package com.book.member.book.dao;

import com.book.admin.book.vo.Book;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.book.common.sql.JDBCTemplate.getConnection;

public class UserBookDao {
    public List<Map<String, String>> selectBookAll(Book b, String content){
        List<Map<String, String>> list = new ArrayList<>();
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int end = b.getNumPerPage();
        try{
            String sql = "SELECT a.books_no AS 도서번호, a.books_title AS 도서이름, a.books_author AS 도서저자, a.books_publisher_name AS 출판사, a.books_img AS 도서이미지, b.book_category_name AS 카테고리 FROM book a \n" +
                    "JOIN book_category b ON a.books_category_no = b.books_category_no";

            if(content != null) {
                sql += " WHERE a.books_title LIKE CONCAT('%','"+content+"','%')";
            }

            sql += " LIMIT "+b.getLimitPageNo()+", "+ b.getNumPerPage();

            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while(rs.next()){
                Map<String, String> row = new HashMap<>();
                row.put("books_no", rs.getString("도서번호"));
                row.put("books_title", rs.getString("도서이름"));
                row.put("books_author", rs.getString("도서저자"));
                row.put("books_publisher", rs.getString("출판사"));
                row.put("books_img", rs.getString("도서이미지"));
                row.put("books_category", rs.getString("카테고리"));

                list.add(row);

            }
        }catch (Exception e){
            e.printStackTrace();
        }


        return list;
    }


    public int selectBoardCount(Book option, String content) {
        int result = 0;
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT COUNT(*) AS cnt FROM book";
            if(content != null) {
                sql += " WHERE books_title LIKE CONCAT('%','"+content+"','%')";
            }


            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                result = rs.getInt("cnt");
            }
        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

}
