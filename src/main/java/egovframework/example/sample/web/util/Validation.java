package egovframework.example.sample.web.util;

import java.util.List;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletResponse;


import egovframework.example.sample.service.impl.SampleDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public class Validation {
	public static boolean isNull(String str){
		return str == null || str.isEmpty() || str.equals("null") || str.equals("NaN") || str.equals("undefined");
	}
	
	public static boolean isValidEmail(String email) { 
		return Pattern.matches("^[_a-zA-Z0-9-\\.]+@[\\.a-zA-Z0-9-]+\\.[a-zA-Z]+$", email);
//		boolean err = false; 
//		String regex = "^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$"; 
//		Pattern p = Pattern.compile(regex); 
//		Matcher m = p.matcher(email); 
//		if(m.matches()) { err = true; } 
//		System.out.println("err:"+err);
//		return err;
	}
	public static boolean isEnNum(String str){
		return Pattern.matches("[a-zA-Z0-9]*$", str);
	}
	public static boolean isValidPhone(String str) {
	    return Pattern.matches("^\\d{2,3}\\d{3,4}\\d{4}$", str);
	}

	public static String getTempPassword(int length) {
		int index = 0;
		char[] charArr = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
				'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a',
				'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
				'w', 'x', 'y', 'z' };
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++) {
			index = (int) (charArr.length * Math.random());
			sb.append(charArr[index]);
		}
		return sb.toString();
	}
	
	public static String getTempNumber(int length) {
		int index = 0;
		char[] charArr = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++) {
			index = (int) (charArr.length * Math.random());
			sb.append(charArr[index]);
		}
		return sb.toString();
	}
	
	// 엑셀
	
}
