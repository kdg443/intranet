<!-- DB. 상담 삭제 -->
<!-- request : adNo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="student.Advice" %>
<%@ page import="student.AdviceDAO" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="ad" class="student.Advice" scope="page" />
<jsp:setProperty name="ad" property="*" />
<script src="./js/Intra.js"></script>

<%
	AdviceDAO aDAO = new AdviceDAO();
	ArrayList<Advice> aList = new ArrayList<Advice>();
	
	aList = aDAO.getData(ad.getAdNo());
	
	int result = aDAO.deleteAdvice(ad.getAdNo());
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%
	}else{
%>
		<script>
			sucessEvent('제거 완료','StudentInfo.jsp','stNo','<%=aList.get(0).getStNo()%>');
		</script>
<%
	}
%>