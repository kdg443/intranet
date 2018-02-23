package student;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//DB접근.	훈련생 기업 지원
public class SupportCompanyDAO {
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
		String SQL = "select scNo from support_company order by scNo desc";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt("scNo") + 1;	// 가장 큰 인덱스 번호 부여
			}
			
			return 1;	// 튜플이 없을 경우 1부터 시작
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;	//데이터 베이스 오류
	}
	
	//SupportCompanyCreateActive.jsp
	//기업 지원 생성
	public int createSupportCompany(SupportCompany sc) {
		connectDB();
		String SQL = "insert into support_company values(";
		SQL += "?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			int index = getNext();		//인덱스 번호
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, index);
			pstmt.setInt(2, sc.getStNo());
			pstmt.setString(3, sc.getScDate());
			pstmt.setString(4, sc.getScCompany());
			pstmt.setString(5, sc.getScAddr());
			pstmt.setString(6, sc.getScName());
			pstmt.setString(7, sc.getScTel());
			pstmt.setString(8, sc.getScContent());
			pstmt.setString(9, sc.getScResult());
			pstmt.setString(10, sc.getScReason());
			return pstmt.executeUpdate();		//생성 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//SupportCompanyUpdateActive.jsp
	//기업 지원 정보 수정
	public int updateSupportCompany(SupportCompany sc) {
		connectDB();
		String SQL = "update support_company set scDate = ?,";
		SQL += "scCompany = ?, scAddr = ?, scName = ?, scTel = ?,";
		SQL += "scContent = ?, scResult = ?, scReason = ? where scNo = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, sc.getScDate());
			pstmt.setString(2, sc.getScCompany());
			pstmt.setString(3, sc.getScAddr());
			pstmt.setString(4, sc.getScName());
			pstmt.setString(5, sc.getScTel());
			pstmt.setString(6, sc.getScContent());
			pstmt.setString(7, sc.getScResult());
			pstmt.setString(8, sc.getScReason());
			pstmt.setInt(9, sc.getScNo());
			return pstmt.executeUpdate();		//수정 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//SupportCompanyDeleteActive.jsp
	//기업 지원 정보 삭제.	paramNo : scNo ( 기업 지원 인덱스 번호 )
	public int deleteSupportCompany(int paramNo) {
		connectDB();
		String SQL = "delete from support_company where scNo = ?";
		
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
		
		return -2;		//데이터베이스 오류
	}
	
	//StudentInfo.jsp
	//특정 훈련생 기업 지원 현황.	날짜 오름 차순.	paramNo : stNo (훈련생 인덱스 번호)
	public ArrayList<SupportCompany> getList(int paramNo){
		connectDB();
		String SQL = "select * from support_company where stNo = ? order by scDate asc";
		ArrayList<SupportCompany> list = new ArrayList<SupportCompany>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SupportCompany sc = new SupportCompany();
				sc.setScNo(rs.getInt("scNo"));
				sc.setStNo(rs.getInt("stNo"));
				sc.setScDate(rs.getString("scDate"));
				sc.setScCompany(rs.getString("scCompany"));
				sc.setScAddr(rs.getString("scAddr"));
				sc.setScName(rs.getString("scName"));
				sc.setScTel(rs.getString("scTel"));
				sc.setScContent(rs.getString("scContent"));
				sc.setScResult(rs.getString("scResult"));
				sc.setScReason(rs.getString("scReason"));
				list.add(sc);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//지원 목록
	}
	
	//SupportCompanyUpdate.jsp
	//특정 기업 지원 정보.	paramNo : scNo (기업 지원 인덱스 번호)
	public ArrayList<SupportCompany> getData(int paramNo){
		connectDB();
		String SQL = "select * from support_company where scNo = ?";
		ArrayList<SupportCompany> list = new ArrayList<SupportCompany>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SupportCompany sc = new SupportCompany();
				sc.setScNo(rs.getInt("scNo"));
				sc.setStNo(rs.getInt("stNo"));
				sc.setScDate(rs.getString("scDate"));
				sc.setScCompany(rs.getString("scCompany"));
				sc.setScAddr(rs.getString("scAddr"));
				sc.setScName(rs.getString("scName"));
				sc.setScTel(rs.getString("scTel"));
				sc.setScContent(rs.getString("scContent"));
				sc.setScResult(rs.getString("scResult"));
				sc.setScReason(rs.getString("scReason"));
				list.add(sc);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//지원 목록
	}
}
