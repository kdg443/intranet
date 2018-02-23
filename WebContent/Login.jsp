<!-- 로그인 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <title>휴먼교육센터</title>
    <style>
        body
        {
            background-image: url("images/<%=java.net.URLEncoder.encode("Background.png","euc-kr").replace("+","%20")%>");
            background-size: 100%;
        }
        .container
        {
            position: absolute;
            top: 100px;
            left: 50%;
            margin-left: -300px;
            width: 600px;
            height: 100px;
        }
        .login-label
        {
            background-color:white;
            position: absolute;
            border: 2px solid grey;
            border-top-left-radius: 1em;
            border-top-right-radius: 1em;
            border-bottom: none;
            left: 20%;
            width: 35%;
            height: 35px;
            text-align: center;
            z-index: 3;
        }
        .login-label-image
        {
            position: absolute;
            top: 17%;
            left: 7%;
            width: 25px;
        }
        .login-label-text
        {
            position:absolute;
            top: 15%;
            left: 20%;
            font-size: 20px;
            font-weight: bold;
        }
        .login-label-shadow
        {
            background-color: rgb(203, 203, 203);
            position: absolute;
            border: 1px solid grey;
            border-top-left-radius: 1em;
            border-top-right-radius: 1em;
            left: 30%;
            width: 45%;
            height: 35px;
            text-align: center;
            z-index: 1;
        }
        .login-box
        {
            background-color:white;
            position: absolute;
            border: 2px solid grey;
            border-top-right-radius: 1em;
            top: 35px;
            left: 50%;
            margin-left: -30%;
            width: 60%;
            height: 300px;
            z-index: 2;
        }
        .login-st-text
        {
        	position: absolute;
        	top: 20px;
        	left: 32px;
        }
        .login-st-text-move
        {
        	text-decoration: none;
        	color: rgb(0, 108, 255);
        }
        .login-id-box
        {
            position: absolute;
            top: 15%;
            left: 5%;
            width: 90%;
            height: 90px;
        }
        .login-pwd-box
        {
            position: absolute;
            top: 40%;
            left: 5%;
            width: 90%;
            height: 90px;
        }
        #login-context
        {
            position:absolute;
            top: 15%;
            left: 5%;
            font-size: 15px;
            font-weight: bold;
        }
        #login-input
        {
            position:absolute;
            border-top: none;
            border-left: none;
            border-right: none;
            border-bottom: 2px solid rgb(0, 108, 255);
            top: 45%;
            left: 5%;
            width: 90%;
            height: 20%;
            font-size: 15px;
        }
        .login-btn
        {
            background-color: rgb(59, 142, 255);
            position: absolute;
            top: 75%;
            border: none;
            border-bottom: 8px solid rgb(0, 108, 255);
            border-radius: 5px;
            width: 90px;
            height: 50px;
            color: white;
            font-weight: bold;
            letter-spacing: 1px;
            transition: all 0.5s;
        }
        .login-btn:hover
        {
            transform: translateY(5px);
            border-bottom: 3px solid rgb(0, 108, 255);
        }
        #login-submit-login
        {
            right: 10%;
        }
    </style>
</head>
<body>
    <div class="container"><!-- 로그인 박스 -->
        <div class="login-label-shadow"></div>
        <div class="login-label"><img src="images/<%=java.net.URLEncoder.encode("locked.png","euc-kr").replace("+","%20") %>" class="login-label-image"><span class="login-label-text">LOGIN</span></div>
        <div class="login-box">
        	<span class="login-st-text"><a class="login-st-text-move" href="./Student/StudentLogin.jsp">훈련생 로그인</a></span>
            <form action="LoginConfig.jsp" method="post">
                <div class="login-id-box">
                    <span id="login-context">아이디</span>
                    <input name="memId" id="login-input" type="text" placeholder="아이디" maxlength="10">
                </div>
                <div class="login-pwd-box">
                    <span id="login-context">비밀번호</span>
                    <input style="letter-spacing: 2px;" name="memPwd" id="login-input" type="password" placeholder="비밀번호" maxlength="20">
                </div>
                <input class="login-btn" id="login-submit-login" type="submit" value="LOGIN">
            </form>
        </div>
    </div><!-- 로그인 박스 끝 -->
</body>
</html>