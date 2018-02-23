package student;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//DB접근.	훈련생 상태
public class StudentStateDAO {
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
		String SQL = "select stStateNo from student_state order by stStateNo desc";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt("stStateNo") + 1;	// 가장 큰 인덱스 번호 부여
			}
			
			return 1;	// 튜플이 없을 경우 1부터 시작
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;	//데이터 베이스 오류
	}
	
	//StudentStateCreateActive.jsp
	//훈련생 상태 명 생성.	paramName : stStateName ( 훈련생 상태 명 )
	public int createStState(String paramName) {
		connectDB();
		String SQL = "select * from student_state where stStateName = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			rs = pstmt.executeQuery();	//검색 성공
			
			if(rs.next()) {
				if(rs.getString("stStateName").equals(paramName)) {
					return -1;	//중복
				}
			}
			
			SQL = "insert into student_state values (?, ?)";
			int num = getNext();
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			pstmt.setString(2, paramName);
			return pstmt.executeUpdate();	//생성 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//StudentStateUpdateActive.jsp
	//훈련생 상태 명 변경.	param : stStateName ( 훈련생 상태 기존 명 ),	paramNew : stStateName ( 훈련생 상태 변경 명 )
	public int updateStState(String param, String paramNew) {
		connectDB();
		String SQL = "select * from student_state where stStateName = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramNew);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("stStateName").equals(paramNew)) {
					return -1;	//중복
				}
			}
			
			SQL = "update student_state set stStateName = ? where stStateName = ?";
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramNew);
			pstmt.setString(2, param);
			return pstmt.executeUpdate();	//수정 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//StudentStateDeleteActive.jsp
	//훈련생 상태 명 제거.	paramName : stStateName ( 훈련생 상태 명 ) 
	public int deleteStState(String paramName) {
		connectDB();
		String SQL = "delete from student_state where stStateName = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			return pstmt.executeUpdate();	//제거 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//StudentDefine.jsp, StudentRegist.jsp
	//훈련생 상태 목록
	public ArrayList<StudentState> getList(){
		connectDB();
		String SQL = "select * from student_state";
		ArrayList<StudentState> list = new ArrayList<StudentState>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();	//검색 성공
			
			while(rs.next()) {
				StudentState ss = new StudentState();
				ss.setStStateNo(rs.getInt("stStateNo"));
				ss.setStStateName(rs.getString("stStateName"));;
				list.add(ss);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//훈련생 상태 목록
	}
}
