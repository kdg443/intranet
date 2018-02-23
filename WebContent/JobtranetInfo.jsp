<!-- 공고 정보 -->
<!-- request : jNo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="student.Jobtranet" %>
<%@ page import="student.JobtranetDAO" %>
<%@ page import="java.util.*" %>
<%@ include file="Default.jsp" %>	<!-- 기본 틀(로고, 상단 메뉴, 사이드 메뉴)-->
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE HTML>
<html>
<head>
	<link rel="stylesheet" href="./css/intra.css">
	<meta charset="UTF-8">
	<title>휴먼교육센터</title>
	<script src="./js/Intra.js"></script>
	<style>
		#nav-move-company
		{
		    background-color: rgb(191, 0, 147);
		}
		#submenu-one
		{
			transform: translateY(8px);
			border-bottom: 2px solid rgb(0, 255, 10);
		}
		.content
		{
			position: absolute;
			top: 400px;
			left: 50%;
			margin-left: -400px;
			width: 800px;
			height: 100px;
		}
		.job-table
        {
            position: absolute;
            top: 20px;
            left: 50%;
            margin-left: -400px;
            width: 800px;
        }
        .job-label
        {
            background-color: rgb(255, 255, 255);
            padding-top: 10px;
            padding-bottom: 10px;
            width: 100px;
            text-align: center;
            font-size: 15px;
            font-weight: bold;
            color: #3352ff;
        }
        .job-content
        {
        	border-bottom: 1px solid #3352ff;
        	font-size: 15px;
        }
        .job-content-text-move
        {
        	text-decoration: none;
        	color: black;
        }
        .job-content-submit
        {
        	background-color: #0076ff;
        	border: none;
        	width: 100%;
        	height: 40px;
        	font-size: 15px;
        	font-weight: bold;
        	color: white;
        }
	</style>
</head>
<body>
<%
	JobtranetDAO jDAO = new JobtranetDAO();
	ArrayList<Jobtranet> jList = new ArrayList<Jobtranet>();
	
	jList = jDAO.getData(Integer.parseInt(request.getParameter("jNo")));
%>
	<div class="submenu-container"><!-- 서브 메뉴 -->
		<ul class="ul">
			<li class="submenu" id="submenu-one"><a class="submenu-move" href="JobtranetConfig.jsp"><span class="submenu-text">잡트라넷</span></a></li>
			<li class="submenu" id="submenu-two"><a class="submenu-move" href="JobtranetRegist.jsp"><span class="submenu-text">구인등록</span></a></li>
			<li class="submenu" id="submenu-three"><a class="submenu-move" href="JobtranetApply.jsp"><span class="submenu-text">지원현황</span></a></li>
		</ul>
	</div><!-- 서브 메뉴 끝 -->
	
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
				<%
					if(jList.get(0).getjSite() != null){
				%>
					<a class="job-content-text-move" href="<%=jList.get(0).getjSite()%>" target="_blank">해당 공고문으로 이동</a>
				<%
					}else{
				%>
						사이트 X
				<%
					}
				%>
				</td>
			</tr>
			<tr>
				<td colspan=4>
					<input class="job-content-submit" type="button" value="수정하기" onclick="movePage('JobtranetInfoUpdate.jsp','jNo','<%=jList.get(0).getjNo()%>');">
				</td>
			</tr>
			<tr>
				<td colspan=4>
					<input class="job-content-submit" type="button" value="제거하기" onclick="deleteEvent('JobtranetInfoDeleteActive.jsp','jNo','<%=jList.get(0).getjNo()%>');">
				</td>
			</tr>
			<tr><td colspan=3 style="height: 100px;"></td></tr>	<!-- 공백 -->
		</table>
	</div><!-- 공고 정보 끝 -->
</body>
</html>