package com.book.member.user.dao;

import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.getConnection;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.book.member.user.vo.User;




public class UserDao {
   
   public int getEmailCount(String email) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection conn = getConnection();
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) AS count FROM `users` WHERE `user_email` = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn);
            close(rs);
            close(pstmt);
        }
        return count;
    }
   
   public int isNicknameExists(String nickname) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection conn = getConnection();
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) AS count FROM `users` WHERE `user_nickname` = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, nickname);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn);
            close(rs);
            close(pstmt);
        }
        return count;
    }
   
   public int createUser(User u) {
        PreparedStatement pstmt = null;
        Connection conn = getConnection();
        int result = 0;
        try {
            // 이메일당 계정 수 확인
            int emailCount = getEmailCount(u.getUser_email());
            if (emailCount >= 3) {
                return -1; 
            }
            
            int nicknameCount = isNicknameExists(u.getUser_nickname());
            if (nicknameCount > 0) {
                return -2;
            }
            
            String sql = "INSERT INTO `users`(user_name, user_id, user_pw, user_email, user_nickname) VALUES(?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, u.getUser_name());
            pstmt.setString(2, u.getUser_id());
            pstmt.setString(3, u.getUser_pw());
            pstmt.setString(4, u.getUser_email());
            pstmt.setString(5, u.getUser_nickname());
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn);
            close(pstmt);
        }
        return result;
    }
   
   public User checkid(String id) {
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      Connection conn = getConnection();
      User u= null;
      try {
         String sql = "SELECT * FROM `users` WHERE user_id=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            u = new User(
                  rs.getInt("user_no"),
                  rs.getString("user_name"),
                  rs.getString("user_id"),
                  rs.getString("user_pw"),
                  rs.getString("user_email"),
                  rs.getString("user_nickname"),
                  rs.getInt("user_active"),
                  rs.getTimestamp("user_create").toLocalDateTime());
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         close(conn);
         close(rs);
         close(pstmt);
      }
      return u;
   }
   
   public User checknickname(String nickname) {
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      Connection conn = getConnection();
      User u= null;
      try {
         String sql = "SELECT * FROM `users` WHERE user_nickname=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, nickname);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            u = new User(
                  rs.getInt("user_no"),
                  rs.getString("user_name"),
                  rs.getString("user_id"),
                  rs.getString("user_pw"),
                  rs.getString("user_email"),
                  rs.getString("user_nickname"),
                  rs.getInt("user_active"),
                  rs.getTimestamp("user_create").toLocalDateTime());
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         close(conn);
         close(rs);
         close(pstmt);
      }
      return u;
   }
   
   public User loginUser(String id, String pw) {
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      Connection conn =getConnection();
      User u=null;
      try {
         String sql = "SELECT * FROM `users` WHERE user_id=? AND user_pw=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         pstmt.setString(2, pw);
         rs = pstmt.executeQuery();
         while(rs.next()) {
            u = new User(
                  rs.getInt("user_no"),
                  rs.getString("user_name"),
                  rs.getString("user_id"),
                  rs.getString("user_pw"),
                  rs.getString("user_email"),
                  rs.getString("user_nickname"),
                  rs.getInt("user_active"),
                  rs.getTimestamp("user_create").toLocalDateTime());
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         close(conn);
         close(rs);
         close(pstmt);
      }
      return u;
   }
   
   public User checkpw(String pw) {
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      Connection conn =getConnection();
      User u=null;
      try {
         String sql = "SELECT * FROM `users` WHERE user_pw=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, pw);
         rs = pstmt.executeQuery();
         while(rs.next()) {
            u = new User(
                  rs.getInt("user_no"),
                  rs.getString("user_name"),
                  rs.getString("user_id"),
                  rs.getString("user_pw"),
                  rs.getString("user_email"),
                  rs.getString("user_nickname"),
                  rs.getInt("user_active"),
                  rs.getTimestamp("user_create").toLocalDateTime());   
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         close(conn);
         close(rs);
         close(pstmt);
      }
      return u;
   }
   
   public int check_delete(String name) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection conn = getConnection();
        int count = 0;
        try {
            String sql = "SELECT `user_active` AS count FROM `users` WHERE `user_name` = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn);
            close(rs);
            close(pstmt);
        }
        return count;
    }
   
   public User findpw(String id,String email) {
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      Connection conn =getConnection();
      User u=null;
      try {
         String sql = "SELECT * FROM `users` WHERE `user_id`=? AND `user_email` = ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         pstmt.setString(2, email);
         rs = pstmt.executeQuery();
         while(rs.next()) {
            u = new User(
                  rs.getInt("user_no"),
                  rs.getString("user_name"),
                  rs.getString("user_id"),
                  rs.getString("user_pw"),
                  rs.getString("user_email"),
                  rs.getString("user_nickname"),
                  rs.getInt("user_active"),
                  rs.getTimestamp("user_create").toLocalDateTime());
        
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         close(conn);
         close(rs);
         close(pstmt);
      }
      return u;
   }
   
   public int editUser(int no,String pw, String name, String nickname, String email) {
      PreparedStatement pstmt = null;
      Connection conn =getConnection();
      int result = 0;
      try {
          int emailCount = getEmailCount(email);
              if (emailCount >= 4) {
                  return -1; 
              }

              // 닉네임 중복 여부 확인
              int nicknameCount = isNicknameExists(nickname);
              if (nicknameCount > 0) {
                  return -2; 
              }
         String sql = "UPDATE `users` set user_pw=?,user_email=?, user_name=?,user_nickname=? WHERE user_no=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1,pw);
         pstmt.setString(2,email);
         pstmt.setString(3, name);
         pstmt.setString(4, nickname);
         pstmt.setInt(5, no);
         result = pstmt.executeUpdate();
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         close(conn);
         close(pstmt);
      }
      return result;
   }
   public int changepw(String id,String pw) {
      PreparedStatement pstmt = null;
      Connection conn =getConnection();
      int result = 0;
      try {
         String sql = "UPDATE `users` SET user_pw=? WHERE user_id=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1,pw);
         pstmt.setString(2,id);
         result = pstmt.executeUpdate();
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         close(conn);
         close(pstmt);
      }
      return result;
   }
   

   public List<User> findid(String name, String email) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection conn = getConnection();
        List<User> resultList =new ArrayList<User>();
        try {
           
        String sql = "SELECT * FROM `users` WHERE `user_name` = ? AND `user_email` = ? AND `user_active` != 0";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        rs = pstmt.executeQuery();
        while(rs.next()) {
         User u = new User (
               rs.getInt("user_no"),
               rs.getString("user_name"),
               rs.getString("user_id"),
               rs.getString("user_pw"),
               rs.getString("user_email"),
               rs.getString("user_nickname"),
               rs.getInt("user_active"),
               rs.getTimestamp("user_create").toLocalDateTime());
         resultList.add(u);
         }
        }catch(Exception e) {
           e.printStackTrace();
        }finally {
           close(conn);
           close(rs);
           close(pstmt);
        }
        return resultList;
    }
    public String getRandomAdjective() {
       Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String ad = null;
        try {
           String sql = "SELECT adjective FROM adjective ORDER BY RAND() LIMIT 1";
           pstmt = conn.prepareStatement(sql);
           rs = pstmt.executeQuery();
           if (rs.next()) {
                   ad = rs.getString("adjective");
               }
        }catch(Exception e) {
           e.printStackTrace();
        }finally{
          close(conn);
           close(rs);
           close(pstmt);
        }
        return ad;
    }
   public List<String> getRandomNouns(int count){
      Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<String> nouns = new ArrayList<>();
        try {
           String sql = "SELECT noun FROM noun ORDER BY RAND() LIMIT ?";
           pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, count);
          rs = pstmt.executeQuery();
          while (rs.next()) {
                nouns.add(rs.getString("noun"));
            }
        }catch(Exception e) {
           e.printStackTrace();
        }finally {
           close(conn);
           close(rs);
           close(pstmt);
        }
        return nouns;
   }
   
   public int deleteUser(String pw,int no) {
      PreparedStatement pstmt = null;
      Connection conn =getConnection();
      int result = 0;
      try {
         String sql = "UPDATE `users` set user_active=0 WHERE user_no=? AND user_pw=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, no);
         pstmt.setString(2, pw);
         result = pstmt.executeUpdate();
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         close(conn);
         close(pstmt);
      }
      return result;
   }
   public List<User> selectBoardList(User u, String order) {
	    List<User> list = new ArrayList<>();
	    Connection conn = getConnection();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try {
	        String sql = "SELECT * FROM users";

	        // 검색 조건
	        if (u.getUser_name() != null && !u.getUser_name().isEmpty()) {
	            sql += " WHERE user_name LIKE CONCAT('%', ?, '%')";
	        }

	        // 정렬 조건
	        if (order != null && !order.isEmpty()) {
	            sql += " ORDER BY " + order + " ASC";
	        }

	        // 페이지 처리 (LIMIT 적용)
	        sql += " LIMIT ?, ?";

	        pstmt = conn.prepareStatement(sql);
	        int paramIndex = 1;

	        // 검색 조건 파라미터 바인딩
	        if (u.getUser_name() != null && !u.getUser_name().isEmpty()) {
	            pstmt.setString(paramIndex++, u.getUser_name());
	        }

	        // LIMIT 파라미터 바인딩
	        pstmt.setInt(paramIndex++, u.getLimitPageNo());
	        pstmt.setInt(paramIndex, u.getNumPerPage());

	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            User user = new User(
	                rs.getInt("user_no"),
	                rs.getString("user_name"),
	                rs.getString("user_id"),
	                rs.getString("user_pw"),
	                rs.getString("user_email"),
	                rs.getString("user_nickname"),
	                rs.getInt("user_active"),
	                rs.getTimestamp("user_create").toLocalDateTime()
	            );
	            list.add(user);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        close(rs);
	        close(pstmt);
	    }
	    return list;
	}




   // 전체 데이터 개수 조회 메서드
   public int selectBoardCount(User u) {
       int result = 0;
       Connection conn = getConnection();
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       try {
           String sql = "SELECT COUNT(*) AS cnt FROM users";

           // 검색 조건 추가
           if (u.getUser_name() != null && !u.getUser_name().isEmpty()) {
               sql += " WHERE user_name LIKE CONCAT('%', ?, '%')";
           }

           pstmt = conn.prepareStatement(sql);
           if (u.getUser_name() != null && !u.getUser_name().isEmpty()) {
               pstmt.setString(1, u.getUser_name());
           }

           rs = pstmt.executeQuery();
           if (rs.next()) {
               result = rs.getInt("cnt");
           }
       } catch (Exception e) {
           e.printStackTrace();
       } finally {
           close(rs);
           close(pstmt);
       }
       return result;
   }

   
   public User getUserById(int no) {
       User user = null;
       
       String query = "SELECT * FROM users WHERE user_no = ?";
       
       try (Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(query)) {
           pstmt.setInt(1, no);
           try (ResultSet rs = pstmt.executeQuery()) {
               if (rs.next()) {
                   user = new User();
                   user.setUser_no(rs.getInt("user_no"));
                   user.setUser_id(rs.getString("user_id"));
                   user.setUser_pw(rs.getString("user_pw"));
                   user.setUser_name(rs.getString("user_name"));
                   user.setUser_nickname(rs.getString("user_nickname"));
                   user.setUser_email(rs.getString("user_email"));
                   user.setUser_active(rs.getInt("user_active"));
                   user.setUser_create(rs.getTimestamp("user_create").toLocalDateTime());
               }
           }
       } catch (Exception e) {
           e.printStackTrace();
       }
       return user;
   }
}