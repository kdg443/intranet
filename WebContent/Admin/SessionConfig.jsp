<!-- 세션 확인 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="./js/Admin.js"></script>
<%
	long lastTime = session.getLastAccessedTime();			//세션에 마지막으로 접근한 시간
	long startTime = session.getCreationTime();				//세션에 처음으로 접근한 시간
	long usedTime = ( lastTime - startTime ) / 60000;		//세션에 머문시간
	long activeTime = session.getMaxInactiveInterval();		//세션의 유효 기간, 60분

	if(usedTime > activeTime){
%>
	<script>
		sessionLimit('세션이 만료되었습니다','../Login.jsp');
	</script>
<%
	}	

	if(String.valueOf(session.getAttribute("userAccept")).equals("0") || session.getAttribute("userId") == null){
%>
		<script>
			failEvent('접근이 제한되어있습니다.');
		</script>
<%
	}

	if(session.getAttribute("adminId") == null){
%>
		<script>
			failEvent('관리자 로그인 후 이용해 주시기 바랍니다.');
		</script>
<%
	}
%>