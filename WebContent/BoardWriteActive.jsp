<!-- DB. 글쓰기 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="utilMade.TimeNow" %>
<%@ page import="java.io.*" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="b" class="board.Board" scope="page" />
<script src="./js/Intra.js"></script>

<%
	String saveFolder = "/upload/board";				//상대경로
	String realFolder = "";								//어플리케이션. 절대경로
	String encType = "UTF-8";							//인코드 타입
	int maxSize = 1024*1024*1024;						//최대 사이즈
	String attribute[] = { "bTitle", "bContent"};		//속성
	
	ServletContext context = getServletContext();
	realFolder = context.getRealPath(saveFolder);
	
	File targetDir = new File(realFolder);
	
	if(!(targetDir.exists()))	//폴더확인. 없을 시 생성
		targetDir.mkdirs();
	
	try{
		MultipartRequest upload = null;
		
		//파일 업로드
		upload = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		
		Enumeration<?> params = upload.getParameterNames();		//type="file"을 제외한 타입
		
		while(params.hasMoreElements()){
			String name = (String)params.nextElement();
			String value = upload.getParameter(name);
			
			if(name.equals(attribute[0])){b.setbTitle(value);}
			if(name.equals(attribute[1])){b.setbContent(value);}
		}
		
		if(b.getbTitle().equals(""))b.setbTitle("제목이 없습니다.");
		
		Enumeration<?> files = upload.getFileNames();			//type="file"만
		
		while(files.hasMoreElements()){
			String name = (String)files.nextElement();
			String filename = upload.getFilesystemName(name);
			
			if(name.equals("bFile")){b.setbFile(filename);}
		}
		
		BoardDAO bDAO = new BoardDAO();
		TimeNow now = new TimeNow();
		
		b.setbDate(now.getyMdhms());		//현재 시간('yyyy-MM-dd hh-mm-ss');
		b.setMemId(String.valueOf(session.getAttribute("userId")));
		
		int result = bDAO.write(b);
		
		if(result == -2){
%>
			<script>
				failEvent('데이버베이스 오류');
			</script>
<%
		}else{
		%>
			<script>
				movePage('Board.jsp');
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