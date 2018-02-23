<!-- DB. 상담 내용 기입 -->
<!-- request : stNo, prStateName, adComment -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="student.AdviceDAO" %>
<%@ page import="utilMade.TimeNow" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="ad" class="student.Advice" scope="page" />
<jsp:setProperty name="ad" property="*" />
<script src="./js/Intra.js"></script>
<%
	if(request.getParameter("prStateName").equals("") ||
			request.getParameter("adComment").equals("")){
%>
		<script>
			failEvent('양식이 비어있습니다.');
		</script>
<%
	}
	
	AdviceDAO aDAO = new AdviceDAO();
	TimeNow now = new TimeNow();
	
	ad.setAdDate(now.getyMd());		//현재 시간. 'yyyy-MM-dd'
	ad.setMemId(String.valueOf(session.getAttribute("userId"))); 
	
	int result = aDAO.createAdvice(ad);
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%
	}else{
%>
		<script>
			sucessEvent('기입 완료',"<%=request.getParameter("pageName")%>",'prNo','<%=request.getParameter("prNo")%>');
		</script>
<%
	}
%>