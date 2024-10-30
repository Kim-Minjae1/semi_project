package com.book.admin.event.dao;

import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.book.admin.event.vo.Event;
import com.book.common.Paging;

public class EventDao {
	
	// 메인페이지 이벤트
	public static List<Map<String, String>> getAllEvents() {
		List<Map<String, String>> events = new ArrayList<>();
	    Connection conn = getConnection();
	    String sql = "SELECT * FROM events WHERE event_end >= CURRENT_DATE";
	    
	    try (PreparedStatement stmt = conn.prepareStatement(sql);
	         ResultSet rs = stmt.executeQuery()) {

	        while (rs.next()) {
	        	Map<String, String> mainPagEv = new HashMap<>();
	        	mainPagEv.put("event_no", rs.getString("event_no"));
	        	mainPagEv.put("event_title", rs.getString("event_title"));
	        	mainPagEv.put("event_start", rs.getString("event_start").toString());
	        	mainPagEv.put("event_end", rs.getString("event_end").toString()); 
	        	mainPagEv.put("event_form", rs.getString("event_form"));
	        	mainPagEv.put("event_new_image", rs.getString("event_new_image"));  
	            events.add(mainPagEv);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();  
	    }
	    return events;
	}

	
    // 이벤트 생성  
    public int createEvent(Event event, Connection conn) {
        PreparedStatement pstmt = null;
        int result = 0;

        try {
            String sql = "INSERT INTO events (event_title, event_content, event_form, event_progress, event_start, event_end, event_ori_image, event_new_image, event_category_no, event_quota) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, event.getEv_title());
            pstmt.setString(2, event.getEv_content());
            pstmt.setInt(3, event.getEv_form());
            pstmt.setString(4, event.getEv_progress());
            pstmt.setString(5, event.getEv_start());
            pstmt.setString(6, event.getEv_end());
            pstmt.setString(7, event.getOri_image());
            pstmt.setString(8, event.getNew_image());
            pstmt.setInt(9, event.getEvent_category());
            if (event.getEv_form() == 2) {
                pstmt.setInt(10, event.getEvent_quota());
            } else {
                pstmt.setNull(10, java.sql.Types.INTEGER);
            }
            result = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(pstmt);
        }
        return result;
    }

    // 이벤트 목록 조회  
    public List<Map<String, String>> selectEventList(Event option, Connection conn) {
        List<Map<String, String>> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT e.event_no AS 번호, e.event_title AS 제목, e.event_regdate AS 등록일, e.event_form AS 유형, c.event_category_name AS 카테고리명, e.event_quota AS 정원, e.event_registered AS 참여인원, e.event_waiting AS 대기인원 " +
                    "FROM events e " +
                    "JOIN event_category c ON e.event_category_no = c.event_category_no " +
                    "WHERE 1=1";  

            // 카테고리 번호에 따라 필터링 조건 추가
            if (option.getEvent_category() != 0) {
                if (option.getEvent_category() == 1 || option.getEvent_category() == 2) {
                    sql += " AND e.event_form = ?";
                } else {
                    sql += " AND c.event_category_no = ?";
                }
            }

            // 년도 필터링 조건 추가
            if (option.getFind_year() > 0) {
                sql += " AND YEAR(e.event_regdate) = ?";
            }

            // 월 필터링 조건 추가
            if (option.getFind_month() > 0) {
                sql += " AND MONTH(e.event_regdate) = ?";
            }
            
            // 이벤트 제목 필터링 조건 추가
            if (option.getEv_title() != null && !option.getEv_title().isEmpty()) {
                sql += " AND e.event_title LIKE CONCAT('%', ?, '%')";
            }

            sql += " ORDER BY e.event_regdate DESC LIMIT ?, ?";

            pstmt = conn.prepareStatement(sql);
            int paramIndex = 1;

            // 카테고리 번호 설정
            if (option.getEvent_category() != 0) {
                if (option.getEvent_category() == 1 || option.getEvent_category() == 2) {
                    pstmt.setInt(paramIndex++, option.getEvent_category()); // event_form 값 설정
                } else {
                    pstmt.setInt(paramIndex++, option.getEvent_category()-2); // event_category_no 값 설정
                }
            }

            // 년도 설정
            if (option.getFind_year() > 0) {
                pstmt.setInt(paramIndex++, option.getFind_year());
            }

            // 월 설정
            if (option.getFind_month() > 0) {
                pstmt.setInt(paramIndex++, option.getFind_month());
            }
            
            // 이벤트 제목 설정
            if (option.getEv_title() != null && !option.getEv_title().isEmpty()) {
                pstmt.setString(paramIndex++, option.getEv_title());
            } 
            
            // LIMIT OFFSET 설정 (페이징 처리)
            pstmt.setInt(paramIndex++, option.getLimitPageNo());
            pstmt.setInt(paramIndex, option.getNumPerPage());

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, String> row = new HashMap<>();
                row.put("event_no", rs.getString("번호"));
                row.put("event_title", rs.getString("제목"));
                row.put("event_regdate", rs.getString("등록일"));
                row.put("event_form", rs.getString("유형"));
                row.put("event_category_name", rs.getString("카테고리명"));
                row.put("event_quota", rs.getString("정원"));
                row.put("event_registered", rs.getString("참여인원"));
                row.put("event_waiting", rs.getString("대기인원"));
                list.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }
        return list;
    }
 
    // 선택된 카테고리에 따른 전체 이벤트 개수 조회 
    public int selectEventCount(Event option, Connection conn) {
        int result = 0;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT COUNT(*) AS cnt FROM events e " +
                    "JOIN event_category c ON e.event_category_no = c.event_category_no " +
                    "WHERE 1=1"; // 시작 조건

            // 카테고리 번호에 따라 필터링 조건 추가
            if (option.getEvent_category() != 0) {
                if (option.getEvent_category() == 1 || option.getEvent_category() == 2) {
                    sql += " AND e.event_form = ?";
                } else {
                    sql += " AND c.event_category_no = ?";
                }
            }

            // 이벤트 제목 필터링 조건 추가
            if (option.getEv_title() != null && !option.getEv_title().isEmpty()) {
                sql += " AND e.event_title LIKE CONCAT('%', ?, '%')";
            }

            pstmt = conn.prepareStatement(sql);
            int paramIndex = 1;

            // 카테고리 번호 설정
            if (option.getEvent_category() != 0) {
                if (option.getEvent_category() == 1 || option.getEvent_category() == 2) {
                    pstmt.setInt(paramIndex++, option.getEvent_category()); // event_form 값 설정
                } else {
                    pstmt.setInt(paramIndex++, option.getEvent_category() - 2); // event_category_no 값 설정
                }
            }

            // 이벤트 제목 설정
            if (option.getEv_title() != null && !option.getEv_title().isEmpty()) {
                pstmt.setString(paramIndex++, option.getEv_title());
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

    // 이벤트 번호로 조회  
    public Event selectEventByNo(int eventNo, Connection conn) {
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

    // 이벤트 수정
    public int updateEvent(Event event, Connection conn) {
        PreparedStatement pstmt = null;
        int result = 0;

        try {
            StringBuilder query = new StringBuilder("UPDATE events SET ");
            query.append("event_title=?, ");
 
            if (event.getEv_start() != null && !event.getEv_start().isEmpty()) {
                query.append("event_start=?, ");
            }
 
            if (event.getEv_end() != null && !event.getEv_end().isEmpty()) {
                query.append("event_end=?, ");
            }
 
            if (event.getEv_progress() != null && !event.getEv_progress().isEmpty()) {
                query.append("event_progress=?, ");
            }

            query.append("event_content=?, event_category_no=?, event_quota=?");
 
            if (event.getOri_image() != null && !event.getOri_image().isEmpty()) {
                query.append(", event_ori_image=?");
            }
 
            if (event.getNew_image() != null && !event.getNew_image().isEmpty()) {
                query.append(", event_new_image=?");
            }

            query.append(" WHERE event_no=?");

            pstmt = conn.prepareStatement(query.toString());

            int index = 1;
            pstmt.setString(index++, event.getEv_title());
 
            if (event.getEv_start() != null && !event.getEv_start().isEmpty()) {
                pstmt.setString(index++, event.getEv_start());
            }
 
            if (event.getEv_end() != null && !event.getEv_end().isEmpty()) {
                pstmt.setString(index++, event.getEv_end());
            }
 
            if (event.getEv_progress() != null && !event.getEv_progress().isEmpty()) {
                pstmt.setString(index++, event.getEv_progress());
            }

            pstmt.setString(index++, event.getEv_content());
            pstmt.setInt(index++, event.getEvent_category());
            pstmt.setInt(index++, event.getEvent_quota());
 
            if (event.getOri_image() != null && !event.getOri_image().isEmpty()) {
                pstmt.setString(index++, event.getOri_image());
            }
 
            if (event.getNew_image() != null && !event.getNew_image().isEmpty()) {
                pstmt.setString(index++, event.getNew_image());
            }

            pstmt.setInt(index++, event.getEvent_no());

            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(pstmt);
        }

        return result;
    }

    // 이벤트 삭세
    public int deleteEvent(int eventNo, Connection conn) {
        PreparedStatement pstmt = null;
        int result = 0;
        try {
            String sql = "DELETE FROM events WHERE event_no = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, eventNo);

            result = pstmt.executeUpdate();  

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(pstmt);
        }
        return result;
    }

    // 전체 이벤트 참여자 목록 가져오기 (진행 중이거나 진행 예정인 이벤트)
    public List<Map<String, String>> getEventParticipations(Paging paging, Connection conn) {
        List<Map<String, String>> events = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT e.event_no, u.user_name, e.event_title, e.event_progress, p.participate_date, p.participate_state " +
                         "FROM events e " +
                         "JOIN participates p ON e.event_no = p.event_no " +
                         "JOIN users u ON u.user_no = p.user_no " +
                         "WHERE DATE(e.event_progress) >= CURDATE() " +
                         "ORDER BY e.event_progress DESC " +
                         "LIMIT ?, ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, paging.getLimitPageNo());
            pstmt.setInt(2, paging.getNumPerPage());
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, String> event = new HashMap<>(); 
                event.put("event_no", rs.getString("event_no"));
                event.put("user_name", rs.getString("user_name"));
                event.put("event_title", rs.getString("event_title"));
                event.put("event_progress", rs.getString("event_progress"));
                event.put("participate_date", rs.getString("participate_date"));
                event.put("participate_state", rs.getString("participate_state"));
                events.add(event);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }
        return events;
    }

    // 참여 이벤트 수
    public int selectParEventCount(String eventTitle, Connection conn) {
        int result = 0;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            String sql = "SELECT COUNT(*) AS cnt FROM events e " +
                         "JOIN participates p ON e.event_no = p.event_no " +
                         "WHERE DATE(e.event_progress) >= CURDATE()";
            if (eventTitle != null && !eventTitle.isEmpty()) {
                sql += " AND e.event_title LIKE ?";
            }
            
            pstmt = conn.prepareStatement(sql);
            if (eventTitle != null && !eventTitle.isEmpty()) {
                pstmt.setString(1, "%" + eventTitle + "%");
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
    
    // 제목별 참여자 목록
    public List<Map<String, String>> getEventParticipationsByTitle(String eventTitle, Paging paging, Connection conn) {
        List<Map<String, String>> events = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try { 
            int offset = (paging.getNowPage() - 1) * paging.getNumPerPage();

            String sql = "SELECT e.event_no, u.user_name, e.event_title, e.event_progress, p.participate_date, p.participate_state " +
                         "FROM events e " +
                         "JOIN participates p ON e.event_no = p.event_no " +
                         "JOIN users u ON u.user_no = p.user_no " +
                         "WHERE DATE(e.event_progress) >= CURDATE() AND e.event_title LIKE ? " +
                         "ORDER BY p.participate_date " +
                         "LIMIT ? OFFSET ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + eventTitle + "%");
            pstmt.setInt(2, paging.getNumPerPage());
            pstmt.setInt(3, offset);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, String> event = new HashMap<>();
                event.put("event_no", rs.getString("event_no"));
                event.put("user_name", rs.getString("user_name"));
                event.put("event_title", rs.getString("event_title"));
                event.put("event_progress", rs.getString("event_progress"));
                event.put("participate_date", rs.getString("participate_date"));
                event.put("participate_state", rs.getString("participate_state"));
                events.add(event);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }
        return events;
    }
 
    // 진행중, 진행 예정 제목
    public List<Map<String, String>> getEventTitles(Connection conn) {
        List<Map<String, String>> eventTitles = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            LocalDate currentDate = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            String sql = "SELECT DISTINCT e.event_title, e.event_progress " +
                         "FROM events e " +
                         "WHERE DATE(e.event_progress) >= ?" +
                         "ORDER BY event_start";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, currentDate.format(formatter));
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, String> event = new HashMap<>();
                event.put("event_title", rs.getString("event_title"));
                event.put("event_progress", rs.getString("event_progress"));
                eventTitles.add(event);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }
        return eventTitles;
    }

    // 이벤트 정보
    public Map<String, String> getEventInfoByTitle(String eventTitle, Connection conn) {
        Map<String, String> eventInfo = new HashMap<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT event_title, event_start, event_quota, event_end, event_registered, event_waiting " +  
                         "FROM events " +
                         "WHERE event_title = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, eventTitle);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                eventInfo.put("event_title", rs.getString("event_title"));
                eventInfo.put("event_start", rs.getString("event_start"));
                eventInfo.put("event_quota", rs.getString("event_quota"));
                eventInfo.put("event_end", rs.getString("event_end"));
                eventInfo.put("event_registered", rs.getString("event_registered"));
                eventInfo.put("event_waiting", rs.getString("event_waiting"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }
        return eventInfo;
    }
 
    // 알림
    public void setNotification(int eventNo, int userNo) {
        String sql = "INSERT INTO event_notifications (user_no, event_no) VALUES (?, ?)";
        try (
    		Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userNo);
            pstmt.setInt(2, eventNo);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void cancelNotification(int eventNo, int userNo) {
        String sql = "DELETE FROM event_notifications WHERE user_no = ? AND event_no = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userNo);
            pstmt.setInt(2, eventNo);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean checkNotification(int eventNo, int userNo) {
        String sql = "SELECT COUNT(*) FROM event_notifications WHERE user_no = ? AND event_no = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userNo);
            pstmt.setInt(2, eventNo);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}