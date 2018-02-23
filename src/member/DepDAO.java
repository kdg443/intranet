package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//DB접근. 부서
public class DepDAO {
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
		String SQL = "select depNo from dep order by depNo desc";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt("depNo") + 1;	//가장 높은 인덱스 번호 부여
			}
			
			return 1;	//튜플이 없을 시 1부터 시작
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//DepCreateActive.jsp
	//부서 생성.	paramName : depName ( 부서 이름 )
	public int createDep(String paramName) {
		connectDB();
		String SQL = "select depName from dep where depName = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				if(rs.getString("depName").equals(paramName))
					return -1;	//중복
			}
			
			int num = getNext();
			SQL = "insert into dep values (?, ?)";
			
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
	
	//DepUpdateActive.jsp
	//부서명 변경.	param : depName ( 기존 부서 이름 ),	paramNew : depNameCh ( 변경할 부서 이름 )
	public int updateDep(String param, String paramNew) {
		connectDB();
		String SQL = "select depName from dep where depName = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramNew);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				if(rs.getString("depName").equals(paramNew))
					return -1;	//중복
			}
			
			SQL = "update dep set depName = ? where depName = ?";
			
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
	
	//DepDeleteActive.jsp
	//부서 제거.	param : depName ( 부서 이름 )
	public int deleteDep(String param) {
		connectDB();
		String SQL = "delete from dep where depName = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, param);
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
	
	//MemberJoin.jsp
	//모든 부서 목록
	public ArrayList<Dep> getList(){
		connectDB();
		String SQL = "select depName from dep";
		ArrayList<Dep> list = new ArrayList<Dep>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Dep dep = new Dep();
				dep.setDepName(rs.getString("depName"));
				list.add(dep);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;	//부서 목록
	}
}
