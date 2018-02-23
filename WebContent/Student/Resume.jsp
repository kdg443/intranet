<!-- 훈련생 이력서 파일 수정 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="StudentDefault.jsp" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE HTML>
<html>
<head>
	<link rel="stylesheet" href="./css/Student.css">
	<meta charset="UTF-8">
	<title>휴먼교육센터</title>
	<script src="./js/Student.js"></script>
</head>
<body>
	<div class="content"><!-- 이력서 수정 -->
	<form action="ResumeActive.jsp" method="post" enctype="multipart/form-data">
		<table class="job-table">
			<tr>
				<td class="job-label">이력서</td>
				<td>
					<input type="file" name="stResume">
				</td>
			</tr>
			<tr>
				<td colspan=2>
					<input class="job-submit" type="submit" value="갱신하기">
				</td>
			</tr>
			<tr>
				<td colspan=2>
					<input class="job-submit" type="button" value="돌아가기" onclick="movePage('JobMain.jsp');">
				</td>
			</tr>
		</table>
	</form>
	</div><!-- 이력서 수정 끝 -->
</body>
</html>