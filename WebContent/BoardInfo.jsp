<!-- 게시물 정보 -->
<!-- request : bNo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.Board" %>
<%@ page import="board.BoardDAO" %>
<%@page import="java.io.File"%>
<%@ page import="java.util.*" %>
<%@ include file="Default.jsp" %>	<!-- 기본 틀(로고, 상단 메뉴, 사이드 메뉴)-->
<!DOCTYPE HTML>
<html>
<head>
	<link rel="stylesheet" href="./css/intra.css">
    <meta charset="UTF-8">
    <title>휴먼교육센터</title>
    <script src="./js/Intra.js"></script>
    <style>
    	.nav-board
		{
		    background-color: #ff9d00;
		}
    	.content
		{
			position: absolute;
			top: 300px;
			left: 50%;
			margin-left: -400px;
			width: 800px;
			height: 100px;
		}
		.board-table
        {
            position: absolute;
            top: 20px;
            left: 50%;
            margin-left: -400px;
            width: 800px;
        }
        .board-label
        {
        	padding-top: 10px;
            padding-bottom: 10px;
            width: 100px;
            text-align: center;
            font-size: 15px;
            font-weight: bold;
            color: #3352ff;
        }
        .board-content
        {
        	border-bottom: 2px solid #0076ff;
        }
        .board-component-btn
        {
        	background-color: #0076ff;
        	border: none;
        	width: 100px;
        	height: 25px;
        	font-weight: bold;
        	color: white;
        }
        .board-component-text
        {
        	border: none;
        	border-bottom: 2px solid #0076ff;
            width: 700px;
            height: 30px;
            letter-spacing: 1px;
        }
        .board-submit
        {
        	background-color: #0076ff;
        	border: none;
        	width: 100%;
        	height: 35px;
        	font-size: 15px;
        	font-weight: bold;
        	color: white;
        }
    </style>
</head>
<body>
<%
	BoardDAO bDAO = new BoardDAO();
	ArrayList<Board> bList = new ArrayList<Board>();
	
	bList = bDAO.getDate(Integer.parseInt(request.getParameter("bNo")));
%>
	<div class="content"><!-- 게시판 정보 -->
		<form action="BoardInfoUpdate.jsp" method="post">
			<input type="hidden" name="bNo" value="<%=bList.get(0).getbNo() %>">
			<table class="board-table">
				<tr>
					<td class="board-label">
						<label for="bTitle">제목</label>
					</td>
					<td class="board-content">
						<%=bList.get(0).getbTitle()%>
	 				</td>
				</tr>
				<tr>
					<td class="board-label">
						<label for="bFile">자료</label>
					</td>
					<td class="board-content">
					<%
						File targetDirFile = new File(application.getRealPath("/upload/board/"));
						
						if(targetDirFile.exists()){		//폴더 확인
							String dir = application.getRealPath("/upload/board/");
							String[] files = new File(dir).list();
							
							for(String file : files){
								if(file.equals(bList.get(0).getbFile())){	//첨부 파일 다운로드 링크
									out.write("<a href=\"" + request.getContextPath() + "/downloadAction?file=" +
										java.net.URLEncoder.encode(file, "UTF-8").replace("+","%20") + "&save=board/" + "\">" + "첨부파일" + "</a>");
								}
							}
						}
								
						if(bList.get(0).getMemId().equals(userId) || String.valueOf(session.getAttribute("userAccept")).equals("1")){		//첨부파일 수정.	작성자만 이용가능
					%>
							<input class="board-component-btn" type="button" value="파일변경" onclick="movePage('BoardInfoFile.jsp','bNo','<%=bList.get(0).getbNo()%>');">
					<%
						}
					%>
					</td>
				</tr>
				<tr>
					<td colspan=2 style="text-align: left;">	<!-- 게시판 내용 -->
						<%
							String content = bList.get(0).getbContent();
							content = content.replace("\r\n", "<br>");
							out.println(content);
						%>
					</td>
				</tr>
				<tr><td colspan=2 style="height: 50px;"></td></tr>	<!-- 공백 -->
				<%
					if(bList.get(0).getMemId().equals(userId) || String.valueOf(session.getAttribute("userAccept")).equals("1")){		//내용 수정.	작성자만 가능
				%>
						<tr>
							<td colspan=2>
								<input class="board-submit" type="submit" value="수정하기">
							</td>
						</tr>
						<tr>
							<td colspan=2>
								<input class="board-submit" type="button" onclick="deleteEvent('BoardInfoDeleteActive.jsp','bNo','<%=bList.get(0).getbNo() %>');" value="삭제하기">
							</td>
						</tr>
				<%
					}
				%>
			</table>
		</form>
	</div><!-- 게시판 정보 끝 -->
</body>
</html>