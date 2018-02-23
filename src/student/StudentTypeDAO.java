package student;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//DB접근. 훈련생 유형
public class StudentTypeDAO {
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
		String SQL = "select stTyNo from student_type order by stTyNo desc";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt("stTyNo") + 1;	// 가장 큰 인덱스 번호 부여
			}
			
			return 1;	// 튜플이 없을 경우 1부터 시작
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;	//데이터 베이스 오류
	}
	
	//StudentTypeCreateActive.jsp
	//훈련생 유형 생성.	paramName : stTyName(유형 명)
	public int createStType(String paramName) {
		connectDB();
		String SQL = "select * from student_type where stTyName = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("stTyName").equals(paramName)) {
					return -1;	// 중복
				}
			}
			
			SQL = "insert into student_type values (?, ?)";
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
		
		return -2;	//데이터 베이스 오류
	}
	
	//StudentTypeUpdateActive.jsp
	//과정 상태 명 변경.	param : stTyName ( 훈련생 유형 기존 명 ),	paramNew : stTyName ( 훈련생 유형 변경 명 )
	public int updateStType(String param, String paramNew) {
		connectDB();
		String SQL = "select * from student_type where stTyName = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramNew);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("stTyName").equals(paramNew)) {
					return -1;	//중복
				}
			}
			
			SQL = "update student_type set stTyName = ? where stTyName = ?";
			
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
	
	//StudentTypeDeleteActive.jsp
	//과정 상태 제거.	paramName : stTyName( 훈련생 유형 명 )
	public int deleteStType(String paramName) {
		connectDB();
		String SQL = "delete from student_type where stTyName = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			return pstmt.executeUpdate();		//삭제 성공
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
	//훈련생 유형 목록
	public ArrayList<StudentType> getList(){
		connectDB();
		String SQL = "select * from student_type";
		ArrayList<StudentType> list = new ArrayList<StudentType>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();	//검색 성공
			
			while(rs.next()) {
				StudentType st = new StudentType();
				st.setStTyNo(rs.getInt("stTyNo"));
				st.setStTyName(rs.getString("stTyName"));;
				list.add(st);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//훈련생 유형 목록
	}
}
