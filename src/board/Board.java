package board;

//게시판 자바빈
public class Board {
	private int bNo;				//인덱스 번호
	private String bTitle;			//제목
	private String memId;			//작성자
	private String bDate;			//작성일
	private String bFile;			//첨부파일
	private String bContent;		//내용
	
	public int getbNo() {
		return bNo;
	}
	public void setbNo(int bNo) {
		this.bNo = bNo;
	}
	public String getbTitle() {
		return bTitle;
	}
	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getbDate() {
		return bDate;
	}
	public void setbDate(String bDate) {
		this.bDate = bDate;
	}
	public String getbFile() {
		return bFile;
	}
	public void setbFile(String bFile) {
		this.bFile = bFile;
	}
	public String getbContent() {
		return bContent;
	}
	public void setbContent(String bContent) {
		this.bContent = bContent;
	}
}
