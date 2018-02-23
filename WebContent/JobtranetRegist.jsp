<!-- 잡트라넷 등록 -->
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
		#nav-move-company
		{
		    background-color: rgb(191, 0, 147);
		}
		#submenu-two
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
        .job-content-text
        {
        	border: none;
        	border-bottom: 1px solid #3352ff;
        	width: 250px;
        }
        #job-content-text-long
        {
        	width: 600px;
        }
        .job-content-textarea
        {
        	border: 1px solid #3352ff;
        	width: 600px;
        	height: 100px;
        }
        .process-cotent-submit
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
	<div class="submenu-container"><!-- 서브 메뉴 -->
		<ul class="ul">
			<li class="submenu" id="submenu-one"><a class="submenu-move" href="Jobtranet.jsp"><span class="submenu-text">잡트라넷</span></a></li>
			<li class="submenu" id="submenu-two"><a class="submenu-move" href="JobtranetRegist.jsp"><span class="submenu-text">구인등록</span></a></li>
			<li class="submenu" id="submenu-three"><a class="submenu-move" href="JobtranetApply.jsp"><span class="submenu-text">지원현황</span></a></li>
		</ul>
	</div><!-- 서브 메뉴 끝 -->
	<div class="content">
		<form action="JobtranetRegistActive.jsp" method="post">
			<table class="job-table">
				<tr>
					<td class="job-label">제목</td>
					<td>
						<input class="job-content-text" name="jTitle" type="text" placeholder="제목" maxlength="30">
					</td>
					<td class="job-label">연봉</td>
					<td>
						<input class="job-content-text" name="jIncome" type="text" placeholder="연봉" maxlength="10">
					</td>
				</tr>
				<tr>
					<td class="job-label">기업이름</td>
					<td>
						<input class="job-content-text" name="jName" type="text" placeholder="기업이름" maxlength="">
					</td>
					<td class="job-label">마감일</td>
					<td>
						<input class="job-content-text" name="jDate" type="text" placeholder="ex. 20xx-xx-xx" maxlength="10">
					</td>
				</tr>
				<tr>
					<td class="job-label">학력</td>
					<td>
						<input class="job-content-text" name="jEdu" type="text" placeholder="학력" maxlength="15">
					</td>
					<td class="job-label">경력</td>
					<td>
						<input class="job-content-text" name="jCareer" type="text" placeholder="경력" maxlength="15">
					</td>
				</tr>
				<tr>
					<td class="job-label">업종</td>
					<td>
						<input class="job-content-text" name="jBusiness" type="text" placeholder="업종" maxlength="">
					</td>
					<td class="job-label">매출액</td>
					<td>
						<input class="job-content-text" name="jTurnover" type="text" placeholder="매출액" maxlength="">
					</td>
				</tr>
				<tr>
					<td class="job-label">주소</td>
					<td colspan=3>
						<input class="job-content-text" id="job-content-text-long" name="jAddr" type="Text" placeholder="주소" maxlength="100">
					</td>
				</tr>
				<tr>
					<td class="job-label">담당업무</td>
					<td colspan=3>
						<textarea class="job-content-textarea" name="jWork" rows="" cols="" placeholder="담당 업무"></textarea>
					</td>
				</tr>
				<tr>
					<td class="job-label">자격요건</td>
					<td colspan=3>
						<textarea class="job-content-textarea" name="jQualify" rows="" cols="" placeholder="자격요건 및 우대사항"></textarea>
					</td>
				</tr>
				<tr>
					<td class="job-label">공고문</td>
					<td colspan=3>
						<input class="job-content-text" id="job-content-text-long" name="jSite" type="text" placeholder="사이트링크 (cf. 공백 허용 X)" maxlength="">
					</td>
				</tr>
				<tr>
					<td colspan=4>
						<input class="process-cotent-submit" type="submit" value="등록하기">
					</td>
				</tr>
				<tr><td colspan=3 style="height: 100px;"></td></tr>	<!-- 공백 -->
			</table>
		</form>
	</div>
</body>
</html>