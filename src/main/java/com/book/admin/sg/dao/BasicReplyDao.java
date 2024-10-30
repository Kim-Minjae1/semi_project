package com.book.admin.sg.dao;

import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.book.admin.sg.vo.Basic;

public class BasicReplyDao {
	// 관리자 기본 답변 추가 페이지에 목록 출력
		public List<Basic> selectBasic() {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<Basic> list = new ArrayList<>();

			try {
				conn = getConnection();
				String sql = "SELECT * FROM `basic_reply`";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Basic result = new Basic(rs.getInt("basic_no"), 
							rs.getInt("user_no"), 
							rs.getString("basic_content"));
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
		
		
		// 관리자 기본 답변 추가
		public int addBasic(Basic b) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int result = 0;

			try {
				conn = getConnection();
				String sql = "INSERT INTO `basic_reply` (user_no, basic_content) VALUES (?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, 1);
				pstmt.setString(2,b.getBasic_content());

				result = pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(pstmt);
				close(conn);
			}
			return result;
		}

		// 관리자 기본 답변 삭제
		public int deleteBasic(int basicNo) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int result = 0;
			try {
				conn = getConnection();
				String sql = "DELETE FROM `basic_reply` WHERE basic_no = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, basicNo);
				result = pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(pstmt);
				close(conn);
			}
			return result;
		}
		
		public int updateBasic(int basicNo, String updateBs) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int result = 0;
			try {
				conn = getConnection();
				String sql = "UPDATE `basic_reply` SET basic_content = ? WHERE basic_no = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, updateBs);
				pstmt.setInt(2, basicNo);
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
