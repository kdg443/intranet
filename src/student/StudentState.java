package student;

//훈련생 상태 자바빈
public class StudentState {
	private int stStateNo;				//인덱스 번호
	private String stStateName;			//상태명 (Ex. 훈련생, 수료생)
	
	public int getStStateNo() {
		return stStateNo;
	}
	public void setStStateNo(int stStateNo) {
		this.stStateNo = stStateNo;
	}
	public String getStStateName() {
		return stStateName;
	}
	public void setStStateName(String stStateName) {
		this.stStateName = stStateName;
	}
}
