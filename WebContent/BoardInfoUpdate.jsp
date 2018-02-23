<!-- 게시물 정보 수정 -->
<!-- request : bNo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.Board" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.util.*" %>
<%@ include file="Default.jsp" %>	<!-- 기본 틀(로고, 상단 메뉴, 사이드 메뉴)-->
<!DOCTYPE HTML>
<html>
<head>
	<link rel="stylesheet" href="./css/intra.css">
    <meta charset="UTF-8">
    <title>휴먼교육센터</title>
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
        .board-component-text
        {
        	border: none;
        	border-bottom: 2px solid #0076ff;
            width: 700px;
            height: 30px;
            letter-spacing: 1px;
        }
        .board-component-textarea
        {
        	width: 800px;
        	height: 300px;
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
	<div class="content"><!-- 게시물 내용 수정 -->
		<form action="BoardInfoUpdateActive.jsp" method="post">
			<input type="hidden" name="bNo" value="<%=bList.get(0).getbNo() %>">
			<table class="board-table">
				<tr>
					<td class="board-label">
						<label for="bTitle">제목</label>
					</td>
					<td>
						<input class="board-component-text" name="bTitle" type="text" placeholder="게시글 제목" maxlength="30" value="<%=bList.get(0).getbTitle()%>">
	 				</td>
				</tr>
				<tr>
					<td class="board-label">
						<label for="bFile">자료</label>
					</td>
					<td>
						 <%=bList.get(0).getbFile()%>
					</td>
				</tr>
				<tr>
					<td colspan=2 style="text-align: center;">
						<textarea class="board-component-textarea" name="bContent" placeholder="글내용 작성"><%=bList.get(0).getbContent() %></textarea>
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<input class="board-submit" type="submit" value="수정하기">
					</td>
				</tr>
			</table>
		</form>
	</div><!-- 게시물 내용 수정 -->
</body>
</html>