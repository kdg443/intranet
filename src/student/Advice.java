package student;

//상담 자바빈
public class Advice {
	private int adNo;					//인덱스 번호
	private String prStateName;			//과정 상태
	private int stNo;					//훈련생 인덱스 번호
	private String memId;				//직원 아이디
	private String adDate;				//작성일
	private String adComment;			//상담 내용
	
	public int getAdNo() {
		return adNo;
	}
	public void setAdNo(int adNo) {
		this.adNo = adNo;
	}
	public String getPrStateName() {
		return prStateName;
	}
	public void setPrStateName(String prStateName) {
		this.prStateName = prStateName;
	}
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
	public String getAdDate() {
		return adDate;
	}
	public void setAdDate(String adDate) {
		this.adDate = adDate;
	}
	public String getAdComment() {
		return adComment;
	}
	public void setAdComment(String adComment) {
		this.adComment = adComment;
	}
}
