<!-- 사후 관리 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.Member"%>
<%@page import="member.MemberDAO"%>
<%@ page import="student.Student" %>
<%@ page import="student.StudentDAO" %>
<%@ page import="training.Process" %>
<%@ page import="training.ProcessDAO" %>
<%@ page import="training.ProcessState" %>
<%@ page import="training.ProcessStateDAO" %>
<%@ page import="training.RegProcess" %>
<%@ page import="training.RegProcessDAO" %>
<%@ page import="java.util.*" %>
<%@ include file="Default.jsp" %>	<!-- 기본 틀(로고, 상단 메뉴, 사이드 메뉴)-->
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="./css/intra.css">
	<meta charset="UTF-8">
	<title>휴먼교육센터</title>
	<script src="./js/Intra.js"></script>
	<style>
		#nav-move-advice
		{
		    background-color: rgb(68, 255, 125);
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
		.advice-table
        {
            position: absolute;
            top: 20px;
            left: 50%;
            margin-left: -400px;
            width: 800px;
        }
        .advice-thead
        {
            background-color: #0076ff;
            font-size: 15px;
            text-align: center;
            color: white;
        }
        .advice-name
        {
        	background-color: white;
        	font-size: 15px;
        	color: black;
        }
        .advice-total
        {
        	font-size: 15px;
        }
        .advice-title
        {
            height: 30px;
        }
        .advice-content-text-move
        {
        	text-decoration: none;
        	color: black;
        }
        .advice-content-odd
        {
            text-align: center;
            height: 30px;
        }
        .advice-content-even
        {
        	background-color: lightgrey;
        	text-align: center;
        	height: 30px;
        }
        .advice-content-submit
        {
        	background-color: #0076ff;
        	border: none;
        	width: 70px;
        	height: 35px;
        	font-weight: bold;
        	color: white;
        }
	</style>
</head>
<body>
<%
	MemberDAO mDAO = new MemberDAO();
	ProcessDAO pDAO = new ProcessDAO();

	ArrayList<Member> mList = new ArrayList<Member>();
	ArrayList<Process> pList = new ArrayList<Process>();
	ArrayList<Process> pListTitle = new ArrayList<Process>();
	
	pList = pDAO.getList();
%>
	<div class="submenu-container"><!-- 서브 메뉴 -->
		<ul class="ul">
			<li class="submenu" id="submenu-one"><a class="submenu-move" href="AdviceAccept.jsp"><span class="submenu-text">접수관리</span></a></li>
			<li class="submenu" id="submenu-two"><a class="submenu-move" href="Advice.jsp"><span class="submenu-text">상담관리</span></a></li>
			<li class="submenu" id="submenu-three"><a class="submenu-move" href="AdviceAfter.jsp"><span class="submenu-text">사후관리</span></a></li>
		</ul>
	</div><!-- 서브 메뉴 끝 -->
	
	<div class="content"><!-- 사후관리, 사후종료. 상담 관리 -->
		<select name="prNo" onchange="movePage('AdviceAfter.jsp','prNo',this.value);"><!-- 과정 선택 -->
			<option></option>
			<%
				for(int i = 0; i < pList.size(); i++){
					if(pList.get(i).getPrStateName().equals("사후관리") || pList.get(i).getPrStateName().equals("사후종료")){			//과정 상태 사후관리, 사후종료만 출력
						String totalDate = pList.get(i).getPrDate();
						String divisDate = "/";
						String[] date = totalDate.split(divisDate);
			%>
						<option value="<%=pList.get(i).getPrNo() %>"><%="(" + date[0] + ")" + pList.get(i).getTrName()%></option>
			<%
					}
				}
			%>
		</select><!-- 과정 선택 끝 -->
		<span>* 작성한 날짜를 기준으로 작성 일이 정해집니다.</span>
		<table class="advice-table">					<!-- 해당 과정을 수강하는 학생 목록 -->
			<thead class="advice-thead">
				<tr class="advice-name">
					<td colspan=3><!-- 과정 정보 -->
					<%
						if(request.getParameter("prNo") != null){
							pListTitle = pDAO.getData(Integer.parseInt(request.getParameter("prNo")));
							mList = mDAO.getList(pListTitle.get(0).getMemId());
					%>
							<span style="float:left;">
								<%=pListTitle.get(0).getTrName() + "(" + pListTitle.get(0).getPrDate() + ")" + "[" + pListTitle.get(0).getPrStateName() + "]" + "-" + mList.get(0).getMemName()%>
							</span>
					<%
						}
					%>
					</td><!-- 과정 정보 끝 -->
				</tr>
				<tr class="advice-title">
					<td width="100">이름</td>
					<td width="100">상태</td>
					<td width="500">상담기입</td>
				</tr>
			</thead>
			<tbody><!-- 학생 목록, 상담기입 -->
			<%
				if(request.getParameter("prNo") != null){
					RegProcessDAO rpDAO = new RegProcessDAO();
					StudentDAO stDAO = new StudentDAO();
					
					ArrayList<RegProcess> rpList = new ArrayList<RegProcess>();
					ArrayList<Student> stList = new ArrayList<Student>();
					
					rpList = rpDAO.getListRegist(Integer.parseInt(request.getParameter("prNo")));
					
					String[] style = {"odd", "even"};		//css name
					
					for(int i = 0; i < rpList.size(); i++){						//cols배경.	홀수 : 흰색, 짝수 : 회색
						stList = stDAO.getData(rpList.get(i).getStNo());
						int stNo = stList.get(0).getStNo();
			%>
						<tr class="advice-content-<%=style[i % 2]%>">
							<td rowspan=2><a class="advice-content-text-move" href="StudentInfo.jsp?stNo=<%=stList.get(0).getStNo() %>"><%=stList.get(0).getStName() %></a></td>
							<td rowspan=2><%=stList.get(0).getStStateName() %></td>
							<td style="text-align:left;">
								<input type="hidden" id="stNo<%=i %>" name="stNo" value="<%=stList.get(0).getStNo()%>">
								<%
									ProcessStateDAO psDAO = new ProcessStateDAO();
									ArrayList<ProcessState> psList = new ArrayList<ProcessState>();
									
									psList = psDAO.getList();
									
									for(int j = 0; j < psList.size(); j++){
								%>
										<input id="prStateName<%=i %>" name="prStateName" type="radio" value="<%=psList.get(j).getPrStateName()%>"><%=psList.get(j).getPrStateName()%>
								<%
									}
								%>
							</td>
						</tr>
						<tr class="advice-content-<%=style[i % 2]%>">
							<td>
								<textarea id="adComment<%=stNo %>" name="adComment" style="float:left;" rows="2" cols="60"></textarea>
								<input type="hidden" id="pageName" name="pageName" value="Advice.jsp">
								<input type="hidden" id="prNo" name="prNo" value="<%=request.getParameter("prNo") %>">	<!-- DB 처리 후 해당 과정으로 돌아오기 위함 -->
								<%
									String paramStNo = "stNo" + i;
									String paramStateName = "prStateName" + i;
									String paramComment = "adComment" + i;
								%>
								<input class="advice-content-submit" type="button" value="등록" onclick="adviceAdd('AdviceActive.jsp','post','<%=stNo %>');">
							</td>
						</tr>
			<%	
					}
				}
			%>
			</tbody><!-- 학생목록, 상담기입 끝 -->
		</table><!-- 해당 과정을 수강하는 학생 목록 끝 -->
	</div><!-- 사후관리, 사후종료. 상담 관리 끝 -->
</body>
</html>