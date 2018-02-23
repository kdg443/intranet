<!-- 관리자 메인 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ include file="SessionConfig.jsp" %><!-- 세션 관리 -->			
<!DOCTYPE HTML>
<html>
<head>
	<link rel="stylesheet" href="css/AdminMain.css">
    <meta charset="utf-8">
    <title>휴먼교육센터</title>
</head>
<body>
<div class="container"><!-- 메뉴 -->
    <div class="nav" id="nav-menu-first"><!-- Training 이동 메뉴 -->
        <a href="TrainingDefine.jsp" class="nav-menu-active">
	       	<span class="nav-menu-number">1</span>
	       	<span class="nav-menu-context">CHOOSE MENU</span>
	       	<span class="nav-menu-name">TRAINING</span>
       	 </a>
        <div class="nav-icon-box">
            <div class="nav-icon-image" id="nav-first-icon-image-one">
            	<span class="nav-icon-text" id="nav-first-icon-text-one">TRAINING</span>
            </div>
            <div class="nav-icon-image" id="nav-first-icon-image-two">
            	<span class="nav-icon-text" id="nav-first-icon-text-two">RELATION</span>
            </div>
        </div>
    </div><!-- Training 이동 메뉴 끝 -->
    <div class="nav" id="nav-menu-second"><!-- Member 이동 메뉴 -->
        <a href="MemberJoin.jsp" class="nav-menu-active">
        	<span class="nav-menu-number">2</span>
        	<span class="nav-menu-context">CHOOSE MENU</span>
       		<span class="nav-menu-name">MEMBER</span>
       	</a>
        <div class="nav-icon-box">
            <div class="nav-icon-image" id="nav-second-icon-image-one">
            	<span class="nav-icon-text" id="nav-second-icon-text-one">DEPARTMENT</span>
            </div>
            <div class="nav-icon-image" id="nav-second-icon-image-two">
            	<span class="nav-icon-text" id="nav-second-icon-text-two">MEMBER</span>
            </div>
        </div>
    </div><!-- Member 이동 메뉴 끝 -->
    <div class="nav" id="nav-menu-third"><!-- Student 이동 메뉴 -->
        <a href="StudentDefine.jsp" class="nav-menu-active">
        	<span class="nav-menu-number">3</span>
        	<span class="nav-menu-context">CHOOSE MENU</span>
       		<span class="nav-menu-name">STUDENT</span>
       	</a>
        <div class="nav-icon-box">
            <div class="nav-icon-image" id="nav-third-icon-image-one">
            	<span class="nav-icon-text" id="nav-third-icon-text-one">STUDENT</span>
            </div>
            <div class="nav-icon-image" id="nav-third-icon-image-two">
            	<span class="nav-icon-text" id="nav-third-icon-text-two">FEATURE</span>
            </div>
        </div>
    </div><!-- Student 이동 메뉴 끝 -->
    <div class="nav-home"><!-- Main 이동 메뉴 -->
        <a href="../Main.jsp" class="nav-home-active">
			<span class="nav-home-text"><img src="./images/arrow.png" class="nav-home-icon">GO HOME</span>
        </a>
    </div><!-- Main 이동 메뉴 끝 -->
</div><!-- 메뉴 끝 -->
</body>
</html>