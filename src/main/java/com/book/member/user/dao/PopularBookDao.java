package com.book.member.user.dao;

import static com.book.common.sql.JDBCTemplate.getConnection;
import static com.book.common.sql.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PopularBookDao {
	
	public List<Map<String, String>> popularBookList() {
	    List<Map<String, String>> pblist = new ArrayList<>();
	    Connection conn = getConnection();
	    Statement stmt = null;
	    ResultSet rs = null;
	    
	    try {
	    	stmt = conn.createStatement();	        
	        String sql = "SELECT b.books_title AS titles, " +
	        			 "b.books_img AS images FROM book b " +
	                     "JOIN (SELECT books_no, COUNT(*) AS bCnt " +
	                     "FROM booktext GROUP BY books_no " +
	                     "ORDER BY bCnt DESC LIMIT 2) " + 
	                     "AS popularBook ON popularBook.books_no = b.books_no";
	        rs = stmt.executeQuery(sql);
	        while (rs.next()) {
	            Map<String, String> bookMap = new HashMap<>();
	            bookMap.put("titles", rs.getString("titles"));
	            bookMap.put("images", rs.getString("images"));
	            
	            pblist.add(bookMap);
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	    	close(rs);
	    	close(stmt);
	    	close(conn);
	    }
	    return pblist;
	}

}