package member;

//부서 자바빈
public class Dep {
	private int depNo;				//인덱스 번호
	private String depName;			//부서 이름
	private String depNameCh;		//변경할 부서 이름
	
	public int getDepNo() {
		return depNo;
	}

	public void setDepNo(int depNo) {
		this.depNo = depNo;
	}

	public String getDepName() {
		return depName;
	}

	public void setDepName(String depName) {
		this.depName = depName;
	}
	public String getDepNameCh() {
		return depNameCh;
	}

	public void setDepNameCh(String depNameCh) {
		this.depNameCh = depNameCh;
	}
}
