<!-- DB. 지원하기 -->
<!-- request : jNo -->
<%@page import="student.ApplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<script src="./js/Student.js"></script>

<%
	//세션 확인
	if(session.getAttribute("stName") == null || String.valueOf(session.getAttribute("stName")).equals("permit")){
%>
		<script>
			failEvent('잘못된 접근방식입니다.');
		</script>
<%		
	}
%>

<%
	int stNo = Integer.parseInt(String.valueOf(session.getAttribute("num")));
	int jNo = Integer.parseInt(request.getParameter("jNo"));
	
	ApplyDAO aDAO = new ApplyDAO();
	int result = aDAO.apply(stNo, jNo);
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%	
	}else if(result == 0){
%>
		<script>
			failEvent('이미 지원한 공고입니다.');
		</script>
<%	
	}else{
%>
		<script>
			sucessEvent('지원 성공','JobMain.jsp');
		</script>
<%	
	}
%>