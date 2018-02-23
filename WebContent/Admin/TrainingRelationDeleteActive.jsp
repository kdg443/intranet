<!-- 과정 관련분야 제거 -->
<!-- request : fName -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="training.RelationFieldDAO" %>
<%@ include file="SessionConfig.jsp" %><!-- 세션 관리 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="relation" class="training.RelationField" scope="page"/>
<jsp:setProperty name="relation" property="fName" />
<script src="./js/Admin.js"></script>

<%
	if(request.getParameter("fName").equals("")){
%>
		<script>
			failEvent('양식이 비어있습니다');
		</script>
<%
	}
	
	RelationFieldDAO rfDAO = new RelationFieldDAO();
	int result = rfDAO.deleteField(relation.getfName());
	
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