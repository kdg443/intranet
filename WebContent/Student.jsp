<!-- 해당 과정 훈련생 조회 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="member.Member"%>
<%@page import="member.MemberDAO"%>
<%@ page import="student.Student" %>
<%@ page import="student.StudentDAO" %>
<%@ page import="training.RegProcess" %>
<%@ page import="training.RegProcessDAO" %>
<%@ page import="training.Process" %>
<%@ page import="training.ProcessDAO" %>
<%@ page import="java.util.ArrayList" %>
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
	MemberDAO mDAO = new MemberDAO();
	StudentDAO stDAO = new StudentDAO();
	RegProcessDAO rpDAO = new RegProcessDAO();
	ProcessDAO pDAO = new ProcessDAO();
	
	ArrayList<Member> mList = new ArrayList<Member>();
	ArrayList<Student> stList = new ArrayList<Student>();
	ArrayList<RegProcess> rpList = new ArrayList<RegProcess>();
	ArrayList<Process> pList = new ArrayList<Process>();
	
	pList = pDAO.getList();
	
	String processName = "";
%>
	<div class="submenu-container"><!-- 서브 메뉴 -->
		<ul class="ul">
			<li class="submenu" id="submenu-one"><a class="submenu-move" href="StudentRegist.jsp"><span class="submenu-text">등록</span></a></li>
			<li class="submenu" id="submenu-two"><a class="submenu-move" href="Student.jsp"><span class="submenu-text">조회</span></a></li>
			<li class="submenu" id="submenu-three"><a class="submenu-move" href="StudentSearch.jsp"><span class="submenu-text">이름검색</span></a></li>
		</ul>
	</div><!-- 서브 메뉴 끝 -->
	
	<div class="content"><!-- 훈련생 목록 -->
		<select name="prNo" onchange="movePage('Student.jsp','prNo',this.value);">	<!-- 과정 선택 -->
			<option></option>
			<%
				for(int i = 0; i < pList.size(); i++){
					String totalDate = pList.get(i).getPrDate();
					String divisDate = "/";
					String[] date = totalDate.split(divisDate);
			%>
					<option value="<%=pList.get(i).getPrNo()%>"><%="(" + date[0] + ")" + pList.get(i).getTrName() %></option>
			<%		
				}
			%>
		</select><!-- 과정 선택 끝 -->
		<table class="student-table"><!-- 해당 과정 정보 및 훈련생 목록 -->
			<thead class="student-thead">
			<%
				if(request.getParameter("prNo") != null){
			%>
					<tr class="student-name">		<!-- 해당 과정 정보, 과정 인원 -->
						<td colspan=4>
			<%
							ArrayList<Process> pListTitle = new ArrayList<Process>();
			pListTitle = pDAO.getData(Integer.parseInt(request.getParameter("prNo")));
							mList = mDAO.getList(pListTitle.get(0).getMemId());
							processName = pListTitle.get(0).getTrName();
			%>
							<span style="float: left;">
								<%=processName + "(" + pListTitle.get(0).getPrDate() + ")" + "[" + pListTitle.get(0).getPrStateName() + "]" + "-" + mList.get(0).getMemName()%>
							</span>
							<span style="float: right;">
								정원 : <%=stDAO.getTotalType(Integer.parseInt(request.getParameter("prNo")), "총원") %>
								/
								<%=pListTitle.get(0).getPrQueta() %>
							</span>
						</td>
					</tr><!-- 해당 과정 정보, 과정 인원 끝 -->
					<tr class="student-total"><!-- 훈련생 상태 종합 -->
						<td colspan=4>
							훈련생 : <%=stDAO.getTotalType(Integer.parseInt(request.getParameter("prNo")), "훈련생") %>명 |
							80%수료생 : <%=stDAO.getTotalType(Integer.parseInt(request.getParameter("prNo")), "80%수료생") %>명 |
							수료생 : <%=stDAO.getTotalType(Integer.parseInt(request.getParameter("prNo")), "수료생") %>명 |
							조기취업 : <%=stDAO.getTotalType(Integer.parseInt(request.getParameter("prNo")), "조기취업") %>명 |
							중도탈락 : <%=stDAO.getTotalType(Integer.parseInt(request.getParameter("prNo")), "중도탈락") %>명 |
							기타 : <%=stDAO.getTotalType(Integer.parseInt(request.getParameter("prNo")), "기타") %>명
						</td>
					</tr><!-- 훈련생 상태 종합 끝 -->
			<%
				}
			%>
				<tr class="student-title">
					<th width="200">
						이름
					</th>
					<th width="200">
						상태
					<th width="250">
						유형
					</th>
					<th width="150">
						합격여부
					</th>
				</tr>
			</thead>
			<tbody><!-- 훈련생 목록 -->
			<%
				if(request.getParameter("prNo") != null){
					int prNo = Integer.parseInt(request.getParameter("prNo"));
					String[] style = { "odd", "even"};
					
					rpList = rpDAO.getListRegist(prNo);
					
					for(int i = 0; i < rpList.size(); i++){
						stList = stDAO.getData(rpList.get(i).getStNo());
			%>
						<tr class="student-content-<%=style[i % 2]%>">
							<td><a class="student-content-text-move" href="StudentInfo.jsp?stNo=<%=stList.get(0).getStNo() %>"><%=stList.get(0).getStName() %></a></td>
							<td><%=stList.get(0).getStStateName() %></td>
							<td><%=stList.get(0).getStTyName()%></td>
							<td><%=stList.get(0).getPaName() %></td>
						</tr>
			<%			
					}
				}
			%>
			<tr><td colspan=4 style="height: 100px;"></td></tr>		<!-- 공백 -->
			</tbody><!-- 훈련생 목록 끝 -->
		</table><!-- 해당 과정 정보 및 훈련생 목록 끝 -->
	</div><!-- 훈련생 목록 끝 -->
</body>
</html>