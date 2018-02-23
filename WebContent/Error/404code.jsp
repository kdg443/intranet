<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% response.setStatus(HttpServletResponse.SC_OK); %>
<title>404에러 페이지</title>
<body>
	<img src="<%=java.net.URLEncoder.encode("error.jpg", "euc-kr").replace("+","%20") %>"><br>
	<span style="font-weight: bold;">서비스 이용에 불편을 끼쳐드려 죄송합니다. 빠른 시간내에 문제를 처리하겠습니다.</span>
</body>