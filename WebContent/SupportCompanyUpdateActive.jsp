<!-- DB접근. 기업 지원 정보 수정 -->
<!-- request : scNo ( 기업 지원 인덱스 번호 ), stNo ( 훈련생 인덱스 번호 ) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="student.SupportCompanyDAO"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="sc" class="student.SupportCompany" scope="page" />
<jsp:setProperty name="sc" property="*" />
<script src="./js/Intra.js"></script>

<%-- <%
	out.println(sc.getScNo()+"<br>");
	out.println(sc.getStNo()+"<br>");
	out.println(sc.getScCompany()+"<br>");
	out.println(sc.getScContent()+"<br>");
	out.println(sc.getScDate()+"<br>");
	out.println(sc.getScName()+"<br>");
	out.println(sc.getScReason()+"<br>");
	out.println(sc.getScResult()+"<br>");
	out.println(sc.getScTel()+"<br>");
%> --%>
<%
	SupportCompanyDAO scDAO = new SupportCompanyDAO();
	int result = scDAO.updateSupportCompany(sc);
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%
	}else{
%>
		<script>
			sucessEvent('수정 완료','StudentInfo.jsp','stNo','<%=request.getParameter("stNo") %>');
		</script>
<%
	}
%>