<!-- 해당 날짜 지원 목록 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="student.StudentDAO"%>
<%@page import="student.Student"%>
<%@page import="student.Apply"%>
<%@page import="student.ApplyDAO"%>
<%@ page import="student.Jobtranet" %>
<%@ page import="student.JobtranetDAO" %>
<%@ page import="java.util.*" %>
<%@page import="java.io.File"%>
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
		.job-table
        {
            position: absolute;
            top: 20px;
            left: 50%;
            margin-left: -400px;
            width: 800px;
        }
        .job-thead
        {
            background-color: #0076ff;
            font-size: 15px;
            text-align: center;
            color: white;
        }
        .job-title
        {
            height: 30px;
        }
        .job-content-text-move
        {
        	text-decoration: none;
        	color: black;
        }
        .job-content-odd
        {
            text-align: center;
            font-size: 13px;
            height: 30px;
        }
        .job-content-even
        {
        	background-color: lightgrey;
        	text-align: center;
        	font-size: 13px;
        	height: 30px;
        }
        .job-content-btn
		{
			background-color: #0076ff;
			position: absolute;
			border-bottom: 5px solid grey;
			border-radius: 5px;
			width: 80px;
			height: 40px;
			transition: all 0.1s;
		}
		.job-content-btn:hover
		{
			transform: translateY(3px);
			border-bottom: 2px solid grey;
		}
		.job-content-btn-text
		{
			position: absolute;
			top: 10px;
			left: 20px;
			text-decoration: none;
			font-size: 18px;
			font-weight: bold;
			color: white;
		}
		#job-content-btn-next
		{
			right: 0px;
		}
		#job-content-btn-before
		{
			left: 0px;
		}  
	</style>
</head>
<body>
<%
	StudentDAO stDAO = new StudentDAO();
	ApplyDAO aDAO = new ApplyDAO();
	JobtranetDAO jDAO = new JobtranetDAO();
	
	ArrayList<Student> stList = new ArrayList<Student>();
	ArrayList<Jobtranet> jList = new ArrayList<Jobtranet>();
	ArrayList<Apply> aList = new ArrayList<Apply>();
	ArrayList<Apply> aListNow = new ArrayList<Apply>();
	
	String aDate = "";
	if(request.getParameter("aDate") != null){
		aDate = request.getParameter("aDate");
		aListNow = aDAO.getList(aDate);
	}
%>
	<div class="submenu-container">	<!-- 서브 메뉴 -->
		<ul class="ul">
			<li class="submenu" id="submenu-one"><a class="submenu-move" href="JobtranetConfig.jsp"><span class="submenu-text">잡트라넷</span></a></li>
			<li class="submenu" id="submenu-two"><a class="submenu-move" href="JobtranetRegist.jsp"><span class="submenu-text">구인등록</span></a></li>
			<li class="submenu" id="submenu-three"><a class="submenu-move" href="JobtranetApply.jsp"><span class="submenu-text">지원현황</span></a></li>
		</ul>
	</div><!-- 서브 메뉴 끝  -->
	
	<div class="content"><!-- 지원 목록 -->
		<select name="aDate" onchange="movePage('JobtranetApply.jsp','aDate',this.value);">
			<option></option>
		<%
			aList = aDAO.getListDate();
		
			for(int i = 0; i < aList.size(); i++){		//해당 날짜 선택
		%>
				<option value="<%=aList.get(i).getaDate() %>"><%=aList.get(i).getaDate() %></option>
		<%
			}
		%>
		</select>
		<%="[" + aDate + "]"  %>	<!-- 해당 날짜 출력 -->
		<table class="job-table">
			<thead class="job-thead">
				<tr class="job-title">
					<th width="100">이름</th>
					<th width="500">제목</th>
					<th width="200">이력서</th>
				</tr>
			</thead>
			<tbody><!-- 해당 날짜 지원 목록 -->
			<%
				String dir = "/upload/resume";
				String real = "";
				
				ServletContext context = getServletContext();
				real = context.getRealPath(dir);

				File targetDir = new File(real);
				
				if(request.getParameter("aDate") != null){
					String[] style = { "odd", "even"};		//css name
					
					for(int i = 0; i < aListNow.size(); i++){		//cols배경.	홀수 : 흰색,	짝수 : 회색
						stList = stDAO.getData(aListNow.get(i).getStNo());
						jList = jDAO.getData(aListNow.get(i).getjNo());
			%>
						<tr class="job-content-<%=style[i % 2]%>">
							<td>
								<a class="job-content-text-move" href="StudentInfo.jsp?stNo=<%=stList.get(0).getStNo() %>"><%=stList.get(0).getStName() %></a>
							</td>
							<td>
								<a class="job-content-text-move" href="JobtranetInfo.jsp?jNo=<%=jList.get(0).getjNo() %>"><%=jList.get(0).getjTitle() %></a>
							</td>
							<td>
							<%
								if(targetDir.exists()){	//폴더 확인.	확인 후 이력서 다운로드 가능
									if(stList.get(0).getStResume() != null){
										String save = application.getRealPath("/upload/resume/");
										String[] files = new File(save).list();
										
										for(String file : files){
											if(file.equals(stList.get(0).getStResume())){
												out.write("<a class=\"" + "job-content-text-move" + "\" " + 
													"href=\"" + request.getContextPath() + "/downloadAction?file=" + 
													java.net.URLEncoder.encode(file, "UTF-8").replace("+","%20") + 
													"&save=resume/" + "\">" + "이력서 다운로드" + "</a>");
											}
										}
									}
								}
							%>
							</td>
						</tr>
			<%
					}
				}
			%>
			<tr><td colspan=3 style="height: 100px;"></td></tr>	<!-- 공백 -->
			</tbody><!-- 해당 날짜 지원 목록 끝 -->
		</table>
	</div><!-- 지원 목록 끝 -->
</body>
</html>