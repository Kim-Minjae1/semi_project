package com.book.member.book.dao;


import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BookReplyDao {

    // 독후감 게시물 댓글 조회
    public List<Map<String, String>> bkReplySelectList(int bt_no){
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Map<String, String>> list = new ArrayList<>();
        try {
            conn = getConnection();
            String sql = "SELECT br.bk_reply_no AS `댓글번호`, br.bk_reply_content AS `댓글내용`, "
                    + "u.user_nickname AS `유저닉네임`, br.user_no AS `댓글작성자번호`, "
                    + "br.is_deleted AS `삭제여부`, br.bk_parent_no AS `부모자식`, "
                    + "br.bk_reg_date AS `등록일`, br.bk_mod_date AS `수정일` "
                    + "FROM booktext_reply br "
                    + "JOIN users u ON br.user_no = u.user_no "
                    + "WHERE br.booktext_no = ? "
                    + "GROUP BY br.bk_reply_no "
                    + "ORDER BY IF(br.bk_parent_no = 0, br.bk_reply_no, br.bk_parent_no), br.bk_reg_date";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bt_no);
            rs = pstmt.executeQuery();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            while(rs.next()) {
                Timestamp btRegDate = rs.getTimestamp("등록일");
                Timestamp btModDate = rs.getTimestamp("수정일");
                Map<String, String> bre = new HashMap<>();
                bre.put("br_no", rs.getString("댓글번호"));
                bre.put("br_userNickName", rs.getString("유저닉네임"));
                bre.put("br_content", rs.getString("댓글내용"));
                bre.put("br_user_no", rs.getString("댓글작성자번호"));
                bre.put("br_delete", rs.getString("삭제여부"));
                bre.put("br_parent",rs.getString("부모자식"));

                bre.put("br_regDate", sdf.format(btRegDate));
                bre.put("br_modDate", sdf.format(btModDate));

                list.add(bre);

            }
        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            close(rs);
            close(pstmt);
            close(conn);
        }
        return list;
    }

    // 새로운 댓글 추가
    public int bkParentReplyAdd(int btUserNo, int btNo, String btReply) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;
        try {
            conn = getConnection();
            String sql = "INSERT INTO `booktext_reply` (`bk_reply_content`,`booktext_no`,`user_no`) VALUES (?,?,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, btReply);
            pstmt.setInt(2, btNo);
            pstmt.setInt(3, btUserNo);
            result = pstmt.executeUpdate();
        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            close(pstmt);
            close(conn);
        }
        return result;
    }

    public int bkchildReplyAdd(int btNo,int btUserNo,int btParentNo,String btReply) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;
        try {
            conn = getConnection();
            String sql = "INSERT INTO `booktext_reply` (`bk_reply_content`,`booktext_no`, `bk_parent_no`,`user_no`) VALUES (?,?,?,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, btReply);
            pstmt.setInt(2, btNo);
            pstmt.setInt(3, btParentNo);
            pstmt.setInt(4, btUserNo);
            result = pstmt.executeUpdate();
        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            close(pstmt);
            close(conn);
        }
        return result;
    }

    public int bkReplyDelete(int btReplyNo) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;
        try {
            conn = getConnection();
            String sql = "UPDATE `booktext_reply` SET is_deleted = 1 WHERE bk_reply_no = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, btReplyNo);
            result = pstmt.executeUpdate();
        }catch (Exception e) {
            e.printStackTrace();
        }finally {
            close(pstmt);
            close(conn);
        }
        return result;
    }

    public int bkReplyupdateReply(int btReplyNo,String btReply) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;
        try {
            conn = getConnection();
            String sql = "UPDATE `booktext_reply` SET bk_reply_content = ? WHERE bk_reply_no = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, btReply);
            pstmt.setInt(2, btReplyNo);
            result = pstmt.executeUpdate();

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            close(pstmt);
            close(conn);
        }
        return result;
    }

    public int btCount(int btNo) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int result = 0;
        try {
            conn = getConnection();
            String sql = "SELECT COUNT(*) AS re_cnt FROM `booktext_reply` WHERE booktext_no = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, btNo);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                result = rs.getInt("re_cnt");
            }
        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            close(pstmt);
            close(conn);
        }
        return result;
    }
}