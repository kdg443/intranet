<!-- DB. 이력서 파일 수정 -->
<!-- request : stNo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="student.Student" %>
<%@ page import="student.StudentDAO" %>
<%@ page import="java.io.*" %>
<%@	page import="java.util.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="st" class="student.Student" scope="page" />
<script src="./js/Intra.js"></script>

<%
	String saveFolder = "/upload/resume";				//상대경로
	String realFolder = "";								//어플리케이션.절대경로
	String encType = "UTF-8";							//인코드타입
	int maxSize = 1024*1024*1024;						//최대사이즈
	
	String befName = "";								//수정 전 파일 이름
	
	ServletContext context = getServletContext();
	realFolder = context.getRealPath(saveFolder);
	
	File targetDir = new File(realFolder);
	
	if(!(targetDir.exists())){			//파일 확인. 없으면 생성
		targetDir.mkdirs();
	}
	
	try{
		MultipartRequest upload = null;
		
		//이밎 업로드
		upload = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		
		Enumeration<?> params = upload.getParameterNames();		//type="file"을 제외한 type
		
		while(params.hasMoreElements()){
			String name = (String)params.nextElement();
			String value = upload.getParameter(name);
			
			st.setStNo(Integer.parseInt(value));
		}
		
		Enumeration<?> files = upload.getFileNames();			//type="file"만
		
		while(files.hasMoreElements()){
			String name = (String)files.nextElement();
			String filename = upload.getFilesystemName(name);
			
			st.setStResume(filename);
		}
		
		StudentDAO stDAO = new StudentDAO();
		ArrayList<Student> stList = new ArrayList<Student>();
		
		stList = stDAO.getData(st.getStNo());
		befName = stList.get(0).getStResume();
		
		int result = stDAO.updateResume(st.getStNo(), st.getStResume());
		
		if(result == -2){
			//실패 시 방금 업로드한 이력서 파일 삭제
			saveFolder += st.getStResume();
			realFolder = context.getRealPath(saveFolder);
			
			File f = new File(realFolder);
			
			if(f.exists())		//파일 확인. 있으면 제거
				f.delete();
%>
			<script>
				failEvent('데이터베이스 오류');
			</script>
<%
		}else{
			//성공 시 수정 전 이력서 파일 삭제
			saveFolder += befName;
			realFolder = context.getRealPath(saveFolder);
			
			File f = new File(realFolder);
			
			if(f.exists())		//파일 확인. 있으면 제거
				f.delete();
		%>
			<script>
				sucessEvent('갱신 성공','StudentInfo.jsp','stNo','<%=st.getStNo()%>');
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