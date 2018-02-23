<!-- DB. 상담 내용 수정 -->
<!-- request : Advice 자바빈 모든 변수 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="student.AdviceDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="ad" class="student.Advice" scope="page" />
<jsp:setProperty name="ad" property="*" />
<script src="./js/Intra.js"></script>

<%
	AdviceDAO aDAO = new AdviceDAO();
	int result = aDAO.updateAdvice(ad);
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%
	}else{
%>
		<script>
			sucessEvent('수정완료','StudentInfo.jsp','stNo','<%=ad.getStNo()%>');
		</script>
<%
	}
%>