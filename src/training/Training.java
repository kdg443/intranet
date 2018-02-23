package training;

//훈련 속성 자바빈
public class Training {
	private int trNo;						//인덱스 번호
	private String trType;					//훈련구분
	private String trRoom;					//교육실
	private String trName;					//과정명
	
	public int getTrNo() {
		return trNo;
	}
	public void setTrNo(int trNo) {
		this.trNo = trNo;
	}
	public String getTrType() {
		return trType;
	}
	public void setTrType(String trType) {
		this.trType = trType;
	}
	public String getTrRoom() {
		return trRoom;
	}
	public void setTrRoom(String trRoom) {
		this.trRoom = trRoom;
	}
	public String getTrName() {
		return trName;
	}
	public void setTrName(String trName) {
		this.trName = trName;
	}
}