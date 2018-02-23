<!-- 훈련생 상태 제거 -->
<!-- request : stStateName -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="student.StudentStateDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ include file="SessionConfig.jsp" %><!-- 세션 관리 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="state" class="student.StudentState" scope="page" />
<jsp:setProperty name="state" property="stStateName" />
<script src="./js/Admin.js"></script>

<%
	if(request.getParameter("stStateName") == null){
%>
		<script>
			failEvent('잘못된 접근 방식입니다.');
		</script>
<%
	}
	StudentStateDAO sStateDAO = new StudentStateDAO();

	int result = sStateDAO.deleteStState(state.getStStateName());
	
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