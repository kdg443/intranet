<!-- 과정 상태 제거 -->
<!-- request : prStateName -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="training.ProcessStateDAO" %>
<%@ include file="SessionConfig.jsp" %><!-- 세션 관리 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="state" class="training.ProcessState" scope="page" />
<jsp:setProperty name="state" property="prStateName" />
<script src="./js/Admin.js"></script>

<%
	if(request.getParameter("prStateName").equals("")){
%>
		<script>
			failEvent('양식이 비어있습니다');
		</script>
<%
	}

	ProcessStateDAO psDAO = new ProcessStateDAO();
	int result = psDAO.deleteState(state.getPrStateName());
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%
	}else{
%>
		<script>
			sucessEvent('제거 완료','TrainingDefine.jsp');
		</script>
<%
	}
%>