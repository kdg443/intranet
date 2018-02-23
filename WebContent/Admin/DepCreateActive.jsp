<!-- DB. 부서 생성 -->
<!-- request : depName -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.DepDAO" %>
<%@ include file="SessionConfig.jsp" %><!-- 세션 관리 -->			
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dep" class="member.Dep" scope="page"/>
<jsp:setProperty name="dep" property="depName"/>
<script src="./js/Admin.js"></script>

<%
	if(request.getParameter("depName") == null){
%>
		<script>
			failEvent('잘못된 접근방식입니다.');
		</script>
<%
	}

	if(request.getParameter("depName").equals(""))
	{
%>
		<script>
			failEvent('양식이 비어있습니다.');
		</script>
<%
	}

	DepDAO dDAO = new DepDAO();

	int result = dDAO.createDep(dep.getDepName());
	
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
			sucessEvent('생성 완료','MemberJoin.jsp');
		</script>
<%
	}
%>