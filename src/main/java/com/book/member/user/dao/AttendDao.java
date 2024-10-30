package com.book.member.user.dao;


import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.book.member.user.vo.User;

public class AttendDao {

    public int attendUser(int userNo) {
        Connection conn = getConnection();
        PreparedStatement pstmt1 = null;
        PreparedStatement pstmt2 = null;
        ResultSet rs = null;
        int result = 0;
        try {
            String sql1 = "SELECT DATE_FORMAT(attend_date, '%Y-%m-%d') FROM attend " +
                    "WHERE user_no = ? AND " +
                    "DATE_FORMAT(attend_date, '%Y-%m-%d') = DATE_FORMAT(CURDATE(), '%Y-%m-%d')";
            pstmt1 = conn.prepareStatement(sql1);
            pstmt1.setInt(1, userNo);
            rs = pstmt1.executeQuery();
            if(rs.next()) {
            
                result = 1;
            } else {
             
                String sql2 = "INSERT INTO `attend`(user_no) VALUES(?)";
                pstmt2 = conn.prepareStatement(sql2);
                pstmt2.setInt(1, userNo);
                result = pstmt2.executeUpdate();
                result = 0;
            }
        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            close(rs);
            close(pstmt1);
            close(pstmt2);
            close(conn);
        }
        return result;
    }
    public int attendCount(int userNo) {
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int result = 0;
        try {
            String sql1 = "SELECT COUNT(*) AS attendCount FROM attend " +
                    "WHERE user_no = ?";
            pstmt = conn.prepareStatement(sql1);
            pstmt.setInt(1, userNo);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                result = rs.getInt("attendCount");
            }
        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            close(rs);
            close(pstmt);
            close(conn);
        }
        return result;
    }
    public String lastAttend(int userNo) {
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String result = null;
        try {
            String sql = "SELECT DATE_FORMAT(attend_date, '%Y-%m-%d') AS lastAt FROM attend " +
                    "WHERE user_no = ? ORDER BY attend_date DESC LIMIT 1, 1";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userNo);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                result = rs.getString("lastAt");
            }
        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            close(rs);
            close(pstmt);
            close(conn);
        }
        return result;
    }
}