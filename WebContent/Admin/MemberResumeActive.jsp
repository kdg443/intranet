<!-- DB. 직원 이력서 파일 수정 -->
<!-- request : memId -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.Member"%>
<%@ include file="SessionConfig.jsp" %><!-- 세션 관리 -->
<% request.setCharacterEncoding("UTF-8"); %>
<script src="./js/Admin.js"></script>

<%
	String save = "/upload/member";						//상대경로
	String real = "";									//어플리케이션.절대경로
	String encType = "UTF-8";							//인코드타입
	int maxSize = 1024*1024*1024;						//최대사이즈
	String memId = "";									//직원 아이디
	
	String befName = "";								//수정 전 파일 이름
	String newName = "";								//업로드 파일 이름
	
	ServletContext context = getServletContext();
	real = context.getRealPath(save);
	
	File targetDir = new File(real);
	
	if(!(targetDir.exists()))targetDir.mkdirs();		//폴더 확인. 없으면 생성
	
	try{
		MultipartRequest upload = null;
		
		//이미지 업로드
		upload = new MultipartRequest(request, real, maxSize, encType, new DefaultFileRenamePolicy());
		
		Enumeration<?> params = upload.getParameterNames();			//type="file"을 제외한 type
		
		while(params.hasMoreElements()){
			String name = (String)params.nextElement();
			String value = upload.getParameter(name);
			
			if(name.equals("memId"))memId=value;
		}
		
		Enumeration<?> files = upload.getFileNames();				//type="file"만
		
		while(files.hasMoreElements()){
			String name = (String)files.nextElement();
			String filename = upload.getFilesystemName(name);
			
			if(name.equals("memResume"))newName = filename;
		}
		
		MemberDAO mDAO = new MemberDAO();
		ArrayList<Member> mList = new ArrayList<Member>();
		
		mList = mDAO.getList(memId);
		befName = mList.get(0).getMemResume();
		
		int result = mDAO.updateResume(memId, newName);
		
		if(result == -2){
			//실패 시 방금 업로드한 파일 삭제
			save = "/upload/member/";
			save += newName;
			real = context.getRealPath(save);
			
			File f = new File(real);
			
			if(f.exists())f.delete();		//파일 확인. 있으면 삭제	
%>
				<script>
					failEvent('데이터베이스 오류');
				</script>
<%
		}else{
			//성공 시 수정 전 파일 삭제
			save = "/upload/member/";
			save += befName;
			real = context.getRealPath(save);
			
			File f = new File(real);
			
			if(f.exists())f.delete();
			
		%>
			<script>
				sucessEvent('갱신 완료','MemberUpdate.jsp','memId','<%=memId%>');
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