<!-- 잡트라넷 메인 -->
<%@page import="utilMade.TimeNow"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="student.Student" %>
<%@ page import="student.StudentDAO" %>
<%@ page import="student.Jobtranet" %>
<%@ page import="student.JobtranetDAO" %>
<%@ page import="java.io.File"%>
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
	int pageNumber = 1;

	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	
	JobtranetDAO jDAO = new JobtranetDAO();
	ArrayList<Jobtranet> jList = new ArrayList<Jobtranet>();
	
	TimeNow now = new TimeNow();
%>
<h1 class="header">Jobtranet</h1>
<div class="content"><!-- 잡트라넷 목록 -->
	<table class="job-table">
		<thead class="job-thead">
			<tr>
				<th colspan=6>해당 제목 클릭 시 자세한 내용 출력</th>
			</tr>
			<tr class="job-title">
				<th width="100">기업이름</th>
				<th width="350">제목</th>
				<th width="150">지원자격</th>
				<th width="100">연봉</th>
				<th width="100">마감일</th>
				<th width="100">즉시지원</th>
			</tr>
		</thead>
		<tbody><!-- 내용 -->
			<%
				int totalRecord = jDAO.totalRecord(now.getyMd());		//총레코드 수.
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
				int beginPerPage = jDAO.totalRecord();
				if(request.getParameter("pageNumber") != null && (Integer.parseInt(request.getParameter("pageNumber"))) > 1)
					beginPerPage = jDAO.endPage((totalRecord - ((pageNumber - 1) * numPerPage)), numPerPage, now.getyMd());
				
				jList = jDAO.jobList(beginPerPage, numPerPage, now.getyMd());
				
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
							<td><a class="job-content-text-move" href="JobInfo.jsp?jNo=<%=jList.get(i).getjNo()%>"><%=jList.get(i).getjTitle() %></a></td>
							<td><%=jList.get(i).getjEdu() + "<br>" + jList.get(i).getjCareer() %></td>
							<td><%=jList.get(i).getjIncome() %></td>
							<td><%=date[1] + "-" + date[2] %></td>
							<td><input class="job-component-btn" type="button" value="즉시지원" onclick="movePage('ApplyActive.jsp','jNo','<%=jList.get(i).getjNo()%>');"></td>
						</tr>
						<tr><td colspan=6 style="background-color:#0076ff;"></td></tr>	<!-- 구분선 -->
				<%		
					}
				%>
				<tr>
					<td colspan=6 style="text-align: center;">	<!-- 이전 10개 페이지 확인 -->
					<%
						if(nowBlock != 1 && nowBlock > 0){
					%>
							<a class="job-content-text-move" href="JobMain.jsp?nowBlock=<%=nowBlock - 1 %>&pageNumber=<%=numEndBlock - (pagePerBlock + 1)%>">[ 이전 10개 ]</a>
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
									<a class="job-content-text-move" href="JobMain.jsp?nowBlock=<%=nowBlock%>&pageNumber=<%=i %>"><%="[" + i + "]" %></a>
					<%			}
							}
						}
					
						if(totalBlock > nowBlock){		// 다음 10개 페이지 확인
					%>
							<a class="job-content-text-move" href="JobMain.jsp?nowBlock=<%=nowBlock + 1 %>&pageNumber=<%=numEndBlock + 1%>">[ 다음 10개 ]</a>
					<%
						}
					%>
					</td>
				</tr>
				<tr><td colspan=4 style="height: 100px;"></td></tr>	<!-- 공백 -->
			</tbody>
	</table>
</div><!-- 잡트라넷 목록 -->
</body>
</html>