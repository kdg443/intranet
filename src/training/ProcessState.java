package training;

//과정 상태 자바빈
public class ProcessState {
	private int prStateNo;						//인덱스 번호
	private String prStateName;					//과정 상태명 ( 개강전, 훈련중 )
	private String prStateNameCh;				//과정 상태 변경 명
	
	public int getPrStateNo() {
		return prStateNo;
	}
	public void setPrStateNo(int prStateNo) {
		this.prStateNo = prStateNo;
	}
	public String getPrStateName() {
		return prStateName;
	}
	public void setPrStateName(String prStateName) {
		this.prStateName = prStateName;
	}
	public String getPrStateNameCh() {
		return prStateNameCh;
	}
	public void setPrStateNameCh(String prStateNameCh) {
		this.prStateNameCh = prStateNameCh;
	}
}
