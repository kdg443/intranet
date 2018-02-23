package student;

//훈련생 자바빈
public class Student {
	private int stNo;					//인덱스 번호
	private String memId;				//직원 아이디(=담당교사)
	private String stImg;				//이미지 파일이름
	private String stName;				//성명
	private String stTyName;			//유형 (Ex. 4대보험적용자)
	private String paName;				//합격 여부 (Ex. 합격, 합격대기)
	private String stStateName;			//상태 (Ex. 훈련생, 중도탈락)
	private String stPwd;				//비밀번호
	private String stTel;				//전화번호.	데이터 얻을때 사용
	private String tel1;				//전화번호 첫번째 자리.	stTel = tel1 + tel2 + tel3.	데이터 삽입, 수정시 사용
	private String tel2;				//전화번호 두번째 자리
	private String tel3;				//전화번호 세번째 자리
	private String stBirth;				//생년월일
	private String stAddr;				//주소
	private String stCharacter;			//특이사항
	private String stResume;			//이력서
	
	public int getStNo() {
		return stNo;
	}
	public void setStNo(int stNo) {
		this.stNo = stNo;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getStImg() {
		return stImg;
	}
	public void setStImg(String stImg) {
		this.stImg = stImg;
	}
	public String getStName() {
		return stName;
	}
	public void setStName(String stName) {
		this.stName = stName;
	}
	public String getStTyName() {
		return stTyName;
	}
	public void setStTyName(String stTyName) {
		this.stTyName = stTyName;
	}
	public String getPaName() {
		return paName;
	}
	public void setPaName(String paName) {
		this.paName = paName;
	}
	public String getStStateName() {
		return stStateName;
	}
	public void setStStateName(String stStateName) {
		this.stStateName = stStateName;
	}
	public String getStPwd() {
		return stPwd;
	}
	public void setStPwd(String stPwd) {
		this.stPwd = stPwd;
	}
	public String getStTel() {
		return stTel;
	}
	public void setStTel(String stTel) {
		this.stTel = stTel;
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
	public String getStBirth() {
		return stBirth;
	}
	public void setStBirth(String stBirth) {
		this.stBirth = stBirth;
	}
	public String getStAddr() {
		return stAddr;
	}
	public void setStAddr(String stAddr) {
		this.stAddr = stAddr;
	}
	public String getStCharacter() {
		return stCharacter;
	}
	public void setStCharacter(String stCharacter) {
		this.stCharacter = stCharacter;
	}
	public String getStResume() {
		return stResume;
	}
	public void setStResume(String stResume) {
		this.stResume = stResume;
	}
}