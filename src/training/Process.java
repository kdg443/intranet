package training;

//과정 자바빈
public class Process {
	private int prNo;					//인덱스 번호
	private String trType;				//훈련구분
	private String prDate;				//개강일+수료일. 정보 얻을 시 사용
	private String sDate;				//개강일.	sDate,eDate는 추가,수정시 사용
	private String eDate;				//수료일
	private int prQueta;				//수용인원
	private String prStateName;			//과정 상태명 ( 개강전, 훈련중 )
	private String trName;				//과정명
	private String memId;				//직원 이름 ( 담당교사 )
	private String trRoom;				//교육실
	
	public int getPrNo() {
		return prNo;
	}
	public void setPrNo(int prNo) {
		this.prNo = prNo;
	}
	public String getTrType() {
		return trType;
	}
	public void setTrType(String trType) {
		this.trType = trType;
	}
	public String getPrDate() {
		return prDate;
	}
	public void setPrDate(String prDate) {
		this.prDate = prDate;
	}
	public String getsDate() {
		return sDate;
	}
	public void setsDate(String sDate) {
		this.sDate = sDate;
	}
	public String geteDate() {
		return eDate;
	}
	public void seteDate(String eDate) {
		this.eDate = eDate;
	}
	public int getPrQueta() {
		return prQueta;
	}
	public void setPrQueta(int prQueta) {
		this.prQueta = prQueta;
	}
	public String getPrStateName() {
		return prStateName;
	}
	public void setPrStateName(String prStateName) {
		this.prStateName = prStateName;
	}
	public String getTrName() {
		return trName;
	}
	public void setTrName(String trName) {
		this.trName = trName;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getTrRoom() {
		return trRoom;
	}
	public void setTrRoom(String trRoom) {
		this.trRoom = trRoom;
	}
}
