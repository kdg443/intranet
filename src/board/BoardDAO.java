package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//DB접근. 게시판
public class BoardDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
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
		String SQL = "select bNo from board order by bNo DESC";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				return rs.getInt("bNo") + 1;	//가장 큰 인덱스 번호 부여
			}
			
			return 1;	//튜플이 없을 시 1부터 시작
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//BoardWritActive.jsp
	//글쓰기
	public int write(Board b) {
		connectDB();
		String SQL="insert into board values ( ?, ?, ?, ?, ?, ?)";
		
		try {
			int num = getNext();
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			pstmt.setString(2, b.getbTitle());
			pstmt.setString(3, b.getMemId());
			pstmt.setString(4, b.getbDate());
			pstmt.setString(5, b.getbFile());
			pstmt.setString(6, b.getbContent());
			return pstmt.executeUpdate();	//글쓰기 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle){}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle){}
			if(conn!=null)try {conn.close();}catch(SQLException sqle){}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//BoardInfoUpdateActive.jsp
	//게시판 수정
	public int updateBoard(Board b) {
		connectDB();
		String SQL = "update board set bTitle = ?, bContent = ? where bNo = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, b.getbTitle());
			pstmt.setString(2, b.getbContent());
			pstmt.setInt(3, b.getbNo());
			return pstmt.executeUpdate();	//수정 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle){}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle){}
			if(conn!=null)try {conn.close();}catch(SQLException sqle){}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//BoardInfoDeleteActive.jsp
	//게시판 삭제.	paramNo : bNo ( 게시판 인덱스 번호 )
	public int deleteBoard(int paramNo) {
		connectDB();
		String SQL = "delete from board where bNo = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			return pstmt.executeUpdate();	//제거 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle){}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle){}
			if(conn!=null)try {conn.close();}catch(SQLException sqle){}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//인덱스 번호 정렬.	paramNo : bNo ( 게시판 인덱스 번호 )
	public void indexSort(int paramNo) {
		connectDB();
		String SQL = "select bNo from board where bNo > ? order by bNo asc";
		ArrayList<Board> list = new ArrayList<Board>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {				// 특정 인덱스 번호 + 1 부터 list 작성
				Board b = new Board();
				b.setbNo(rs.getInt("bNo"));
				list.add(b);
			}
			
			for(int i = 0; i < list.size(); i++) {				//특정 인덱스 번호부터 마지막 인덱스 번호 까지 정렬
				SQL = "update board set bNo = ? where bNo = ?";
				
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, paramNo);
				pstmt.setInt(2, list.get(i).getbNo());
				pstmt.executeUpdate();
				
				paramNo++;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle){}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle){}
			if(conn!=null)try {conn.close();}catch(SQLException sqle){}
		}
	}
	
	//BoardInfoFileActive.jsp
	//첨부파일 변경.	paramNo : bNo ( 게시판 인덱스 번호 ), paramName : bFile ( 게시판 첨부파일 이름 )
	public int updateFile(int paramNo, String paramName) {
		connectDB();
		String SQL = "update board set bFile = ? where bNo = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			pstmt.setInt(2, paramNo);
			return pstmt.executeUpdate();	//변경 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle){}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle){}
			if(conn!=null)try {conn.close();}catch(SQLException sqle){}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//Main.jsp
	//최근 작성한 게시물 표시.		visibleNum : 쿼리 실행 시 출력 수 제한
	public ArrayList<Board> getMainList(int visibleNum){
		connectDB();
		String SQL = "select * from board order by bNo desc limit ?";
		ArrayList<Board> list = new ArrayList<Board>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, visibleNum);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Board b = new Board();
				b.setbNo(rs.getInt("bNo"));
				b.setbTitle(rs.getString("bTitle"));
				b.setMemId(rs.getString("memId"));
				b.setbDate(rs.getString("bDate"));
				b.setbContent(rs.getString("bContent"));
				list.add(b);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle){}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle){}
			if(conn!=null)try {conn.close();}catch(SQLException sqle){}
		}
		
		return list;	//게시물 목록
	}
	
	//BoardInfo.jsp, BoardInfoUpdate.jsp
	//특정 게시물의 정보.	paramNo : bNo ( 게시물 인덱스 번호 )
	public ArrayList<Board> getDate(int paramNo){
		connectDB();
		String SQL = "select * from board where bNo = ?";
		ArrayList<Board> list = new ArrayList<Board>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Board b = new Board();
				b.setbNo(rs.getInt("bNo"));
				b.setbTitle(rs.getString("bTitle"));
				b.setMemId(rs.getString("memId"));
				b.setbDate(rs.getString("bDate"));
				b.setbFile(rs.getString("bFile"));
				b.setbContent(rs.getString("bContent"));
				list.add(b);
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
	
	//Board.jsp
	//레코드 총합
	public int totalRecord(){
		connectDB();
		String SQL = "select count(*) bNo from board";	//총 레코드 수
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				return rs.getInt("bNo");		//레코드 총합
			
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
	
	//Board.jsp
	//게시물 목록.	paramBegin : bNo ( 게시판 인덱스 번호 ), limit : 출력 수 제한
	public ArrayList<Board> boardList(int paramBegin, int limit){
		connectDB();
		String SQL = "select * from board where bNo <= ? order by bNo desc limit ?";
		ArrayList<Board> list = new ArrayList<Board>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramBegin);
			pstmt.setInt(2, limit);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Board b = new Board();
				b.setbNo(rs.getInt("bNo"));
				b.setbTitle(rs.getString("bTitle"));
				b.setMemId(rs.getString("memId"));
				b.setbDate(rs.getString("bDate"));
				b.setbFile(rs.getString("bFile"));
				b.setbContent(rs.getString("bContent"));
				list.add(b);
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
