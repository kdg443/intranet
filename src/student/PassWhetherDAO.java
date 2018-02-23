package student;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//DB접근. 합격여부
public class PassWhetherDAO {
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
		String SQL = "select paNo from pass_whether order by paNo desc";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt("paNo") + 1;	// 가장 큰 인덱스 번호 부여
			}
			
			return 1;	// 튜플이 없을 경우 1부터 시작
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;	//데이터 베이스 오류
	}
	
	//StudentPassWhetherCreateActive.jsp
	//합격 여부 명 생성.	paramName : paName(합격여부 명)
	public int createPass(String paramName) {
		connectDB();
		String SQL = "select * from pass_whether where paName = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("paName").equals(paramName)) {
					return -1;	// 중복
				}
			}
			
			SQL = "insert into pass_whether values (?, ?)";
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
	
	//StudentPassWhetherUpdateActive.jsp
	//합격 여부 명 변경.	param : 기존 명,	paramNew : 변경 명
	public int updatePass(String param, String paramNew) {
		connectDB();
		String SQL = "select * from pass_whether where paName = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramNew);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("paName").equals(paramNew)) {
					return -1;	// 변경할 데이터가 이미 존재.
				}
			}
			
			SQL = "update pass_whether set paName = ? where paName = ?";
			
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
		
		return -2;	//데이터 베이스 오류
	}
	
	//StudentPassWhetherDeleteActive.jsp
	//합격 여부 명 제거
	public int deletePass(String param) {
		connectDB();
		String SQL = "delete from pass_whether where paName = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, param);
			return pstmt.executeUpdate();	//삭제 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터 베이스 오류
	}
	
	//TrainingDefine.jsp, StudentRegist.jsp
	//합격 여부 목록
	public ArrayList<PassWhether> getList(){
		connectDB();
		String SQL = "select * from pass_whether";
		ArrayList<PassWhether> list = new ArrayList<PassWhether>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				PassWhether pw = new PassWhether();
				pw.setPaNo(rs.getInt("paNo"));
				pw.setPaName(rs.getString("paName"));;
				list.add(pw);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//합격 여부명 목록
	}
}
