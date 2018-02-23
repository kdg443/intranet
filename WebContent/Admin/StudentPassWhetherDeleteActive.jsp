<!-- 훈련생 합격여부 제거 -->
<!-- request : paName -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="student.PassWhetherDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ include file="SessionConfig.jsp" %><!-- 세션 관리 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="pw" class="student.PassWhether" scope="page" />
<jsp:setProperty name="pw" property="paName" />
<script src="./js/Admin.js"></script>

<%
	if(request.getParameter("paName") == null){
%>
		<script>
			failEvent('잘못된 접근 방식입니다.');
		</script>
<%
	}
	PassWhetherDAO pwDAO = new PassWhetherDAO();

	int result = pwDAO.deletePass(pw.getPaName());
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%
	}else{
%>
		<script>
			sucessEvent('제거 완료','StudentDefine.jsp');
		</script>
<%
	}
%>