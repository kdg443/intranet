<!-- DB. 직원 삭제 -->
<!-- request : memId -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="member.MemberDAO" %>
<%@ include file="SessionConfig.jsp" %><!-- 세션 관리 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="member" class="member.Member" scope="page" />
<jsp:setProperty name="member" property="*" />
<script src="./js/Admin.js"></script>

<%
	if(request.getParameter("memId") == null){
%>
		<script>
			failEvent('잘못된 접근 방식입니다.');
		</script>
<%
	}
	
	MemberDAO mDAO = new MemberDAO();
	int result = mDAO.deleteMember(member.getMemId());
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%
	}else{
		%>
		<script>
			sucessEvent('제거 완료','MemberConfig.jsp');
		</script>
<%
	}
%>