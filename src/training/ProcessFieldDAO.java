package training;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//DB접근. 과정 관련 분야
public class ProcessFieldDAO {
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
		String SQL = "select prFiNo from process_field order by prFiNo desc";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt("prFiNo") + 1;	// 가장 큰 인덱스 번호 부여
			}
			
			return 1;	// 튜플이 없을 경우 1부터 시작
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;	//데이터 베이스 오류
	}
	
	//TrainingBeginActive.jsp
	//관련 분야 생성.	paramNo : prNo( 과정 인덱스번호 ), paramName : fName ( 관련 분야명 )
	public int createProField(int paramNo, String[] paramName) {
		connectDB();
		String SQL = "select * from process_field where prNo = ? and fName = ?";
		try {
			for(int i = 0; i < paramName.length; i++) {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, paramNo);
				pstmt.setString(2, paramName[i]);
				rs = pstmt.executeQuery();		//검색 성공
				
				if(rs.next()) {
					if(rs.getInt("prNo") == paramNo && rs.getString("fName").equals(paramName[i])) {
						return -1;		//중복
					}
				}
			}
			
			SQL = "insert into process_field values (?, ?, ?)";
			
			for(int i = 0; i < paramName.length; i++) {			//관련 분야 생성
				int num = getNext();
				
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, num);
				pstmt.setInt(2, paramNo);
				pstmt.setString(3, paramName[i]);
				pstmt.executeUpdate();
			}
			
			return 1;	//성공
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//TrainingBeginUpdateActive.jsp
	//특정 과정의 관련 분야 모두 제거.	paramNo : prNo ( 과정 인덱스 번호 )
	public int deleteProField(int paramNo) {
		connectDB();
		String SQL ="delete from process_field where prNo = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
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
	
	//TrainingBeginUpdate.jsp
	//관련 분야 목록.	paramNo : prNo ( 과정 인덱스 번호 )
	public ArrayList<ProcessField> getList(int paramNo){
		connectDB();
		String SQL = "select * from process_field where prNo = ?";
		ArrayList<ProcessField> list = new ArrayList<ProcessField>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			rs = pstmt.executeQuery();		//검색 성공
			
			while(rs.next()) {
				ProcessField pf = new ProcessField();
				pf.setPrFiNo(rs.getInt("prFiNo"));
				pf.setPrNo(rs.getInt("prNo"));
				pf.setfName(rs.getString("fName"));
				list.add(pf);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//과정 분야 목록
	}
}