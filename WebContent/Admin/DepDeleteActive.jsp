<!-- DB. 부서 제거 -->
<!-- request : depName -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.DepDAO" %>
<%@ include file="SessionConfig.jsp" %><!-- 세션 관리 -->			
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="dept" class="member.Dep" scope="page"/>
<jsp:setProperty name="dept" property="depName" />
<script src="./js/Admin.js"></script>

<%
	if(request.getParameter("depName") == null){
%>
		<script>
			failEvent('잘못된 접근 방식입니다.');
		</script>
<%
	}
	
	DepDAO dDAO = new DepDAO();

	int result = dDAO.deleteDep(dept.getDepName());
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%
	}else{
%>
		<script>
			sucessEvent('제거 완료','MemberJoin.jsp');
		</script>
<%
	}
%>