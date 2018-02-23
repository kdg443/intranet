package student;

//훈련생 유형 자바빈
public class StudentType {
	private int stTyNo;					//인덱스 번호
	private String stTyName;			//훈련생 유형 명(4대보험적용자 등)
	
	public int getStTyNo() {
		return stTyNo;
	}
	public void setStTyNo(int stTyNo) {
		this.stTyNo = stTyNo;
	}
	public String getStTyName() {
		return stTyName;
	}
	public void setStTyName(String stTyName) {
		this.stTyName = stTyName;
	}
}
