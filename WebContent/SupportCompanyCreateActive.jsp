<!-- DB. 기업 지원 추가 -->
<!-- request : stNo ( 훈련생 인덱스 번호 ) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="student.SupportCompanyDAO"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="sc" class="student.SupportCompany" scope="page" />
<jsp:setProperty name="sc" property="*" />
<script src="./js/Intra.js"></script>

<%
	SupportCompanyDAO scDAO = new SupportCompanyDAO();
	int result = scDAO.createSupportCompany(sc);
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%
	}else{
%>
		<script>
			sucessEvent('추가 성공','StudentInfo.jsp','stNo','<%=request.getParameter("stNo") %>');
		</script>
<%
	}
%>