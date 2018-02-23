<!-- 훈련생 수강 과정 변경 -->
<!-- request : stNo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="student.Student" %>
<%@ page import="student.StudentDAO" %>
<%@ page import="training.Process" %>
<%@ page import="training.ProcessDAO" %>
<%@ page import="java.util.*" %>
<%@ include file="Default.jsp" %>	<!-- 기본 틀(로고, 상단 메뉴, 사이드 메뉴)-->
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="./css/intra.css">
	<meta charset="UTF-8">
	<title>휴먼교육센터</title>
	<script src="./js/Intra.js"></script>
	<style>
		#nav-move-student
		{
		    background-color: rgb(106, 212, 0);
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
        .student-component-select
        {
            width: 214px;
            height: 30px;
            letter-spacing: 1px;
        }
        .student-component-text
        {
            width: 210px;
            height: 25px;
            letter-spacing: 1px;
        }
        .student-submit
        {
        	position: absolute;
            background-color: #0076ff;
            border: none;
            left: 50%;
            margin-left: -330px;
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
	StudentDAO stDAO = new StudentDAO();
	ProcessDAO pDAO = new ProcessDAO();
	
	ArrayList<Student> stList = new ArrayList<Student>();
	ArrayList<Process> pList = new ArrayList<Process>();
	ArrayList<Process> pListNo = new ArrayList<Process>();
	
	String trName = "";
	String prStateName = "";
	String prDate = "";
	String divis = "/";
	int prNo;
	
	if(request.getParameter("prNo") != null){
		prNo = Integer.parseInt(request.getParameter("prNo"));
		
		pListNo = pDAO.getData(prNo);
		trName = pListNo.get(0).getTrName();
		prStateName = pListNo.get(0).getPrStateName();
		prDate = pListNo.get(0).getPrDate();
	}
%>
	<div class="submenu-container"><!-- 서브 메뉴 -->
		<ul class="ul">
			<li class="submenu" id="submenu-one"><a class="submenu-move" href="StudentRegist.jsp"><span class="submenu-text">등록</span></a></li>
			<li class="submenu"><a class="submenu-move" href="Student.jsp"><span class="submenu-text">조회</span></a></li>
			<li class="submenu" id="submenu-three"><a class="submenu-move" href="StudentSearch.jsp"><span class="submenu-text">이름검색</span></a></li>
		</ul>
	</div><!-- 서브 메뉴 끝 -->
	
	<div class="content"><!-- 과정 변경 -->
		<form action="StudentInfoUpdateProcessActive.jsp" method="post">
			<input type="hidden" name="stNo" value="<%=request.getParameter("stNo") %>">
			<input type="hidden" name="prNo" value="<%=request.getParameter("prNo") %>">
			<table class="student-table">
				<tr>
					<td class="student-label">
						<label for="trName">과정이름</label>
					</td>
					<td colspan=3>
						<select class="student-component-select" onchange="movePage('StudentInfoUpdateProcess.jsp','prNo',this.value,'stNo',<%=request.getParameter("stNo")%>);"><!-- 과정 선택 -->
							<option></option>
							<%
								pList = pDAO.getList();
								
								for(int i = 0; i < pList.size(); i++){
									String str = pList.get(i).getPrDate();
									String[] date = str.split(divis);
							%>
									<option value="<%=pList.get(i).getPrNo() %>"><%="(" + date[0] + ")" + pList.get(i).getTrName()%></option>
							<%
								}
							%>
						</select><!-- 과정 선택 끝 -->
						<input class="student-component-text" name="trName" value="<%=trName %>" readonly>
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="prStateName">과정상태</label>
					</td>
					<td>
						<input class="student-component-text" name="prStateName" value="<%=prStateName %>" readonly>
					</td>
					<td class="student-label">
						<label for="prDate">과정날짜</label>
					</td>
					<td>
						<input class="student-component-text" name="prDate" value="<%=prDate %>" readonly>
					</td>
				</tr>
				<tr>
					<td class="student-label">
						이름
					</td>
					<td colspan=3>
						<%
							stList = stDAO.getData(Integer.parseInt(request.getParameter("stNo")));
							out.println(stList.get(0).getStName());
						%>
					</td>
				</tr>
				<tr>
					<td colspan=4>
						<input class="student-submit" type="submit" value="수정">
					</td>
				</tr>
			</table>
		</form>
	</div><!-- 과정 변경 끝 -->
</body>
</html>