<!-- DB. 훈련생 정보 수정 -->
<!-- request : Student 자바빈 변수 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="student.StudentDAO" %>
<%@ page import="student.LicenseDAO" %>
<%@page import="utilMade.PatternCheck"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="st" class="student.Student" scope="page" />
<jsp:setProperty name="st" property="*" />
<script src="./js/Intra.js"></script>
<%
	PatternCheck pc = new PatternCheck();
	
	if(request.getParameter("stName").equals("") ||
			request.getParameter("stPwd").equals("") ||
			request.getParameter("tel1").equals("") ||
			request.getParameter("tel2").equals("") ||
			request.getParameter("tel3").equals("") ||
			request.getParameter("stBirth").equals("") ||
			request.getParameter("stAddr").equals("") ||
			request.getParameter("stCharacter").equals(""))
	{
%>
		<script>
			failEvent('양식이 비어있습니다.');
		</script>
<%
	}
	
	if(!(pc.examination(request.getParameter("tel1"))) ||
			!(pc.examination(request.getParameter("tel2"))) ||
			!(pc.examination(request.getParameter("tel3")))){
%>
		<script>
			failEvent('양식에 맞지 않습니다 : 전화번호');
		</script>
<%
	}
	
	if(!(pc.checkDate(request.getParameter("stBirth")))){
%>
		<script>
			failEvent('양식에 맞지 않습니다 : 생년월일');
		</script>
<%
	}
	
	StudentDAO stDAO = new StudentDAO();

	int result = stDAO.updateStudent(st);
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류(훈련생 수정)');
		</script>
<%
	}else{
		LicenseDAO lDAO = new LicenseDAO();
		result = lDAO.deleteLicense(st.getStNo());
		
		if(result == -2){
%>
			<script>
				failEvent('데이터베이스 오류(자격증 삭제)');
			</script>
<%
		}else{
			// 성공시 자격증 수정
			for( int i = 1; i <= 4; i++){
				if(!(request.getParameter("liName" + i).equals(""))){
					result = lDAO.createLicense(st.getStNo(), request.getParameter("liName" + i));
					
					if(result == -2){
						break;
					}else if(result == -1){
						break;
					}
				}
			}
			
			if( result == -2 ){
%>
				<script>
					failEvent('데이터베이스 오류 (자격증 수정)');
				</script>
<%
			}else if( result == -1 ){
%>
				<script>
					failEvent('자격증명 중복');
				</script>
<%
			}else{
%>
				<script>
					sucessEvent('수정 성공','StudentInfo.jsp','stNo','<%=request.getParameter("stNo")%>');
				</script>
<%
			}
		}
	}
%>