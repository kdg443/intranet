package student;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//DB접근.	 잡트라넷
public class JobtranetDAO {
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
		String SQL = "select jNo from jobtranet order by jNo desc";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				return rs.getInt("jNo") + 1;	//가장 큰 인덱스 번호 부여
			
			return 1;	//튜플이 없을 시 1부터 시작
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//JobtranetRegistActive.jsp
	//잡트라넷 생성
	public int createJob(Jobtranet j) {
		connectDB();
		String SQL = "insert into jobtranet values( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			int num = getNext();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			pstmt.setString(2, j.getjTitle());
			pstmt.setString(3, j.getjIncome());
			pstmt.setString(4, j.getjName());
			pstmt.setString(5, j.getjDate());
			pstmt.setString(6, j.getjEdu());
			pstmt.setString(7, j.getjCareer());
			pstmt.setString(8, j.getjBusiness());
			pstmt.setString(9, j.getjTurnover());
			pstmt.setString(10, j.getjAddr());
			pstmt.setString(11, j.getjWork());
			pstmt.setString(12, j.getjQualify());
			pstmt.setString(13, j.getjSite());
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
	
	//JobtranetInfoUpdateActive.jsp
	//잡트라넷 수정
	public int updateJob(Jobtranet j) {
		connectDB();
		String SQL = "update jobtranet set jTitle = ?, jIncome = ?,";
		SQL += "jName = ?, jDate = ?, jEdu = ?, jCareer = ?, jBusiness = ?,";
		SQL += "jTurnover = ?, jAddr = ?, jWork = ?, jQualify = ?, jSite = ?";
		SQL += "where jNo = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, j.getjTitle());
			pstmt.setString(2, j.getjIncome());
			pstmt.setString(3, j.getjName());
			pstmt.setString(4, j.getjDate());
			pstmt.setString(5, j.getjEdu());
			pstmt.setString(6, j.getjCareer());
			pstmt.setString(7, j.getjBusiness());
			pstmt.setString(8, j.getjTurnover());
			pstmt.setString(9, j.getjAddr());
			pstmt.setString(10, j.getjWork());
			pstmt.setString(11, j.getjQualify());
			pstmt.setString(12, j.getjSite());
			pstmt.setInt(13, j.getjNo());
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
	
	//JobtranetInfoDeleteActive.jsp
	//잡트라넷 제거. paramNo : jNo ( 잡트라넷 인덱스 번호 )
	public int deleteJob(int paramNo) {
		connectDB();
		String SQL = "delete from jobtranet where jNo = ?";
		ArrayList<Jobtranet> list = new ArrayList<Jobtranet>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			pstmt.executeUpdate();	//제거 성공
			
			SQL = "select jNo from jobtranet where jNo > ? order by jNo desc";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				do {
					Jobtranet j = new Jobtranet();
					j.setjNo(rs.getInt("jNo"));
					list.add(j);
				}while(rs.next());		//모든 인덱스 번호
				
				for(int i = 0; i < list.size(); i++) {				//인덱스 번호 정렬
					SQL = "update jobtranet set jNo = ? where jNo = ?";
					pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, paramNo);
					pstmt.setInt(2, list.get(i).getjNo());
					pstmt.executeUpdate();
					
					paramNo++;
				}
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
	
	//JobtranetInfo.jsp, JobtranetInfoUpdate.jsp
	//특정 잡트라넷.	paramNo : jNo ( 잡트라넷 인덱스 번호 )
	public ArrayList<Jobtranet> getData(int paramNo){
		connectDB();
		String SQL = "select * from jobtranet where jNo = ?";
		ArrayList<Jobtranet> list = new ArrayList<Jobtranet>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			rs = pstmt.executeQuery();	//검색 성공
			
			while(rs.next()) {
				Jobtranet j = new Jobtranet();
				j.setjNo(rs.getInt("jNo"));
				j.setjTitle(rs.getString("jTitle"));
				j.setjIncome(rs.getString("jIncome"));
				j.setjName(rs.getString("jName"));
				j.setjDate(rs.getString("jDate"));
				j.setjEdu(rs.getString("jEdu"));
				j.setjCareer(rs.getString("jCareer"));
				j.setjBusiness(rs.getString("jBusiness"));
				j.setjTurnover(rs.getString("jTurnover"));
				j.setjAddr(rs.getString("jAddr"));
				j.setjWork(rs.getString("jWork"));
				j.setjQualify(rs.getString("jQualify"));
				j.setjSite(rs.getString("jSite"));
				list.add(j);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//잡트라넷 정보 목록
	}
	
	//Jobtranet.jsp
	//총 레코드 수
	public int totalRecord() {
		connectDB();
		String SQL = "select count(*) jNo from jobtranet";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				return rs.getInt("jNo");		//레코드 총합
			
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
	
	//JobMain.jsp
	//총 레코드 수.마감일 기준		paramDate : jDate ( 잡트라넷 마감 일 )
	public int totalRecord(String paramDate) {
		connectDB();
		String SQL = "select count(*) jNo from jobtranet where jDate >= ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramDate);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				return rs.getInt("jNo");		//레코드 총합
			
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
	
	//Jobtranet.jsp
	//게시물 목록.	paramBegin : jNo ( 잡트라넷 인덱스 번호 ), limit : 출력 수 제한
	public ArrayList<Jobtranet> jobList(int paramBegin, int limit){
		connectDB();
		String SQL = "select * from jobtranet where jNo <= ? order by jNo desc limit ?";
		ArrayList<Jobtranet> list = new ArrayList<Jobtranet>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramBegin);
			pstmt.setInt(2, limit);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Jobtranet j = new Jobtranet();
				j.setjNo(rs.getInt("jNo"));
				j.setjTitle(rs.getString("jTitle"));
				j.setjIncome(rs.getString("jIncome"));
				j.setjName(rs.getString("jName"));
				j.setjDate(rs.getString("jDate"));
				j.setjEdu(rs.getString("jEdu"));
				j.setjCareer(rs.getString("jCareer"));
				j.setjBusiness(rs.getString("jBusiness"));
				j.setjTurnover(rs.getString("jTurnover"));
				j.setjAddr(rs.getString("jAddr"));
				j.setjWork(rs.getString("jWork"));
				j.setjQualify(rs.getString("jQualify"));
				j.setjSite(rs.getString("jSite"));
				list.add(j);
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
	
	//JobMain.jsp
	//게시물 목록.	paramBegin : jNo ( 잡트라넷 인덱스 번호 ), limit : 출력 수 제한,	paramDate : jDate ( 잡트라넷 마감 일 )
	public ArrayList<Jobtranet> jobList(int paramBegin, int limit, String paramDate){
		connectDB();
		String SQL = "select * from jobtranet where jNo <= ? and jDate >= ? order by jNo desc limit ?";
		ArrayList<Jobtranet> list = new ArrayList<Jobtranet>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramBegin);
			pstmt.setString(2, paramDate);
			pstmt.setInt(3, limit);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Jobtranet j = new Jobtranet();
				j.setjNo(rs.getInt("jNo"));
				j.setjTitle(rs.getString("jTitle"));
				j.setjIncome(rs.getString("jIncome"));
				j.setjName(rs.getString("jName"));
				j.setjDate(rs.getString("jDate"));
				j.setjEdu(rs.getString("jEdu"));
				j.setjCareer(rs.getString("jCareer"));
				j.setjBusiness(rs.getString("jBusiness"));
				j.setjTurnover(rs.getString("jTurnover"));
				j.setjAddr(rs.getString("jAddr"));
				j.setjWork(rs.getString("jWork"));
				j.setjQualify(rs.getString("jQualify"));
				j.setjSite(rs.getString("jSite"));
				list.add(j);
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
	
	//Jobtranet.jsp
	//해당 페이지 마지막 게시물 번호.		paramBegin : jNo ( 잡트라넷 인덱스 번호 ), limit : 출력 수 제한,	paramDate : jDate ( 잡트라넷 마감 일 )
	public int startPage(int paramBegin, String paramDate) {
		connectDB();
		String SQL = "select * from jobtranet where jNo <= ? and jDate >= ? order by jNo desc";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramBegin);
			pstmt.setString(2, paramDate);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				return rs.getInt("jNo");		//튜플 중 가장 높은 인덱스
			
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
	
	//Jobtranet.jsp
	//해당 페이지 마지막 게시물 번호.		paramBegin : jNo ( 잡트라넷 인덱스 번호 ), limit : 출력 수 제한,	paramDate : jDate ( 잡트라넷 마감 일 )
	public int endPage(int paramBegin, int limit, String paramDate) {
		connectDB();
		String SQL = "select * from jobtranet where jNo <= ? and jDate >= ? order by jNo asc limit ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramBegin);
			pstmt.setString(2, paramDate);
			pstmt.setInt(3, limit);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				return rs.getInt("jNo");		//튜플 중 가장 낮은 인덱스
			
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
