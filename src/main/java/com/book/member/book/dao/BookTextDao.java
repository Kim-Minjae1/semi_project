package com.book.member.book.dao;

import com.book.member.book.vo.BookText;

import javax.xml.transform.Result;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.book.common.sql.JDBCTemplate.getConnection;

public class BookTextDao {

    public int inputBookText(BookText bt){
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        int result = 0;
        try{
            String sql = "INSERT INTO `booktext` (book_first_read, book_end_read, book_content, recommendation_no, books_no, user_no) " +
                    "VALUES (?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, Date.valueOf(bt.getBook_first_read()));
            pstmt.setDate(2, Date.valueOf(bt.getBook_end_read()));
            pstmt.setString(3,bt.getBook_content());
            pstmt.setInt(4, bt.getRecommendation_no());
            pstmt.setInt(5, bt.getBook_no());
            pstmt.setInt(6, bt.getUser_no());

            result =pstmt.executeUpdate();



        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public  List<Map<String, String>> selectBooktext(BookText bt, String content, String recommendation) {

        List<Map<String, String>> list = new ArrayList<>();
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;


        try{
            String sql = "SELECT a.booktext_no AS 독후감번호,b.user_nickname AS 작성자 ,d.books_img AS 책이미지, d.books_title AS 책제목, c.description AS 추천도 ,a.upload_text AS 업로드 FROM `booktext` a \n" +
                    "INNER JOIN users b ON a.user_no = b.user_no \n" +
                    "JOIN recommendation c ON a.recommendation_no = c.recommendation_no\n" +
                    "JOIN book d ON d.books_no = a.books_no";

            if(content != null) {
                sql += " WHERE d.books_title LIKE CONCAT('%','"+content+"','%')";
            }

            if (recommendation != null && !recommendation.isEmpty() && !"0".equals(recommendation)) {
                sql += " AND c.recommendation_no = '"+recommendation+"'";

            }
            sql += " LIMIT "+bt.getLimitPageNo()+", "+ bt.getNumPerPage();


            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            while(rs.next()){
                Timestamp upload = rs.getTimestamp("업로드");

                Map<String, String> row = new HashMap<>();
                row.put("bt_no", rs.getString("독후감번호"));
                row.put("bt_writer", rs.getString("작성자"));
                row.put("bk_title", rs.getString("책제목"));
                row.put("recommendation", rs.getString("추천도"));
                row.put("bk_img", rs.getString("책이미지"));
                row.put("upload", sdf.format(upload) );

                list.add(row);

            }
        }catch (Exception e){
            e.printStackTrace();

        }


    return list;
    }
    public  List<Map<String, String>> selectSaveText(int userNo, BookText bt, String content, String recommendation) {

        List<Map<String, String>> list = new ArrayList<>();
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;


        try{
            String sql = "SELECT a.save_no AS 저장번호, b.user_nickname AS 작성자 ,d.books_img AS 책이미지," +
                    " d.books_title AS 책제목, c.description AS 추천도 ,a.upload_save AS 업로드 ," +
                    "d.books_publisher_name AS 출판사 FROM `saveBooktext` a \n" +
                    "JOIN users b ON a.user_no = b.user_no \n" +
                    "JOIN recommendation c ON a.recommendation_no = c.recommendation_no\n" +
                    "JOIN book d ON d.books_no = a.books_no WHERE a.user_no = ? AND upload_save >= ?";

            if(content != null) {
                sql += " AND d.books_title LIKE CONCAT('%','"+content+"','%')";
            }
           
            if (recommendation != null && !recommendation.isEmpty() && !"0".equals(recommendation)) {
                sql += " AND c.recommendation_no = '"+recommendation+"'";

            }
            sql += " LIMIT "+bt.getLimitPageNo()+", "+bt.getNumPerPage();


            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,userNo);
            pstmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now().minusDays(7)));
            rs = pstmt.executeQuery();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            while(rs.next()){
                Timestamp upload = rs.getTimestamp("업로드");

                Map<String, String> row = new HashMap<>();
                row.put("save_no", rs.getString("저장번호"));
                row.put("bt_writer", rs.getString("작성자"));
                row.put("bk_title", rs.getString("책제목"));
                row.put("bk_publisher_name", rs.getString("출판사"));
                row.put("bk_img", rs.getString("책이미지"));
                row.put("upload", sdf.format(upload) );

                list.add(row);

            }
        }catch (Exception e){
            e.printStackTrace();

        }
        return list;
    }
    public  List<Map<String, String>> detailBookText(int bt_no) {

        List<Map<String, String>> list = new ArrayList<>();
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT a.book_first_read AS 읽기시작, a.booktext_no AS 독후감번호, a.book_end_read AS 읽기종료, a.book_content AS 독후감내용,  c.description AS 추천도, d.books_title AS 도서제목, b.user_nickname AS 작성자,e.book_category_name AS 카테고리명, e.books_category_no AS 카테고리번호, d.books_img AS 이미지, d.books_publisher_name AS 출판사, b.user_no AS 사용자번호 FROM booktext a\n" +
                    "JOIN users b ON a.user_no = b.user_no \n" +
                    "JOIN recommendation c ON a.recommendation_no = c.recommendation_no\n" +
                    "JOIN book d ON d.books_no = a.books_no " +
                    "JOIN book_category e ON e.books_category_no = d.books_category_no WHERE a.booktext_no = ? ;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,bt_no);
            rs = pstmt.executeQuery();

            while(rs.next()){

                Map<String, String> row = new HashMap<>();
                row.put("bt_start", rs.getString("읽기시작"));
                row.put("bt_end", rs.getString("읽기종료"));
                row.put("bt_content", rs.getString("독후감내용"));
                row.put("bk_title", rs.getString("도서제목"));
                row.put("recommendation", rs.getString("추천도"));
                row.put("bt_writer", rs.getString("작성자"));
                row.put("bk_img", rs.getString("이미지"));
                row.put("bk_cate", rs.getString("카테고리명"));
                row.put("bk_publisher", rs.getString("출판사"));
                row.put("user_no",rs.getString("사용자번호"));
                row.put("bt_no",rs.getString("독후감번호"));
                row.put("bk_cate_no",rs.getString("카테고리번호"));
                list.add(row);


            }
        }catch (Exception e){
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
    return list;
    }

    public int selectBoardCount(BookText option, String content, String recommendation) {
        int result = 0;
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {

            String sql = "SELECT COUNT(*) AS cnt FROM booktext a JOIN book b ON a.books_no = b.books_no ";
            if(content != null) {
                sql += " WHERE b.books_title LIKE CONCAT('%','"+content+"','%')";
            }
            // 추천도가 선택된 경우 SQL에 조건을 추가합니다.
            if (recommendation != null && !recommendation.isEmpty() && !"0".equals(recommendation)) {
                sql += " AND a.recommendation_no = '"+recommendation+"'";
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

    public  List<Map<String, String>> userBooktext(BookText bt, String content, String recommendation, int user_no) {

        List<Map<String, String>> list = new ArrayList<>();
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;


        try{
            String sql = "SELECT a.booktext_no AS 독후감번호,b.user_nickname AS 작성자 ,d.books_img AS 책이미지, d.books_title AS 책제목, c.description AS 추천도 ,a.upload_text AS 업로드 FROM `booktext` a \n" +
                    "JOIN users b ON a.user_no = b.user_no \n" +
                    "JOIN recommendation c ON a.recommendation_no = c.recommendation_no\n" +
                    "JOIN book d ON d.books_no = a.books_no WHERE b.user_no = ?";

            if(content != null) {
                sql += " AND d.books_title LIKE CONCAT('%','"+content+"','%')";
            }
            // 추천도가 선택된 경우 SQL에 조건을 추가합니다.
            if (recommendation != null && !recommendation.isEmpty() && !"0".equals(recommendation)) {
                sql += " AND c.recommendation_no = '"+recommendation+"'";

            }
            sql += " LIMIT "+bt.getLimitPageNo()+", "+ bt.getNumPerPage();


            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,user_no);
            rs = pstmt.executeQuery();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            while(rs.next()){
                Timestamp upload = rs.getTimestamp("업로드");

                Map<String, String> row = new HashMap<>();
                row.put("bt_no", rs.getString("독후감번호"));
                row.put("bt_writer", rs.getString("작성자"));
                row.put("bk_title", rs.getString("책제목"));
                row.put("recommendation", rs.getString("추천도"));
                row.put("bk_img", rs.getString("책이미지"));
                row.put("upload", sdf.format(upload) );

                list.add(row);

            }
        }catch (Exception e){
            e.printStackTrace();
        }


        return list;
    }
    public int userBooktextCount(BookText option, String content, String recommendation, int user_no) {
        int result = 0;
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {

            String sql = "SELECT COUNT(*) AS cnt FROM booktext a JOIN book b ON a.books_no = b.books_no WHERE a.user_no = ?";
            if(content != null) {
                sql += " AND b.books_title LIKE CONCAT('%','"+content+"','%')";
            }
            // 추천도가 선택된 경우 SQL에 조건을 추가합니다.
            if (recommendation != null && !recommendation.isEmpty() && !"0".equals(recommendation)) {
                sql += " AND a.recommendation_no = '"+recommendation+"'";
            }

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,user_no);
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
    public int saveBooktextCount(int userNo,BookText option, String content, String recommendation) {
        int result = 0;
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {

            String sql = "SELECT COUNT(*) AS cnt FROM saveBooktext a JOIN book b ON a.books_no = b.books_no " +
                    "WHERE a.user_no =? ";
            if(content != null) {
                sql += "AND b.books_title LIKE CONCAT('%','"+content+"','%')";
            }
            // 추천도가 선택된 경우 SQL에 조건을 추가합니다.
            if (recommendation != null && !recommendation.isEmpty() && !"0".equals(recommendation)) {
                sql += " AND a.recommendation_no = '"+recommendation+"'";
            }

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userNo);
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

    public int updateInfo(BookText bt) {

        int result = 0;
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        try {

            String sql = "UPDATE booktext SET book_content = ?, recommendation_no = ?,book_first_read= ?, book_end_read = ? WHERE booktext_no = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,bt.getBook_content());
            pstmt.setInt(2,bt.getRecommendation_no());
            pstmt.setDate(3, Date.valueOf(bt.getBook_first_read()));
            pstmt.setDate(4, Date.valueOf(bt.getBook_end_read()));
            pstmt.setInt(5, bt.getBooktext_no());
            result= pstmt.executeUpdate();


        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            try {
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;

    }

    public List<Map<String, String>> checkInfo(String id){

        List<Map<String, String>> list = new ArrayList<>();
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;


        try{
            String sql = "SELECT a.book_first_read AS 읽기시작, a.booktext_no AS 독후감번호, " +
                    "a.book_end_read AS 읽기종료, a.book_content AS 독후감내용,  c.description AS 추천도, c.recommendation_no AS 추천도번호, " +
                    "d.books_title AS 도서제목, b.user_name AS 작성자,e.book_category_name AS 카테고리명, " +
                    "e.books_category_no AS 카테고리번호, d.books_img AS 이미지, d.books_publisher_name AS 출판사, " +
                    "b.user_no AS 사용자번호, d.books_author AS 저자 FROM booktext a\n" +
                    "JOIN users b ON a.user_no = b.user_no \n" +
                    "JOIN recommendation c ON a.recommendation_no = c.recommendation_no\n" +
                    "JOIN book d ON d.books_no = a.books_no " +
                    "JOIN book_category e ON e.books_category_no = d.books_category_no WHERE a.booktext_no = ? ;";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,Integer.parseInt(id));
            rs = pstmt.executeQuery();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            while(rs.next()){
                Timestamp start = rs.getTimestamp("읽기시작");
                Timestamp end = rs.getTimestamp("읽기종료");
                
                Map<String, String> row = new HashMap<>();
                row.put("bt_no", rs.getString("독후감번호"));
                row.put("bk_title", rs.getString("도서제목"));
                row.put("bk_recommendation", rs.getString("추천도"));
                row.put("recommendation_no", rs.getString("추천도번호"));
                row.put("bk_category", rs.getString("카테고리명"));
                row.put("books_category_no", String.valueOf(rs.getInt("카테고리번호")));
                row.put("bk_publisher_name", rs.getString("출판사"));
                row.put("bk_author", rs.getString("저자"));
                row.put("bw_start_date", sdf.format(start) );
                row.put("bw_end_date", sdf.format(end) );
                row.put("bw_content", rs.getString("독후감내용"));
                row.put("bk_img", rs.getString("이미지"));
                list.add(row);

            }
        }catch (Exception e){
            e.printStackTrace();
        }


        return list;
    }
    public int deleteBooktext(String bt_no){
        int booktext_no = Integer.parseInt(bt_no);
        int result = 0;
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        try{
            String sql = "DELETE FROM booktext WHERE booktext_no = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,booktext_no);
            result = pstmt.executeUpdate();

        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

    public int inputSaveBookText(BookText bt) {
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        int result = 0;
        try{
            String sql = "INSERT INTO `saveBooktext` (save_first_read, save_end_read, save_content, recommendation_no, books_no, user_no) " +
                    "VALUES (?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, Date.valueOf(bt.getBook_first_read()));
            pstmt.setDate(2, Date.valueOf(bt.getBook_end_read()));
            pstmt.setString(3, bt.getBook_content() != null ? bt.getBook_content() : "");
            pstmt.setInt(4, bt.getRecommendation_no());
            pstmt.setInt(5, bt.getBook_no());
            pstmt.setInt(6, bt.getUser_no());

            result =pstmt.executeUpdate();




        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    public List<Map<String, String>> checkSave(String no){

        List<Map<String, String>> list = new ArrayList<>();
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;


        try{
            String sql = "SELECT a.user_no AS 사용자번호, a.books_no AS 도서번호, a.save_first_read AS 읽기시작, a.save_no AS 저장번호, " +
                    "a.save_end_read AS 읽기종료, a.save_content AS 저장내용,  c.description AS 추천도, c.recommendation_no AS 추천도번호, " +
                    "d.books_title AS 도서제목, b.user_nickname AS 작성자,e.book_category_name AS 카테고리명, " +
                    "e.books_category_no AS 카테고리번호, d.books_img AS 이미지, d.books_publisher_name AS 출판사, " +
                    "b.user_no AS 사용자번호, d.books_author AS 저자 FROM saveBooktext a\n" +
                    "JOIN users b ON a.user_no = b.user_no \n" +
                    "JOIN recommendation c ON a.recommendation_no = c.recommendation_no\n" +
                    "JOIN book d ON d.books_no = a.books_no " +
                    "JOIN book_category e ON e.books_category_no = d.books_category_no WHERE a.save_no = ? ;";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,Integer.parseInt(no));
            rs = pstmt.executeQuery();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            while(rs.next()){
                Timestamp start = rs.getTimestamp("읽기시작");
                Timestamp end = rs.getTimestamp("읽기종료");
                Map<String, String> row = new HashMap<>();
                row.put("save_no", rs.getString("저장번호"));
                row.put("bk_title", rs.getString("도서제목"));
                row.put("bk_recommendation", rs.getString("추천도"));
                row.put("recommendation_no", rs.getString("추천도번호"));
                row.put("bk_category", rs.getString("카테고리명"));
                row.put("books_category_no", String.valueOf(rs.getInt("카테고리번호")));
                row.put("bk_publisher_name", rs.getString("출판사"));
                row.put("bk_author", rs.getString("저자"));
                row.put("bw_start_date", sdf.format(start) );
                row.put("bw_end_date", sdf.format(end) );
                row.put("bw_content", rs.getString("저장내용"));
                row.put("bk_img", rs.getString("이미지"));
                row.put("bk_no", rs.getString("도서번호")); 
                row.put("user_no", rs.getString("사용자번호"));
                list.add(row);

            }
        }catch (Exception e){
            e.printStackTrace();
        }


        return list;
    }
    public int updateSaveInfo(int save_no ,BookText bt) {
        int result = 0;
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        try {

            String sql = "UPDATE saveBookText SET save_content = ?, recommendation_no = ?,save_first_read= ?, save_end_read = ? WHERE save_no = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, bt.getBook_content());
            pstmt.setInt(2, bt.getRecommendation_no());
            pstmt.setDate(3, Date.valueOf(bt.getBook_first_read()));
            pstmt.setDate(4, Date.valueOf(bt.getBook_end_read()));
            pstmt.setInt(5, save_no);
            result = pstmt.executeUpdate();


        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }
    public int deleteSaveInfo(int saveNo){
        int result = 0;
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        try{
            String sql = "DELETE FROM saveBooktext WHERE save_no = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,saveNo);
            result = pstmt.executeUpdate();

        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }
}
