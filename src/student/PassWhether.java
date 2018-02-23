package student;

//합격 여부 자바빈
public class PassWhether {
	private int paNo;			//인덱스 번호
	private String paName;		//합격 여부 명 (Ex. 접수중, 합격, 합격대기)
	
	public int getPaNo() {
		return paNo;
	}
	public void setPaNo(int paNo) {
		this.paNo = paNo;
	}
	public String getPaName() {
		return paName;
	}
	public void setPaName(String paName) {
		this.paName = paName;
	}
}
