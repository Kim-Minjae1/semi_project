package com.book.common.filter;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class PasswordEncodingWrapper extends HttpServletRequestWrapper{

	public PasswordEncodingWrapper(HttpServletRequest request) {
		super(request);
		
	}
	
	@Override
	public String getParameter(String name) {
		String result = super.getParameter(name);
		if("pw".equals(name)) {
			String ori = super.getParameter(name);
			String enc = getSHA512(ori);

			
			result = enc;
		}
		return result;
	}
	
	//매개변수로 문자열을 받아서 암호화된 문자열 리턴
	private String getSHA512(String oriStr) {
		// Java에서 제공하는 암호화 처리 클래스
		MessageDigest md = null;
		try {
			// 적용할 알고리즘 선택하여 인스턴스화
			md = MessageDigest.getInstance("SHA-512");
		}catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		// String을 byte배열로 자름
		byte[] oriData = oriStr.getBytes();
		// 자른 데이터를 암호화 처리
		md.update(oriData);
		byte[] encryptData = md.digest();
		return Base64.getEncoder().encodeToString(encryptData);
	}	
	
}