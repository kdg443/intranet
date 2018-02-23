<!-- 훈련생 로그인 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<link rel="stylesheet" href="./css/Student.css">
    <meta charset="utf-8">
    <title>휴먼교육센터</title>
    <script src="./js/Student.js"></script>
</head>
<body class="back">
    <div class="container"><!-- 로그인 박스 -->
        <div class="login-label-shadow"></div>
        <div class="login-label"><img src="./images/locked.png" class="login-label-image"><span class="login-label-text">STUDENT</span></div>
        <div class="login-box">
            <form action="StudentLoginConfig.jsp" method="post">
            	<div class="login-birth-box">
            		<span id="login-context">생년월일</span>
            		<input name="stBirth" id="login-input" type="text" placeholder="yyyy-MM-dd" maxlength="10">
            	</div>
                <div class="login-id-box">
                    <span id="login-context">이름</span>
                    <input name="stName" id="login-input" type="text" placeholder="아이디" maxlength="10">
                </div>
                <div class="login-pwd-box">
                    <span id="login-context">비밀번호</span>
                    <input style="letter-spacing: 2px;" name="stPwd" id="login-input" type="password" placeholder="비밀번호" maxlength="20">
                </div>
                <input class="login-btn" id="login-submit-back" type="button" value="BACK" onclick="movePage('../Login.jsp');">
                <input class="login-btn" id="login-submit-login" type="submit" value="LOGIN">
            </form>
        </div>
    </div><!-- 로그인 박스 -->
</body>
</html>