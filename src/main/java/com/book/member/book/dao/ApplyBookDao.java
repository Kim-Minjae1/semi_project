package com.book.member.book.dao;

import com.book.admin.book.vo.ApplyBook;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.book.common.sql.JDBCTemplate.getConnection;

public class ApplyBookDao {
    public int inputApply(ApplyBook ab){

        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection conn = getConnection();
        int result = 0;
        try{


            conn.setAutoCommit(false);


            String sql = "SELECT COUNT(*) FROM book WHERE books_title =? AND books_author =? AND books_publisher_name = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, ab.getApply_bk_title());
            pstmt.setString(2, ab.getApply_bk_author());
            pstmt.setString(3, ab.getApply_bk_publisher());
            rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt(1);

            if (count > 0) {
               
                result = 0;
            } else {
                String sql2 = "SELECT COUNT(*) FROM book_apply WHERE apply_bk_title =? AND apply_bk_author =? AND apply_bk_publisher = ?";
                pstmt = conn.prepareStatement(sql2);
                pstmt.setString(1, ab.getApply_bk_title());
                pstmt.setString(2, ab.getApply_bk_author());
                pstmt.setString(3, ab.getApply_bk_publisher());
                rs = pstmt.executeQuery();
                rs.next();
                int count2 = rs.getInt(1);

                if (count2 > 0) {
                   
                    result = 0;

                }else {
                    String sql3 = "INSERT INTO book_apply (apply_bk_title, apply_bk_author, apply_bk_publisher, user_no) VALUES (?,?,?, ?)";
                    pstmt = conn.prepareStatement(sql3);
                    pstmt.setString(1, ab.getApply_bk_title());
                    pstmt.setString(2, ab.getApply_bk_author());
                    pstmt.setString(3, ab.getApply_bk_publisher());
                    pstmt.setInt(4, ab.getAp_user_no());
                    result = pstmt.executeUpdate();

                }
            }
            conn.commit();
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException e2) {
                    e2.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            try {
                rs.close();
                pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e2) {
                e2.printStackTrace();
            }
        }

        return result;

    }
    public List<Map<String, String>> selectApplyList(ApplyBook ab, String title) {

        List<Map<String, String>> list = new ArrayList<>();
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try{

            String sql = "SELECT a.apply_no AS 신청번호, a.apply_bk_status AS 상태, a.apply_bk_title AS 도서이름, a.apply_bk_author AS 저자, a.apply_bk_publisher AS 출판사, " +
                    "b.user_nickname AS 사용자 FROM book_apply a " +
                    "JOIN users b ON a.user_no = b.user_no";

            if(title != null) {
                sql += " WHERE a.apply_bk_title LIKE CONCAT('%','"+title+"','%')";
            }
            sql += " ORDER BY CASE WHEN a.apply_bk_status = '0' THEN 0 ELSE 1 END, a.apply_bk_status";
            sql += " LIMIT "+ab.getLimitPageNo()+", "+ab.getNumPerPage();

            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while(rs.next()){
                Map<String, String> row = new HashMap<>();
                row.put("apply_no", rs.getString("신청번호"));
                row.put("apply_bk_title", rs.getString("도서이름"));
                row.put("apply_bk_author", rs.getString("저자"));
                row.put("apply_bk_publisher", rs.getString("출판사"));
                row.put("user_nickname", rs.getString("사용자"));
                row.put("apply_bk_status", rs.getString("상태"));
                list.add(row);

            }
        }catch (Exception e){
            e.printStackTrace();
        }


        return list;
    }

    public int selectBoardCount(ApplyBook option, String title) {
        int result = 0;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection conn = getConnection();
        try {

            String sql = "SELECT COUNT(*) AS cnt FROM book_apply";
            if(title != null) {
                sql += " WHERE apply_bk_title LIKE CONCAT('%','"+title+"','%')";
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

    public int updateApplyStatus(int applyNo, int status){
        int result = 0;
        Connection conn = getConnection();
        PreparedStatement pstmt = null;

        try {

            String sql = "UPDATE book_apply SET apply_bk_status = ? WHERE apply_no = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, status);
            pstmt.setInt(2, applyNo);

           result = pstmt.executeUpdate();


        }catch(Exception e) {
            e.printStackTrace();

        }
        return result;
    }

}