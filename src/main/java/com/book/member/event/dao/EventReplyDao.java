package com.book.member.event.dao;

import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EventReplyDao {

	public List<Map<String, String>> selectErList(int eventNo){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Map<String, String>> list = new ArrayList<>();
		Connection conn = getConnection();
		
		try {
			String sql = "SELECT er.ev_reply_no AS `댓글번호`,er.is_deleted AS `삭제여부`,"
					+ " u.user_nickname AS `유저닉네임`, er.ev_reply_content AS `댓글내용` ,er.ev_parent_no AS `부모자식`, er.ev_reg_date AS `등록일`, er.user_no AS `댓글작성자번호`,er.ev_mod_date AS `수정일`"
					+ " FROM event_reply er"
					+ " JOIN users u ON er.user_no = u.user_no"
					+ " WHERE er.event_no = ?"
					+ " GROUP BY er.ev_reply_no"
					+ " ORDER BY IF(er.ev_parent_no = 0, er.ev_reply_no,er.ev_parent_no),ev_reg_date";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, eventNo);
			rs = pstmt.executeQuery();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			while(rs.next()) {
				Timestamp erRegDate = rs.getTimestamp("등록일");
				Timestamp erModDate = rs.getTimestamp("수정일");
				
				Map<String, String> row = new HashMap<>();
				row.put("er_no", rs.getString("댓글번호"));
				row.put("er_delete", rs.getString("삭제여부"));
				row.put("er_userNickName", rs.getString("유저닉네임"));
				row.put("er_content", rs.getString("댓글내용"));
				row.put("er_regDate", sdf.format(erRegDate));
				row.put("er_modDate", sdf.format(erModDate));
				row.put("er_parent",rs.getString("부모자식"));
				row.put("er_user_no", rs.getString("댓글작성자번호"));
				
				list.add(row);
				
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
	
	public int parentReplyAdd(int userNo,int eventNo,String erReply) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			conn = getConnection();
			String sql = "INSERT INTO `event_reply` (`ev_reply_content`,`event_no`,`user_no`) VALUES (?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, erReply);
			pstmt.setInt(2, eventNo);
			pstmt.setInt(3, userNo);
			result = pstmt.executeUpdate();
		}catch(Exception e) {
		
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(conn);
		}
		return result;
	}
	
	public int childReplyAdd(int userNo,int eventNo, int parentNo, String erReply) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			conn = getConnection();
			String sql = "INSERT INTO `event_reply` (`ev_reply_content`,`event_no`, `ev_parent_no`,`user_no`) VALUES (?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, erReply);
			pstmt.setInt(2, eventNo);
			pstmt.setInt(3, parentNo);
			pstmt.setInt(4, userNo);
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(conn);		
		}
		return result;
	}
	
	public int replyDelete(int eventReplyNo) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    int result = 0;
	    try {
	        conn = getConnection();
	        String sql = "UPDATE `event_reply` SET is_deleted = 1 WHERE ev_reply_no = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, eventReplyNo);
	        result = pstmt.executeUpdate();
	    }catch (Exception e) {
	       
	        e.printStackTrace();
	    }finally {
	        close(pstmt);
	        close(conn);
	    }
	    return result;
	}
	
	public int updateReply(int eventReplyNo,String updateContent) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    int result = 0;
		try {
			conn = getConnection();
			String sql = "UPDATE `event_reply` SET ev_reply_content = ? WHERE ev_reply_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, updateContent);
	        pstmt.setInt(2, eventReplyNo);
	        result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
	        close(pstmt);
	        close(conn);
	    }
	    return result;
	}
	
	public int countReply(int eventNo) {
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int result = 0;
	    try {
	    	conn = getConnection();
	    	String sql = "SELECT COUNT(*) AS re_cnt FROM `event_reply` WHERE event_no = ?";
	    	pstmt = conn.prepareStatement(sql);
	    	pstmt.setInt(1, eventNo);
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
