<!-- 과정 속성 관리 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="training.Training" %>
<%@ page import="training.TrainingTypeDAO" %>
<%@ page import="training.TrainingNameDAO" %>
<%@ page import="training.TrainingRoomDAO" %>
<%@ page import="training.RelationField" %>
<%@ page import="training.RelationFieldDAO" %>
<%@ page import="training.ProcessState" %>
<%@ page import="training.ProcessStateDAO" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="SessionConfig.jsp" %><!-- 세션 관리 -->
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
            height: 1100px;
        }
        #first-box
        {
            top: 150px;
            left: 50px;
            width: 700px;
            height: 100px;
        }
        .add-input
        {
            margin-top: 10px;
            margin-left: 20px;
            width: 199px;
            height: 30px;
            font-size: 15px;
        }
        .add-submit
        {
            position: absolute;
            top: 55px;
            left: 20px;
            background-color: #0076ff;
            border: none;
            width: 660px;
            height: 35px;
            font-size: 20px;
            font-weight: bold;
            letter-spacing: 3px;
            color: white;
        }
        #second-box
        {
            top: 310px;
            left: 50px;
            width: 700px;
            height: 140px;
        }
        .adjust-select
        {
            position: absolute;
            left: 20px;
            width: 200px;
            height: 30px;
            letter-spacing: 1px;
        }
        .adjust-input
        {
            position: absolute;
            left: 240px;
            width: 200px;
            height: 25px;
            letter-spacing: 1px;
        }
        #adjust-one
        {
            top: 10px;
        }
        #adjust-two
        {
            top: 55px;
        }
        #adjust-three
        {
            top: 100px;
        }
        .adjust-submit
        {
            position: absolute;
            top: 10px;
            left: 465px;
            background-color: #0076ff;
            border: none;
            width: 215px;
            height: 120px;
            font-size: 20px;
            font-weight: bold;
            color: white;
            letter-spacing: 5px;
        }
        #third-box
        {
            top: 510px;
            left: 50px;
            width: 700px;
            height: 100px;
        }
        .delete-input
        {
            margin-top: 10px;
            margin-left: 20px;
            width: 199px;
            height: 30px;
            font-size: 15px;
        }
        .delete-submit
        {
            position: absolute;
            top: 55px;
            left: 20px;
            background-color: #0076ff;
            border: none;
            width: 660px;
            height: 35px;
            font-size: 20px;
            font-weight: bold;
            letter-spacing: 3px;
            color: white;
        }
        #forth-box
        {
            top: 700px;
            left: 50px;
            width: 700px;
            height: 100px;
        }
        .form-box
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
        #form-add
        {
            left: 20px;
        }
        #form-del
        {
            left: 360px;
        }
        #form-adj
        {
            top: 65px;
            left: 20px;
        }
        .form-component
        {
            position: absolute;
            width: 150px;
            height: 30px;
            font-size: 15px;
        }
        #form-component-add-text
        {
            height: 24px;
        }
        #form-component-adjust-select
        {
            width: 200px;
        }
        #form-component-adjust-text
        {
            left: 230px;
            width: 200px;
            height: 23px;
        }
        .form-submit
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
        #form-submit-adjust
        {
            left: 460px;
            width: 200px;
        }
        #fifth-box
        {
            top: 900px;
            left: 50px;
            width: 700px;
            height: 100px;
        }
    </style>
</head>
<body>
<%
	TrainingTypeDAO tTypeDAO = new TrainingTypeDAO();
	TrainingRoomDAO tRoomDAO = new TrainingRoomDAO();
	TrainingNameDAO tNameDAO = new TrainingNameDAO();
	RelationFieldDAO rfDAO = new RelationFieldDAO();
	ProcessStateDAO psDAO = new ProcessStateDAO();
	
	ArrayList<Training> trList = new ArrayList<Training>();
	ArrayList<RelationField> rfList = new ArrayList<RelationField>();
	ArrayList<ProcessState> psList = new ArrayList<ProcessState>();
%>
<div class="container"><!-- 틀  -->
    <div class="article"><!-- 내용 -->
        <div class="article-mark"><!-- 북마크 -->
            <img src="./images/bookmark1.png" class="bookmark-img">
            <span class="bookmark-text">TRAINING</span>
        </div><!-- 북마크 끝 -->
        <button class="btn-move" id="btn-move-one" type="button" onclick="movePage('TrainingBegin.jsp');">과정 개설하기</button>  <!-- 과정 개설하기 -->
        <button class="btn-move" id="btn-move-two" type="button" onclick="movePage('TrainingBeginConfig.jsp');">개강 확인하기</button>  <!-- 개강 확인하기 -->
        <div class="article-mark-move"><!-- MEMBER 페이지 이동 -->
            <a href="MemberJoin.jsp" class="mark-move" id="mark-move-one">
                <img src="./images/bookmark2.png" class="mark-move-img">
                <span class="mark-move-text">MEMBER</span>
            </a>
        </div><!-- MEMBER 페이지 이동 끝 -->
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
        
        <div class="content" id="first-box"><!-- 과정 속성 추가 폼 -->
            <div class="content-comment">
                <img src="./images/comment.png" class="comment-img">
                <span class="comment-text">추가</span>
            </div>
            <form action="TrainingCreateActive.jsp" method="post">
                <input class="add-input" name="trType" type="text" maxlength="10" placeholder="훈련구분">
                <input class="add-input" name="trRoom" type="text" maxlength="10" placeholder="교육실">
                <input class="add-input" name="trName" type="text" maxlength="20" placeholder="훈련명">
                <input class="add-submit" type="submit" value="추가하기">
            </form>
        </div><!-- 과정 속성 추가 폼 끝 -->
        
        <div class="content" id="second-box"><!-- 과정 속성 수정 폼 -->
            <div class="content-comment">
                <img src="./images/comment.png" class="comment-img">
                <span class="comment-text">수정</span>
            </div>
            <form action="TrainingUpdateActive.jsp" method="post">
                <select class="adjust-select" id="adjust-one" name="trType">
                	<option></option>
                	<%
						trList = tTypeDAO.getList();
					
						for(int i = 0; i < trList.size(); i++){		//훈련구분 목록
					%>
						<option value="<%=trList.get(i).getTrType() %>"><%=trList.get(i).getTrType() %></option>
					<%
						}
					%>
                </select>
                <input class="adjust-input" id="adjust-one" name="chType" type="text" maxlength="10" placeholder="훈련구분 변경명">
                <select class="adjust-select" id="adjust-two" name="trRoom">
                	<option></option>
                	<%
						trList = tRoomDAO.getList();
					
						for(int i = 0; i < trList.size(); i++){		//교육실 목록
					%>
                        <option value="<%=trList.get(i).getTrRoom() %>"><%=trList.get(i).getTrRoom() %></option>
					<%
						}
					%>
                </select>
                <input class="adjust-input" id="adjust-two" name="chRoom" type="text" maxlength="10" placeholder="교육실 변경명">
                <select class="adjust-select" id="adjust-three" name="trName">
                	<option></option>
                	<%
						trList = tNameDAO.getList();
					
						for(int i = 0; i < trList.size(); i++){		//훈련명 목록
					%>
						<option value="<%=trList.get(i).getTrName() %>"><%=trList.get(i).getTrName() %></option>
					<%
						}
					%>
                </select>
                <input class="adjust-input" id="adjust-three" name="chName" type="text" maxlength="20" placeholder="훈련명 변경명">
                <input class="adjust-submit" type="submit" value="수정하기">
            </form>
        </div><!-- 과정 속성 수정 폼 끝 -->
        <div class="content" id="third-box"><!-- 과정 속성 제거 폼 -->
            <div class="content-comment">
                <img src="./images/comment.png" class="comment-img">
                <span class="comment-text">제거</span>
            </div>
            <form id="trDel" action="TrainingDeleteActive.jsp" method="post">
                <select class="delete-input" id="adjust-one" name="trType">
                	<option></option>
                	<%
						trList = tTypeDAO.getList();
					
						for(int i = 0; i < trList.size(); i++){		//훈련구분 목록
					%>
						<option value="<%=trList.get(i).getTrType() %>"><%=trList.get(i).getTrType() %></option>
					<%
						}
					%>
                </select>
                <select class="delete-input" id="adjust-two" name="trRoom">
                	<option></option>
                	<%
						trList = tRoomDAO.getList();
					
						for(int i = 0; i < trList.size(); i++){		//교육실 목록
					%>
						<option value="<%=trList.get(i).getTrRoom() %>"><%=trList.get(i).getTrRoom() %></option>
					<%
						}
					%>
                </select>
                <select class="delete-input" id="adjust-three" name="trName">
                	<option></option>
                	<%
						trList = tNameDAO.getList();
					
						for(int i = 0; i < trList.size(); i++){		//훈련명 목록
					%>
						<option value="<%=trList.get(i).getTrName() %>"><%=trList.get(i).getTrName() %></option>
					<%
						}
					%>
                </select>
                <input class="delete-submit" type="button" value="제거하기" onclick="submitDeleteEvent('trDel','제거하시겠습니까?');">
            </form>
        </div><!-- 제거 폼 끝 -->
        
        <div class="content" id="forth-box"><!-- 관련 분야 폼 -->
            <div class="content-comment">
                <img src="./images/comment.png" class="comment-img">
                <span class="comment-text">분야</span>
            </div>
            <div class="form-box" id="form-add"><!-- 관련분야 추가 -->
                <form action="TrainingRelationCreateActive.jsp" method="post">
                    <input class="form-component" id="form-component-add-text" name="fName" type="text" maxlength="10" placeholder="관련 분야명">
                    <input class="form-submit" type="submit" value="추가">
                </form>
            </div><!-- 관련분야 추가 끝 -->
            <hr class="division-add-del">
            <div class="form-box" id="form-del"><!-- 관련분야 제거 -->
                <form id="rfDel" action="TrainingRelationDeleteActive.jsp" method="post">
                    <select class="form-component" name="fName">
                    	<option></option>
                    	<%
                    		rfList = rfDAO.getList();
                    	
                    		for(int i = 0; i < rfList.size(); i++){		//관련분야 목록
                    	%>
                    			<option value="<%=rfList.get(i).getfName() %>"><%=rfList.get(i).getfName() %></option>
                    	<%
                    		}
                    	%>
                    </select>
                    <input class="form-submit" type="button" value="제거" onclick="submitDeleteEvent('rfDel','제거하시겠습니까?');">
                </form>
            </div><!-- 관련분야 제거 끝 -->
            <hr class="division-add-adj">
            <div class="form-box" id="form-adj"><!-- 관련분야 수정 -->
                <form action="TrainingRelationUpdateActive.jsp" method="post">
                    <select class="form-component" id="form-component-adjust-select" name="fName">
                    	<option></option>
                    	<%for(int i = 0; i < rfList.size(); i++){		//관련분야 목록
                    	%>
                    			<option value="<%=rfList.get(i).getfName() %>"><%=rfList.get(i).getfName() %></option>
                    	<%}
                    	%>
                    </select>
                    <input class="form-component" id="form-component-adjust-text" name="fNameCh" type="text" maxlength="10" placeholder="변경할 관련 분야명">
                    <input class="form-submit" id="form-submit-adjust" type="submit" value="수정">
                </form>
            </div><!-- 관련분야 수정 끝 -->
        </div><!-- 관련 분야 폼 끝 -->
        
        <div class="content" id="fifth-box"><!-- 과정 상태 폼 -->
            <div class="content-comment">
                <img src="./images/comment.png" class="comment-img">
                <span class="comment-text">상태</span>
            </div>
            <div class="form-box" id="form-add"><!-- 과정 상태 추가 -->
                <form action="TrainingStateCreateActive.jsp" method="post">
                    <input class="form-component" id="form-component-add-text" name="prStateName" type="text" maxlength="10" placeholder="과정 상태명">
                    <input class="form-submit" type="submit" value="추가">
                </form>
            </div><!-- 과정 상태 추가 끝 -->
            <hr class="division-add-del">
            <div class="form-box" id="form-del"><!-- 과정 상태 제거 -->
                <form id="tsDel" action="TrainingStateDeleteActive.jsp" method="post">
                    <select class="form-component" name="prStateName">
                    	<option></option>
                    	<%
                    		psList = psDAO.getList();
                    	
                    		for(int i = 0; i < psList.size(); i++){		//과정상태 목록
                    	%>
                    			<option value="<%=psList.get(i).getPrStateName() %>"><%=psList.get(i).getPrStateName() %></option>
                    	<%
                    		}
                    	%>
                    </select>
                    <input class="form-submit" type="button" value="제거" onclick="submitDeleteEvent('tsDel','제거하시겠습니까?');">
                </form>
            </div><!-- 과정 상태 제거 끝 -->
            <hr class="division-add-adj">
            <div class="form-box" id="form-adj"><!-- 과정 상태 수정 -->
                <form action="TrainingStateUpdateActive.jsp" method="post">
                    <select class="form-component" id="form-component-adjust-select" name="prStateName">
                    	<option></option>
                    	<%for(int i = 0; i < psList.size(); i++){		//과정상태 목록
                    	%>
                    			<option value="<%=psList.get(i).getPrStateName() %>"><%=psList.get(i).getPrStateName() %></option>
                    	<%}
                    	%>
                    </select>
                    <input class="form-component" id="form-component-adjust-text" name="prStateNameCh" type="text" maxlength="10" placeholder="변경할 과정명">
                    <input class="form-submit" id="form-submit-adjust" type="submit" value="수정">
                </form>
            </div><!-- 과정 상태 수정 끝 -->
        </div><!-- 과정 상태 폼 끝 -->
    </div><!-- 내용 끝 -->
</div><!-- 틀 끝 -->
</body>
</html>