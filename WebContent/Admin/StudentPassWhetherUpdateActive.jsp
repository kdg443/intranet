<!-- 훈련생 합격여부 생성 -->
<!-- request : paName, paNameCh -->
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

	int result = pwDAO.updatePass(pw.getPaName(), request.getParameter("paNameCh"));
	
	if(result == -1){
%>
		<script>
			failEvent('변경할 이름이 이미 존재합니다.');
		</script>
<%
	}else if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%
	}else{
%>
		<script>
			sucessEvent('수정 완료','StudentDefine.jsp');
		</script>
<%
	}
%>