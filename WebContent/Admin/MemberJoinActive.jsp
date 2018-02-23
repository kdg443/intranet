<!-- DB. 멤버 등록 -->
<!-- request : Member 자바빈 변수 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="member.MemberDAO" %>
<%@ page import="utilMade.PatternCheck" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ include file="SessionConfig.jsp" %><!-- 세션 관리 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="member" class="member.Member" scope="page"/>
<script src="./js/Admin.js"></script>

<%
	PrintWriter script = response.getWriter();
	String saveFolder = "/upload/member";					//상대경로
	String realFolder = "";									//어플리케이션.절대경로
	String enctype = "UTF-8";								//인코드타입
	int maxSize = 1024*1024*1024;							//최대사이즈
	
	//파라미터 이름
	String attribute[] = { "depName", "memName", "memId", "memPwd", "tel1", "tel2", "tel3", "memResume"};
	
	ServletContext context = getServletContext();
	realFolder = context.getRealPath(saveFolder);
	
	File targetDir = new File(realFolder);
	
	if(!targetDir.exists()){	//폴더 확인. 없으면 생성
		targetDir.mkdirs();
	}
	
	try{
		MultipartRequest upload = null;
		
		//파일 업로드
		upload = new MultipartRequest(request, realFolder, maxSize, enctype, new DefaultFileRenamePolicy());
		
		Enumeration<?> params = upload.getParameterNames();			//type="file"을 제외한 type
		
		while(params.hasMoreElements()){
			String name = (String)params.nextElement();
			String value = upload.getParameter(name);
			
			if(attribute[0].equals(name)){member.setDepName(value);}
			if(attribute[1].equals(name)){member.setMemName(value);}
			if(attribute[2].equals(name)){member.setMemId(value);}
			if(attribute[3].equals(name)){member.setMemPwd(value);}
			if(attribute[4].equals(name)){member.setTel1(value);}
			if(attribute[5].equals(name)){member.setTel2(value);}
			if(attribute[6].equals(name)){member.setTel3(value);}
		}
		
		Enumeration<?> files = upload.getFileNames();				//type="file"만
		
		while(files.hasMoreElements()){
			String name = (String)files.nextElement();
			String filename = upload.getFilesystemName(name);
			
			if(attribute[7].equals(name)){member.setMemResume(filename);}
		}
		
		PatternCheck pc = new PatternCheck();
		
		if(!(pc.examination(member.getTel1())) ||			//숫자 판별
				!(pc.examination(member.getTel2())) ||
				!(pc.examination(member.getTel3()))){
			saveFolder += "/" + member.getMemResume();
			realFolder = context.getRealPath(saveFolder);

			File f = new File(realFolder);
			
			if(f.exists())f.delete();		//파일 확인. 있으면 삭제
%>
			<script>
				failEvent('양식에 맞지 않습니다 : 전화번호');
			</script>
<%			
		}
		
		MemberDAO mDAO = new MemberDAO();
		int result = mDAO.join(member);
		
		if(result == -1){
			//실패 시 방금 업로드한 파일 삭제
			saveFolder += "/" + member.getMemResume();
			realFolder = context.getRealPath(saveFolder);
			
			File f = new File(realFolder);
			
			if(f.exists())f.delete();		//파일 확인. 있으면 삭제	
%>
				<script>
					failEvent('중복된 아이디입니다.');
				</script>
<%	
		}else if(result == -2){
			//실패 시 방금 업로드한 파일 삭제
			saveFolder += "/" + member.getMemResume();
			realFolder = context.getRealPath(saveFolder);
			
			File f = new File(realFolder);
			
			if(f.exists())f.delete();		//파일 확인. 있으면 삭제	
%>
				<script>
					failEvent('데이터베이스 오류');
				</script>
<%
		}else{
%>
				<script>
					sucessEvent('가입 완료','MemberJoin.jsp');
				</script>
<%
		}
	}catch(Exception e){
%>
		<script>
			failEvent('ERROR !!');
		</script>
<%
	}
%>