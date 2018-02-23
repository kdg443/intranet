<!-- DB. 로그인 확인 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.Member" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<script src="./js/Admin.js"></script>

<%
	if(String.valueOf(session.getAttribute("userAccept")).equals("0") || session.getAttribute("userId") == null){
%>
		<script>
			failEvent('접근이 제한되어있습니다.');
		</script>
<%
	}

	if(request.getParameter("adminId").equals("") || request.getParameter("adminPwd").equals(""))
	{
%>
		<script>
			failEvent('양식이 비어있습니다.');
		</script>
<%
	}
	
	if(!(String.valueOf(session.getAttribute("userId")).equals(request.getParameter("adminId")))){		//세션에 등록된 계정과 파라미터 adminId 값이 맞는지 비교
%>
		<script>
			failEvent('계정이 맞지 않습니다.');
		</script>
<%	
	}
	
	MemberDAO mDAO = new MemberDAO();
	int result = mDAO.login(String.valueOf(session.getAttribute("userId")),request.getParameter("adminPwd"));
	
	if(result == 1){	//로그인 성공
		session.setAttribute("adminId", request.getParameter("adminPwd"));
%>
		<script>
			movePage('AdminMain.jsp');
		</script>
<%
	}else{		//로그인 실패
%>
		<script>
			movePage('AdminLogin.jsp');
		</script>
<%
	}
%>