package student;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import utilMade.TimeNow;

//DB접근. 잡트라넷 지원
public class ApplyDAO {
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
		String SQL = "select aNo from apply order by aNo desc";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt("aNo") + 1;	// 가장 큰 인덱스 번호 부여
			}
			
			return 1;	// 튜플이 없을 경우 1부터 시작
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;	//데이터 베이스 오류
	}
	
	//ApplyActive.jsp
	//공고 지원.	paramSt : stNo ( 훈련생 인덱스 번호 ), paramJ : jNo ( 잡트라넷 인덱스 번호 )
	public int apply(int paramSt, int paramJ) {
		connectDB();
		String SQL = "select jNo from apply where stNo = ?";
	
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramSt);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				if(rs.getInt("jNo") == paramJ) {
					return 0;	//이미 지원한 공고
				}
			}
			
			int num = getNext();
			TimeNow now = new TimeNow();
			
			SQL = "insert into apply values (? ,? ,? ,?)";
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			pstmt.setInt(2, paramSt);
			pstmt.setInt(3, paramJ);
			pstmt.setString(4, now.getyMd());
			return pstmt.executeUpdate();		//지원 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//ApplyDelteActive.jsp
	//지원 취소.	paramSt : stNo ( 훈련생 인덱스 번호 ), paramJ : jNo ( 잡트라넷 인덱스 번호 )
	public int deleteApply(int paramSt, int paramJ) {
		connectDB();
		String SQL = "delete from apply where stNo = ? and jNo = ?";
	
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramSt);
			pstmt.setInt(2, paramJ);
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
		
	//해당 날짜 지원 목록.	paramName : aDate ( 지원 일자 )
	public ArrayList<Apply> getList(String paramName){
		connectDB();
		String SQL = "select * from apply where aDate = ?";
		ArrayList<Apply> list = new ArrayList<Apply>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			rs = pstmt.executeQuery();		//검색 성공
			
			while(rs.next()) {
				Apply a = new Apply();
				a.setaNo(rs.getInt("aNo"));
				a.setStNo(rs.getInt("stNo"));
				a.setjNo(rs.getInt("jNo"));
				a.setaDate(rs.getString("aDate"));
				list.add(a);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//지원목록
	}
	
	//JobtranetApply.jsp
	//모든 지원 날짜.
	public ArrayList<Apply> getListDate(){
		connectDB();
		String SQL = "select distinct aDate from apply order by aDate desc";
		ArrayList<Apply> list = new ArrayList<Apply>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();		//검색 성공
			
			while(rs.next()) {
				Apply a = new Apply();
				a.setaDate(rs.getString("aDate"));
				list.add(a);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//지원목록
	}
	
	//ApplyConfig.jsp
	//총 레코드 수.	paramNo : stNo ( 훈련생 인덱스 번호 )
	public int totalRecord(int paramNo) {
		connectDB();
		String SQL = "select count(*) aNo from apply where stNo = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				return rs.getInt("aNo");		//레코드 총합
			
			return 0;		//튜플이 없을 시
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle){}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle){}
			if(conn!=null)try {conn.close();}catch(SQLException sqle){}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//ApplyConfig.jsp
	//게시물 목록.	paramBegin : aNo ( 지원 인덱스 번호 ), limit : 출력 수 제한
	public ArrayList<Apply> applyList(int paramBegin, int paramNo, int limit){
		connectDB();
		String SQL = "select * from apply where aNo <= ? and stNo = ? order by aNo desc limit ?";
		ArrayList<Apply> list = new ArrayList<Apply>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramBegin);
			pstmt.setInt(2, paramNo);
			pstmt.setInt(3, limit);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Apply a = new Apply();
				a.setaNo(rs.getInt("aNo"));
				a.setStNo(rs.getInt("stNo"));
				a.setjNo(rs.getInt("jNo"));
				a.setaDate(rs.getString("aDate"));
				list.add(a);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle){}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle){}
			if(conn!=null)try {conn.close();}catch(SQLException sqle){}
		}
		
		return list;	//특정 게시물 정보
	}
	
	//ApplyConfig.jsp
	//해당 페이지 마지막 게시물 번호.		paramBegin : jNo ( 잡트라넷 인덱스 번호 ), limit : 출력 수 제한,	paramDate : jDate ( 잡트라넷 마감 일 )
	public int endPage(int paramBegin, int paramNo, int limit) {
		connectDB();
		String SQL = "select * from apply where aNo <= ? and stNo = ? order by aNo asc limit ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramBegin);
			pstmt.setInt(2, paramNo);
			pstmt.setInt(3, limit);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				return rs.getInt("aNo");		//레코드 총합
			
			return 0;		//튜플이 없을 시
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle){}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle){}
			if(conn!=null)try {conn.close();}catch(SQLException sqle){}
		}
		
		return -2;	//데이터베이스 오류
	}
}
