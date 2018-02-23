package training;

//관련 분야 자바빈
public class RelationField {
	private int fNo;							//인덱스 번호
	private String fName;						//관련 분야 명(네트워크, 프로그래밍 등 분야)
	private String fNameCh;						//관련 분야 변경 명
	
	
	public int getfNo() {
		return fNo;
	}
	public void setfNo(int fNo) {
		this.fNo = fNo;
	}
	public String getfName() {
		return fName;
	}
	public void setfName(String fName) {
		this.fName = fName;
	}
	public String getfNameCh() {
		return fNameCh;
	}
	public void setfNameCh(String fNameCh) {
		this.fNameCh = fNameCh;
	}
}
