package training;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//DB접근. 훈련명
public class TrainingNameDAO {
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
		String SQL = "select trNo from training_name order by trNo desc";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt("trNo") + 1;	//가장 높은 인덱스 번호 부여
			}
			
			return 1;	//튜플이 없을 시 1부터 시작
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;	//데이터 베이스 오류
	}

	//TrainingCreateActive.jsp
	//훈련명 생성.	paramName : trName ( 훈련 명 )
	public int createName(String paramName) {
		connectDB();
		String SQL = "select trName from training_name where trName = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			rs = pstmt.executeQuery();		//검색 성공
			
			if(rs.next())
			{
				if(rs.getString("trName").equals(paramName))
				{
					return -1;	//중복
				}
			}
			
			int num = getNext();
			
			SQL = "insert into training_name values (?,?)";
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

	//TrainingUpdateActive.jsp
	//훈련명 수정.	param : trName ( 훈련 기존 명 ), paramNew : trName ( 훈련 변경 명 )
	public int updateName(String param,String paramNew) {
		connectDB();
		String SQL = "select trName from training_name where trName = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramNew);
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				if(rs.getString("trName").equals(paramNew))
					return -1;	//중복된 컬럼
			}
			
			SQL = "update training_name set trName = ? where trName = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramNew);
			pstmt.setString(2, param);
			return pstmt.executeUpdate();	//수정 성공
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//TrainingDeleteActive.jsp
	//훈련명 제거.	paramName : trName ( 훈련 명 )
	public int removeName(String paramName) {
		connectDB();
		String SQL = "delete from training_name where trName = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			return pstmt.executeUpdate();	//제거 성공
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//TrainingDefine.jsp, TrainingBegin.jsp, TrainingBeginUpdate.jsp
	//trName(교육명) 목록 출력
	public ArrayList<Training> getList(){
		connectDB();
		String SQL = "select * from training_name";
		ArrayList<Training> list = new ArrayList<Training>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();		//검색 성공
			
			while(rs.next())
			{
				Training training = new Training();
				training.setTrNo(rs.getInt("trNo"));
				training.setTrName(rs.getString("trName"));
				list.add(training);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//훈련 명 목록
	}
}
