<!-- DB. 훈련생 수강 과정 변경 -->
<!-- request : stNo, prNo -->
<%@page import="training.Process"%>
<%@page import="java.util.ArrayList"%>
<%@page import="training.ProcessDAO"%>
<%@page import="student.StudentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="training.RegProcessDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<script src="./js/Intra.js"></script>

<%
	int stNo = Integer.parseInt(request.getParameter("stNo"));
	int prNo = Integer.parseInt(request.getParameter("prNo"));
	
	RegProcessDAO rpDAO = new RegProcessDAO();
	StudentDAO stDAO = new StudentDAO();
	ProcessDAO pDAO = new ProcessDAO();
	
	ArrayList<Process> pList = new ArrayList<Process>();
	
	pList = pDAO.getData(prNo);
	
	if((stDAO.getTotalType(prNo, "총합")) >= pList.get(0).getPrQueta()){
%>
		<script>
			failEvent("정원 초과");
		</script>
<%
	}
	
	int result = rpDAO.changeProcess(stNo, prNo);
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%
	}else{
%>
		<script>
			sucessEvent('수정 완료','Student.jsp');
		</script>
<%
	}
%>