package student;

//자격증 자바빈
public class License {
	private int liNo;			//인덱스 번호
	private int stNo;			//훈련생 인덱스 번호
	private String liName;		//자격증 명
	
	public int getLiNo() {
		return liNo;
	}
	public void setLiNo(int liNo) {
		this.liNo = liNo;
	}
	public int getStNo() {
		return stNo;
	}
	public void setStNo(int stNo) {
		this.stNo = stNo;
	}
	public String getLiName() {
		return liName;
	}
	public void setLiName(String liName) {
		this.liName = liName;
	}
}
