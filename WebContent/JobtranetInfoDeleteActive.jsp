<!-- DB. 공고 삭제 -->
<!-- request : jNo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="student.JobtranetDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<script src="./js/Intra.js"></script>

<%
	JobtranetDAO jDAO = new JobtranetDAO();
	int result = jDAO.deleteJob(Integer.parseInt(request.getParameter("jNo")));
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%
	}else{
%>
		<script>
			movePage("JobtranetConfig.jsp");
		</script>
<%
	}
%>