package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//DB접근. 직원
public class MemberDAO {
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
	
	//LoginConfig.jsp
	//로그인.	id : memId ( 직원 아이디 ), pwd : memPwd ( 직원 패스워드 )
	public int login(String id, String pwd) {
		connectDB();
		String SQL = "select memPwd from member where memId=?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				if(rs.getString("memPwd").equals(pwd))
					return 1; // 로그인 성공
				else
					return 0; // 비밀번호 불일치
			}
			
			return -1; // 아이디 없음
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2; //데이터베이스 오류
	}
	
	//인덱스 번호
	public int getNext() {
		connectDB();
		String SQL = "select memNo from member order by memNo desc";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				return rs.getInt("memNo") + 1;	//가장 큰 인덱스 번호 부여
			}
			
			return 1;	//튜플이 없을 시 1부터 시작
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//MemberCreateActive.jsp
	//회원가입.
	public int join(Member member) {
		connectDB();
		String SQL = "select memId from member where memId = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, member.getMemId());
			rs = pstmt.executeQuery();	//검색 성공
			
			if(rs.next()) {
				if(rs.getString("memId").equals(member.getMemId())) return -1;	//아이디 중복
			}
			int num = getNext();
			SQL = "insert into member values (? ,? ,? ,? ,? ,? ,? ,?)";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			pstmt.setString(2, member.getDepName());
			pstmt.setString(3, member.getMemName());
			pstmt.setString(4, member.getMemId());
			pstmt.setString(5, member.getMemPwd());
			pstmt.setString(6, member.getTel1()+"-"+member.getTel2()+"-"+member.getTel3());
			pstmt.setString(7, member.getMemResume());
			pstmt.setInt(8, 0);
			return pstmt.executeUpdate();	//가입 완료
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//MemberUpdateActive.jsp
	//회원 정보 수정
	public int updateMember(Member member) {
		connectDB();
		String SQL = "update member set depName = ?, memName = ?,";
		SQL += "memPwd = ?, memTel = ?, memResume = ?, memAdmin = ? where memId = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, member.getDepName());
			pstmt.setString(2, member.getMemName());
			pstmt.setString(3, member.getMemPwd());
			pstmt.setString(4, member.getTel1()+"-"+member.getTel2()+"-"+member.getTel3());
			pstmt.setString(5, member.getMemResume());
			pstmt.setInt(6, member.getMemAdmin());
			pstmt.setString(7, member.getMemId());
			return pstmt.executeUpdate();	//수정 완료
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//MemberDeleteActive.jsp
	//멤버 제거.	paramId : memId ( 직원 아이디 )
	public int deleteMember(String paramId) {
		connectDB();
		String SQL = "select memNo from member where memId = ?";
		ArrayList<Member> list = new ArrayList<Member>();
		
		try {
			int index = 0;
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) index = rs.getInt("memNo");
			
			SQL = "delete from member where memNo = ?";
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramId);
			pstmt.executeUpdate();		//직원 제거
			
			SQL = "select * from member where memNo > ? order by memNo asc";
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, index);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {			//제거한 쿼리의 인덱스 보다 높은 인덱스 ArrayList에 추가
				do {
					Member m = new Member();
					m.setMemNo(rs.getInt("memNo"));
					list.add(m);
				}while(rs.next());
				
				for(int i = 0; i < list.size(); i++) {					//인덱스 번호 정렬
					SQL = "update member set memNo = ? where memNo = ?";
					
					pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, index);
					pstmt.setInt(2, list.get(i).getMemNo());
					pstmt.executeUpdate();
					
					index += 1;
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
	
	//MemberResumeActive.jsp
	//이력서 파일 수정.	paramId : memId ( 직원 아이디 ), paramName : memResume ( 직원 이력서 )
	public int updateResume(String paramId, String paramName) {
		connectDB();
		String SQL = "update member set memResume = ? where memId = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			pstmt.setString(2, paramId);
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
	
	//TrainingBegin.jsp, TrainingBeginUpdate.jsp, StudentRegist.jsp
	//부서 별 멤버 출력.
	public ArrayList<Member> getListDep(String paramDept){
		connectDB();
		String SQL = "select * from member where depName = ?";
		ArrayList<Member> list = new ArrayList<Member>();

		try {			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramDept);
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				Member member = new Member();
				member.setMemNo(rs.getInt("memNo"));
				member.setDepName(rs.getString("depName"));
				member.setMemName(rs.getString("memName"));
				member.setMemId(rs.getString("memId"));
				member.setMemPwd(rs.getString("memPwd"));
				member.setMemTel(rs.getString("memTel"));
				member.setMemResume(rs.getString("memResume"));
				list.add(member);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//직원 목록
	}
	
	//MemberUpdate.jsp, LoginInfo.jsp
	//특정 멤버 확인.	paramName : memId(멤버 아이디)
	public ArrayList<Member> getList(String paramId){
		connectDB();
		String SQL = "select * from member where memId = ?";
		ArrayList<Member> list = new ArrayList<Member>();

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				Member member = new Member();
				member.setMemNo(rs.getInt("memNo"));
				member.setDepName(rs.getString("depName"));
				member.setMemName(rs.getString("memName"));
				member.setMemId(rs.getString("memId"));
				member.setMemPwd(rs.getString("memPwd"));
				member.setMemTel(rs.getString("memTel"));
				member.setMemResume(rs.getString("memResume"));
				member.setMemAdmin(rs.getInt("memAdmin"));
				list.add(member);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//직원 정보 목록
	}
	
	//AdviceUpdate.jsp
	//총 멤버 목록
	public ArrayList<Member> getList(){
		connectDB();
		String SQL = "select * from member";
		ArrayList<Member> list = new ArrayList<Member>();

		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Member member = new Member();
				member.setMemNo(rs.getInt("memNo"));
				member.setDepName(rs.getString("depName"));
				member.setMemName(rs.getString("memName"));
				member.setMemId(rs.getString("memId"));
				member.setMemPwd(rs.getString("memPwd"));
				member.setMemTel(rs.getString("memTel"));
				member.setMemResume(rs.getString("memResume"));
				member.setMemAdmin(rs.getInt("memAdmin"));
				list.add(member);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//직원 정보 목록
	}
	
	//MemberConfig.jsp
	//레코드 총합
	public int totalRecord(){
		connectDB();
		String SQL = "select count(*) memNo from member";	//10개까지 제한
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				return rs.getInt("memNo");		//레코드 총합
			
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
	
	//MemberConfig.jsp
	//게시물 목록.	paramBegin : memNo ( 직원 인덱스 번호 ), limit : 출력 수 제한
	public ArrayList<Member> boardList(int paramBegin, int limit){
		connectDB();
		String SQL = "select * from member where memNo <= ? order by memNo desc limit ?";
		ArrayList<Member> list = new ArrayList<Member>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramBegin);
			pstmt.setInt(2, limit);
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				Member member = new Member();
				member.setMemNo(rs.getInt("memNo"));
				member.setDepName(rs.getString("depName"));
				member.setMemName(rs.getString("memName"));
				member.setMemId(rs.getString("memId"));
				member.setMemPwd(rs.getString("memPwd"));
				member.setMemTel(rs.getString("memTel"));
				member.setMemResume(rs.getString("memResume"));
				list.add(member);
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
