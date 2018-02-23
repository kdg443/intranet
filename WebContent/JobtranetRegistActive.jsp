<!-- DB. 잡트라넷 등록 -->
<!-- request : Jobtranet 자바빈 변수 -->
<%@page import="utilMade.PatternCheck"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="student.JobtranetDAO" %>
<%@ page import="java.io.*" %>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="j" class="student.Jobtranet" scope="page" />
<jsp:setProperty name="j" property="*" />
<script src="./js/Intra.js"></script>

<%
	PrintWriter script = response.getWriter();

	if(request.getParameter("jTitle").equals("") ||
			request.getParameter("jIncome").equals("") ||
			request.getParameter("jName").equals("") ||
			request.getParameter("jDate").equals("") ||
			request.getParameter("jEdu").equals("") ||
			request.getParameter("jCareer").equals("") ||
			request.getParameter("jAddr").equals("") ||
			request.getParameter("jWork").equals("") ||
			request.getParameter("jQualify").equals(""))
	{
%>
		<script>
			failEvent('양식이 비어있습니다 (업종, 매출액 제외)');
		</script>
<%
	}
	else
	{
		PatternCheck pc = new PatternCheck();
	
		if(!(pc.checkDate(request.getParameter("jDate")))){
	%>
			<script>
				failEvent('날짜 : 양식에 맞지 않습니다.');
			</script>
	<%
		}else{
			String totalDate = request.getParameter("jDate");
			String divis = "[-]";
			String[] date = totalDate.split(divis);
			
			if(date.length != 3){
	%>
				<script>
					failEvent('날짜 : 양식에 맞지 않습니다.');
				</script>
	<%
			}
		}
		
		JobtranetDAO jDAO = new JobtranetDAO();
		
		int result = jDAO.createJob(j);
		
		if(result == -2){
	%>
			<script>
				failEvent('데이터베이스 오류');
			</script>
	<%
		}else{
	%>
			<script>
				movePage('JobtranetConfig.jsp');
			</script>
	<%
		}
	}
%>