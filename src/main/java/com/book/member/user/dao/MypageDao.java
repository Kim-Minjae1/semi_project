package com.book.member.user.dao;

import static com.book.common.sql.JDBCTemplate.getConnection;
import static com.book.common.sql.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.book.member.user.vo.User;

public class MypageDao {

    public int eventCount(int userNo) {
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int result = 0;

        try {
            String sql = "SELECT COUNT(event_no) AS 'evCount' FROM participates "
                    + "WHERE user_no = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userNo);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                result = rs.getInt("evCount");
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
            close(conn);
        }
        return result;
    }

    public int btCount(int userNo) {
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int result = 0;

        try {
            String sql = "SELECT COUNT(booktext_no) AS 'btCount' FROM booktext "
                    + "WHERE user_no = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userNo);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                result = rs.getInt("btCount");
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
            close(conn);
        }
        return result;
    }
    public int sgCount(int userNo) {
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int result = 0;

        try {
            String sql = "SELECT COUNT(sg_no) AS 'sgCount' FROM suggestion "
                    + "WHERE user_no = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userNo);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                result = rs.getInt("sgCount");
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
            close(conn);
        }
        return result;
    }
}