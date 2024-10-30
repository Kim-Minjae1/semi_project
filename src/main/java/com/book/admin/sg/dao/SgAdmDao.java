package com.book.admin.sg.dao;

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

public class SgAdmDao {

	// 문의사항 게시물 조회 및 검색
	public List<Map<String, String>> selectSgList(Suggestion sgOp,String sgStatus) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Map<String, String>> list = new ArrayList<>();

		try {
			conn = getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT sg.sg_no AS `sgNo`, sg.sg_title AS `sgTitle`, u.user_name AS `userName`, sg.sg_reg_date AS `sgRegDate`, sg.sg_status AS `sgStatus`")
			.append(" FROM `suggestion` sg")
			.append(" JOIN `users` u USING (user_no)");
			if (sgOp.getSg_title() != null) {
				sql.append("WHERE sg_title LIKE ?");
			}
			if (sgStatus != null) {
	            if (sgOp.getSg_title() != null) {
	                sql.append("AND sg.sg_status = ? ");
	            } else {
	                sql.append("WHERE sg.sg_status = ? ");
	            }
	        }

	        sql.append("ORDER BY sg.sg_reg_date DESC ")
	           .append("LIMIT ?, ?");

	        pstmt = conn.prepareStatement(sql.toString());

	        int paramIndex = 1;
	        if (sgOp.getSg_title() != null) {
	            pstmt.setString(paramIndex++, "%" + sgOp.getSg_title() + "%");
	        }
	        if (sgStatus != null) {
	            pstmt.setString(paramIndex++, sgStatus);
	        }
	        pstmt.setInt(paramIndex++, sgOp.getLimitPageNo());
	        pstmt.setInt(paramIndex++, sgOp.getNumPerPage());
	        
			rs = pstmt.executeQuery();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			while (rs.next()) {
				Timestamp date = rs.getTimestamp("sgRegDate");

				Map<String, String> row = new HashMap<>();
				row.put("sg_no", rs.getString("sgNo"));
				row.put("sg_title", rs.getString("sgTitle"));
				row.put("sg_userName", rs.getString("userName"));
				row.put("regDate", sdf.format(date));
				row.put("sg_status", rs.getString("sgStatus"));

				list.add(row);
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

	// 문의사항 페이징바 및 검색
	public int selectSgCount(Suggestion sgOp) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;

		try {
			conn = getConnection();
			String sql = "SELECT COUNT(*) AS cnt FROM `suggestion`";
			if (sgOp.getSg_title() != null) {
				sql += " WHERE sg_title LIKE CONCAT('%','" + sgOp.getSg_title() + "','%')";
			}
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt("cnt");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(conn);
		}
		return result;
	}

	// 문의사항 상세조회
	public Suggestion detailSg(Suggestion sgOp) {
		Suggestion sg = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();
			String sql = "SELECT * FROM `suggestion` WHERE sg_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sgOp.getSg_no());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				sg = new Suggestion(rs.getInt("sg_no"), rs.getInt("user_no"), rs.getString("sg_title"),
						rs.getString("sg_content"), rs.getString("ori_img1"), rs.getString("new_img1"),
						rs.getString("ori_img2"), rs.getString("new_img2"), rs.getString("ori_img3"),
						rs.getString("new_img3"), rs.getTimestamp("sg_reg_date").toLocalDateTime(),
						rs.getTimestamp("sg_mod_date").toLocalDateTime(), rs.getInt("sg_status"));
			}
		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(conn);
		}
		return sg;
	}

	// 문의사항에 이미 나와있는 댓글 목록 출력
	public SuggestionReply getReplyList(int sgNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		SuggestionReply sr = null;

		try {
			conn = getConnection();
			String sql = "SELECT sg_reply_no, sg_no, user_no, sg_reply_content, sg_reply_date FROM suggestion_reply WHERE sg_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sgNo);

			rs = pstmt.executeQuery();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			if (rs.next()) {
				sr = new SuggestionReply(
						rs.getInt("sg_reply_no"), 
						rs.getInt("sg_no"), 
						rs.getInt("user_no"),
						rs.getString("sg_reply_content"),
						rs.getTimestamp("sg_reply_date").toLocalDateTime());
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(conn);
		}
		return sr;
	}

	// 관리자 문의사항 답변 남기기
	public int replySg(SuggestionReply sr) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			conn = getConnection();
			String sql = "INSERT INTO `suggestion_reply`(`sg_no`,`user_no`,`sg_reply_content`)" + " VALUES (?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sr.getSg_no());
			pstmt.setInt(2, 1);
			pstmt.setString(3, sr.getSg_reply_content());

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(conn);
		}
		return result;
	}
	
	// 관리자 문의사항 답변 삭제
	public int deleteReply(int replyNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			conn = getConnection();
			String sql = "DELETE FROM `suggestion_reply` WHERE sg_reply_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, replyNo);
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(conn);
		}
		return result;
	}
	
	public int updateReply(int replyNo, String sgReply) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			conn = getConnection();
			String sql = "UPDATE `suggestion_reply` SET `sg_reply_content` =? WHERE sg_reply_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sgReply);
			pstmt.setInt(2, replyNo);
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