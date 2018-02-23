<!-- DB. 훈련생 이미지 파일 수정 -->
<!-- request : stNo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="student.Student" %>
<%@ page import="student.StudentDAO" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.*" %>
<%@page import="java.util.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<script src="./js/Intra.js"></script>

<%
	String saveFolder = "/upload/img";				//상대경로
	String realFolder = "";							//어플리케이션.절대경로
	String encType = "UTF-8";					//인코드타입
	int maxSize = 1024*1024*1024;				//최대사이즈
	
	int stNo = 0;								//훈련생 인덱스 번호
	String befName = "";						//수정 전 파일 이름
	String newName = "";						//수정 후 파일 이름
	
	ServletContext context = getServletContext();
	realFolder = context.getRealPath(saveFolder);
	
	File targetDir = new File(realFolder);
	
	if(!(targetDir.exists()))		//폴더 확인. 없을 시 생성
		targetDir.mkdirs();
	
	try{
		MultipartRequest upload = null;
		
		//이미지 업로드
		upload = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		
		Enumeration<?> params = upload.getParameterNames();		//type="file"을 제외한 type
		
		while(params.hasMoreElements()){
			String name = (String)params.nextElement();
			String value = upload.getParameter(name);
			
			stNo = Integer.parseInt(value);
		}
		
		Enumeration<?> files = upload.getFileNames();			//type="file"만
		
		while(files.hasMoreElements()){
			String name = (String)files.nextElement();
			String filename = upload.getFilesystemName(name);
			
			newName = filename;
		}
		
		StudentDAO stDAO = new StudentDAO();
		ArrayList<Student> stList = new ArrayList<Student>();
		String existFolder = "/upload/img/";
		
		stList = stDAO.getData(stNo);
		
		int result = stDAO.updateImg(stNo, newName);
		
		if(result == -2){
			//실패 시 방금 업로드한 파일 삭제
			existFolder += newName;
			realFolder = context.getRealPath(existFolder);
			
			File img = new File(realFolder);
			
			if(img.exists())
				img.delete();
%>
			<script>
				failEvent('데이터베이스 오류');
			</script>
<%
		}else{
			//성공 시 이전 파일 삭제
			existFolder += stList.get(0).getStImg();
			realFolder = context.getRealPath(existFolder);
			
			File img = new File(realFolder);
			
			if(img.exists())
				img.delete();
			
		%>
			<script>
				sucessEvent('갱신완료','StudentInfo.jsp','stNo','<%=stNo%>');
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