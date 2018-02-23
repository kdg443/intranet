<!-- 직원 이력서 파일 수정 -->
<!-- request : memId -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ include file="SessionConfig.jsp" %><!-- 세션 관리 -->
<!DOCTYPE HTML>
<html>
<head>
    <link rel="stylesheet" href="./css/intraAdmin.css">
    <meta charset="utf-8">
    <title>휴먼교육센터</title>
    <script src="./js/Admin.js"></script>
    <style>
        #first-box
        {
            top: 150px;
            left: 50px;
            width: 700px;
            height: 320px;
        }
        .member-table
        {
            position: absolute;
            top: 10px;
            left: 15px;
        }
        .member-label
        {
            background-color: rgb(255, 255, 255);
            padding-top: 10px;
            padding-bottom: 10px;
            width: 100px;
            text-align: center;
            font-size: 15px;
            font-weight: bold;
            color: #3352ff;
        }
        .member-component-btn
        {
        	background-color: #0076ff;
        	border: none;
        	width: 100px;
        	height: 25px;
        	font-weight: bold;
        	color: white;
        }
        .member-component-select
        {
            width: 214px;
            height: 30px;
            letter-spacing: 1px;
        }
        .member-component-text
        {
            width: 210px;
            height: 25px;
            letter-spacing: 1px;
        }
        #member-component-tel
        {
            width: 100px;
        }
        .member-component-file
        {
        	text-decoration: none;
        }
        .member-submit
        {
            margin-left: 20px;
            background-color: #0076ff;
            border: none;
            width: 660px;
            height: 35px;
            font-size: 20px;
            font-weight: bold;
            letter-spacing: 3px;
            color: white;
        }
    </style>
</head>
<body>
<div class="container"><!-- 틀  -->
    <div class="article"><!-- 내용 -->
        <div class="article-mark"><!-- 북마크 -->
            <img src="./images/bookmark1.png" class="bookmark-img">
            <span class="bookmark-text">MEMBER</span>
        </div><!-- 북마크 끝 -->
        <button class="btn-move" id="btn-move-one" type="button" onclick="movePage('MemberJoin.jsp');">멤버 추가하기</button>  <!-- 멤버 추가하기 -->
        <button class="btn-move" id="btn-move-two" type="button" onclick="movePage('MemberConfig.jsp');">멤버 확인하기</button>  <!-- 멤버 확인하기 -->
        <div class="article-mark-move"><!-- Training 페이지 이동 -->
            <a href="TrainingDefine.jsp" class="mark-move" id="mark-move-one">
                <img src="./images/bookmark2.png" class="mark-move-img">
                <span class="mark-move-text">TRAINING</span>
            </a>
        </div><!-- Training 페이지 이동 끝 -->
        <div class="article-mark-move"><!-- Student 페이지 이동 -->
            <a href="StudentDefine.jsp" class="mark-move" id="mark-move-two">
                <img src="./images/bookmark2.png" class="mark-move-img">
                <span class="mark-move-text">STUDENT</span>
            </a>
        </div><!-- Student 페이지 이동 끝 -->
        <div class="article-mark-move"><!-- 메인 페이지 이동 -->
            <a href="../Main.jsp" class="mark-move" id="mark-move-three">
                <img src="./images/bookmark3.png" class="mark-move-img">
                <span class="mark-move-text">HOME</span>
            </a>
        </div><!-- 메인 페이지 이동 끝 -->
        
       	<div class="content" id="first-box"><!-- 파일 수정 폼 -->
            <div class="content-comment"><!-- 파일 주석 -->
                <img src="./images/comment.png" class="comment-img">
                <span class="comment-text">파일</span>
            </div><!-- 파일 주석 끝 -->
            <form action="MemberResumeActive.jsp" method="post" enctype="multipart/form-data">
            	<input type="hidden" name="memId" value="<%=request.getParameter("memId") %>">
                <table class="member-table"><!-- 파일 수정 양식 -->
                	<tr>
                		<td class="member-label">
                			<label for="memResume">이력서</label>
                		</td>
                		<td>
                			<input type="file" name="memResume">
                		</td>
                	</tr>
                	<tr>
                		<td colspan=2>
                			<input class="member-submit" id="member-submit-update" type="submit" value="수정하기">
                		</td>
                	</tr>
                </table><!-- 파일 수정 양식  끝-->
            </form>
        </div><!-- 파일 수정 폼 끝 -->
    </div><!-- 내용 끝 -->
</div><!-- 틀 끝 -->
</body>
</html>