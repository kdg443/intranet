<!-- 잡트라넷 정보 확인0 -->
<!-- request : jNo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="student.Jobtranet" %>
<%@ page import="student.JobtranetDAO" %>
<%@ page import="java.util.*" %>
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
<%
	JobtranetDAO jDAO = new JobtranetDAO();
	ArrayList<Jobtranet> jList = new ArrayList<Jobtranet>();
	
	jList = jDAO.getData(Integer.parseInt(request.getParameter("jNo")));
%>
<h1 class="header">공고 정보</h1>
<div class="content"><!-- 공고 정보 -->
	<table class="job-table">
		<tr>
			<td class="job-label">제목</td>
			<td class="job-content">
				<%=jList.get(0).getjTitle() %>
			</td>
			<td class="job-label">연봉</td>
			<td class="job-content">
				<%=jList.get(0).getjIncome()%>
			</td>
		</tr>
		<tr>
			<td class="job-label">기업이름</td>
			<td class="job-content">
				<%=jList.get(0).getjName() %>
			</td>
			<td class="job-label">마감일</td>
			<td class="job-content">
				<%=jList.get(0).getjDate() %>
			</td>
		</tr>
		<tr>
			<td class="job-label">학력</td>
			<td class="job-content">
				<%=jList.get(0).getjEdu() %>
			</td>
			<td class="job-label">경력</td>
			<td class="job-content">
				<%=jList.get(0).getjCareer() %>
			</td>
		</tr>
		<tr>
			<td class="job-label">업종</td>
			<td class="job-content">
				<%=jList.get(0).getjBusiness() %>
			</td>
			<td class="job-label">매출액</td>
			<td class="job-content">
				<%=jList.get(0).getjTurnover() %>
			</td>
		</tr>
		<tr>
			<td class="job-label">주소</td>
			<td colspan=3 class="job-content">
				<%=jList.get(0).getjAddr() %>
			</td>
		</tr>
		<tr>
			<td class="job-label">담당업무</td>
			<td colspan=3 class="job-content">
			<%
				String work = jList.get(0).getjWork();
				work = work.replace("\r\n", "<br>");
				out.println(work);
			%>
			</td>
		</tr>
		<tr>
			<td class="job-label">자격요건</td>
			<td colspan=3 class="job-content">
			<%
				String qulify = jList.get(0).getjQualify();
				qulify = qulify.replace("\r\n", "<br>");
				out.println(qulify);
			%>
			</td>
		</tr>
		<tr>
			<td class="job-label">공고문</td>
			<td colspan=3>
				<a class="job-content-text-move" href="<%=jList.get(0).getjSite()%>" target="_blank">해당 공고문으로 이동</a>
			</td>
		</tr>
		<tr>
			<td colspan=4>
				<input class="job-submit" type="button" value="지원하기" onclick="movePage('ApplyActive.jsp','jNo','<%=request.getParameter("jNo") %>');">
			</td>
		</tr>
		<tr><td colspan=3 style="height: 100px;"></td></tr>	<!-- 공백 -->
	</table>
</div><!-- 공고 정보 끝 -->
</body>
</html>