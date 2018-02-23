package training;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//DB접근. 관련 분야
public class RelationFieldDAO {
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
		String SQL = "select fNo from relation_field order by fNo desc";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt("fNo") + 1;	// 가장 큰 인덱스 번호 부여
			}
			
			return 1;	// 튜플이 없을 경우 1부터 시작
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//TrainingRelationCreateActive.jsp
	//관련 분야 생성.	paramName : fName ( 관련 분야 명 )
	public int createField(String paramName) {
		connectDB();
		String SQL = "select * from relation_field where fName = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("fName").equals(paramName)) {
					return -1;	// 중복
				}
			}
			
			SQL = "insert into relation_field values (?, ?)";
			int num = getNext();
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			pstmt.setString(2, paramName);
			return pstmt.executeUpdate();	// 생성 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터 베이스 오류
	}
	
	//TrainingRelationUpdateActive.jsp
	//관련 분야 명 변경.	param : fName ( 관련 분야 기존 명 ), paramNew : (관련 분야 변경 명 )
	public int updateField(String param, String paramNew) {
		connectDB();
		String SQL = "select * from relation_field where fName = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramNew);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("fName").equals(paramNew)) {
					return -1;	//중복
				}
			}
			SQL = "update relation_field set fName = ? where fName = ?";
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramNew);
			pstmt.setString(2, param);
			return pstmt.executeUpdate();	//변경 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//TrainingRelationDeleteActive.jsp
	//관련 분야 제거.	paramName : fName ( 관련 분야 명 )
	public int deleteField(String paramName) {
		connectDB();
		String SQL = "delete from relation_field where fName = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			return pstmt.executeUpdate();	// 제거 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터 베이스 오류
	}
	
	//TrainingDefine.jsp, TrainingBegin.jsp, TrainingBeginUpdate.jsp
	//관련 분야 목록
	public ArrayList<RelationField> getList(){
		connectDB();
		String SQL = "select * from relation_field";
		ArrayList<RelationField> list = new ArrayList<RelationField>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();			//검색 성공
			
			while(rs.next()) {
				RelationField rf = new RelationField();
				rf.setfNo(rs.getInt("fNo"));
				rf.setfName(rs.getString("fName"));
				list.add(rf);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}

	
		return list;	//관련 분야 목록
	}
}
