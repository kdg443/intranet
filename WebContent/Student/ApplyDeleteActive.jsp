<!-- DB. 지원 공고 제거 -->
<!-- request : jNo -->
<%@page import="java.io.PrintWriter"%>
<%@page import="student.ApplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<script src="./js/Student.js"></script>

<%
	PrintWriter script = response.getWriter();
	int stNo = Integer.parseInt(String.valueOf(session.getAttribute("num")));
	int jNo = Integer.parseInt(request.getParameter("jNo"));
	
	ApplyDAO aDAO = new ApplyDAO();

	int result = aDAO.deleteApply(stNo, jNo);
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%
	}else{
%>
		<script>
			sucessEvent('취소하였습니다','ApplyConfig.jsp');
		</script>
<%
	}
%>