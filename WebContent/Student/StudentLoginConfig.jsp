<!-- DB. 훈련생 확인 -->
<!-- request : stName, stPwd -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="student.Student" %>
<%@ page import="student.StudentDAO" %>
<%@ page import="utilMade.TimeNow" %>
<%@ page import="java.util.*" %>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="st" class="student.Student" scope="page" />
<jsp:setProperty name="st" property="*" />
<script src="./js/Student.js"></script>
<%
	StudentDAO stDAO = new StudentDAO();

	int result = stDAO.login(st.getStName(), st.getStPwd(), st.getStBirth());
	
	if(result == 1)
	{
		ArrayList<Student> stList = new ArrayList<Student>();
		stList = stDAO.getData(st.getStName());
		session.setAttribute("stName", st.getStName());
		session.setAttribute("num", stList.get(0).getStNo());
		
%>
		<script>
			movePage('JobMain.jsp');
		</script>
<%
	}else if(result == 0){
%>
		<script>
			movePage('StudentLogin.jsp');
		</script>
<%
	}
	else if(result == -1)
	{
		%>
		<script>
			movePage('StudentLogin.jsp');
		</script>
<%
	}
	else if(result == -2)
	{
		%>
		<script>
			movePage('StudentLogin.jsp');
		</script>
<%
	}
%>