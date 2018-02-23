<!-- DB. 게시물 첨부파일 수정 -->
<!-- request : bNo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.*"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.*"%>
<%@page import="board.Board"%>
<%@page import="board.BoardDAO"%>
<% request.setCharacterEncoding("UTF-8"); %>
<script src="./js/Intra.js"></script>

<%
	String uploadFolder = "/upload/board";			//상대경로
	String realFolder = "";							//어플리케이션. 절대경로
	String encType = "UTF-8";						//인코드 타입
	int maxSize = 1024*1024*1024;					//최대 사이즈
	int bNo = 0;
	String befName = "";
	String newName = "";
	
	ServletContext context = getServletContext();
	realFolder = context.getRealPath(uploadFolder);
	
	File targetDir = new File(realFolder);
	
	if(!(targetDir.exists())){			//폴더 확인. 없을 시 생성
		targetDir.mkdirs();
	}
	
	try{
		MultipartRequest upload = null;
		
		//파일 업로드
		upload = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		
		Enumeration<?> params = upload.getParameterNames();		//type="file"을 제외한 나머지 type
		
		while(params.hasMoreElements()){
			String name = (String)params.nextElement();
			String value = upload.getParameter(name);
			
			bNo = Integer.parseInt(value);
		}
		
		Enumeration<?> files = upload.getFileNames();			//type="file"만
		
		while(files.hasMoreElements()){
			String name = (String)files.nextElement();
			String filename = upload.getFilesystemName(name);
			
			newName = filename;
		}
		
		BoardDAO bDAO = new BoardDAO();
		ArrayList<Board> bList = new ArrayList<Board>();
		
		bList = bDAO.getDate(bNo);
		befName = bList.get(0).getbFile();
		
		int result = bDAO.updateFile(bNo, newName);
		
		if(result == -2){
			//방금 업로드한 파일 삭제
			String boardFolder= "/upload/board/";
			boardFolder += newName;
			
			realFolder = context.getRealPath(boardFolder);
			
			File f = new File(realFolder);
			
			if(f.exists())f.delete();
%>
			<script>
				failEvent('데이터베이스 오류');
			</script>
<%
		}else{
			//수정 전 첨부파일 삭제
			String boardFolder= "/upload/board/";
			boardFolder += befName;

			realFolder = context.getRealPath(boardFolder);
			
			File f = new File(realFolder);
			
			if(f.exists())f.delete();
			
		%>
			<script>
				sucessEvent('파일 변경완료','BoardInfo.jsp','bNo','<%=bNo%>');
			</script>
		<%
		}
	}catch(Exception e){
%>
		<script>
			failEvent('ERROR!!');
		</script>
<%
	}
%>