<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% response.setStatus(HttpServletResponse.SC_OK); %>
<title>404에러 페이지</title>
<body>
	<img src="<%=java.net.URLEncoder.encode("error.jpg", "euc-kr").replace("+","%20") %>"><br>
	<span style="font-weight: bold;">요쳥하신 페이지는 존재하지 않습니다.</span>
</body>