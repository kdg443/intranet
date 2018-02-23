<!-- DB. 훈련생 이력서 파일 수정 -->
<%@page import="student.Student"%>
<%@page import="java.util.ArrayList"%>
<%@page import="student.StudentDAO"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<script src="./js/Student.js"></script>

<%
	String saveFolder = "/upload/resume";					//상대경로
	String realFolder = "";									//어플리케이션.절대경로
	String encType = "UTF-8";								//인코드타입
	int maxSize = 1024*1024*1024;							//최대사이즈
	
	String newName = "";									//업로드 파일 이름
	String befName = "";									//수정 전 파일 이름
	
	//훈련생 인덱스 번호
	int stNo = Integer.parseInt(String.valueOf(session.getAttribute("num")));
	
	ServletContext context = getServletContext();
	realFolder = context.getRealPath(saveFolder);
	
	File targetDir = new File(realFolder);
	
	if(!(targetDir.exists())) targetDir.mkdirs();		//폴더 확인. 없을시 생공
	
	try{
		MultipartRequest upload = null;
		
		//파일 업로드
		upload = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		
		Enumeration<?> files = upload.getFileNames();			//type="file"만
		
		while(files.hasMoreElements()){
			String name = (String)files.nextElement();
			String value = upload.getFilesystemName(name);
			
			newName = value;
		}
		
		StudentDAO stDAO = new StudentDAO();
		ArrayList<Student> stList = new ArrayList<Student>();
		stList = stDAO.getData(stNo);
		befName = stList.get(0).getStResume();
		
		int result = stDAO.updateResume(stNo, newName);
		
		if(result == -2){
			//실패 시 업로드한 파일 삭제
			saveFolder = "/upload/resume/";
			saveFolder += newName;
			realFolder = context.getRealPath(saveFolder);
			
			File file = new File(realFolder);
			
			if(file.exists())file.delete();		//파일 확인. 있을 시 제거
%>
			<script>
				failEvent('데이터베이스 오류');
			</script>
<%
		}else{
			//성공 시 수정 전 파일 삭제
			saveFolder = "/upload/resume/";
			saveFolder += befName;
			realFolder = context.getRealPath(saveFolder);
			
			File file = new File(realFolder);
			
			if(file.exists())file.delete();		//파일 확인. 있을 시 제거
%>
			<script>
				sucessEvent('갱신성공','JobMain.jsp');
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