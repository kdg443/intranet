<!-- 훈련생 속성 관리 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="student.StudentType" %>
<%@ page import="student.StudentTypeDAO" %>
<%@ page import="student.StudentState" %>
<%@ page import="student.StudentStateDAO" %>
<%@ page import="student.PassWhether" %>
<%@ page import="student.PassWhetherDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>
<%@ include file="SessionConfig.jsp" %><!-- 세션 관리 -->
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE HTML>
<html>
<head>
    <link rel="stylesheet" href="./css/intraAdmin.css">
    <meta charset="utf-8">
    <title>휴먼교육센터</title>
    <script src="./js/Admin.js"></script>
    <style>
    	.article
    	{
    		height: 650px;
    	}
        #first-box
        {
            top: 150px;
            left: 50px;
            width: 700px;
            height: 110px;
        }
        .student-box
        {
            position: absolute;
            top: 10px;
            width: 350px;
        }
        .division-add-del
        {
            position: absolute;
            left: 350px;
            height: 43px;
            border: 1px solid rgb(0, 119, 255);
        }
        .division-add-adj
        {
            position: absolute;
            top: 43px;
            left: 20px;
            width: 658px;
            border: 1px solid rgb(0, 119, 255);
        }
        #student-add
        {
            left: 20px;
        }
        #student-del
        {
            left: 360px;
        }
        #student-adj
        {
            top: 65px;
            left: 20px;
        }
        .student-component
        {
            position: absolute;
            width: 150px;
            height: 30px;
            font-size: 15px;
        }
        #student-component-add-text
        {
            height: 24px;
        }
        #student-component-adjust-select
        {
            width: 200px;
        }
        #student-component-adjust-text
        {
            left: 230px;
            width: 200px;
            height: 23px;
        }
        .student-submit
        {
            position: absolute;
            left: 170px;
            background-color: #0076ff;
            border: none;
            width: 150px;
            height: 29px;
            font-size: 20px;
            font-weight: bold;
            letter-spacing: 1px;
            color: white;
        }
        #student-submit-adjust
        {
            left: 460px;
            width: 200px;
        }
        #second-box
        {
            top: 330px;
            left: 50px;
            width: 700px;
            height: 110px;
        }
        #three-box
        {
        	top: 510px;
            left: 50px;
            width: 700px;
            height: 110px;
        }
    </style>
</head>
<body>
<%
	StudentTypeDAO sTypeDAO = new StudentTypeDAO();
	StudentStateDAO sStateDAO = new StudentStateDAO();
	PassWhetherDAO pwDAO = new PassWhetherDAO();
	
	ArrayList<StudentType> sTypeList = new ArrayList<StudentType>();
	ArrayList<StudentState> sStateList = new ArrayList<StudentState>();
	ArrayList<PassWhether> pwList = new ArrayList<PassWhether>();
%>
<div class="container"><!-- 틀  -->
    <div class="article"><!-- 내용 -->
        <div class="article-mark"><!-- 북마크 -->
            <img src="./images/bookmark1.png" class="bookmark-img">
            <span class="bookmark-text">STUDENT</span>
        </div><!-- 북마크 끝 -->
        <div class="article-mark-move"><!-- Training 페이지 이동 -->
            <a href="TrainingDefine.jsp" class="mark-move" id="mark-move-one">
                <img src="./images/bookmark2.png" class="mark-move-img">
                <span class="mark-move-text">TRAINING</span>
            </a>
        </div><!-- Training 페이지 이동 끝 -->
        <div class="article-mark-move"><!-- Member 페이지 이동 -->
            <a href="MemberJoin.jsp" class="mark-move" id="mark-move-two">
                <img src="./images/bookmark2.png" class="mark-move-img">
                <span class="mark-move-text">MEMBER</span>
            </a>
        </div><!-- Member 페이지 이동 끝 -->
        <div class="article-mark-move"><!-- 메인 페이지 이동 -->
            <a href="../Main.jsp" class="mark-move" id="mark-move-three">
                <img src="./images/bookmark3.png" class="mark-move-img">
                <span class="mark-move-text">HOME</span>
            </a>
        </div><!-- 메인 페이지 이동 끝 -->
        
        <div class="content" id="first-box"><!-- 유형 폼 -->
            <div class="content-comment">
                <img src="./images/comment.png" class="comment-img">
                <span class="comment-text">유형</span>
            </div>
            <div class="student-box" id="student-add"><!-- 유형 생성 -->
                <form action="StudentTypeCreateActive.jsp" method="post">
                    <input class="student-component" id="student-component-add-text" name="stTyName" type="text" maxlength="10" placeholder="유형명">
                    <input class="student-submit" type="submit" value="추가">
                </form>
            </div><!-- 유형 생성 끝 -->
            <hr class="division-add-del"><!-- 유형 제거 -->
            <div class="student-box" id="student-del">
                <form id="stTyDel" action="StudentTypeDeleteActive.jsp" method="post">
                    <select class="student-component" name="stTyName">
                    	<option></option>
                    	<%
                    		sTypeList = sTypeDAO.getList();
                    		
                    		for(int i = 0; i < sTypeList.size(); i++){
                    	%>
                    			<option value="<%=sTypeList.get(i).getStTyName()%>"><%=sTypeList.get(i).getStTyName()%></option>
                    	<%
                    		}
                    	%>
                    </select>
                    <input class="student-submit" type="button" value="삭제하기" onclick="submitDeleteEvent('stTyDel','제거하시겠습니까?');">
                </form>
            </div><!-- 유형 제거 끝 -->
            <hr class="division-add-adj">
            <div class="student-box" id="student-adj"><!-- 유형 수정 -->
                <form action="StudentTypeUpdateActive.jsp" method="post">
                    <select class="student-component" id="student-component-adjust-select" name="stTyName">
                    	<option></option>
                    	<%
                    		sTypeList = sTypeDAO.getList();
                    		
                    		for(int i = 0; i < sTypeList.size(); i++){
                    	%>
                    			<option value="<%=sTypeList.get(i).getStTyName()%>"><%=sTypeList.get(i).getStTyName()%></option>
                    	<%
                    		}
                    	%>
                    </select>
                    <input class="student-component" id="student-component-adjust-text" name="stTyNameCh" type="text" maxlength="10" placeholder="변경할 유형명">
                    <input class="student-submit" id="student-submit-adjust" type="submit" value="수정">
                </form>
            </div><!-- 유형 수정 끝 -->
        </div><!-- 유형 폼 끝 -->
        
        <div class="content" id="second-box"><!-- 상태 폼 -->
            <div class="content-comment">
                <img src="./images/comment.png" class="comment-img">
                <span class="comment-text">상태</span>
            </div>
            <div class="student-box" id="student-add"><!-- 상태 생성 -->
                <form action="StudentStateCreateActive.jsp" method="post">
                    <input class="student-component" id="student-component-add-text" name="stStateName" type="text" maxlength="10" placeholder="상태명">
                    <input class="student-submit" type="submit" value="추가">
                </form>
            </div><!-- 상태 생성 끝 -->
            <hr class="division-add-del"><!-- 상태 제거 -->
            <div class="student-box" id="student-del">
                <form id="stStDel" action="StudentStateDeleteActive.jsp" method="post">
                    <select class="student-component" name="stStateName">
                    	<option></option>
                    	<%
                    		sStateList = sStateDAO.getList();
                    		
                    		for(int i = 0; i < sStateList.size(); i++){
                    	%>
                    			<option value="<%=sStateList.get(i).getStStateName()%>"><%=sStateList.get(i).getStStateName()%></option>
                    	<%
                    		}
                    	%>
                    </select>
                    <input class="student-submit" type="button" value="제거" onclick="submitDeleteEvent('stStDel','제거하시겠습니까?');">
                </form>
            </div><!-- 상태 제거 끝 -->
            <hr class="division-add-adj">
            <div class="student-box" id="student-adj"><!-- 상태 수정 -->
                <form action="StudentStateUpdateActive.jsp" method="post">
                    <select class="student-component" id="student-component-adjust-select" name="stStateName">
                    	<option></option>
                    	<%
                    		sStateList = sStateDAO.getList();
                    		
                    		for(int i = 0; i < sStateList.size(); i++){
                    	%>
                    			<option value="<%=sStateList.get(i).getStStateName()%>"><%=sStateList.get(i).getStStateName()%></option>
                    	<%
                    		}
                    	%>
                    </select>
                    <input class="student-component" id="student-component-adjust-text" name="stStateNameCh" type="text" maxlength="10" placeholder="변경할 상태명">
                    <input class="student-submit" id="student-submit-adjust" type="submit" value="수정">
                </form>
            </div><!-- 상태 수정 끝 -->
        </div><!-- 상태 폼 끝 -->
        
        <div class="content" id="three-box"><!-- 합격여부 폼 -->
            <div class="content-comment">
                <img src="./images/comment.png" class="comment-img">
                <span class="comment-text">여부</span>
            </div>
            <div class="student-box" id="student-add"><!-- 합격여부 생성 -->
                <form action="StudentPassWhetherCreateActive.jsp" method="post">
                    <input class="student-component" id="student-component-add-text" name="paName" type="text" maxlength="10" placeholder="합격여부명">
                    <input class="student-submit" type="submit" value="추가">
                </form>
            </div><!-- 합격여부 생성 끝 -->
            <hr class="division-add-del"><!-- 합격여부 제거 -->
            <div class="student-box" id="student-del">
                <form id="paDel" action="StudentPassWhetherDeleteActive.jsp" method="post">
                    <select class="student-component" name="paName">
                    	<option></option>
                    	<%
                    		pwList = pwDAO.getList();
                    		
                    		for(int i = 0; i < pwList.size(); i++){
                    	%>
                    			<option value="<%=pwList.get(i).getPaName()%>"><%=pwList.get(i).getPaName()%></option>
                    	<%
                    		}
                    	%>
                    </select>
                    <input class="student-submit" type="button" value="제거" onclick="submitDeleteEvent('paDel','제거하시겠습니까?');">
                </form>
            </div><!-- 합격여부 제거 끝 -->
            <hr class="division-add-adj">
            <div class="student-box" id="student-adj"><!-- 합격여부 수정 -->
                <form action="StudentPassWhetherUpdateActive.jsp" method="post">
                    <select class="student-component" id="student-component-adjust-select" name="paName">
                    	<option></option>
                    	<%
                    		pwList = pwDAO.getList();
                    		
                    		for(int i = 0; i < pwList.size(); i++){
                    	%>
                    			<option value="<%=pwList.get(i).getPaName()%>"><%=pwList.get(i).getPaName()%></option>
                    	<%
                    		}
                    	%>
                    </select>
                    <input class="student-component" id="student-component-adjust-text" name="paNameCh" type="text" maxlength="10" placeholder="변경할 합격여부명">
                    <input class="student-submit" id="student-submit-adjust" type="submit" value="수정">
                </form>
            </div><!-- 합격여부 수정 끝 -->
        </div><!-- 합격여부 폼 끝 -->
        
    </div><!-- 내용 끝 -->
</div><!-- 틀 끝 -->
</body>
</html>