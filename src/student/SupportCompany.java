package student;

//훈련생 기업 지원 자바빈
public class SupportCompany {
	private int scNo;						//인덱스 번호
	private int stNo;						//훈련생 인덱스 번호
	private String scDate;					//지원일자
	private String scCompany;				//기업이름
	private String scAddr;					//기업주소
	private String scName;					//담당자
	private String scTel;					//기업 전화번호
	private String scContent;				//알선내용
	private String scResult;				//최종결과
	private String scReason;				//사유
	
	public int getScNo() {
		return scNo;
	}
	public void setScNo(int scNo) {
		this.scNo = scNo;
	}
	public int getStNo() {
		return stNo;
	}
	public void setStNo(int stNo) {
		this.stNo = stNo;
	}
	public String getScDate() {
		return scDate;
	}
	public void setScDate(String scDate) {
		this.scDate = scDate;
	}
	public String getScCompany() {
		return scCompany;
	}
	public void setScCompany(String scCompany) {
		this.scCompany = scCompany;
	}
	public String getScAddr() {
		return scAddr;
	}
	public void setScAddr(String scAddr) {
		this.scAddr = scAddr;
	}
	public String getScName() {
		return scName;
	}
	public void setScName(String scName) {
		this.scName = scName;
	}
	public String getScTel() {
		return scTel;
	}
	public void setScTel(String scTel) {
		this.scTel = scTel;
	}
	public String getScContent() {
		return scContent;
	}
	public void setScContent(String scContent) {
		this.scContent = scContent;
	}
	public String getScResult() {
		return scResult;
	}
	public void setScResult(String scResult) {
		this.scResult = scResult;
	}
	public String getScReason() {
		return scReason;
	}
	public void setScReason(String scReason) {
		this.scReason = scReason;
	}
}
