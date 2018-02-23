<!-- 훈련생 상태 수정 -->
<!-- request : stStateName, stStateNameCh -->
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

	int result = sStateDAO.updateStState(state.getStStateName(), request.getParameter("stStateNameCh"));
	
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