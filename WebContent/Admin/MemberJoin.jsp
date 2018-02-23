<!-- 직원 등록 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.Dep" %>
<%@ page import="member.DepDAO" %>
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
    		height: 700px;
    	}
        #first-box
        {
            top: 150px;
            left: 50px;
            width: 700px;
            height: 110px;
        }
        .dep-box
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
        #dep-add
        {
            left: 20px;
        }
        #dep-del
        {
            left: 360px;
        }
        #dep-adj
        {
            top: 65px;
            left: 20px;
        }
        .dep-component
        {
            position: absolute;
            width: 150px;
            height: 30px;
            font-size: 15px;
        }
        #dep-component-add-text
        {
            height: 24px;
        }
        #dep-component-adjust-select
        {
            width: 200px;
        }
        #dep-component-adjust-text
        {
            left: 230px;
            width: 200px;
            height: 23px;
        }
        .dep-submit
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
        #dep-submit-adjust
        {
            left: 460px;
            width: 200px;
        }
        #second-box
        {
            top: 330px;
            left: 50px;
            width: 700px;
            height: 260px;
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
        #member-component-addr
        {
            width: 533px;
        }
        .member-submit
        {
            background-color: #0076ff;
            border: none;
            width: 100%;
            height: 35px;
            font-size: 20px;
            font-weight: bold;
            letter-spacing: 3px;
            color: white;
        }
    </style>
</head>
<body>
<script>
	function btn_dep_del(){
		if(confirm("제거하시겠습니까?") == true){
			document.dep.submit();
		}else{
			return;
		}
	}
</script>
<%
	DepDAO dDAO = new DepDAO();
	ArrayList<Dep> dList = new ArrayList<Dep>();
	
	dList = dDAO.getList();
%>
<div class="container"><!-- 틀  -->
    <div class="article"><!-- 내용 -->
        <div class="article-mark"><!-- 북마크 -->
            <img src="./images/bookmark1.png" class="bookmark-img">
            <span class="bookmark-text">MEMBER</span>
        </div><!-- 북마크 끝 -->
        <button class="btn-move" id="btn-move-one" type="button" onclick="movePage('MemberConfig.jsp');">멤버 확인하기</button>  <!-- 개강 확인하기 -->
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
        
        <div class="content" id="first-box"><!-- 부서 폼 -->
            <div class="content-comment">
                <img src="./images/comment.png" class="comment-img">
                <span class="comment-text">부서</span>
            </div>
            <div class="dep-box" id="dep-add"><!-- 부서 생성 -->
                <form action="DepCreateActive.jsp" method="post">
                    <input class="dep-component" id="dep-component-add-text" name="depName" type="text" maxlength="10" placeholder="부서명">
                    <input class="dep-submit" type="submit" value="추가">
                </form>
            </div><!-- 부서 생성 끝 -->
            <hr class="division-add-del"><!-- 부서 제거 -->
            <div class="dep-box" id="dep-del">
                <form id="dep" action="DepDeleteActive.jsp" method="post">
                    <select class="dep-component" name="depName">
                    	<option></option>
                    	<%for(int i = 0; i < dList.size(); i++){%>
                    		<option value="<%=dList.get(i).getDepName() %>"><%=dList.get(i).getDepName() %></option>
                    	<%} %>
                    </select>
                    <input class="dep-submit" type="button" value="제거" onclick="submitDeleteEvent('dep','제거하시겠습니까?');">
                </form>
            </div><!-- 부서 제거 끝 -->
            <hr class="division-add-adj">
            <div class="dep-box" id="dep-adj"><!-- 부서 수정 -->
                <form action="DepUpdateActive.jsp" method="post">
                    <select class="dep-component" id="dep-component-adjust-select" name="depName">
                    	<option></option>
                    	<%for(int i = 0; i < dList.size(); i++){%>
                    		<option value="<%=dList.get(i).getDepName() %>"><%=dList.get(i).getDepName() %></option>
                    	<%} %>
                    </select>
                    <input class="dep-component" id="dep-component-adjust-text" name="depNameCh" type="text" maxlength="10" placeholder="변경할 부서명">
                    <input class="dep-submit" id="dep-submit-adjust" type="submit" value="수정">
                </form>
            </div><!-- 부서 수정 끝 -->
        </div><!-- 부서 폼 끝 -->
        
        <div class="content" id="second-box"><!-- 멤거 가입 폼 -->
            <div class="content-comment"><!-- 멤버 주석 -->
                <img src="./images/comment.png" class="comment-img">
                <span class="comment-text">멤버</span>
            </div><!-- 멤버 주석 끝 -->
            <form action="MemberJoinActive.jsp" method="post" enctype="multipart/form-data">
                <table class="member-table"><!-- 멤버 가입 양식 -->
                    <tr>
                        <td class="member-label">
                            <label for="memId">아이디</label>
                        </td>
                        <td>
                            <input class="member-component-text" name="memId" type="text" placeholder="아이디. 영어/숫자만 기입" maxlength="10">
                        </td>
                        <td class="member-label">
                            <label for="depName">부서</label>
                        </td>
                        <td>
                            <select class="member-component-select" name="depName">
                            	<option></option>
                            	<%for(int i = 0; i < dList.size(); i++){%>	<!-- 부서 목록 -->
		                    		<option value="<%=dList.get(i).getDepName() %>"><%=dList.get(i).getDepName() %></option>
		                    	<%} %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="member-label">
                            <label for="memPwd">비밀번호</label>
                        </td>
                        <td colspan=3>
                            <input class="member-component-text" name="memPwd" type="password" placeholder="비밀번호" maxlength="20">
                        </td>
                    </tr>
                    <tr>
                        <td class="member-label">
                            <label for="memName">이름</label>
                        </td>
                        <td colspan=2>
                            <input class="member-component-text" name="memName" type="text" placeholder="이름" maxlength="10">
                        </td>
                    </tr>
                    <tr>
                        <td class="member-label">
                            <label>전화번호</label>
                        </td>
                        <td colspan="3">
                            <select class="member-component-select" id="member-component-tel" name="tel1">
                            	<option value="010">010</option>
                            	<option value="011">011</option>
                            	<option value="017">017</option>
                            </select> -
                            <input class="member-component-text" id="member-component-tel" type="text" name="tel2" placeholder="두번째 자리" maxlength="4"> -
                            <input class="member-component-text" id="member-component-tel" type="text" name="tel3" placeholder="세번째 자리" maxlength="4">
                        </td>
                    </tr>
                    <tr>
                    	<td class="member-label">
                    		<label for="memResume">이력서</label>
                    	</td>
                    	<td>
                    		<input class="member-component-text" name="memResume" type="file">
                    	</td>
                    </tr>
                    <tr>
                    	<td colspan=4>
                    		<input class="member-submit" type="submit" value="등록">
                    	</td>
                    </tr>
                </table><!-- 멤버 가입 양식  끝-->
            </form>
        </div><!-- 멤거 가입 폼 끝 -->
    </div><!-- 내용 끝 -->
</div><!-- 틀 끝 -->
</body>
</html>