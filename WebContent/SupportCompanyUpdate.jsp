<!-- 기업 지원 정보 수정 -->
<!-- request : scNo ( 기업 지원 인덱스 번호 ) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="student.SupportCompany"%>
<%@page import="java.util.ArrayList"%>
<%@page import="student.SupportCompanyDAO"%>
<%@ include file="Default.jsp" %>	<!-- 기본 틀(로고, 상단 메뉴, 사이드 메뉴)-->
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="./css/intra.css">
	<meta charset="UTF-8">
	<title>휴면교육센터</title>
	<script src="./js/Intra.js"></script>
	<style>
		#nav-move-student
		{
		    background-color: rgb(106, 212, 0);
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
		.student-table
        {
            position: absolute;
            top: 10px;
            left: 50%;
            margin-left: -400px;
            width: 800px;
        }
		.student-label
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
        .student-component-text
        {
        	width: 150px;
        }
        .student-submit
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
<%
	SupportCompanyDAO scDAO = new SupportCompanyDAO();
	ArrayList<SupportCompany> scList = new ArrayList<SupportCompany>();
	
	scList = scDAO.getData(Integer.parseInt(request.getParameter("scNo")));
%>
	<div class="submenu-container"><!-- 서브 메뉴 -->
		<ul class="ul">
			<li class="submenu" id="submenu-one"><a class="submenu-move" href="StudentRegist.jsp"><span class="submenu-text">등록</span></a></li>
			<li class="submenu" id="submenu-two"><a class="submenu-move" href="Student.jsp"><span class="submenu-text">조회</span></a></li>
			<li class="submenu" id="submenu-three"><a class="submenu-move" href="StudentSearch.jsp"><span class="submenu-text">이름검색</span></a></li>
		</ul>
	</div><!-- 서브 메뉴 끝 -->
	
	<div class="content"><!-- 기업 지원 정보 수정 양식 -->
		<form action="SupportCompanyUpdateActive.jsp" method="post">
			<input type="hidden" name="stNo" value="<%=request.getParameter("stNo") %>">
			<input type="hidden" name="scNo" value="<%=request.getParameter("scNo") %>">
			<table class="student-table">
				<tr>
					<td class="student-label" rowspan=2>
						일자
					</td>
					<td class="student-label">
						회사명
					</td>
					<td>
						<input class="student-component-text" name="scCompany" type="text" placeholder="회사명" maxlength="15" value="<%=scList.get(0).getScCompany() %>">
					</td>
					<td class="student-label">
						소재지
					</td>
					<td>
						<input class="student-component-text" name="scAddr" type="text" placeholder="주소" maxlength="30" value="<%=scList.get(0).getScAddr() %>">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						담당자
					</td>
					<td>
						<input class="student-component-text" name="scName" type="text" placeholder="담당자명" maxlength="10" value="<%=scList.get(0).getScName() %>">
					</td>
					<td class="student-label">
						회사전번
					</td>
					<td>
						<input class="student-component-text" name="scTel" type="text" placeholder="전화번호" maxlength="15" value="<%=scList.get(0).getScTel() %>">
					</td>
				</tr>
				<tr>
					<td rowspan=2><!-- 일자 text -->
						<input class="student-component-text" name="scDate" type="text" placeholder="2000-xx-xx" maxlength="12" value="<%=scList.get(0).getScDate() %>"> 
					</td>
					<td class="student-label">
						알선내용
					</td>
					<td colspan=3>
						<textarea  name="scContent" rows="" cols="50"><%=scList.get(0).getScContent() %></textarea>
					</td>
				</tr>
				<tr>
					<td class="student-label">
						최종결과
					</td>
					<td>
						<input class="student-component-text" name="scResult" type="text" placeholder="최종결과" maxlength="10" value="<%if(scList.get(0).getScResult() != null)out.println(scList.get(0).getScResult()); %>">
					</td>
					<td class="student-label">
						사유
					</td>
					<td>
						<input class="student-component-text" name="scReason" type="text" placeholder="최종결과" maxlength="10" value="<%if(scList.get(0).getScReason() != null)out.println(scList.get(0).getScReason()); %>">
					</td>
				</tr>
				<tr>
					<td colspan=5>
						<input class="student-submit" type="submit" value="수정하기">
					</td>
				</tr>
			</table>
		</form>
	</div><!-- 기업 지원 정보 수정 양식 끝 -->
</body>
</html>