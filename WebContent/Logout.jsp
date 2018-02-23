<!-- 로그아웃 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
    <script src="./js/Intra.js"></script>
</head>
<body>
<%
	session.invalidate();		//모든 세션 제거
%>
<script>
	movePage('Login.jsp');
</script>
</body>
</html>