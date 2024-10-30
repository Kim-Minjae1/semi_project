package com.book.admin.book.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.book.admin.book.vo.Book;

import static com.book.common.sql.JDBCTemplate.*;

public class BookDao {

    public int createBook(Book bk) {
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int result = 0;

        try {
            conn.setAutoCommit(false);
            String sql = "SELECT COUNT(*) FROM book WHERE books_title =? AND books_author =? AND books_publisher_name = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, bk.getBooks_title());
            pstmt.setString(2, bk.getBooks_author());
            pstmt.setString(3, bk.getBooks_publisher_name());
            rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt(1);

            if (count > 0) {
               
                result = 0;
            } else {
                String sql2 = "INSERT INTO `book`(`books_title`, `books_author` , `books_category_no`, `books_publisher_name`, `books_img`) VALUES(?,?,?,?,?)";
                pstmt = conn.prepareStatement(sql2);
                pstmt.setString(1, bk.getBooks_title());
                pstmt.setString(2, bk.getBooks_author());
                pstmt.setInt(3, bk.getBooks_category_no());
                pstmt.setString(4, bk.getBooks_publisher_name());
                pstmt.setString(5, bk.getBooks_image());
                result = pstmt.executeUpdate();
                
            }


            conn.commit();
        } catch (Exception e) {
            if (conn != null) {
                rollback(conn);
            }
            e.printStackTrace();
        } finally {
            try {
                close(rs);
               close(pstmt);
                if (conn != null) conn.close();
            } catch (SQLException e2) {
                e2.printStackTrace();
            }
        }
       return result;
    }

    public List<Map<String, String>> selectBook(Book b, String content) {
        List<Map<String, String>> list = new ArrayList<>();
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try{

            String sql = "SELECT a.books_no AS 도서번호, a.books_title AS 도서이름, a.books_author AS 도서저자, a.books_publisher_name AS 출판사, a.books_img AS 도서이미지, b.book_category_name AS 카테고리 FROM book a \n" +
                    "JOIN book_category b ON a.books_category_no = b.books_category_no";

            if(content != null) {
                sql += " WHERE a.books_title LIKE CONCAT('%','"+content+"','%')";
            }
            sql += " ORDER BY a.books_title ASC";
            sql += " LIMIT "+b.getLimitPageNo()+", "+b.getNumPerPage();

            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while(rs.next()){
                Map<String, String> row = new HashMap<>();
                row.put("books_no", rs.getString("도서번호"));
                row.put("books_title", rs.getString("도서이름"));
                row.put("books_author", rs.getString("도서저자"));
                row.put("books_publisher_name", rs.getString("출판사"));
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
    public List<Map<String, String>> checkInfo(String id) {
        List<Map<String, String>> list = new ArrayList<>();
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int book_no = Integer.parseInt(id);


        try{

            String sql = "SELECT a.books_no AS 도서번호, a.books_title AS 도서이름, a.books_author AS 도서저자, a.books_publisher_name AS 출판사, a.books_img AS 도서이미지, b.book_category_name AS 카테고리 FROM book a \n" +
                    "JOIN book_category b ON a.books_category_no = b.books_category_no WHERE a.books_no =?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,book_no);
            rs = pstmt.executeQuery();

            while(rs.next()){
                Map<String, String> row = new HashMap<>();
                row.put("books_no", rs.getString("도서번호"));
                row.put("books_title", rs.getString("도서이름"));
                row.put("books_author", rs.getString("도서저자"));
                row.put("books_publisher_name", rs.getString("출판사"));
                row.put("books_img", rs.getString("도서이미지"));
                row.put("books_category", rs.getString("카테고리"));

                list.add(row);

            }
        }catch (Exception e){
            e.printStackTrace();
        }


        return list;
    }
    
    public int editBook(Book bk) {
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        int result = 0;
        try {
           String sql = "UPDATE `book` SET books_img = ?, books_title = ?, books_author =? , books_category_no = ?, books_publisher_name = ? WHERE books_no = ?";
			
			 pstmt = conn.prepareStatement(sql); pstmt.setString(1, bk.getBooks_image());
			 pstmt.setString(2, bk.getBooks_title()); 
			 pstmt.setString(3, bk.getBooks_author()); 
			 pstmt.setInt(4, bk.getBooks_category_no());
			 pstmt.setString(5, bk.getBooks_publisher_name());
			 pstmt.setInt(6, bk.getBooks_no());
			 
           result = pstmt.executeUpdate();

        } catch (Exception e) {
           e.printStackTrace();
        } finally {
           close(pstmt);
           close(conn);
        }
        return result;
     }
    
    public  List<Map<String, String>> checkBook(int book_no){

        List<Map<String, String>> list = new ArrayList<>();
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;


        try{
            String sql = "SELECT a.books_no AS 도서번호, a.books_title AS 도서이름,"
            		+ " a.books_img AS 이미지, a.books_author AS 저자, a.books_publisher_name AS 출판사,a.books_category_no AS 카테고리번호, b.book_category_name AS 카테고리이름 FROM `book` a \n" +
                    "INNER JOIN book_category b ON a.books_category_no = b.books_category_no WHERE a.books_no = ?";


            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, book_no);  // Use parameter to filter by book_no
            rs = pstmt.executeQuery();
            
            while(rs.next()){

                Map<String, String> row = new HashMap<>();
                row.put("books_no", rs.getString("도서번호"));
                row.put("books_title", rs.getString("도서이름"));
                row.put("books_img", rs.getString("이미지"));
                row.put("books_author", rs.getString("저자"));
                row.put("books_publisher_name", rs.getString("출판사"));
                row.put("books_category_no", rs.getString("카테고리번호"));
                row.put("book_category_name", rs.getString("카테고리이름"));

                list.add(row);

            }
        }catch (Exception e){
            e.printStackTrace();

        }


    return list;
    }
    public int deleteBook(int book_no) {
    	  Connection conn = getConnection();
          PreparedStatement pstmt = null;
          int result = 0;
          try {
             String sql = "DELETE FROM book WHERE books_no =?";
  			
  			 pstmt = conn.prepareStatement(sql); 
  			 pstmt.setInt(1, book_no);
  			 
             result = pstmt.executeUpdate();

          } catch (Exception e) {
             e.printStackTrace();
          } finally {
             close(pstmt);
             close(conn);
          }
          return result;
    }
}