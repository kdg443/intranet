package student;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import training.RegProcess;
import training.RegProcessDAO;

//DB접근.	훈련생
public class StudentDAO {
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
	
	//StudentLoginConfig.jsp
	//로그인.	paramName : stName ( 훈련생 명 ), paramPwd : stPwd ( 훈련생 비밀번호 ), paramBirth : stBirth ( 훈련생 생년월일 )
	public int login(String paramName, String paramPwd, String paramBirth) {
		connectDB();
		String SQL = "select stPwd,stBirth from student where stName = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				if(rs.getString("stPWd").equals(paramPwd) && rs.getString("stBirth").equals(paramBirth))
					return 1;	//로그인 성공
				else
					return 0;	//로그인 실패
			}
			
			return -1;	//튜플이 없을 시 -1.	로그인 실패(계정없음)
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//인덱스 번호
	public int getNext() {
		connectDB();
		String SQL = "select stNo from student order by stNo desc";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt("stNo") + 1;	// 가장 큰 인덱스 번호 부여
			}
			
			return 1;	// 튜플이 없을 경우 1부터 시작
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;	//데이터베이스 오류
	}
	
	//StudentRegistActive.jsp
	//훈련생 추가
	public int createStudent(Student st) {
		connectDB();
		String SQL = "insert into student values (?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,? ,? ,?)";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, st.getStNo());
			pstmt.setString(2, st.getMemId());
			pstmt.setString(3, st.getStImg());
			pstmt.setString(4, st.getStName());
			pstmt.setString(5, st.getStTyName());
			pstmt.setString(6, st.getPaName());
			pstmt.setString(7, st.getStStateName());
			pstmt.setString(8, st.getStPwd());
			pstmt.setString(9, st.getTel1()+"-"+st.getTel2()+"-"+st.getTel3());
			pstmt.setString(10, st.getStBirth());
			pstmt.setString(11, st.getStAddr());
			pstmt.setString(12, st.getStCharacter());
			pstmt.setString(13, null);
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
	
	//StudentInfoUpdateActive.jsp
	//훈련생 수정
	public int updateStudent(Student st) {
		connectDB();
		String SQL = "update student set memId = ?, stName = ?, stTyName = ?, paName = ?,";
		SQL += "stStateName = ?, stPwd = ?, stTel = ?, stBirth = ?, stAddr = ?,";
		SQL += "stCharacter = ? where stNo = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, st.getMemId());
			pstmt.setString(2, st.getStName());
			pstmt.setString(3, st.getStTyName());
			pstmt.setString(4, st.getPaName());
			pstmt.setString(5, st.getStStateName());
			pstmt.setString(6, st.getStPwd());
			pstmt.setString(7, st.getTel1()+"-"+st.getTel2()+"-"+st.getTel3());
			pstmt.setString(8, st.getStBirth());
			pstmt.setString(9, st.getStAddr());
			pstmt.setString(10, st.getStCharacter());
			pstmt.setInt(11, st.getStNo());
			return pstmt.executeUpdate();	//수정 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2; //데이터베이스 오류
	}
	
	//StudentInfoDeleteActive.jsp
	//훈련생 제거.	paramNo : stNo ( 훈련생 인덱스 번호 )
	public int deleteStudent(int paramNo) {
		connectDB();
		String SQL = "delete from student where stNo = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			return pstmt.executeUpdate();	//제거 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return -2; //데이터베이스 오류
	}
	
	//StudentResumeActive.jsp
	//이력서 생성.	paramNo : stNo ( 훈련생 인덱스 번호 ), paramName : stResume ( 훈련생 이력서 파일 이름 )
	public int updateResume(int paramNo, String paramName) {
		connectDB();
		String SQL = "update student set stResume = ? where stNo = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			pstmt.setInt(2, paramNo);
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
	
	//StudentInfoImgActive.jsp
	//훈련생 사진 갱신.	paramNo : stNo ( 훈련생 인덱스 번호 ), paramName : stImg (훈련생 이미지 파일 이름 )
	public int updateImg(int paramNo, String paramName) {
		connectDB();
		String SQL = "update student set stImg = ? where stNo = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			pstmt.setInt(2, paramNo);
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
	
	//Student.jsp, AdviceAccept.jsp, Advice.jsp, AdviceAfter.jsp
	//특정 훈련생 정보.	paramNo : stNo (훈련생 인덱스 번호)
	public ArrayList<Student> getData(int paramNo){
		connectDB();
		String SQL = "select * from student where stNo = ?";
		ArrayList<Student> list = new ArrayList<Student>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, paramNo);
			rs = pstmt.executeQuery();	//검색 성공
			
			if(rs.next()) {
				Student st = new Student();
				st.setStNo(rs.getInt("stNo"));
				st.setMemId(rs.getString("memId"));
				st.setStImg(rs.getString("stImg"));
				st.setStName(rs.getString("stName"));
				st.setStTyName(rs.getString("stTyName"));
				st.setPaName(rs.getString("paName"));
				st.setStStateName(rs.getString("stStateName"));
				st.setStPwd(rs.getString("stPwd"));
				st.setStTel(rs.getString("stTel"));
				st.setStBirth(rs.getString("stBirth"));
				st.setStAddr(rs.getString("stAddr"));
				st.setStCharacter(rs.getString("stCharacter"));
				st.setStResume(rs.getString("stResume"));
				list.add(st);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//훈련생 정보 목록
	}
	
	//StudentSearch.jsp
	//훈련생 이름으로 확인.	paramName : stName ( 훈련생 이름 )
	public ArrayList<Student> getData(String paramName){
		connectDB();
		String SQL = "select * from student where stName = ?";
		ArrayList<Student> list = new ArrayList<Student>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, paramName);
			rs = pstmt.executeQuery();	//검색 성공
			
			if(rs.next()) {
				Student st = new Student();
				st.setStNo(rs.getInt("stNo"));
				st.setMemId(rs.getString("memId"));
				st.setStImg(rs.getString("stImg"));
				st.setStName(rs.getString("stName"));
				st.setStTyName(rs.getString("stTyName"));
				st.setPaName(rs.getString("paName"));
				st.setStStateName(rs.getString("stStateName"));
				st.setStPwd(rs.getString("stPwd"));
				st.setStTel(rs.getString("stTel"));
				st.setStBirth(rs.getString("stBirth"));
				st.setStAddr(rs.getString("stAddr"));
				st.setStCharacter(rs.getString("stCharacter"));
				st.setStResume(rs.getString("stResume"));
				list.add(st);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(SQLException sqle) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException sqle) {}
			if(conn!=null)try {conn.close();}catch(SQLException sqle) {}
		}
		
		return list;	//훈련생 정보 목록
	}
	
	//Student.jsp
	//훈련생 상태 총합.	paramNo : prNo (과정 인덱스 번호), paramType : stStateName (훈련생 상태 명)
	public int getTotalType(int paramNo,String paramType) {
		RegProcessDAO rpDAO = new RegProcessDAO();
		ArrayList<RegProcess> rpList = new ArrayList<RegProcess>();
		
		rpList = rpDAO.getListRegist(paramNo);
		
		int count = 0;
		
		if(paramType.equals("총원")) {
			count = rpList.size();			//해당 과정의 모든 훈련생 수
		}else {
			for(int i = 0; i < rpList.size(); i++) {
				ArrayList<Student> stList = new ArrayList<Student>();
				
				stList = getData(rpList.get(i).getStNo());
				
				//특정 상태인 훈련생 수
				if(paramType.equals(stList.get(0).getStStateName())) {
					count ++;
				}
			}
		}
		
		return count;	//합계
	}
}
