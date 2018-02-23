package training;

//과정 관련 분야(해당 과정에 포함되는 관련 분야) 자바빈
public class ProcessField {
	private int prFiNo;						//인덱스 번호
	private int prNo;						//과정 인덱스 번호
	private String fName;					//관련 분야 명
	
	public int getPrFiNo() {
		return prFiNo;
	}
	public void setPrFiNo(int prFiNo) {
		this.prFiNo = prFiNo;
	}
	public int getPrNo() {
		return prNo;
	}
	public void setPrNo(int prNo) {
		this.prNo = prNo;
	}
	public String getfName() {
		return fName;
	}
	public void setfName(String fName) {
		this.fName = fName;
	}
}
