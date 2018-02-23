package training;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//교육실 테이블 접근
public class TrainingRoomDAO {
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
		String SQL = "select trNo from training_room order by trNo desc";
		
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
	//교육실 생성.	paramName : trRoom ( 교육실 명 )
	public int createRoom(String paramName) {
		connectDB();
		String SQL = "select trRoom from training_room where trRoom = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				if(rs.getString("trRoom").equals(paramName))
				{
					return -1;	//중복
				}
			}
			
			int num = getNext();
			
			SQL = "insert into training_room values (?,?)";
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
	//교육실 수정.	param : trRoom ( 교육실 기존 명 ), paramNew : trRoom ( 교육실 변경 명 )
	public int updateRoom(String param,String paramNew) {
		connectDB();
		String SQL = "select trRoom from training_room where trRoom = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramNew);
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				if(rs.getString("trRoom").equals(paramNew))
					return -1;	//중복
			}
			
			SQL = "update training_room set trRoom = ? where trRoom = ?";
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
	//교육실 제거.	paramName : trRoom ( 교육실 명 )
	public int removeRoom(String paramName) {
		connectDB();
		String SQL = "delete from training_room where trRoom = ?";
		
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
	//교육실 목록.
	public ArrayList<Training> getList(){
		connectDB();
		String SQL = "select * from training_room";
		ArrayList<Training> list = new ArrayList<Training>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				Training training = new Training();
				training.setTrRoom(rs.getString("trRoom"));
				list.add(training);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//교육실 목록
	}
}
