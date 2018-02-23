<!-- 상담 내용 수정 -->
<%@page import="training.ProcessState"%>
<%@page import="training.ProcessStateDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.Member" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="student.Advice" %>
<%@ page import="student.AdviceDAO" %>
<%@ page import="java.util.*" %>
<%@ include file="Default.jsp" %>	<!-- 기본 틀(로고, 상단 메뉴, 사이드 메뉴)-->
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="./css/intra.css">
	<meta charset="UTF-8">
	<title>휴먼교육센터</title>
	<style>
		#nav-move-advice
		{
		    background-color: rgb(68, 255, 125);
		}
		#submenu-two
		{
			transform: translateY(8px);
			border-bottom: 2px solid rgb(0, 255, 10);
		}
		.content
		{
			position: absolute;
			top: 400px;
			left: 50%;
			margin-left: -400px;
			width: 800px;
			height: 100px;
		}
		.advice-table
        {
            position: absolute;
            top: 20px;
            left: 50%;
            margin-left: -400px;
            width: 800px;
        }
        .advice-thead
        {
            background-color: #0076ff;
            font-size: 15px;
            text-align: center;
            color: white;
        }
        .advice-title
        {
            height: 30px;
        }
        .advice-content-submit
        {
        	background-color: #0076ff;
        	border: none;
        	width: 100%;
        	height: 40px;
        	font-size: 20px;
        	font-weight: bold;
        	color: white;
        }
	</style>
</head>
<body>
<%
	MemberDAO mDAO = new MemberDAO();
	AdviceDAO aDAO = new AdviceDAO();
	ProcessStateDAO psDAO = new ProcessStateDAO();
	
	ArrayList<Member> mList = new ArrayList<Member>();
	ArrayList<Advice> aList = new ArrayList<Advice>();
	ArrayList<ProcessState> psList = new ArrayList<ProcessState>();
	
	aList = aDAO.getData(Integer.parseInt(request.getParameter("adNo")));
	mList = mDAO.getList();
	psList = psDAO.getList();
%>
	<div class="submenu-container"><!-- 서브 메뉴 -->
		<ul class="ul">
			<li class="submenu" id="submenu-one"><a class="submenu-move" href="StudentRegist.jsp"><span class="submenu-text">등록</span></a></li>
			<li class="submenu" id="submenu-two"><a class="submenu-move" href="Student.jsp"><span class="submenu-text">조회</span></a></li>
			<li class="submenu" id="submenu-three"><a class="submenu-move" href="StudentSearch.jsp"><span class="submenu-text">이름검색</span></a></li>
		</ul>
	</div><!-- 서브 메뉴 끝 -->
	
	<div class="content"><!-- 상담 수정 -->
		<form action="AdviceUpdateActive.jsp" method="post">
			<table class="advice-table">
				<thead class="advice-thead">
					<tr class="student-title">
						<td width="100">상태</td>
						<td width="150">상담직원<br>날짜</td>
						<td width="550">상담내용</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<input type="hidden" name="adNo" value="<%=request.getParameter("adNo")%>">
							<input type="hidden" name="stNo" value="<%=aList.get(0).getStNo() %>">
							<select name="prStateName">
							<%
								for(int i = 0; i < psList.size(); i++){
									if(aList.get(0).getPrStateName().equals(psList.get(i).getPrStateName())){
							%>
										<option value="<%=psList.get(i).getPrStateName() %>" selected><%=psList.get(i).getPrStateName() %></option>
							<%
									}else{
							%>
										<option value="<%=psList.get(i).getPrStateName() %>"><%=psList.get(i).getPrStateName() %></option>
							<%
									}
								}
							%>
							</select>
						</td>
						<td>
							<select name="memId"><!-- 작성자. -->
							<%
								for(int i = 0; i < mList.size(); i++){
							%>
									<option value="<%=mList.get(i).getMemId() %>"><%="[" + mList.get(i).getMemId() + "]" + mList.get(i).getMemName() %></option>
							<%
								}
							%>
							</select><!-- 작성자 변경 끝 -->
							<br>
							<input name="adDate" type="text" maxlength="10" value="<%=aList.get(0).getAdDate() %>"><!-- 작성일 -->
						</td>
						<td>
							<textarea name="adComment" rows="5" cols="65"><%=aList.get(0).getAdComment() %></textarea><!-- 상담내용 -->
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<input class="advice-content-submit" type="submit" value="수정">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div><!-- 상담 수정 끝 -->
</body>
</html>