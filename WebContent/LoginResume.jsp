<!-- 직원 이력서 파일 수정 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="Default.jsp" %>	<!-- 기본 틀(로고, 상단 메뉴, 사이드 메뉴)-->
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE HTML>
<html>
<head>
	<link rel="stylesheet" href="./css/intra.css">
	<meta charset="UTF-8">
	<title>휴먼교육센터</title>
	<style>
		.content
		{
			position: absolute;
			top: 400px;
			left: 50%;
			margin-left: -400px;
			width: 800px;
			height: 100px;
		}
		.login-table
        {
            position: absolute;
            top: 20px;
            left: 50%;
            margin-left: -400px;
            width: 800px;
        }
        .login-label
        {
            background-color: lightgrey;
            padding-top: 10px;
            padding-bottom: 10px;
            width: 100px;
            text-align: center;
            font-size: 15px;
            font-weight: bold;
            color: #3352ff;
        }
        .login-submit
        {
            background-color: #0076ff;
            margin-left: 70px;
            border: none;
            width: 660px;
            height: 35px;
            font-size: 20px;
            font-weight: bold;
            letter-spacing: 3px;
            color: white;
        }
	</style>
</head>
<body>
	<div class="content"><!-- 이력서 파일 수정 -->
		<form action="LoginResumeActive.jsp" method="post" enctype="multipart/form-data">
			<table class="login-table">
				<tr>
					<td class="login-label">이력서</td>
					<td>
						<input type="file" name="memResume">
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<input class="login-submit" type="submit" value="갱신하기">
					</td>
				</tr>
			</table>
		</form>
	</div><!-- 이력서 파일 수정 끝 -->
</body>
</html>