package member;

//직원 자바빈
public class Member {
	private int memNo;				//인덱스 번호
	private String depName;			//부서이름
	private String memName;			//성명
	private String memId;			//아이디
	private String memPwd;			//비밀번호
	private String memTel;			//전화번호. 정보 얻을 시 사용
	private String tel1;			//전화번호 첫번째 자리.	추가.변경 시 사용
	private String tel2;			//전화번호 두번째 자리.	추가.변경 시 사용
	private String tel3;			//전화번호 세번째 자리.	추가.변경 시 사용
	private String memResume;		//이력서 이름
	private int memAdmin;			//Admin 접근 권한 (0 : 접근 X, 1 : 접근 O)
	
	public int getMemNo() {
		return memNo;
	}
	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}
	public String getDepName() {
		return depName;
	}
	public void setDepName(String depName) {
		this.depName = depName;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getMemPwd() {
		return memPwd;
	}
	public void setMemPwd(String memPwd) {
		this.memPwd = memPwd;
	}
	public String getMemTel() {
		return memTel;
	}
	public void setMemTel(String memTel) {
		this.memTel = memTel;
	}
	public String getTel1() {
		return tel1;
	}
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}
	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	public String getTel3() {
		return tel3;
	}
	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}
	public String getMemResume() {
		return memResume;
	}
	public void setMemResume(String memResume) {
		this.memResume = memResume;
	}
	public int getMemAdmin() {
		return memAdmin;
	}
	public void setMemAdmin(int memAdmin) {
		this.memAdmin = memAdmin;
	}
	
}