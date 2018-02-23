<!-- 훈련생 정보 -->
<!-- requst : stNo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="student.Advice" %>
<%@ page import="student.AdviceDAO" %>
<%@ page import="student.Student" %>
<%@ page import="student.StudentDAO" %>
<%@ page import="student.License" %>
<%@ page import="student.LicenseDAO" %>
<%@page import="student.SupportCompany"%>
<%@page import="student.SupportCompanyDAO"%>
<%@ page import="member.Member" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="training.Process" %>
<%@ page import="training.ProcessDAO" %>
<%@ page import="training.RegProcess" %>
<%@ page import="training.RegProcessDAO" %>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.naming.java.javaURLContextFactory"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
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
        #student-table-advice
        {
        	top: 730px;
        	visibility: visible;
        }
        #student-table-apply
        {
        	top: 730px;
        	visibility: hidden;
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
        .student-banner
        {
        	text-align: center;
        }
        .student-component-img
        {
        	width: 100px;
        }
        .student-component-btn
        {
        	background-color: #0076ff;
        	border: none;
        	width: 90px;
        	height: 25px;
        	font-weight: bold;
        	color: white;
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
        .student-thead
        {
            background-color: #0076ff;
            font-size: 15px;
            text-align: center;
            color: white;
        }
        .student-title
        {
            height: 30px;
        }
        .student-advice-btn
        {
        	border: none;
        	background-color: #0076ff;
        	color: white;
        }
        .student-detail
        {
        	border: 1px solid black;
        	position: absolute;
        	top: 700px;
        }
	</style>
</head>
<body>
<%
	AdviceDAO aDAO = new AdviceDAO();
	StudentDAO stDAO = new StudentDAO();
	MemberDAO mDAO = new MemberDAO();
	ProcessDAO pDAO = new ProcessDAO();
	RegProcessDAO rpDAO = new RegProcessDAO();
	LicenseDAO lDAO = new LicenseDAO();
	SupportCompanyDAO scDAO = new SupportCompanyDAO();
	
	ArrayList<Advice> aList = new ArrayList<Advice>();
	ArrayList<Student> stList = new ArrayList<Student>();
	ArrayList<Member> mList = new ArrayList<Member>(); 
	ArrayList<Process> pList = new ArrayList<Process>();
	ArrayList<RegProcess> rpList = new ArrayList<RegProcess>();
	ArrayList<License> lList = new ArrayList<License>();
	ArrayList<SupportCompany> scList = new ArrayList<SupportCompany>();
	
	rpList = rpDAO.getList(Integer.parseInt(request.getParameter("stNo")));
	stList = stDAO.getData(rpList.get(0).getStNo());
	pList = pDAO.getData(rpList.get(0).getPrNo());
	lList = lDAO.getList(rpList.get(0).getStNo());
	scList = scDAO.getList(Integer.parseInt(request.getParameter("stNo")));
%>
	<div class="submenu-container"><!-- 서브 메뉴 -->
		<ul class="ul">
			<li class="submenu" id="submenu-one"><a class="submenu-move" href="StudentRegist.jsp"><span class="submenu-text">등록</span></a></li>
			<li class="submenu" id="submenu-two"><a class="submenu-move" href="Student.jsp"><span class="submenu-text">조회</span></a></li>
			<li class="submenu" id="submenu-three"><a class="submenu-move" href="StudentSearch.jsp"><span class="submenu-text">이름검색</span></a></li>
		</ul>
	</div><!-- 서브 메뉴 끝 -->
	
	<div class="content"><!-- 훈련생 정보 -->
		<form action="StudentInfoUpdate.jsp" method="post">
			<input type="hidden" name="stNo" value="<%=request.getParameter("stNo")%>">
			<table class="student-table">
				<tr>
					<td class="student-banner" colspan=2>
						<h1>훈련생 조회</h1>
					</td>
					<td class="student-component-img" rowspan=4>
						<%
							String save = "/upload/img";
							String real = "";
							
							ServletContext context = getServletContext();
							real = context.getRealPath(save);
							
							File targetDirImg = new File(real);
							
							if(targetDirImg.exists()){		//폴더 확인
								if(stList.get(0).getStImg() != null){
									
									String dirImg = session.getServletContext().getRealPath("/upload/img/");
									String[] imgFiles = new File(dirImg).list();
									
									for(String file : imgFiles){		//이미지 출력
										if(stList.get(0).getStImg().equals(file)){
											out.write("<img src=\"" + "./upload/img/" + java.net.URLEncoder.encode(file,"euc-kr").replace("+","%20") + "\" " +
												"style=\"" + "width: 90px; height: 120px;\"" + ">");
										}
									}
								}else{
						%>
									등록된 파일이 없습니다.
						<%
								}
							}else{
						%>
								폴더가 없습니다.
						<%
							}
						%>
						<br>
						<!-- 이미지 파일 수정 -->
						<input class="student-component-btn" type="button" value="갱신하기" onclick="movePage('StudentInfoImg.jsp','stNo','<%=request.getParameter("stNo")%>');">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="trName">과정이름</label>
					</td>
					<td>
						<input name="processNo" type="hidden" value="<%=pList.get(0).getPrNo()%>">
						<%=pList.get(0).getTrName() %>
						<input name="trName" type="hidden" value="<%=pList.get(0).getTrName()%>">
						<input class="student-component-btn" type="button" onclick="movePage('StudentInfoUpdateProcess.jsp','stNo','<%=request.getParameter("stNo")%>');" value="과정변경">
					</td>
					
				</tr>
				<tr>
					<td class="student-label">
						<label for="prStateName">과정상태</label>
					</td>
					<td>
						<%=pList.get(0).getPrStateName() %>
						<input name="prStateName" type="hidden" value="<%=pList.get(0).getPrStateName() %>">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="prDate">과정날짜</label>
					</td>
					<td>
						<%=pList.get(0).getPrDate() %>
						<input name="prDate" type="hidden" value="<%=pList.get(0).getPrDate() %>">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="memId">담당교사</label>
					</td>
					<td colspan=2>
						<%=stList.get(0).getMemId() %>
						<input name="memId" type="hidden" value="<%=stList.get(0).getMemId() %>">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						유형
					</td>
					<td colspan=2>
						유형 : 
						<%=stList.get(0).getStTyName() %> || 
						<input name="stTyName" type="hidden" value="<%=stList.get(0).getStTyName() %>">
						합격 여부 : 
						<%=stList.get(0).getPaName() %> || 
						<input name="paName" type="hidden" value="<%=stList.get(0).getPaName() %>">
						상태 : 
						<%=stList.get(0).getStStateName() %> || 
						<input name="stStateName" type="hidden" value="<%=stList.get(0).getStStateName() %>">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="stName">이름</label>
					</td>
					<td colspan=2>
						<%=stList.get(0).getStName() %>
						<input name="stName" type="hidden" value="<%=stList.get(0).getStName() %>">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="stBirth">생년월일</label>
					</td>
					<td colspan=2>
						<%=stList.get(0).getStBirth() %>
						<input name="stBirth" type="hidden" value="<%=stList.get(0).getStBirth() %>">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="">전화번호</label>
					</td>
					<td colspan=2>
						<%=stList.get(0).getStTel() %>
						<%
							String TotalTel = stList.get(0).getStTel();
							String divisTel = "[-]";
							String[] tel = TotalTel.split(divisTel);
						%>
						<input name="tel1" type="hidden" value="<%=tel[0] %>">
						<input name="tel2" type="hidden" value="<%=tel[1] %>">
						<input name="tel3" type="hidden" value="<%=tel[2] %>">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="stAddr">주소</label>
					</td>
					<td colspan=2>
						<%=stList.get(0).getStAddr() %>
						<input name="stAddr" type="hidden" value="<%=stList.get(0).getStAddr() %>">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="">자격증명</label>
					</td>
					<td colspan=2>
					<%
						String[] liName = new String[4];
								
						for(int i = 0; i < 4; i++){
							liName[i] = "";
						}
								
						for(int i = 0; i < lList.size(); i++){
							if(lList.get(i).getLiName() != null || !(lList.get(i).getLiName().equals(""))){
								liName[i] = lList.get(i).getLiName();
							}
						}
					%>
						자격증 1 : <%=liName[0] %> || 
						<input type="hidden" name="liName1" value="<%=liName[0] %>">
						자격증 2 : <%=liName[1] %>
						<input type="hidden" name="liName2" value="<%=liName[1] %>">
						<br>
						자격증 3 : <%=liName[2] %> || 
						<input type="hidden" name="liName3" value="<%=liName[2] %>">
						자격증 4 : <%=liName[3] %>
						<input type="hidden" name="liName4" value="<%=liName[3] %>">
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="stCharacter">학생특성</label>
					</td>
					<td colspan=2>
						<input name="stCharacter" type="hidden" value="<%=stList.get(0).getStCharacter() %>">
						<%
							String stCharacter = stList.get(0).getStCharacter();
							stCharacter = stCharacter.replace("\r\n", "<br>");
							out.println(stCharacter);
						%>
					</td>
				</tr>
				<tr>
					<td class="student-label">
						<label for="stResume">이력서</label>
					</td>
					<td colspan=2>
						<%
							save = "/upload/resume";
							real = context.getRealPath(save);
								
							File targetDirReume = new File(real);
							
							if(targetDirReume.exists()){	//폴더 확인
								if(stList.get(0).getStResume() != null){
									String dirReume = application.getRealPath("/upload/resume/");
									String[] reFiles = new File(dirReume).list();
									
									for(String file : reFiles){		//이력서 파일 다운로드 링크
										if(stList.get(0).getStResume().equals(file)){
											out.write("<a href=\"" + request.getContextPath() + "/downloadAction?file=" +
												java.net.URLEncoder.encode(file, "UTF-8").replace("+","%20") + "&save=resume/" + "\">" + "이력서 다운로드" + "</a>");
										}
									}
								}else{
						%>
									등록된 이력서가 없습니다.
						<%
								}
							}else{
						%>
								폴더가 없습니다.
						<%
							}
						%>
						<!-- 이력서 파일 수정 -->
						<input class="student-component-btn" type="button" value="갱신하기" onclick="movePage('StudentResume.jsp','stNo','<%=stList.get(0).getStNo()%>');">
					</td>
				</tr>
				<tr>
					<td colspan=3>
						<input class="student-submit" type="submit" value="수정">
					</td>
				</tr>
				<tr>
					<td colspan=3>
						<input class="student-submit" type="button" value="제거" onclick="deleteEvent('StudentInfoDeleteActive.jsp','stNo','<%=request.getParameter("stNo")%>');">
					</td>
				</tr>
			</table>
		</form>
		
		<div class="student-detail">
			<input class="student-component-btn" type="button" value="지원현황" onclick="visible('student-table-advice', 'student-table-apply', this);">
		</div>
		
		<table class="student-table" id="student-table-advice"><!-- 상담내용 -->
			<thead class="student-thead">
				<tr class="student-title">
					<th width="100">과정상태</th>
					<th width="150">상담직원<br>날짜</th>
					<th width="500">상담내용</th>
					<th width="50"></th>
				</tr>
			</thead>
			<tbody style="text-align:center;">
				<%
					aList = aDAO.getList(stList.get(0).getStNo());
								
					for(int i = 0; i < aList.size(); i++){
						mList = mDAO.getList(aList.get(i).getMemId());
				%>
						<tr>
							<td><%=aList.get(i).getPrStateName() %></td>
							<td><%=mList.get(0).getMemName() %><br><%=aList.get(i).getAdDate() %></td>
							<td style="text-align:left;">
							<%
								String comment = aList.get(i).getAdComment();
								comment = comment.replace("\r\n", "<br>");
								out.println(comment);
							%>
							</td>
							<td>
								<input class="student-advice-btn" type="button" onclick="movePage('AdviceUpdate.jsp','adNo','<%=aList.get(i).getAdNo() %>');" value="수정">
								<hr>
								<input class="student-advice-btn" type="button" onclick="deleteEvent('AdviceDeleteActive.jsp','adNo','<%=aList.get(i).getAdNo() %>');" value="제거">
							</td>
						</tr>
						<tr>
							<td colspan=4 style="background-color:black;">
							</td>
						</tr>
				<%
					}
				%>
				<tr><td style="height: 100px;" colspan=4></td></tr>	<!-- 공백 -->
			</tbody>
		</table><!-- 상담 내용 끝 -->
		
		<table class="student-table" id="student-table-apply">
			<tr>
				<td colspan=5>
					<input class="student-component-btn" type="button" value="추가하기" onclick="movePage('SupportCompanyCreate.jsp', 'stNo', '<%=request.getParameter("stNo") %>');">
				</td>
			</tr>
			<%
				for(int i = 0; i < scList.size(); i++){
			%>
					<tr>
						<td class="student-label" rowspan=2>
							지원일자
						</td>
						<td class="student-label">
							회사명
						</td>
						<td>
							<%=scList.get(i).getScCompany() %>
						</td>
						<td class="student-label">
							소재지
						</td>
						<td>
							<%=scList.get(i).getScAddr() %>
						</td>
					</tr>
					<tr>
						<td class="student-label">
							담당자
						</td>
						<td>
							<%=scList.get(i).getScName() %>
						</td>
						<td class="student-label">
							회사전번
						</td>
						<td>
							<%=scList.get(i).getScTel() %>
						</td>
					</tr>
					<tr>
						<td rowspan=2>
							<%=scList.get(i).getScDate() %>
						</td>
						<td class="student-label">
							알선내용
						</td>
						<td colspan=3>
							<%
								String str = scList.get(i).getScContent();
								str = str.replace("\r\n", "<br>");
								out.println(str);
							%>
						</td>
					</tr>
					<tr>
						<td class="student-label">
							최종결과
						</td>
						<td>
							<%if(scList.get(i).getScResult() != null)out.println(scList.get(i).getScResult()); %>
						</td>
						<td class="student-label">
							사유
						</td>
						<td>
							<%if(scList.get(i).getScReason() != null)out.println(scList.get(i).getScReason()); %>
						</td>
					</tr>
					<tr>
						<td	colspan=5 style="text-align: right;">
							<input class="student-component-btn" type="button" value="수정" onclick="movePage('SupportCompanyUpdate.jsp', 'scNo', '<%=scList.get(i).getScNo() %>', 'stNo', '<%=request.getParameter("stNo") %>');">
							<input class="student-component-btn" type="button" value="제거" onclick="deleteEvent('SupportCompanyDeleteActive.jsp', 'scNo', '<%=scList.get(i).getScNo() %>', 'stNo', '<%=request.getParameter("stNo") %>');">
						</td>
					</tr>
					<tr><td style="background-color: black;" colspan=5></td></tr>	<!-- 경계선 -->
			<%
				}
			%>
			<tr><td style="height: 100px;"></td></tr><!-- 공백 -->
		</table>
	</div><!-- 훈련생 정보 끝 -->
</body>
</html>