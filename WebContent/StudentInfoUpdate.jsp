<!-- 훈련생 정보 수종 -->
<!-- request : stNo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.Member" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="student.PassWhether" %>
<%@ page import="student.PassWhetherDAO" %>
<%@ page import="student.Student" %>
<%@ page import="student.StudentDAO" %>
<%@ page import="student.StudentState" %>
<%@ page import="student.StudentStateDAO" %>
<%@ page import="student.StudentType" %>
<%@ page import="student.StudentTypeDAO" %>
<%@ page import="student.License" %>
<%@ page import="student.LicenseDAO" %>
<%@ page import="training.Process" %>
<%@ page import="training.ProcessDAO" %>
<%@ page import="training.RegProcess" %>
<%@ page import="training.RegProcessDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="Default.jsp" %>	<!-- 기본 틀(로고, 상단 메뉴, 사이드 메뉴)-->
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE HTML>
<html>
<head>
	<link rel="stylesheet" href="./css/intra.css">
	<meta charset="UTF-8">
	<title>휴먼교육센터</title>
	<style>
		#nav-move-student
		{
		    background-color: rgb(106, 212, 0);
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
	StudentDAO stDAO = new StudentDAO();
	RegProcessDAO rpDAO = new RegProcessDAO();
	LicenseDAO lDAO = new LicenseDAO();
	MemberDAO mDAO = new MemberDAO();
	ProcessDAO pDAO = new ProcessDAO();
	
	ArrayList<Student> stList = new ArrayList<Student>();
	ArrayList<RegProcess> rpList = new ArrayList<RegProcess>();
	ArrayList<License> lList = new ArrayList<License>();
	ArrayList<Member> mList = new ArrayList<Member>();
	ArrayList<Process> pList = new ArrayList<Process>();
	
	rpList = rpDAO.getList(Integer.parseInt(request.getParameter("stNo")));
	stList= stDAO.getData(rpList.get(0).getStNo());
	lList = lDAO.getList(rpList.get(0).getStNo());
	pList = pDAO.getData(rpList.get(0).getPrNo());
	
	String trName = pList.get(0).getTrName();
	String prStateName = pList.get(0).getPrStateName();
	String prDate = pList.get(0).getPrDate();
	String divis = "/";
%>
	<div class="submenu-container"><!-- 서브 메뉴 -->
		<ul class="ul">
			<li class="submenu" id="submenu-one"><a class="submenu-move" href="StudentRegist.jsp"><span class="submenu-text">등록</span></a></li>
			<li class="submenu" id="submenu-two"><a class="submenu-move" href="Student.jsp"><span class="submenu-text">조회</span></a></li>
			<li class="submenu" id="submenu-three"><a class="submenu-move" href="StudentSearch.jsp"><span class="submenu-text">이름검색</span></a></li>
		</ul>
	</div><!-- 서브 메뉴 끝 -->
	
	<div class="content"><!-- 훈련생 정보 수정 -->
		<form action="StudentInfoUpdateActive.jsp" method="post">
			<input type="hidden" name="stNo" value="<%=request.getParameter("stNo")%>">
			<table class="student-table">
				<tr>
					<td class="student-label">
						<label for="trName">과정이름*</label>
					</td>
					<td colspan=3>
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
							<%
								mList = mDAO.getListDep("교사");
								
								for(int i = 0; i < mList.size(); i++){
									if(stList.get(0).getMemId().equals(mList.get(i).getMemId())){
							%>
										<option value="<%=mList.get(i).getMemId() %>" selected><%=mList.get(i).getMemName() + "(" + mList.get(i).getMemTel() + ")" %></option>
							<%			
									}else{
							%>
										<option value="<%=mList.get(i).getMemId() %>"><%=mList.get(i).getMemName() + "(" + mList.get(i).getMemTel() + ")" %></option>
							<%		}
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label>유형*</label>
					</td>
					<td colspan=3>
						유형*
						<select class="student-component-select" name="stTyName">
							<%
								StudentTypeDAO sTypeDAO = new StudentTypeDAO();
								ArrayList<StudentType> stTypeList = new ArrayList<StudentType>();
								
								stTypeList = sTypeDAO.getList();
								
								for(int i = 0; i < stTypeList.size(); i++){
									if(stList.get(0).getStTyName().equals(stTypeList.get(i).getStTyName())){
							%>
										<option value="<%=stTypeList.get(i).getStTyName() %>" selected><%=stTypeList.get(i).getStTyName() %></option>
							<%			
									}else{
							%>
										<option value="<%=stTypeList.get(i).getStTyName() %>"><%=stTypeList.get(i).getStTyName() %></option>
							<%		}
								}
							%>
						</select>
						합격 여부*
						<select class="student-component-select" name="paName">
							<%
								PassWhetherDAO pwDAO = new PassWhetherDAO();
								ArrayList<PassWhether> pwList = new ArrayList<PassWhether>();
								
								pwList = pwDAO.getList();
								
								for(int i = 0; i < pwList.size(); i++){
									if(stList.get(0).getPaName().equals(pwList.get(i).getPaName())){
							%>
										<option value="<%=pwList.get(i).getPaName() %>" selected><%=pwList.get(i).getPaName() %></option>
							<%			
									}else{
							%>
										<option value="<%=pwList.get(i).getPaName() %>"><%=pwList.get(i).getPaName() %></option>
							<%		}
								}
							%>
						</select><br>
						상태*
						<select class="student-component-select" name="stStateName">
							<%
								StudentStateDAO sStDAO = new StudentStateDAO();
								ArrayList<StudentState> sStList = new ArrayList<StudentState>();
								
								sStList = sStDAO.getList();
								
								for(int i = 0; i < sStList.size(); i++){
									if(stList.get(0).getStStateName().equals(sStList.get(i).getStStateName())){
							%>
										<option value="<%=sStList.get(i).getStStateName() %>" selected><%=sStList.get(i).getStStateName() %></option>
							<%			
									}else{
							%>
										<option value="<%=sStList.get(i).getStStateName() %>"><%=sStList.get(i).getStStateName() %></option>
							<%		}
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
						<input class="student-component-text" name="stName" placeholder="이름" maxlength="5" value="<%=stList.get(0).getStName()%>">
					</td>
					<td class="student-label">
						<label for="stPwd">비밀번호*</label>
					</td>
					<td>
						<input class="student-component-text" name="stPwd" placeholder="" maxlength="20" value="<%=stList.get(0).getStPwd()%>">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="stBirth">생년월일*</label>
					</td>
					<td colspan=3>
						<input class="student-component-text" name="stBirth" placeholder="ex. 1900-01-01" maxlength="10" value="<%=stList.get(0).getStBirth()%>">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="">전화번호*</label>
					</td>
					<td colspan=3>
						<%
							String totalTel = stList.get(0).getStTel();
							String divisTel = "[-]";
							String[] tel = totalTel.split(divisTel);
						%>
						<input class="student-component-text" id="student-component-tel" name="tel1" placeholder="ex. 010" maxlength="3" value="<%=tel[0]%>">-
						<input class="student-component-text" id="student-component-tel" name="tel2" placeholder="ex. 번호 두번째 자리" maxlength="4" value="<%=tel[1]%>">-
						<input class="student-component-text" id="student-component-tel" name="tel3" placeholder="ex. 번호 세번째 자리" maxlength="4" value="<%=tel[2]%>">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="stAddr">주소</label>
					</td>
					<td colspan=3>
						<input class="student-component-text" id="student-component-addr" name="stAddr" placeholder="주소" maxlength="100" value="<%=stList.get(0).getStAddr()%>">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="">자격증명</label>
					</td>
					<td colspan=3>
						<% 
							String[] liName = new String[4];
								
							for( int i = 0; i < liName.length; i++ ){
								liName[i] = "";
							}
							
							for( int i = 0; i < lList.size(); i++ ){
								liName[i] = lList.get(i).getLiName();
							}
						%>
						자격증 1<input class="student-component-text" name="liName1" placeholder="" maxlength="20" value="<%=liName[0]%>">
						자격증 2<input class="student-component-text" name="liName2" placeholder="" maxlength="20" value="<%=liName[1]%>">
						<br>
						자격증 3<input class="student-component-text" name="liName3" placeholder="" maxlength="20" value="<%=liName[2]%>">
						자격증 4<input class="student-component-text" name="liName4" placeholder="" maxlength="10" value="<%=liName[3]%>">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="stCharacter">학생특성*</label>
					</td>
					<td colspan=3>
						<textarea name="stCharacter" cols="75" rows="10"><%=stList.get(0).getStCharacter() %> 
						</textarea>
					</td>
				</tr>
				<tr>
					<td colspan=4>
						<input class="student-submit" type="submit" value="수정">
					</td>
				</tr>
			</table>
		</form>
	</div><!-- 훈련생 정보 수정 끝 -->
</body>
</html>