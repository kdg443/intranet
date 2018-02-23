<!-- 왼쪽 사이드 메뉴 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="student.Student"%>
<%@page import="java.util.ArrayList"%>
<%@page import="student.StudentDAO"%>
<%@page import="java.net.URLEncoder"%>
<script src="./js/Student.js"></script>
<%
	//세션 확인
	if(session.getAttribute("stName") == null){
%>
		<script>
			failEvent('잘못된 접근방식입니다.');
		</script>
<%		
	}

if(!(session.getAttribute("stName").equals("permit"))){
%>
<%
	StudentDAO stDAO = new StudentDAO();
	ArrayList<Student> stList = new ArrayList<Student>();
	stList = stDAO.getData(Integer.parseInt(String.valueOf(session.getAttribute("num"))));
%>
<div class="profile"><!-- 사이드 메뉴 -->
	<div class="var-img">	<!-- 사이드 메뉴 줄 -->
		<hr class="var-img-hr" id="left-hr"><hr class="var-img-hr" id="right-hr">
	</div><!-- 사이드 메뉴 줄 끝 -->
	<div class="img-div"><!-- 썸네일 -->
<%
	String save = application.getRealPath("/upload/img");
	File targetDirImg = new File(save);
	
	if(targetDirImg.exists()){
		if(stList.get(0).getStImg() != null){
			String saveImg = application.getRealPath("/upload/img/");
			String[] imgFiles = new File(saveImg).list();
					
			for(String file : imgFiles){
				if(stList.get(0).getStImg().equals(file)){
					out.write("<img class=\"" + "thumbnail" + "\" " + 
						"src=\"" + "../upload/img/" + java.net.URLEncoder.encode(file, "euc-kr").replace("+","%20") + "\"" + ">");
				}
			}
		}
	}
%>
	</div><!-- 썸네일 끝 -->
	
	<!-- 이름 -->
	<div class="profile-name"><%=session.getAttribute("stName") %></div>
<%
	//이력서 파일 다운로드 링크
	save = application.getRealPath("/upload/resume");
	File targetDirResume = new File(save);
	
	if(targetDirResume.exists()){
		String saveResume = application.getRealPath("/upload/resume/");
		String[] resumeFiles = new File(saveResume).list();
		
		for(String file : resumeFiles){
			if(stList.get(0).getStResume().equals(file)){
				out.write("<a class=\"" + "profile-resume" + "\" " + "href=\"" + request.getContextPath() + "/downloadAction?file=" +
						java.net.URLEncoder.encode(file, "UTF-8") + "&save=resume/" + "\">" + "이력서 다운로드" + "</a>");
			}
		}
	}
%>
	<!-- 이력서 파일 수정 -->
	<input class="profile-resume" id="profile-resume-btn" type="button" value="이력서 갱신하기" onclick="movePage('Resume.jsp');">
	
	<!-- 잡트라넷 -->
	<input class="profile-resume" id="profile-job-btn" type="button" value="잡트라넷" onclick="movePage('JobMain.jsp');">
	
	<!-- 지원 현황 -->
	<input class="profile-resume" id="profile-apply-btn" type="button" value="지원 목록" onclick="movePage('ApplyConfig.jsp');">
	
	<!-- 로그아웃 -->
	<input class="profile-resume" id="profile-log-btn" type="button" value="로그아웃" onclick="movePage('../Logout.jsp');">
</div><!-- 사이드 메뉴 끝 -->
<%}%>