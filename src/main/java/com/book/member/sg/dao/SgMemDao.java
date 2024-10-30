package com.book.member.sg.dao;

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

import com.book.admin.sg.vo.SuggestionReply;
import com.book.member.sg.vo.Suggestion;

public class SgMemDao {
	
	public int createSg(Suggestion sgOp) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			conn = getConnection();
			String sql = "INSERT INTO `suggestion` (`user_no`,`sg_title`,`sg_content`, `ori_img1`, `new_img1`,`ori_img2`, `new_img2`,`ori_img3`, `new_img3`) VALUES (?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sgOp.getUser_no());
			pstmt.setString(2, sgOp.getSg_title());
			pstmt.setString(3, sgOp.getSg_content());
			pstmt.setString(4, sgOp.getOri_img1() != null ? sgOp.getOri_img1() : "");
			pstmt.setString(5, sgOp.getNew_img1() != null ? sgOp.getNew_img1() : "");
			pstmt.setString(6, sgOp.getOri_img2() != null ? sgOp.getOri_img2() : "");
			pstmt.setString(7, sgOp.getNew_img2() != null ? sgOp.getNew_img2() : "");
			pstmt.setString(8, sgOp.getOri_img3() != null ? sgOp.getOri_img3() : "");
			pstmt.setString(9, sgOp.getNew_img3() != null ? sgOp.getNew_img3() : "");
			
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally { 
			close(pstmt);
			close(conn);
		}
		return result;
	}

	public List<Suggestion> selectSgList(Suggestion sgOp, String sgSort) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<Suggestion> list = new ArrayList<Suggestion>();
	    
	    try {
	        conn = getConnection();
	        String sql = "SELECT * FROM `suggestion` WHERE user_no = ?";
	        if (sgOp.getSg_title() != null) {
	            sql += " AND sg_title LIKE ?";
	        }
	        sql += " ORDER BY sg_mod_date " + ("오래된순".equals(sgSort) ? "ASC" : "DESC");
	        sql += " LIMIT ?, ?";
	        
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, sgOp.getUser_no());
	        
	        int paramIndex = 2;
	        if (sgOp.getSg_title() != null) {
	            pstmt.setString(paramIndex++, "%" + sgOp.getSg_title() + "%");
	        }
	        pstmt.setInt(paramIndex++, sgOp.getLimitPageNo());
	        pstmt.setInt(paramIndex, sgOp.getNumPerPage());
	        
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            Suggestion result = new Suggestion(
	                rs.getInt("sg_no"),
	                rs.getInt("user_no"),
	                rs.getString("sg_title"),
	                rs.getString("sg_content"),
	                rs.getString("ori_img1"),
	                rs.getString("new_img1"),
	                rs.getString("ori_img2"),
	                rs.getString("new_img2"),
	                rs.getString("ori_img3"),
	                rs.getString("new_img3"),
	                rs.getTimestamp("sg_reg_date").toLocalDateTime(),
	                rs.getTimestamp("sg_mod_date").toLocalDateTime(),
	                rs.getInt("sg_status")
	            );
	            list.add(result);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        close(rs);
	        close(pstmt);
	        close(conn);
	    }
	    return list;
	}


	public int selectSgCount(Suggestion sgOp) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			conn = getConnection();
			String sql = "SELECT COUNT(*) AS cnt FROM `suggestion`";
			if(sgOp.getSg_title() !=null) {
				sql += " WHERE sg_title LIKE CONCAT('%','"+sgOp.getSg_title()+"','%')";
			}
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt("cnt");
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

	public Suggestion detailSg(Suggestion sgOp) {
		Suggestion sg = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "SELECT * FROM `suggestion` WHERE sg_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,sgOp.getSg_no());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sg = new Suggestion(rs.getInt("sg_no"),
						rs.getInt("user_no"),
						rs.getString("sg_title"),
						rs.getString("sg_content"),
						rs.getString("ori_img1"),
						rs.getString("new_img1"),
						rs.getString("ori_img2"),
						rs.getString("new_img2"),
						rs.getString("ori_img3"),
						rs.getString("new_img3"),
						rs.getTimestamp("sg_reg_date").toLocalDateTime(),
						rs.getTimestamp("sg_mod_date").toLocalDateTime(),
						rs.getInt("sg_status"));
			}
		}catch(Exception e) {
		
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
			close(conn);
		}
		return sg;
	}
	

			public List<SuggestionReply> getReplyList(int sgNo) {
			    Connection conn = null;
			    PreparedStatement pstmt = null;
			    ResultSet rs = null;
			    List<SuggestionReply> list = new ArrayList<>();
			    
			    try {
			        conn = getConnection();
			        String sql = "SELECT sg_reply_no, sg_no, user_no, sg_reply_content FROM suggestion_reply WHERE sg_no = ?";
			        pstmt = conn.prepareStatement(sql);
			        pstmt.setInt(1, sgNo);
			        
			        rs = pstmt.executeQuery();
			        while (rs.next()) {
			            SuggestionReply sr = new SuggestionReply();
			            sr.setSg_reply_no(rs.getInt("sg_reply_no"));
			            sr.setSg_no(rs.getInt("sg_no"));
			            sr.setUser_no(rs.getInt("user_no"));
			            sr.setSg_reply_content(rs.getString("sg_reply_content"));
			            
			            list.add(sr);
			        }
			        
			    } catch (Exception e) {
			        e.printStackTrace();
			    } finally {
			        close(rs);
			        close(pstmt);
			        close(conn);
			    }
			    return list;
			}
			
	

	public int deleteSg(Suggestion sgOp) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			conn = getConnection();
			String sql = "DELETE FROM `suggestion` WHERE sg_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,sgOp.getSg_no());
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(conn);
		}
		return result;
	}
	
}