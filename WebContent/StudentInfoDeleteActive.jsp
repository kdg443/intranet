<!-- DB. 훈련생 정보 삭제 -->
<!-- request : stNo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="student.Student" %>
<%@ page import="student.StudentDAO" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="st" class="student.Student" scope="page" />
<jsp:setProperty name="st" property="stNo" />
<script src="./js/Intra.js"></script>

<%
	StudentDAO stDAO = new StudentDAO();
	ArrayList<Student> stList = new ArrayList<Student>();
	
	stList = stDAO.getData(st.getStNo());
	int result = stDAO.deleteStudent(st.getStNo());
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%
	}else{
		//성공 시 해당 훈련생의 이미지, 이력서 삭제
		String real = "";
		String resFolder = "/upload/resume/";
		resFolder += stList.get(0).getStResume();
		
		ServletContext context = getServletContext();
		real = context.getRealPath(resFolder);
		
		File resF = new File(real);
		
		if(resF.exists())resF.delete();		//파일 확인.	확인 시 삭제
		
		String imgFolder = "/upload/img/";
		imgFolder += stList.get(0).getStImg();
		
		real = context.getRealPath(imgFolder);
		
		File imgF = new File(real);
		
		if(imgF.exists())imgF.delete();		//파일 확인.	확인 시 삭제
%>
		<script>
			sucessEvent('제거 완료',"Student.jsp");
		</script>
<%
	}
%>