package training;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//DB접근. 과정 상태
public class ProcessStateDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//DB 연결
	public void connectDB() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/intra";
			String dbId = "root";
			String dbPwd = "123123";
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbId, dbPwd);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//인덱스 번호
	public int getNext() {
		connectDB();
		String SQL = "select prStateNo from process_state order by prStateNo desc";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt("prStateNo") + 1;	// 가장 큰 인덱스 번호 부여
			}
			
			return 1;	// 튜플이 없을 경우 1부터 시작
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;	//데이터 베이스 오류
	}
	
	//TrainingStateCreateActive.jsp
	//과정 상태 생성.	paramName : prStateName ( 과정 상태 명 )
	public int createState(String paramName) {
		connectDB();
		String SQL = "select * from process_state where prStateName = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			rs = pstmt.executeQuery();	//검색 성공
			
			if(rs.next()) {
				if(rs.getString("prStateName").equals(paramName)) {
					return -1;	// 중복
				}
			}
			
			SQL = "insert into process_state values (?, ?)";
			int num = getNext();
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			pstmt.setString(2, paramName);
			return pstmt.executeUpdate();		//생성 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//TrainingStateUpdateActive.jsp
	//과정 상태 명 변경.	param : prStateName ( 훈련 상태 기존 명 ), paramNew : prStateName ( 훈련 상태 변경 명 )
	public int updateState(String param, String paramNew) {
		connectDB();
		String SQL = "select * from process_state where prStateName = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramNew);
			rs = pstmt.executeQuery();	//검색 성공
			
			if(rs.next()) {
				if(rs.getString("prStateName").equals(paramNew)) {
					return -1;	//중복
				}
			}
			
			SQL = "update process_state set prStateName = ? where prStateName = ?";
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramNew);
			pstmt.setString(2, param);
			return pstmt.executeUpdate();		//수정 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//TrainingStateDeleteActive.jsp
	//과정 상태 제거.	paramName : prStateName ( 과정 상태 명 )
	public int deleteState(String paramName) {
		connectDB();
		String SQL = "delete from process_state where prStateName = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			return pstmt.executeUpdate();		//제거 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//TrainingDefine.jsp
	//과정 상태 목록
	public ArrayList<ProcessState> getList(){
		connectDB();
		String SQL = "select * from process_state";
		ArrayList<ProcessState> list = new ArrayList<ProcessState>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();		//검색 성공
			
			while(rs.next()) {
				ProcessState ps = new ProcessState();
				ps.setPrStateNo(rs.getInt("prStateNo"));
				ps.setPrStateName(rs.getString("prStateName"));
				list.add(ps);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//과정 상태 목록
	}
}
