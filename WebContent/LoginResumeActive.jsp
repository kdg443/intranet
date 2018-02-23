<!-- DB. 직원 이력서 파일 수정 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.Member"%>
<% request.setCharacterEncoding("UTF-8"); %>
<script src="./js/Intra.js"></script>

<%
	String save = "/upload/member";					//상대경로
	String real = "";								//어플리케이션.절대경로
	String encType = "UTF-8";						//인코드타입
	int maxSize = 1024*1024*1024;					//최대사이즈
	String memId = String.valueOf(session.getAttribute("userId"));
	
	String befName = "";
	String newName = "";
	
	ServletContext context = getServletContext();
	real = context.getRealPath(save);
	
	File targetDir = new File(real);
	
	if(!(targetDir.exists()))targetDir.mkdirs();	//폴더 확인. 없을 시 생성
	
	try{
		MultipartRequest upload = null;
		
		//파일 업로드
		upload = new MultipartRequest(request, real, maxSize, encType, new DefaultFileRenamePolicy());
		
		Enumeration<?> files = upload.getFileNames();		//type="file"을 제외한 type
		
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
			//실패 시 방금 업르도한 파일 삭제
			save = "/upload/member/";
			save += newName;
			real = context.getRealPath(save);
			
			File f = new File(real);
			
			if(f.exists())f.delete();
%>
			<script>
				failEvent('데이터베이스 오류');
			</script>
<%
		}else{
			//성공 시 수정 전에 등록된 파일 삭제
			save = "/upload/member/";
			save += befName;
			real = context.getRealPath(save);
			
			File f = new File(real);
			
			if(f.exists())f.delete();
			
		%>
			<script>
				sucessEvent('갱신 완료','LoginInfo.jsp');
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