package com.book.member.event.dao;

import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.book.admin.event.vo.Event;
import com.book.member.event.vo.MemEvent;

public class MemEventDao {
 
   // 알림 받기 설정한 이벤트 목록 
    public List<Event> getNotifiedEventsForUser(int userNo) {
        List<Event> events = new ArrayList<>();
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            String sql = "SELECT e.* FROM events e " +
                         "JOIN event_notifications n ON e.event_no = n.event_no " +
                         "WHERE n.user_no = ? AND e.event_start > NOW() " +
                         "ORDER BY e.event_start ASC";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userNo);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Event event = new Event(); 
                event.setEvent_no(rs.getInt("event_no"));
                event.setEv_title(rs.getString("event_title"));
                event.setEv_start(rs.getString("event_start")); 
                event.setEv_end(rs.getString("event_end"));
                events.add(event);
            }
            close(conn);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt); 
        }

        return events;
    } 
    
   // 진행 중인 이벤트 목록 조회  
    public List<Map<String, String>> selectOngoingEvents(Event option) {
        List<Map<String, String>> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection conn = getConnection();
        
        try {
            String sql = "SELECT e.event_no, e.event_title, e.event_regdate, e.event_start, e.event_end, e.event_form, c.event_category_name, e.event_new_image " +
                         "FROM events e " +
                         "JOIN event_category c ON e.event_category_no = c.event_category_no " +
                         "WHERE e.event_end >= CURRENT_DATE " +
                         "ORDER BY e.event_start " +
                         "LIMIT ? OFFSET ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, option.getNumPerPage());
            pstmt.setInt(2, option.getLimitPageNo());
            
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, String> row = new HashMap<>();
                row.put("event_no", rs.getString("event_no"));
                row.put("event_title", rs.getString("event_title"));
                row.put("event_regdate", rs.getString("event_regdate"));
                row.put("event_start", rs.getString("event_start"));
                row.put("event_end", rs.getString("event_end"));
                row.put("event_form", rs.getString("event_form"));
                row.put("event_category_name", rs.getString("event_category_name"));
                row.put("event_new_image", rs.getString("event_new_image"));
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

    public List<Map<String, String>> selectEndedEvents(Event option) {
        List<Map<String, String>> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection conn = getConnection();
        
        try {
            String sql = "SELECT e.event_no, e.event_title, e.event_regdate, e.event_start, e.event_end, e.event_form, c.event_category_name, e.event_new_image " +
                         "FROM events e " +
                         "JOIN event_category c ON e.event_category_no = c.event_category_no " +
                         "WHERE e.event_end < CURRENT_DATE " +
                         "ORDER BY e.event_end DESC " +
                         "LIMIT ? OFFSET ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, option.getNumPerPage());
            pstmt.setInt(2, option.getLimitPageNo());
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, String> row = new HashMap<>();
                row.put("event_no", rs.getString("event_no"));
                row.put("event_title", rs.getString("event_title"));
                row.put("event_regdate", rs.getString("event_regdate"));
                row.put("event_start", rs.getString("event_start"));
                row.put("event_end", rs.getString("event_end"));
                row.put("event_form", rs.getString("event_form"));
                row.put("event_category_name", rs.getString("event_category_name"));
                row.put("event_new_image", rs.getString("event_new_image"));
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
 
    public int selectOngoingCount(Event option) {
       Connection conn = getConnection();
        int totalCount = 0;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT COUNT(*) AS totalCount " + 
                         "FROM events e " +
                         "JOIN event_category c ON e.event_category_no = c.event_category_no " +
                         "WHERE e.event_end >= CURRENT_DATE";

            pstmt = conn.prepareStatement(sql); 
            rs = pstmt.executeQuery();
            if (rs.next()) {
                totalCount = rs.getInt("totalCount");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
            close(conn);
        }

        return totalCount;
    } 
    

    public int selectEndedCount(Event option) {
       Connection conn = getConnection();
        int totalCount = 0;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT COUNT(*) AS totalCount " + 
                         "FROM events e " +
                         "JOIN event_category c ON e.event_category_no = c.event_category_no " +
                         "WHERE e.event_end < CURRENT_DATE";

            pstmt = conn.prepareStatement(sql); 
            rs = pstmt.executeQuery();
            if (rs.next()) {
                totalCount = rs.getInt("totalCount");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
            close(conn);
        }

        return totalCount;
    }
     

    public int selectEventCount(Event option) {
       Connection conn = getConnection();
        int totalCount = 0;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT COUNT(*) AS totalCount FROM events e JOIN event_category c ON e.event_category_no = c.event_category_no WHERE 1=1";

            if (option.getEvent_category() != 0) {
                if (option.getEvent_category() == 1 || option.getEvent_category() == 2) {
                    sql += " AND e.event_form = ?";
                } else {
                    sql += " AND c.event_category_no = ?";
                }
            }

            if (option.getEv_title() != null && !option.getEv_title().isEmpty()) {
                sql += " AND e.event_title LIKE CONCAT('%', ?, '%')";
            }

            pstmt = conn.prepareStatement(sql);
            int paramIndex = 1;

            if (option.getEvent_category() != 0) {
                if (option.getEvent_category() == 1 || option.getEvent_category() == 2) {
                    pstmt.setInt(paramIndex++, option.getEvent_category());
                } else {
                    pstmt.setInt(paramIndex++, option.getEvent_category() - 2);
                }
            }

            if (option.getEv_title() != null && !option.getEv_title().isEmpty()) {
                pstmt.setString(paramIndex++, option.getEv_title());
            }

            rs = pstmt.executeQuery();
            if (rs.next()) {
                totalCount = rs.getInt("totalCount");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
            close(conn);
        }

        return totalCount;
    } 
    

    public Event selectEventByNo(int eventNo) {
       Connection conn = getConnection();
        Event event = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT e.*, c.event_category_name " +
                    "FROM events e " +
                    "JOIN event_category c ON e.event_category_no = c.event_category_no " +
                    "WHERE e.event_no = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, eventNo);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                event = new Event(rs.getInt("event_no"),
                        rs.getInt("event_category_no"),
                        rs.getString("event_title"),
                        rs.getString("event_content"),
                        rs.getInt("event_form"),
                        rs.getString("event_regdate"),
                        rs.getString("event_progress"),
                        rs.getString("event_start"),
                        rs.getString("event_end"),
                        rs.getString("event_ori_image"),
                        rs.getString("event_new_image"),
                        rs.getInt("event_quota"),
                        rs.getString("event_category_name"),
                        rs.getInt("event_registered"),
                        rs.getInt("event_waiting")); 
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt); 
        }

        return event;
    }
    

    public boolean checkRegistration(int eventNo, int userNo) {
       Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean isRegistered = false;

        try {
            String sql = "SELECT COUNT(*) FROM participates WHERE event_no = ? AND user_no = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, eventNo);
            pstmt.setInt(2, userNo);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                    isRegistered = true;
                }
            }
            close(conn);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
            close(conn);
        } 
        return isRegistered;
    }
    
    // 이벤트 등록, 대기 상태 조회
    public int getParticipateState(int userNo, int eventNo) {
       Connection conn = getConnection();
       int state = -1;
       String query = "SELECT participate_state FROM participates WHERE user_no = ? AND event_no = ?";
       try (PreparedStatement ps = conn.prepareStatement(query)) {
          ps.setInt(1, userNo);
          ps.setInt(2, eventNo);
          
          try (ResultSet rs = ps.executeQuery()) {
             if (rs.next()) {
                state = rs.getInt("participate_state");
             }
             close(conn);
          }
       } catch (Exception e) {
          e.printStackTrace();
       }
       return state;
    }
 

    public void registerForEvent(int eventNo, int userNo) {
        String sql = "INSERT INTO participates (user_no, event_no) VALUES (?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userNo);
            pstmt.setInt(2, eventNo);
            pstmt.executeUpdate();
            close(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }  
   

    public void cancelRegistration(int eventNo, int userNo) {
        String sql = "DELETE FROM participates WHERE event_no = ? AND user_no = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, eventNo);
            pstmt.setInt(2, userNo);
            pstmt.executeUpdate();

           autoPromoteWaitingParticipant(eventNo);
           close(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
    private void autoPromoteWaitingParticipant(int eventNo) {
        String updateSql = "UPDATE participates " +
                           "SET participate_state = 0, participate_date = CURRENT_TIMESTAMP " +
                           "WHERE participate_state = 1 AND event_no = ? " +
                           "ORDER BY participate_date ASC " +
                           "LIMIT 1";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
            pstmt.setInt(1, eventNo);
            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {

                updateEventCounts(eventNo);
            }
            close(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void updateEventCounts(int eventNo) {
       Connection conn = getConnection();
        String updateEventSql = "UPDATE events " +
                                "SET event_registered = event_registered + 1, " +
                                "event_waiting = event_waiting - 1 " +
                                "WHERE event_no = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(updateEventSql)) {
            pstmt.setInt(1, eventNo);
            pstmt.executeUpdate();
            close(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
 

    public void waitForEvent(int eventNo, int userNo) {
        String sql = "INSERT INTO participates (user_no, event_no, participate_state) VALUES (?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userNo);
            pstmt.setInt(2, eventNo);
            pstmt.setInt(3, 1);
            pstmt.executeUpdate();
            close(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void cancelWaiting(int eventNo, int userNo) {
        String sql = "DELETE FROM participates WHERE event_no = ? AND user_no = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, eventNo);
            pstmt.setInt(2, userNo);
            pstmt.executeUpdate();
            close(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int selectParEventCount(int userNo, String searchKeyword) {
       Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int result = 0;
 
        String sql = "SELECT COUNT(*) " +
                     "FROM participates p " +
                     "JOIN events e ON p.event_no = e.event_no " +
                     "WHERE p.user_no = ?";

        if (searchKeyword != null && !searchKeyword.isEmpty()) {
            sql += " AND e.event_title LIKE ?";
        }

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userNo);
            if (searchKeyword != null && !searchKeyword.isEmpty()) {
                pstmt.setString(2, "%" + searchKeyword + "%");
            }
            rs = pstmt.executeQuery();
            if (rs.next()) {
                result = rs.getInt(1);
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

    public List<Map<String, String>> getUserEventParticipations(int userNo, int startRow, int numPerPage, String searchKeyword) {
       Connection conn = getConnection();
        List<Map<String, String>> events = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT e.event_no AS 번호, e.event_title AS 제목, e.event_progress AS 진행일, ")
               .append("p.participate_date AS 참여등록일, p.participate_state AS 상태, e.event_end AS 종료일 ")
               .append("FROM events e ")
               .append("JOIN participates p ON e.event_no = p.event_no ")
               .append("WHERE p.user_no = ? ");

            if (searchKeyword != null && !searchKeyword.isEmpty()) {
                sql.append("AND e.event_title LIKE ? ");
            }

            sql.append("ORDER BY p.participate_date DESC ")
               .append("LIMIT ?, ?");

            pstmt = conn.prepareStatement(sql.toString());
            int paramIndex = 1;
            pstmt.setInt(paramIndex++, userNo);

            if (searchKeyword != null && !searchKeyword.isEmpty()) {
                pstmt.setString(paramIndex++, "%" + searchKeyword + "%");
            }

            pstmt.setInt(paramIndex++, startRow);
            pstmt.setInt(paramIndex++, numPerPage);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, String> event = new HashMap<>();
                event.put("event_no", rs.getString("번호"));
                event.put("event_title", rs.getString("제목"));
                event.put("participate_date", rs.getString("참여등록일"));
                event.put("event_progress", rs.getString("진행일"));
                event.put("participate_state", rs.getString("상태"));
                event.put("event_end", rs.getString("종료일"));
                events.add(event);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
            close(conn);
        }
        return events;
    }

 

}