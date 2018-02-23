package student;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//DB접근.	자격증
public class LicenseDAO {
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
		String SQL = "select liNo from license order by liNo desc";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt("liNo") + 1;	// 가장 큰 인덱스 번호 부여
			}
			
			return 1;	// 튜플이 없을 경우 1부터 시작
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;	//데이터 베이스 오류
	}
	
	//StudentRegistActive.jsp, StudentInfoUpdateActive.jsp
	//훈련생 자격증 생성.	paramNo : stNo(훈련생 인덱스 번호), paramName : liName(자격증 명)
	public int createLicense(int paramNo, String paramName) {
		connectDB();
		String SQL = "insert into license values (?, ?, ?)";
		try {
			int num = getNext();
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			pstmt.setInt(2, paramNo);
			pstmt.setString(3, paramName);
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
	
	//StudentRegistActive.jsp, StudentInfoUpdateActive.jsp
	//훈련생 자격증 변경.		paramNo : stNo(훈련생 인덱스 번호)
	public int deleteLicense(int paramNo) {
		connectDB();
		String SQL = "delete from license where stNo = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터 베이스 오류
	}
	
	//StudentInfo.jsp
	//특정 훈련생의 자격증 목록.	paramNo : stNo ( 훈련생 인덱스 번호 )
	public ArrayList<License> getList(int paramNo){
		connectDB();
		String SQL = "select * from license where stNo = ?";
		ArrayList<License> list = new ArrayList<License>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				License lc = new License();
				lc.setLiNo(rs.getInt("liNo"));
				lc.setStNo(rs.getInt("stNo"));
				lc.setLiName(rs.getString("liName"));
				list.add(lc);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//자격증 목록
	}
}
