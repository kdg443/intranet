package student;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//DB접근. 상담
public class AdviceDAO {
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
		String SQL = "select adNo from advice order by adNo desc";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt("adNo") + 1;	// 가장 큰 인덱스 번호 부여
			}
			
			return 1;	// 튜플이 없을 경우 1부터 시작
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;	//데이터 베이스 오류
	}
	
	//AdviceActive.jsp
	//상담 추가
	public int createAdvice(Advice ad) {
		connectDB();
		String SQL = "insert into advice values (?, ?, ?, ?, ?, ?)";
		try {
			int num = getNext();
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			pstmt.setString(2, ad.getPrStateName());
			pstmt.setInt(3, ad.getStNo());
			pstmt.setString(4, ad.getMemId());
			pstmt.setString(5, ad.getAdDate());
			pstmt.setString(6, ad.getAdComment());
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
	
	//AdviceUpdateActive.jsp
	//훈련생 상담 정보 변경
	public int updateAdvice(Advice ad) {
		connectDB();
		String SQL = "update advice set prStateName = ?,";
		SQL += "memId = ?, adDate = ?, adComment = ?";
		SQL += "where adNo = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, ad.getPrStateName());
			pstmt.setString(2, ad.getMemId());
			pstmt.setString(3, ad.getAdDate());
			pstmt.setString(4, ad.getAdComment());
			pstmt.setInt(5, ad.getAdNo());
			return pstmt.executeUpdate();	// 수정 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터 베이스 오류
	}
	
	//AdviceDeleteActive.jsp
	//훈련생 상담 정보 변경.	paramNo : adNo ( 상담 인덱스 번호 )
	public int deleteAdvice(int paramNo) {
		connectDB();
		String SQL = "delete from advice where adNo = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
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
	
	//StudentInfo.jsp
	//특정 훈련생의 상담 목록(작성일이 오래될수록 순위가 높음).	paramNo : stNo ( 훈련생 인덱스 번호 )
	public ArrayList<Advice> getList(int paramNo){
		connectDB();
		String SQL = "select * from advice where stNo = ? order by adDate asc";
		ArrayList<Advice> list = new ArrayList<Advice>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Advice ad = new Advice();
				ad.setAdNo(rs.getInt("adNo"));
				ad.setPrStateName(rs.getString("prStateName"));
				ad.setStNo(rs.getInt("stNo"));
				ad.setMemId(rs.getString("memId"));
				ad.setAdDate(rs.getString("adDate"));
				ad.setAdComment(rs.getString("adComment"));
				list.add(ad);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//훈령생 상담 목록
	}
	
	//AdviceUpdate.jsp
	//특정 상담 내용.	paramNo : adNo ( 상담 인덱스 번호 )
	public ArrayList<Advice> getData(int paramNo){
		connectDB();
		String SQL = "select * from advice where adNo = ?";
		ArrayList<Advice> list = new ArrayList<Advice>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Advice ad = new Advice();
				ad.setAdNo(rs.getInt("adNo"));
				ad.setPrStateName(rs.getString("prStateName"));
				ad.setStNo(rs.getInt("stNo"));
				ad.setMemId(rs.getString("memId"));
				ad.setAdDate(rs.getString("adDate"));
				ad.setAdComment(rs.getString("adComment"));
				list.add(ad);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//상담 정보 목록
	}
}
