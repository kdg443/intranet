<!-- 과정 상태 생성 -->
<!-- request : prStateName, prStateNameCh -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="training.ProcessStateDAO" %>
<%@ include file="SessionConfig.jsp" %><!-- 세션 관리 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="state" class="training.ProcessState" scope="page" />
<jsp:setProperty name="state" property="prStateName" />
<jsp:setProperty name="state" property="prStateNameCh" />
<script src="./js/Admin.js"></script>

<%
	if(request.getParameter("prStateName") == null){
%>
		<script>
			failEvent('잘못된 접근 방식입니다.');
		</script>
<%
	}
	
	if(request.getParameter("prStateName").equals("") || request.getParameter("prStateNameCh").equals("")){
%>
		<script>
			failEvent('양식이 비어있습니다.');
		</script>
<%
	}

	ProcessStateDAO psDAO = new ProcessStateDAO();
	int result = psDAO.updateState(state.getPrStateName(), state.getPrStateNameCh());
	
	if(result == -1){
%>
		<script>
			failEvent('중복된 이름입니다.');
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
			sucessEvent('수정 완료','TrainingDefine.jsp');
		</script>
<%
	}
%>