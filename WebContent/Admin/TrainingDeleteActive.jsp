<!-- 과정 속성 제거 -->
<!-- request : trType, trRoom, trName -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="training.TrainingTypeDAO" %>
<%@ page import="training.TrainingRoomDAO" %>
<%@ page import="training.TrainingNameDAO" %>
<%@ include file="SessionConfig.jsp" %><!-- 세션 관리 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="training" class="training.Training" scope="page" />
<jsp:setProperty name="training" property="trType" />
<jsp:setProperty name="training" property="trRoom" />
<jsp:setProperty name="training" property="trName" />
<script src="./js/Admin.js"></script>

<%
	//파라미터 값 확인
	if(request.getParameter("trType").equals("") &&
			request.getParameter("trRoom").equals("") &&
			request.getParameter("trName").equals(""))
	{
%>
		<script>
			failEvent('모든 양식이 비어있습니다.');
		</script>
<%
	}
	
	int result;	//리턴값 확인
	
	//훈련종류
	if(!(request.getParameter("trType").equals("")))
	{
		TrainingTypeDAO tTypeDAO = new TrainingTypeDAO();
		result = tTypeDAO.removeType(training.getTrType());
		
		if(result == -2)	//데이터 베이스오류
		{
%>
			<script>
				failEvent('데이터베이스 오류');
			</script>
<%
		}
	}
	
	//교육실
	if(!(request.getParameter("trRoom").equals("")))
	{
		TrainingRoomDAO tRoomDAO = new TrainingRoomDAO();
		result = tRoomDAO.removeRoom(training.getTrRoom());
		
		if(result == -2)	//데이터 베이스오류
		{
%>
			<script>
				failEvent('데이터베이스 오류');
			</script>
<%
		}
	}
	
	//훈련명
	if(!(request.getParameter("trName").equals("")))
	{
		TrainingNameDAO tNameDAO = new TrainingNameDAO();
		result = tNameDAO.removeName(training.getTrName());
		
		if(result == -2)	//데이터 베이스오류
		{
%>
			<script>
				failEvent('데이터베이스 오류');
			</script>
<%
		}
	}
%>
<!-- 제거완료 -->
<script>
	sucessEvent('제거 완료','TrainingDefine.jsp');
</script>
