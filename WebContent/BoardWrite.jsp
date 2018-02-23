<!-- 글쓰기 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<div class="content"><!-- 글쓰기 -->
		<form action="BoardWriteActive.jsp" method="post" enctype="multipart/form-data">
			<table class="board-table">
				<tr>
					<td class="board-label">
						<label for="bTitle">제목</label>
					</td>
					<td>
						<input class="board-component-text" name="bTitle" type="text" placeholder="게시글 제목" maxlength="30">
	 				</td>
				</tr>
				<tr>
					<td class="board-label">
						<label for="bFile">파일첨부</label>
					</td>
					<td>
						<input type="file" name="bFile">
					</td>
				</tr>
				<tr>
					<td colspan=2 style="text-align: center;">
						<textarea class="board-component-textarea" name="bContent" placeholder="글내용 작성"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<input class="board-submit" type="submit" value="작성하기">
					</td>
				</tr>
			</table>
		</form>
	</div><!-- 글쓰기 끝 -->
</body>
</html>