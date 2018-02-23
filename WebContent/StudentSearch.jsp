<!-- 훈련생 이름 검색 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="student.Student" %>
<%@ page import="student.StudentDAO" %>
<%@ page import="training.RegProcess" %>
<%@ page import="training.RegProcessDAO" %>
<%@ page import="training.Process" %>
<%@ page import="training.ProcessDAO" %>
<%@ page import="java.util.*" %>
<%@ include file="Default.jsp" %>	<!-- 기본 틀(로고, 상단 메뉴, 사이드 메뉴)-->
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE HTML>
<html>
<head>
	<link rel="stylesheet" href="./css/intra.css">
	<meta charset="UTF-8">
	<title>휴먼교육센터</title>
	<style>
		#nav-move-student
		{
		    background-color: rgb(106, 212, 0);
		}
		#submenu-three
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
		.student-search-submit
		{
			border: none;
			background-color: #0076ff;
			width: 70px;
			height: 20px;
			font-weight: bold;
			color: white;
		}
		.student-table
        {
            position: absolute;
            top: 20px;
            left: 50%;
            margin-left: -400px;
            width: 800px;
        }
        .student-thead
        {
            background-color: #0076ff;
            font-size: 15px;
            text-align: center;
            color: white;
        }
        .student-name
        {
        	background-color: white;
        	font-size: 15px;
        	color: black;
        }
        .student-total
        {
        	font-size: 15px;
        }
        .student-title
        {
            height: 30px;
        }
        .student-content-text-move
        {
        	text-decoration: none;
        	color: black;
        }
        .student-content-odd
        {
            text-align: center;
            height: 30px;
        }
        .student-content-even
        {
        	background-color: lightgrey;
        	text-align: center;
        	height: 30px;
        }
	</style>
</head>
<body>
<%
	StudentDAO stDAO = new StudentDAO();
	RegProcessDAO rpDAO = new RegProcessDAO();
	ProcessDAO pDAO = new ProcessDAO();
	
	ArrayList<Student> stList = new ArrayList<Student>();
	ArrayList<RegProcess> rpList = new ArrayList<RegProcess>();
	ArrayList<Process> pList = new ArrayList<Process>();
%>
	<div class="submenu-container"><!-- 서브 메뉴 -->
		<ul class="ul">
			<li class="submenu" id="submenu-one"><a class="submenu-move" href="StudentRegist.jsp"><span class="submenu-text">등록</span></a></li>
			<li class="submenu" id="submenu-two"><a class="submenu-move" href="Student.jsp"><span class="submenu-text">조회</span></a></li>
			<li class="submenu" id="submenu-three"><a class="submenu-move" href="StudentSearch.jsp"><span class="submenu-text">이름검색</span></a></li>
		</ul>
	</div><!-- 서브 메뉴 끝 -->
	
	<div class="content"><!-- 목록 -->
		<form action="StudentSearch.jsp" method="post"><!-- 훈련생 검색 -->
			<input name="stName" type="text" placeholder="훈련생 이름" maxlength="5">
			<input class="student-search-submit" type="submit" value="검색">
		</form><!-- 훈련생 검색 끝 -->
		<table class="student-table"><!-- 훈련생 목록 -->
			<thead class="student-thead">
				<tr class="student-title">
					<th width="150">
						이름
					</th>
					<th width="150">
						상태
					<th width="500">
						과정명
					</th>
				</tr>
			</thead>
			<tbody>
				<%
					if(request.getParameter("stName") != null){
						stList = stDAO.getData(request.getParameter("stName"));
						String[] style = { "odd", "even"};		//css name
						
						for(int i = 0; i < stList.size(); i++){					//cols배경.	홀수 : 흰색,	짝수 : 회색
							rpList = rpDAO.getList(stList.get(i).getStNo());
							pList = pDAO.getData(rpList.get(0).getPrNo());
				%>
							<tr class="student-content-<%=style[i % 2]%>">
								<td><a class="student-content-text-move" href="StudentInfo.jsp?stNo=<%=stList.get(i).getStNo()%>"><%=stList.get(i).getStName() %></a></td>
								<td><%=stList.get(i).getStStateName() %></td>
								<td><%="<" + pList.get(0).getTrType() + ">" + pList.get(0).getTrName() %></td>
							</tr>
				<%
						}
					}
				%>
			</tbody>
		</table><!-- 훈련생 목록 끝 -->
	</div><!-- 목록 끝 -->
</body>
</html>