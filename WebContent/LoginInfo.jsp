<!-- 직원 정보 수정 -->
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="member.Member"%>
<%@page import="member.MemberDAO"%>
<%@ include file="Default.jsp" %>	<!-- 기본 틀(로고, 상단 메뉴, 사이드 메뉴)-->
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE HTML>
<html>
<head>
	<link rel="stylesheet" href="./css/intra.css">
    <meta charset="utf-8">
    <title>휴먼교육센터</title>
    <script src="./js/Intra.js"></script>
    <style>
    	.content
		{
			position: absolute;
			top: 400px;
			left: 50%;
			margin-left: -400px;
			width: 800px;
			height: 100px;
		}
		.login-table
        {
            position: absolute;
            top: 10px;
            left: 50%;
            margin-left: -400px;
            width: 800px;
        }
        .login-label
        {
            background-color: lightgrey;
            padding-top: 10px;
            padding-bottom: 10px;
            width: 100px;
            text-align: center;
            font-size: 15px;
            font-weight: bold;
            color: #3352ff;
        }
        .login-component-btn
        {
        	background-color: #0076ff;
        	border: none;
        	width: 100px;
        	height: 25px;
        	font-weight: bold;
        	color: white;
        }
        .login-component-select
        {
            width: 214px;
            height: 30px;
            letter-spacing: 1px;
        }
        #login-component-tel
        {
            width: 100px;
        }
        .login-component-text
        {
            width: 210px;
            height: 25px;
            letter-spacing: 1px;
        }
        .login-submit
        {
            background-color: #0076ff;
            margin-left: 70px;
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
<%
	MemberDAO mDAO = new MemberDAO();
	ArrayList<Member> mList = new ArrayList<Member>();
	
	String memId = String.valueOf(session.getAttribute("userId"));
	mList = mDAO.getList(memId);
%>
<div class="content"><!-- 직원 정보 수정 -->
	<form action="LoginInfoUpdateActive.jsp" method="post">
	<input type="hidden" name="memNo" value="<%=mList.get(0).getMemNo() %>">
		<table class="login-table"><!-- 회원 수정 양식 -->
			<tr>
			    <td class="login-label">
			        <label for="memId">아이디</label>
			    </td>
			    <td>
			    	<input type="hidden" name="memId" value="<%=mList.get(0).getMemId()%>">
					<%=mList.get(0).getMemId()%>
				</td>
				<td class="login-label">
					<label for="depName">부서</label>
				</td>
				<td>
					<input type="hidden" name="depName" value="<%=mList.get(0).getDepName() %>">
					<%=mList.get(0).getDepName() %>
	    		</td>
			</tr>
			<tr>
			    <td class="login-label">
			        <label for="memPwd">비밀번호</label>
			    </td>
			    <td colspan=3>
			        <input class="login-component-text" name="memPwd" type="password" placeholder="비밀번호" maxlength="20">
				</td>
			</tr>
			<tr>
			    <td class="login-label">
			        <label for="memName">이름</label>
			    </td>
			    <td colspan=3>
			    	<input type="hidden" name="memName" value="<%=mList.get(0).getMemName()%>">
			    	<%=mList.get(0).getMemName()%>
			    </td>
			</tr>
			<tr>
			    <td class="login-label">
			        <label>전화번호</label>
			    </td>
	    		<td colspan="3">
					<select class="login-component-select" id="login-component-tel" name="tel1">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="017">017</option>
					</select>
					<%
						String totalTel = mList.get(0).getMemTel();
						String divis = "[-]";
						String[] tel = totalTel.split(divis);
					%>
					<script>
						selectedTel('login-component-tel','option','<%=tel[0] %>');
					</script>
					-
					<input class="login-component-text" id="login-component-tel" type="text" name="tel2" placeholder="두번째 자리" maxlength="4" value="<%=tel[1]%>"> -
					<input class="login-component-text" id="login-component-tel" type="text" name="tel3" placeholder="세번째 자리" maxlength="4" value="<%=tel[2]%>">
				</td>
			</tr>
			<tr>
				<td class="login-label">
					<input name="memResume" type="hidden" value="<%=mList.get(0).getMemResume()%>">
					<label for="memResume">이력서</label>
				</td>
				<td colspan=3>
				<%
					String dirMember = "/upload/member";
					String real = "";
					
					ServletContext context = getServletContext();
					real = context.getRealPath(dirMember);
					
					File targetDir = new File(real);
					
					if(targetDir.exists()){		//폴더 확인.
						if(mList.get(0).getMemResume() != null){		//이력서 파일 다운로드 링크
							String dir = application.getRealPath("/upload/member/");
							String[] files = new File(dir).list();
							
							for(String file : files){
								if(mList.get(0).getMemResume().equals(file)){
									out.write("<a href=\"" + request.getContextPath() + "/downloadAction?file=" +
										java.net.URLEncoder.encode(file, "UTF-8").replace("+","%20") + "&save=member/" + "\">" + "이력서 다운로드" + "</a>");
								}
							}
						}else{
				%>
							등록된 이력서가 없습니다.
				<%
						}
					}
				%>
					<input class="login-component-btn" type="button" onclick="movePage('LoginResume.jsp');" value="갱신하기">
	    		</td>
			</tr>
			<tr>
				<td colspan=4>
					<input class="login-submit" type="submit" value="수정">
				</td>
			</tr>
		</table><!-- 멤버 수정 양식  끝-->
	</form><!-- 직원 정보 수정 -->
</div>
</body>
</html>