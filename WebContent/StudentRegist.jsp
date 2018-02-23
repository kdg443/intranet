<!-- 훈련생 등록 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.Member" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="student.PassWhether" %>
<%@ page import="student.PassWhetherDAO" %>
<%@ page import="student.StudentState" %>
<%@ page import="student.StudentStateDAO" %>
<%@ page import="student.StudentType" %>
<%@ page import="student.StudentTypeDAO" %>
<%@ page import="student.StudentDAO" %>
<%@ page import="training.Process" %>
<%@ page import="training.ProcessDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="Default.jsp" %>	<!-- 기본 틀(로고, 상단 메뉴, 사이드 메뉴)-->
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE HTML>
<html>
<head>
	<link rel="stylesheet" href="./css/intra.css">
	<meta charset="UTF-8">
	<title>휴먼교육센터</title>
	<script src="./js/Intra.js"></script>
	<style>
		#nav-move-student
		{
		    background-color: rgb(106, 212, 0);
		}
		#submenu-one
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
		.student-table
        {
            position: absolute;
            top: 10px;
            left: 50%;
            margin-left: -400px;
            width: 800px;
        }
        .student-label
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
        .student-component-select
        {
            width: 214px;
            height: 30px;
            letter-spacing: 1px;
        }
        .student-component-text
        {
            width: 210px;
            height: 25px;
            letter-spacing: 1px;
        }
        #student-component-tel
        {
            width: 100px;
        }
        #student-component-addr
        {
            width: 533px;
        }
        .student-submit
        {
        	position: absolute;
            background-color: #0076ff;
            border: none;
            left: 50%;
            margin-left: -330px;
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
	ProcessDAO pDAO = new ProcessDAO();
	StudentDAO stDAO = new StudentDAO();
	
	ArrayList<Member> mList = new ArrayList<Member>();
	ArrayList<Process> pList = new ArrayList<Process>();
	ArrayList<Process> pListNo = new ArrayList<Process>();
	
	int prNo = 0;
	String trName = "";
	String prStateName = "";
	String prDate = "";
	String divis = "/";
	
	if(request.getParameter("prNo") != null){
		prNo = Integer.parseInt(request.getParameter("prNo"));
		
		pListNo = pDAO.getData(prNo);
		trName = pListNo.get(0).getTrName();
		prStateName = pListNo.get(0).getPrStateName();
		prDate = pListNo.get(0).getPrDate();
	}
%>
	<div class="submenu-container"><!-- 서브 메뉴 -->
		<ul class="ul">
			<li class="submenu" id="submenu-one"><a class="submenu-move" href="StudentRegist.jsp"><span class="submenu-text">등록</span></a></li>
			<li class="submenu"><a class="submenu-move" href="Student.jsp"><span class="submenu-text">조회</span></a></li>
			<li class="submenu" id="submenu-three"><a class="submenu-move" href="StudentSearch.jsp"><span class="submenu-text">이름검색</span></a></li>
		</ul>
	</div><!-- 서브 메뉴 끝 -->
	
	<div class="content"><!-- 훈련생 정보 기입 -->
		<form action="StudentRegistActive.jsp" method="post" enctype="multipart/form-data">
			<input type="hidden" name="stNo" value="<%=stDAO.getNext() %>">
			<table class="student-table">
				<tr>
					<td class="student-label">
						<label for="stImg">사진</label>
					</td>
					<td colspan=3>
						<input type="file" name="stImg">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="trName">과정이름*</label>
					</td>
					<td colspan=3>
						<select class="student-component-select" onchange="movePage('StudentRegist.jsp','prNo',this.value);"><!-- 과정 선택 -->
							<option></option>
							<%
								pList = pDAO.getList();
								
								for(int i = 0; i < pList.size(); i++){
									String str = pList.get(i).getPrDate();
									String[] date = str.split(divis);
							%>
									<option value="<%=pList.get(i).getPrNo() %>"><%="(" + date[0] + ")" + pList.get(i).getTrName()%></option>
							<%
								}
							%>
						</select><!-- 과정 선택 끝 -->
						<input name="prNo" type="hidden" value="<%=prNo%>">
						<input class="student-component-text" name="trName" value="<%=trName %>" readonly>
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="prStateName">과정상태*</label>
					</td>
					<td>
						<input class="student-component-text" name="prStateName" value="<%=prStateName %>" readonly>
					</td>
					<td class="student-label">
						<label for="prDate">과정날짜*</label>
					</td>
					<td>
						<input class="student-component-text" name="prDate" value="<%=prDate %>" readonly>
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="memId">담당교사*</label>
					</td>
					<td>
						<select name="memId">
							<option></option>
							<%
								mList = mDAO.getListDep("교사");
								
								for(int i = 0; i < mList.size(); i++){		//부서가 교사인 직원만 출력
							%>
									<option value="<%=mList.get(i).getMemId() %>"><%=mList.get(i).getMemName() + "(" + mList.get(i).getMemTel() + ")" %></option>
							<%
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td class="student-label">
						유형*
					</td>
					<td colspan=3>
						유형*
						<select class="student-component-select" name="stTyName">
							<option></option>
							<%
								StudentTypeDAO sTypeDAO = new StudentTypeDAO();
								ArrayList<StudentType> stTypeList = new ArrayList<StudentType>();
								
								stTypeList = sTypeDAO.getList();
								
								for(int i = 0; i < stTypeList.size(); i++){
							%>
									<option value="<%=stTypeList.get(i).getStTyName() %>"><%=stTypeList.get(i).getStTyName() %></option>
							<%
								}
							%>
						</select>
						합격 여부*
						<select class="student-component-select" name="paName">
							<option></option>
							<%
								PassWhetherDAO pwDAO = new PassWhetherDAO();
								ArrayList<PassWhether> pwList = new ArrayList<PassWhether>();
								
								pwList = pwDAO.getList();
								
								for(int i = 0; i < pwList.size(); i++){
							%>
									<option value="<%=pwList.get(i).getPaName() %>"><%=pwList.get(i).getPaName() %></option>
							<%
								}
							%>
						</select><br>
						상태*
						<select class="student-component-select" name="stStateName">
							<option></option>
							<%
								StudentStateDAO sStDAO = new StudentStateDAO();
								ArrayList<StudentState> sStList = new ArrayList<StudentState>();
								
								sStList = sStDAO.getList();
								
								for(int i = 0; i < sStList.size(); i++){
							%>
									<option value="<%=sStList.get(i).getStStateName() %>"><%=sStList.get(i).getStStateName() %></option>
							<%
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="stName">이름*</label>
					</td>
					<td>
						<input class="student-component-text" name="stName" placeholder="이름" maxlength="5">
					</td>
					<td class="student-label">
						<label for="stPwd">비밀번호*</label>
					</td>
					<td>
						<input class="student-component-text" name="stPwd" placeholder="" maxlength="20">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="stBirth">생년월일*</label>
					</td>
					<td colspan=3>
						<input class="student-component-text" name="stBirth" placeholder="ex. 1900-01-01" maxlength="10">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="">전화번호*</label>
					</td>
					<td colspan=3>
						<input class="student-component-text" id="student-component-tel" name="tel1" placeholder="ex. 010" maxlength="3">-
						<input class="student-component-text" id="student-component-tel" name="tel2" placeholder="ex. 번호 두번째 자리" maxlength="4">-
						<input class="student-component-text" id="student-component-tel" name="tel3" placeholder="ex. 번호 세번째 자리" maxlength="4">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="stAddr">주소*</label>
					</td>
					<td colspan=3>
						<input class="student-component-text" id="student-component-addr" name="stAddr" placeholder="주소" maxlength="100">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="">자격증명</label>
					</td>
					<td colspan=3>
						자격증 <input class="student-component-text" name="liName" placeholder="" maxlength="20">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="stCharacter">학생특성*</label>
					</td>
					<td colspan=3>
						<textarea name="stCharacter" cols="75" rows="10">//취업희망지역 : ,경력사항 : ,성격 : ,보유기술 : ,기타 : </textarea>
					</td>
				</tr>
				<tr>
					<td colspan=4>
						<input class="student-submit" type="submit" value="등록">
					</td>
				</tr>
			</table>
		</form>
	</div><!-- 훈련생 정보 기입 -->
</body>
</html>