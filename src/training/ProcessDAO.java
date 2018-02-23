package training;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//DB접근. 과정
public class ProcessDAO {
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
		String SQL = "select prNo from process order by prNo desc";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt("prNo") + 1;	// 가장 큰 인덱스 번호
			}
			
			return 1;	// 튜플이 없을 시 1부터 시작
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;	//데이터 베이스 오류
	}
	
	//TrainingBeginActive.jsp
	//과정 개설
	public int createProcess(Process pr) {
		connectDB();
		String SQL = "select trName, prDate from process where trName = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, pr.getTrName());
			rs = pstmt.executeQuery();	//검색 성공
			
			while(rs.next()) {
				if(rs.getString("trName").equals(pr.getTrName()) && 
						rs.getString("prDate").substring(0,10).equals(pr.getsDate()))
				{
					return -1;	//중복
				}
			}
			
			SQL = "insert into process values (?, ?, ?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, pr.getPrNo());
			pstmt.setString(2, pr.getTrType());
			pstmt.setString(3, pr.getsDate() + "/" + pr.geteDate());
			pstmt.setInt(4, pr.getPrQueta());
			pstmt.setString(5, pr.getPrStateName());
			pstmt.setString(6, pr.getTrName());
			pstmt.setString(7, pr.getMemId());
			pstmt.setString(8, pr.getTrRoom());
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
	
	//TrainingBeginUpdateActive.jsp
	//개설 과정 정보 수정
	public int updateProcess(Process pr) {
		connectDB();
		String SQL = "update process set trType = ?, prDate = ?,";
		SQL += "prQueta = ?, prStateName = ?, trName = ?, memId = ?,";
		SQL += "trRoom = ? where prNo = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, pr.getTrType());
			pstmt.setString(2, pr.getsDate() + "/" + pr.geteDate());
			pstmt.setInt(3, pr.getPrQueta());
			pstmt.setString(4, pr.getPrStateName());
			pstmt.setString(5, pr.getTrName());
			pstmt.setString(6, pr.getMemId());
			pstmt.setString(7, pr.getTrRoom());
			pstmt.setInt(8, pr.getPrNo());
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
	
	//TrainingBeginDeleteActive.jsp
	//개설된 훈련 제거.	paramNo : prNo ( 과정 인덱스 번호 )
	public int deleteProcess(int paramNo) {
		connectDB();
		String SQL = "delete from process where prNo = ?";
		ArrayList<Process> list = new ArrayList<Process>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			pstmt.executeUpdate();		//삭제 성공
			
			SQL = "select prNo from process order by prNo asc";
			
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {					//모든 과정 인덱스 번호 목록
				Process p = new Process();
				p.setPrNo(rs.getInt("prNo"));
				list.add(p);
			}
			
			int num = 1;
			
			for( int i = 0; i < list.size(); i++ ) {				//인덱스 번호 정렬
				SQL = "update process set prNo = ? where prNo = ?";
				
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, num);
				pstmt.setInt(2, list.get(i).getPrNo());
				pstmt.executeUpdate();
				
				num++;
			}
			
			return 1;		//성공
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;			//데이터베이스 오류
	}
	
	//StudentRegist.jsp
	//모든 과정 출력(Date가 최신일수록 우선순위 높음)
	public ArrayList<Process> getList(){
		connectDB();
		String SQL = "select * from process order by prDate desc";
		ArrayList<Process> list = new ArrayList<Process>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();		//검색 성공
			
			while(rs.next()) {
				Process pr = new Process();
				pr.setPrNo(rs.getInt("prNo"));
				pr.setTrType(rs.getString("trType"));
				pr.setPrDate(rs.getString("prDate"));
				pr.setPrQueta(rs.getInt("prQueta"));
				pr.setPrStateName(rs.getString("prStateName"));
				pr.setTrName(rs.getString("trName"));
				pr.setMemId(rs.getString("memId"));
				pr.setTrRoom(rs.getString("trRoom"));
				list.add(pr);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//과정 목록
	}
	
	//StudentInfo.jsp, StudentInfoUpdateProcess.jsp
	//특정 과정 목록.	paramNo : prNo ( 과정 인덱스 번호 )
	public ArrayList<Process> getData(int paramNo){
		connectDB();
		String SQL = "select * from process where prNo = ?";
		ArrayList<Process> list = new ArrayList<Process>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Process pr = new Process();
				pr.setPrNo(rs.getInt("prNo"));
				pr.setTrType(rs.getString("trType"));
				pr.setPrDate(rs.getString("prDate"));
				pr.setPrQueta(rs.getInt("prQueta"));
				pr.setPrStateName(rs.getString("prStateName"));
				pr.setTrName(rs.getString("trName"));
				pr.setMemId(rs.getString("memId"));
				pr.setTrRoom(rs.getString("trRoom"));
				list.add(pr);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//과정 정보 목록
	}
	
	//TrainingBeginConfig.jsp
	//총 레코드 수
	public int totalRecord() {
		connectDB();
		String SQL = "select count(*) prNo from process";	//10개까지 제한
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				return rs.getInt("prNo");		//레코드 총합
			
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
	
	//TrainingBeginConfig.jsp
	//게시물 목록.	paramBegin : pNo ( 과정 인덱스 번호 ), limit : 출력 수 제한
	public ArrayList<Process> processList(int paramBegin, int limit){
		connectDB();
		String SQL = "select * from process where prNo <= ? order by prNo desc limit ?";
		ArrayList<Process> list = new ArrayList<Process>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramBegin);
			pstmt.setInt(2, limit);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Process pr = new Process();
				pr.setPrNo(rs.getInt("prNo"));
				pr.setTrType(rs.getString("trType"));
				pr.setPrDate(rs.getString("prDate"));
				pr.setPrQueta(rs.getInt("prQueta"));
				pr.setPrStateName(rs.getString("prStateName"));
				pr.setTrName(rs.getString("trName"));
				pr.setMemId(rs.getString("memId"));
				pr.setTrRoom(rs.getString("trRoom"));
				list.add(pr);
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
}
