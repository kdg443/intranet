<!-- 잡트라넷 목록 (10개씩) -->
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
        .job-context-now
        {
        	font-size: 25px;
        	color: #0076ff;
        }
	</style>
</head>
<body>
<%
	int pageNumber = 1;			//해당 페이지 번호

	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	JobtranetDAO jDAO = new JobtranetDAO();
	ArrayList<Jobtranet> jList = new ArrayList<Jobtranet>();
%>
	<div class="submenu-container"><!-- 서브 메뉴 -->
		<ul class="ul">
			<li class="submenu" id="submenu-one"><a class="submenu-move" href="JobtranetConfig.jsp"><span class="submenu-text">잡트라넷</span></a></li>
			<li class="submenu" id="submenu-two"><a class="submenu-move" href="JobtranetRegist.jsp"><span class="submenu-text">구인등록</span></a></li>
			<li class="submenu" id="submenu-three"><a class="submenu-move" href="JobtranetApply.jsp"><span class="submenu-text">지원현황</span></a></li>
		</ul>
	</div><!-- 서브 메뉴 끝 -->
	
	<div class="content"><!-- 잡트라넷 목록 -->
		<table class="job-table">
			<thead class="job-thead">
				<tr class="job-title">
					<th width="100">기업이름</th>
					<th width="350">제목</th>
					<th width="150">지원자격</th>
					<th width="100">연봉</th>
					<th width="100">마감일</th>
				</tr>
			</thead>
			<tbody><!-- 내용 -->
			<%
				int totalRecord = jDAO.totalRecord();					//총레코드 수
				int numPerPage = 10;									//페이지 당 게시물 출력 수
				int pagePerBlock = 10;									//페이지 당 블록 수
				
				//총 페이지 수
				int totalPage = (totalRecord / numPerPage) + ((totalRecord % numPerPage) > 0? 1 : 0);
				
				//총 블록 수
				int totalBlock = (totalRecord / (numPerPage * pagePerBlock));
				totalBlock += (totalRecord % (numPerPage * pagePerBlock)) > 0? 1 : 0;
				
				//현재 블록
				int nowBlock = 1;
				if(request.getParameter("nowBlock") != null)
					nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
				
				//시작 게시물 번호
				int beginPerPage = totalRecord - ((pageNumber - 1) * numPerPage);
				
				jList = jDAO.jobList(beginPerPage, numPerPage);
				
				//마지막 블록 수
				int numEndBlock = (pagePerBlock * nowBlock);
				
				//첫 블록 수
				int numStartBlock = numEndBlock - (pagePerBlock - 1);
				
				String[] style = { "odd", "even"};
				
				for(int i = 0; i < jList.size(); i++){			//cols배경.	홀수 : 흰색, 짝수 : 회색
					String totalDate = jList.get(i).getjDate();
					String divisDate = "-";
					String[] date = totalDate.split(divisDate);
				%>
						<tr class="job-content-<%=style[i % 2] %>">
							<td><%=jList.get(i).getjName() %></td>
							<td><a class="job-content-text-move" href="JobtranetInfo.jsp?jNo=<%=jList.get(i).getjNo()%>"><%=jList.get(i).getjTitle() %></a></td>
							<td><%=jList.get(i).getjEdu() + "<br>" + jList.get(i).getjCareer() %></td>
							<td><%=jList.get(i).getjIncome() %></td>
							<td><%=date[1] + "-" + date[2] %></td>
						</tr>
				<%		
					}
				%>
				<tr>
					<td colspan=5 style="text-align: center;">	<!-- 이전 10개 페이지 확인 -->
					<%
						if(nowBlock != 1 && nowBlock > 0){
					%>
							<a class="job-content-text-move" href="Jobtranet.jsp?nowBlock=<%=nowBlock - 1 %>&pageNumber=<%=numEndBlock - (pagePerBlock + 1)%>">[ 이전 10개 ]</a>
					<%
						}
					
						for(int i = numStartBlock; i <= numEndBlock; i++){	//페이지 번호
							if(totalPage >= i){
								if(pageNumber == i){	//페이징 목록과 현제 페이지 비교
					%>
									<span class="job-context-now"><%=i %></span>
					<%
								}else{
					%>
									<a class="job-content-text-move" href="Jobtranet.jsp?nowBlock=<%=nowBlock%>&pageNumber=<%=i %>"><%="[" + i + "]" %></a>
					<%			}
							}
						}
					
						if(totalBlock > nowBlock){		// 다음 10개 페이지 확인
					%>
							<a class="job-content-text-move" href="Jobtranet.jsp?nowBlock=<%=nowBlock + 1 %>&pageNumber=<%=numEndBlock + 1%>">[ 다음 10개 ]</a>
					<%
						}
					%>
					</td>
				</tr>
				<tr><td colspan=5 style="height: 100px;"></td></tr>	<!-- 공백 -->
			</tbody>
		</table>
	</div><!-- 잡트라넷 목록 끝 -->
</body>
</html>