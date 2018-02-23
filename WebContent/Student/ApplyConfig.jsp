<!-- 지원 목록 확인 -->
<%@page import="student.Apply"%>
<%@page import="student.ApplyDAO"%>
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
	
	ApplyDAO aDAO = new ApplyDAO();
	JobtranetDAO jDAO = new JobtranetDAO();
	
	ArrayList<Apply> aList = new ArrayList<Apply>();
	ArrayList<Jobtranet> jList = new ArrayList<Jobtranet>();
	
	int stNo = Integer.parseInt(String.valueOf(session.getAttribute("num")));
%>
<h1 class="header">지원 목록</h1>
<div class="content"><!-- 지원 목록 -->
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
				<th width="100">지원취소</th>
			</tr>
		</thead>
		<tbody>
		<%
			int totalRecord = aDAO.totalRecord(stNo);					//총레코드 수
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
			int beginPerPage = totalRecord;
			if(request.getParameter("pageNumber") != null && (Integer.parseInt(request.getParameter("pageNumber"))) > 1)
				beginPerPage = aDAO.endPage((totalRecord - ((pageNumber - 1) * numPerPage)), stNo, numPerPage);
			
			aList = aDAO.applyList(beginPerPage, stNo, numPerPage);

			//마지막 블록 수
			int numEndBlock = (pagePerBlock * nowBlock);
			
			//첫 블록 수
			int numStartBlock = numEndBlock - (pagePerBlock - 1);
		
			String[] style = { "odd", "even"};			//css name
			
			for(int i = 0; i < aList.size(); i++){			//cols배경.	홀수 : 흰색, 짝수 : 회색
				jList = jDAO.getData(aList.get(i).getjNo());
		%>
				<tr class="job-content-<%=style[i % 2]%>">
					<td><%=jList.get(0).getjName() %></td>
					<td><a class="job-content-text-move" href="JobInfo.jsp?jNo=<%=jList.get(0).getjNo() %>"><%=jList.get(0).getjTitle() %></a></td>
					<td><%=jList.get(0).getjEdu() + "<br>" + jList.get(0).getjCareer()%></td>
					<td><%=jList.get(0).getjIncome() %></td>
					<td>
					<%
						String totalDate = jList.get(0).getjDate();
						String divisDate = "[-]";
						String[] date = totalDate.split(divisDate);
						
						out.println(date[1] + "-" + date[2]);
					%>
					</td>
					<td>
						<input class="job-component-btn" type="button" value="취소하기" onclick="deleteEvent('ApplyDeleteActive.jsp','jNo','<%=jList.get(0).getjNo() %>');">
					</td>
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
					<a class="job-content-text-move" href="ApplyConfig.jsp?nowBlock=<%=nowBlock - 1 %>&pageNumber=<%=numEndBlock - (pagePerBlock + 1)%>">[ 이전 10개 ]</a>
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
							<a class="job-content-text-move" href="ApplyConfig.jsp?nowBlock=<%=nowBlock%>&pageNumber=<%=i %>"><%="[" + i + "]" %></a>
			<%			}
					}
				}
			
				if(totalBlock > nowBlock){		// 다음 10개 페이지 확인
			%>
					<a class="job-content-text-move" href="ApplyConfig.jsp?nowBlock=<%=nowBlock + 1 %>&pageNumber=<%=numEndBlock + 1%>">[ 다음 10개 ]</a>
			<%
				}
			%>
			</td>
		</tr>
		<tr><td colspan=6 style="height: 100px;"></td></tr>	<!-- 공백 -->
		</tbody>
	</table>
</div><!-- 지원 목록 끝 -->
</body>
</html>