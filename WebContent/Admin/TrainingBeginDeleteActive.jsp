<!-- DB. 과정 제거 -->
<!-- request : prNo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="training.ProcessDAO" %>
<%@ include file="SessionConfig.jsp" %><!-- 세션 관리 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="process" class="training.Process" scope="page" />
<jsp:setProperty name="process" property="prNo" />
<script src="./js/Admin.js"></script>

<%
	if(request.getParameter("prNo") == null){
%>
		<script>
			failEvent('잘못된 접근 방식입니다.');
		</script>
<%
	}
	ProcessDAO pDAO = new ProcessDAO();
	int result = pDAO.deleteProcess(process.getPrNo());
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%
	}else{
%>
		<script>
			movePage('TrainingBeginConfig.jsp');
		</script>
<%
	}
%>