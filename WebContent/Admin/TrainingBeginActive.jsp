<!-- DB. 개강 생성 -->
<!-- request : Process 자바빈 변수 -->
<%@page import="utilMade.PatternCheck"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="training.ProcessDAO" %>
<%@ page import="training.ProcessFieldDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ include file="SessionConfig.jsp" %><!-- 세션 관리 -->
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="process" class="training.Process" scope="page"/>
<jsp:setProperty name="process" property="*" />
<script src="./js/Admin.js"></script>

<%
 	if(request.getParameter("trType").equals("") ||
			request.getParameter("prStateName").equals("") ||
			request.getParameter("trName").equals("") ||
			request.getParameter("memId").equals("") ||
			request.getParameter("sDate").equals("") ||
			request.getParameter("eDate").equals("") ||
			request.getParameter("prQueta").equals("") ||
			request.getParameter("trRoom").equals("")){
 %>
 		<script>
 			failEvent('양식이 비어있습니다.');
 		</script>
 <%
	}
 	
 	PatternCheck p = new PatternCheck();
 	
 	if(!(p.checkDate(request.getParameter("sDate"))) ||
 			!(p.checkDate(request.getParameter("eDate"))))
 	{
%>
 		<script>
 			failEvent('날짜가 양식에 맞지 않습니다.');
 		</script>
<%
 	}else{
 		String totalDate = "";
 		String divis = "[-]";
 		String[] date;
 		
 		totalDate = request.getParameter("sDate");
 		date = totalDate.split(divis);
 		
 		if(date.length != 3){
%>
 	 		<script>
 	 			failEvent('개강일 : 양식에 맞지 않습니다.');
 	 		</script>
<%
 		}
 		
 		totalDate = request.getParameter("eDate");
 		date = totalDate.split(divis);
 		
 		if(date.length != 3){
%>
 	 		<script>
 	 			failEvent('수료일 : 양식에 맞지 않습니다.');
 	 		</script>
<%
 		}
 	}

	ProcessDAO pDAO = new ProcessDAO();
	ProcessFieldDAO pfDAO = new ProcessFieldDAO();
	
	int index = pDAO.getNext();
	process.setPrNo(index);
	
	int result = pDAO.createProcess(process);
	
	if(result == -1)
	{
%>
 		<script>
 			failEvent('훈련 중복(process)');
 		</script>
<%
	}else if(result == -2){
%>
 		<script>
 			failEvent('데이터베이스 오류(process)');
 		</script>
<%
	}else{
		if(request.getParameterValues("fName") != null){
			String[] arrfName = request.getParameterValues("fName");
			
			result = pfDAO.createProField(index, arrfName);
			
			if(result == -1)
			{
%>
		 		<script>
		 			failEvent('훈련 중복(processField)');
		 		</script>
<%
			}else if(result == -2){
%>
		 		<script>
		 			failEvent('데이터베이스 오류(processField)');
		 		</script>
<%
			}
		}
		
%>
		<script>
			sucessEvent('과정 생성성공','TrainingBegin.jsp');
		</script>
<%
	}
%>