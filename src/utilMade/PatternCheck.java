package utilMade;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PatternCheck {
	private Pattern p = null;
	private Matcher match;
	
	//숫자 판별.	숫자만 있을 시 = TRUE, 숫자의외에 데이터가 있을 시 = FALSE
	public boolean examination(String check) {
		p = Pattern.compile("^[0-9]*$");
		match = p.matcher(check);
		
		return match.find();
	}
	
	//날짜 구별 특수문자 판별.	'-'가 있을 시 = TRUE, 없을 시  = FALSE
	public boolean checkDate(String check) {
		p = Pattern.compile("[-]");
		match = p.matcher(check);
		
		return match.find();
	}
}