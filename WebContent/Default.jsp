<!-- intra 기본 틀 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./css/intra.css">
<script src="./js/Intra.js"></script>
<style>
	.login-move
	{
		text-decoration: none;
		color: black;
	}
</style>
<%
	long lastTime = session.getLastAccessedTime();			//세션에 마지막으로 접근한 시간
	long startTime = session.getCreationTime();				//세션에 처음으로 접근한 시간
	long usedTime = ( lastTime - startTime ) / 60000;		//세션에 머문시간
	long activeTime = session.getMaxInactiveInterval();		//세션의 유효 기간, 60분
	
	if(usedTime > activeTime){
%>
		<script>
			sessionLimit('세션이 만료되었습니다','Login.jsp');
		</script>
<%
	}

	//세션 관리
	String userId = null;
	String connect = null;
	String userName = null;

	if(session.getAttribute("userId") != null){
		userId = (String) session.getAttribute("userId");
		connect = (String) session.getAttribute("connect");
		userName = (String) session.getAttribute("userName");
	}else{
%>
		<script>
			failEvent('로그인 후 이용해 주시기 바랍니다.');
		</script>
<%
	}
	
	if(session.getAttribute("adminId") != null){
		session.removeAttribute("adminId");
	}
%>							<!-- 세션 관리 끝 -->
<div class="container"><!-- 로고 및 [접속시간]성명, 로그아웃 -->
    <div class="top-left"><img src="images/<%=java.net.URLEncoder.encode("logo.jpeg","euc-kr").replace("+","%20") %>" class="logo-image"></div>
    <div class="top-right"><%="[" + connect + "]" %><a class="login-move" href="LoginInfo.jsp"><%=userName %></a> <button class="btn-logout" type="button" onclick="movePage('Logout.jsp');">로그아웃</button></div>
</div><!-- 로고 및 [접속시간]성명, 로그아웃 끝 -->
<div class="nav"><!-- 상단 메뉴 -->
    <div class="nav-center">
        <ul class="ul">
            <li class="nav-bar"><a href="Main.jsp" class="nav-move" id="nav-move-home"><span class="nav-name" id="nav-text-home">HOME</span></a></li>
            <li class="nav-bar"><a href="JobtranetConfig.jsp" class="nav-move" id="nav-move-company"><span class="nav-name" id="nav-text-company">구인</span></a></li>
            <li class="nav-bar"><a href="Advice.jsp" class="nav-move" id="nav-move-advice"><span class="nav-name" id="nav-text-advice">상담</span></a></li>
            <li class="nav-bar"><a href="Student.jsp" class="nav-move" id="nav-move-student"><span class="nav-name" id="nav-text-student">훈련생</span></a></li>
        </ul>
        <div class="nav-board">
            <a href="Board.jsp" class="nav-move-board">
               <span class="nav-text-board">공지사항</span>
            </a>
        </div>
    </div>
</div><!-- 상단 메뉴 끝 -->
<div class="nav-side"><!-- 우측 하단 사이드 메뉴 -->
    <ul class="ul">
        <li class="nav-side-var" id="nav-side-menu"><div class="nav-side-line"><hr class="line-decoration"><hr class="line-decoration"><hr class="line-decoration"></div></li>
        <li class="nav-side-var" id="nav-side-admin"><a href="Admin/AdminLogin.jsp" class="nav-side-admin-move"></a></li>
        <li class="nav-side-var" id="nav-side-calendar"><a href="Calendar.jsp" class="nav-side-calendar-move" target="_blank"></a></li>
        <li class="nav-side-var" id="nav-side-job"><a href="./Student/JobMain.jsp" class="nav-side-job-move" target="_blank"></a></li>
    </ul>
</div><!-- 우측 하단 사이드 메뉴 끝 -->