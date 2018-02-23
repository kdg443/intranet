<!-- DB. 공고 정보 수정 -->
<!-- request : jobtranet 자바빈 모든 변수 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="student.JobtranetDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="j" class="student.Jobtranet" scope="page" />
<jsp:setProperty name="j" property="*" />
<script src="./js/Intra.js"></script>

<%
	JobtranetDAO jDAO = new JobtranetDAO();
	
	int result = jDAO.updateJob(j);
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%
	}else{
%>
		<script>
			sucessEvent('수정 완료','JobtranetInfo.jsp','jNo','<%=j.getjNo()%>');
		</script>
<%
	}
%>