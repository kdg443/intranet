package training;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//DB접근. 수강 과정
public class RegProcessDAO {
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
		String SQL = "select regNo from reg_process order by regNo desc";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt("regNo") + 1;	// 가장 큰 인덱스 번호 부여
			}
			
			return 1;	// 튜플이 없을 경우 1부터 시작
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//StudentRegist.jsp
	//훈련생 수강 과정 생성.	paramSt : stNo(훈련생 인덱스 번호), paramPr : prNo (과정 인덱스 번호)
	public int createRegPro(int paramSt, int paramPr) {
		connectDB();
		String SQL = "insert into reg_process values (?, ?, ?)";
		try {
			int num = getNext();
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			pstmt.setInt(2, paramSt);
			pstmt.setInt(3, paramPr);
			return pstmt.executeUpdate();	// 생성 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//StudentInfoUpdateProcessActive.jsp
	//수강 과정 변경.	paramSt : stNo (훈련생 인덱스 번호), paramPr : prNo (과정 인덱스 번호)
	public int changeProcess(int paramSt, int paramPr) {
		connectDB();
		String SQL = "update reg_process set prNo = ? where stNo = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramPr);
			pstmt.setInt(2, paramSt);
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
	
	//StudentRegistActive.jsp
	//수강 과정 제거.	paramSt : stNo (훈련생 인덱스 번호), paramPr : prNo (과정 인덱스 번호)
	public int deleteRegPro(int paramSt, int paramPr) {
		connectDB();
		String SQL = "delete from reg_process where stNo = ? and prNo = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramSt);
			pstmt.setInt(2, paramPr);
			return pstmt.executeUpdate();	// 제거 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//Student.jsp, StudentInfoUpdate.jsp, StudentSearch.jsp
	//수강과정 목록
	public ArrayList<RegProcess> getList(int paramNo){
		connectDB();
		String SQL = "select * from reg_process where stNo = ?";
		ArrayList<RegProcess> list = new ArrayList<RegProcess>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			rs = pstmt.executeQuery();		//검색 성공
			
			while(rs.next()) {
				RegProcess rp = new RegProcess();
				
				rp.setRegNo(rs.getInt("regNo"));
				rp.setPrNo(rs.getInt("prNo"));
				rp.setStNo(rs.getInt("stNo"));
				list.add(rp);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
	
		return list;	//수강과정 목록
	}
	
	//Student.jsp, Advice.jsp, AdviceAccept.jsp, AdviceAfter.jsp / StudentDAO.java
	//특정 과정을 수강한 훈련생 목록.		paramNo : prNo (과정 인덱스 번호)
	public ArrayList<RegProcess> getListRegist(int paramNo){
		connectDB();
		String SQL = "select * from reg_process where prNo = ?";
		ArrayList<RegProcess> list = new ArrayList<RegProcess>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			rs = pstmt.executeQuery();		//검색 성공
			
			while(rs.next()) {
				RegProcess rp = new RegProcess();
				
				rp.setRegNo(rs.getInt("regNo"));
				rp.setPrNo(rs.getInt("prNo"));
				rp.setStNo(rs.getInt("stNo"));
				list.add(rp);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
	
		return list;	// 훈련생 목록 반환
	}
	
	//ProcessInfo.jsp
	//특정 과정의 훈련생 총 인원 수.	paramNo : prNo ( 과정 인덱스 번호 )
	public int getTotal(int paramNo) {
		connectDB();
		String SQL = "select * from reg_process where prNo = ?";
		
		try {
			int count = 0;
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			rs = pstmt.executeQuery();		//검색 성공
			
			while(rs.next()) {
				count++;
			}
			
			return count;		//총 인원 수
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	
}