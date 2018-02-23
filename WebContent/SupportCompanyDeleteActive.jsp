<!-- DB접근. 기업 지원 제거 -->
<!-- request : scNo ( 기업 지원 인덱스 번호 ), stNo ( 훈련생 인덱스 번호 ) -->
<%@page import="student.SupportCompanyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<script src="./js/Intra.js"></script>

<%
	SupportCompanyDAO scDAO = new SupportCompanyDAO();

	int scNo = Integer.parseInt(request.getParameter("scNo"));
	int result = scDAO.deleteSupportCompany(scNo);
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%
	}else{
%>
		<script>
			sucessEvent('제거 성공','StudentInfo.jsp','stNo','<%=request.getParameter("stNo") %>');
		</script>
<%
	}
%>