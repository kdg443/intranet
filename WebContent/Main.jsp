<!-- 메인 페이지 -->
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.Board" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="member.Member" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="training.Process" %>
<%@ page import="training.ProcessDAO" %>
<%@ page import="java.util.*" %>
<%@ include file="Default.jsp" %>	<!-- 기본 틀(로고, 상단 메뉴, 사이드 메뉴)-->
<!DOCTYPE HTML>
<html>
<head>
	<link rel="stylesheet" href="./css/intra.css">
    <meta charset="UTF-8">
    <title>휴먼교육센터</title>
   	<style>
   		#nav-move-home
		{
		    background-color: rgb(37, 37, 255);
		}
		.content
		{
			position: absolute;
			left: 50%;
			margin-left: -400px;
			width: 800px;
			height: 100px;
		}
		#content-board
		{
			top: 350px;
		}
		#content-process
		{
			top: 550px;
		}
		.board-table
        {
            position: absolute;
            top: 20px;
            left: 50%;
            margin-left: -400px;
            width: 800px;
        }
        .board-thead
        {
            background-color: #0076ff;
            font-size: 15px;
            text-align: center;
            color: white;
        }
        .board-title
        {
            height: 30px;
        }
        .board-content-text-move
        {
        	text-decoration: none;
        	color: black;
        }
        .board-content-odd
        {
            text-align: center;
            height: 30px;
        }
        .board-content-even
        {
        	background-color: lightgrey;
        	text-align: center;
        	height: 30px;
        }
        .board-context-now
        {
        	font-size: 25px;
        	color: #0076ff;
        }
   	</style>
</head>
<body>
<%
	int pageNumber = 1;		//해당 페이지 번호

	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	BoardDAO bDAO = new BoardDAO();
	MemberDAO mDAO = new MemberDAO();
	ProcessDAO pDAO = new ProcessDAO();
	
	ArrayList<Board> bList = new ArrayList<Board>();
	ArrayList<Member> mList = new ArrayList<Member>();
	ArrayList<Process> pList = new ArrayList<Process>();
%>
	<div class="content" id="content-board"><!-- 게시판 -->
		<span>* 최근 작성된 게시물 [3개]</span>
		<table class="board-table">
			<thead class="board-thead">
				<tr class="board-title">
					<th width="100">No</th>
					<th width="400">제목</th>
					<th width="100">작성자</th>
					<th width="200">작성일</th>
				</tr>
			</thead>
			<tbody>
			<%
				bList = bDAO.getMainList(3);		//최근 작성 게시물 3개
				
				String[] style = { "odd", "even" };		//css name
			
				for(int i = 0; i < bList.size(); i++){			//cols배경.	홀수 : 흰색,	짝수 : 회색
					mList = mDAO.getList(bList.get(i).getMemId());
			%>
					<tr class="board-content-<%=style[i % 2]%>">
						<td><%=bList.get(i).getbNo() %></td>
						<td style="text-align: left; font-size: 13px;"><a class="board-content-text-move" href="BoardInfo.jsp?bNo=<%=bList.get(i).getbNo()%>"><%=bList.get(i).getbTitle()%></a></td>
						<td><%=mList.get(0).getMemName() %></td>
						<td><%=bList.get(i).getbDate()%></td>
					</tr>
			<%		
				}
			%>
			</tbody>
		</table>
	</div><!-- 게시판 끝 -->
	
	<div class="content" id="content-process"><!-- 훈련 조회 -->
		<span>* 훈련 조회</span>
		<table class="board-table">
			<thead class="board-thead">
				<tr class="board-title">
					<th width="70">No</th>
                    <th width="420">훈련명</th>
                    <th width="110">기간</th>
                    <th width="100">과정상태</th>
				</tr>
			</thead>
			<tbody><!-- 내용 -->
				<%
					int totalRecord = pDAO.totalRecord();					//총레코드 수
					int numPerPage = 10;									//페이지 당 게시물 출력 수
					int pagePerBlock = 10;									//페이지 당 블록 수
					
					//총 페이지 수
					int totalPage = (totalRecord / numPerPage) + ((totalRecord % numPerPage) > 0? 1 : 0);
					
					//총 블록 수d
					int totalBlock = (totalRecord / (numPerPage * pagePerBlock));
					totalBlock += (totalRecord % (numPerPage * pagePerBlock)) > 0? 1 : 0;
					
					//현재 블록
					int nowBlock = 1;
					if(request.getParameter("nowBlock") != null)
						nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
					
					//시작 게시물 번호
					int beginPerPage = totalRecord - ((pageNumber - 1) * numPerPage);
					
					pList = pDAO.processList(beginPerPage, numPerPage);
					
					//마지막 블록 수
					int numEndBlock = (pagePerBlock * nowBlock);
					
					//첫 블록 수
					int numStartBlock = numEndBlock - (pagePerBlock - 1);
					
					for(int i = 0; i < pList.size(); i++){			//cols배경.	홀수 : 흰색, 짝수 : 회색
						String totalDate = pList.get(i).getPrDate();
						String divisDate = "/";
						String[] date = totalDate.split(divisDate);
				%>
						<tr class="board-content-<%=style[i % 2] %>">
							<td><%=pList.get(i).getPrNo()%></td>
							<td style="text-align: left;"><a class="board-content-text-move" href="ProcessInfo.jsp?prNo=<%=pList.get(i).getPrNo()%>"><%="[" + pList.get(i).getTrType() + "]" + pList.get(i).getTrName()%></a></td>
							<td><%=date[0] + "<br>" + date[1] %></td>
							<td><%=pList.get(i).getPrStateName() %></td>
						</tr>
				<%		
					}
				%>
					<tr>
						<td colspan=4 style="text-align: center;">	<!-- 이전 10개 페이지 확인 -->
						<%
							if(nowBlock != 1 && nowBlock > 0){
						%>
								<a class="board-content-text-move" href="ProcessInfo.jsp?nowBlock=<%=nowBlock - 1 %>&pageNumber=<%=numEndBlock - (pagePerBlock + 1)%>">[ 이전 10개 ]</a>
						<%
							}
						
							for(int i = numStartBlock; i <= numEndBlock; i++){	//페이지 번호
								if(totalPage >= i){
									if(pageNumber == i){	//페이징 목록과 현제 페이지 비교
						%>
										<span class="board-context-now"><%=i %></span>
						<%
									}else{
						%>
										<a class="board-content-text-move" href="ProcessInfo.jsp?nowBlock=<%=nowBlock%>&pageNumber=<%=i %>"><%="[" + i + "]" %></a>
						<%			}
								}
							}
						
							if(totalBlock > nowBlock){		// 다음 10개 페이지 확인
						%>
								<a class="board-content-text-move" href="ProcessInfo.jsp?nowBlock=<%=nowBlock + 1 %>&pageNumber=<%=numEndBlock + 1%>">[ 다음 10개 ]</a>
						<%
							}
						%>
						</td>
					</tr>
					<tr><td colspan=4 style="height: 100px;"></td></tr>	<!-- 공백 -->
				</tbody>
		</table>
	</div><!-- 훈련 조회 끝-->
</body>
</html>