<!-- 과정 속성 생성 -->
<!-- request : trType, chType, trRoom, chRoom, trName, chName -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="training.TrainingTypeDAO"%>
<%@ page import="training.TrainingRoomDAO"%>
<%@ page import="training.TrainingNameDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ include file="SessionConfig.jsp" %><!-- 세션 관리 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="training" class="training.Training" scope="page"/>
<jsp:setProperty name="training" property="trType"/>
<jsp:setProperty name="training" property="trRoom"/>
<jsp:setProperty name="training" property="trName"/>
<script src="./js/Admin.js"></script>

<%
	PrintWriter script = response.getWriter();

	//모든 필드 값 확인
	if( request.getParameter("trType").equals("") &&
			request.getParameter("chType").equals("") &&
			request.getParameter("trRoom").equals("") &&
			request.getParameter("chRoom").equals("") &&
			request.getParameter("trName").equals("") &&
			request.getParameter("chName").equals(""))
	{
%>
		<script>
			failEvent('모든 양식이 비어있습니다.');
		</script>
<%
	}
	
	//훈련종류 필드 값 확인
	if(!(request.getParameter("trType").equals("")) &&
			request.getParameter("chType").equals(""))
	{
%>
		<script>
			failEvent('변경하실 이름이 없습니다.(훈련종류)');
		</script>
<%
	}
	else if(request.getParameter("trType").equals("") &&
			!(request.getParameter("chType").equals("")))
	{
%>
		<script>
			failEvent('변경할 이름 선택.(훈련종류)');
		</script>
<%
	}
	
	//교육실 필드 값 확인
	if( !(request.getParameter("trRoom").equals("")) &&
			request.getParameter("chRoom").equals(""))
	{
%>
		<script>
			failEvent('변경하실 이름이 없습니다.(교육실)');
		</script>
<%
	}
	else if(request.getParameter("trRoom").equals("") &&
			!(request.getParameter("chRoom").equals("")))
	{
%>
		<script>
			failEvent('변경할 이름 선택.(교육실)');
		</script>
<%
	}
	
	//훈련명 필드 값 확인
	if(!(request.getParameter("trName").equals("")) && request.getParameter("chName").equals(""))
	{
%>
		<script>
			failEvent('변경하실 이름이 없습니다.(훈련명)');
		</script>
<%
	}
	else if(request.getParameter("trName").equals("") && !(request.getParameter("chName").equals("")))
	{
%>
		<script>
			failEvent('변경할 이름 선택.(훈련명)');
		</script>
<%
	}
	
	//데이터 수정(훈련종류, 교육실, 훈련명)
	int result;	//리턴값 확인
	
	//훈련종류 수정
	if( !(request.getParameter("trType").equals("")) &&
			!(request.getParameter("chType").equals("")))
	{
		TrainingTypeDAO tTypeDAO = new TrainingTypeDAO();
		result = tTypeDAO.updateType(training.getTrType(), request.getParameter("chType"));
		
		if(result == -1)
		{
%>
			<script>
				failEvent('존재하는 이름입니다.(훈련종류)');
			</script>
<%
		}
		else if(result == -2)
		{
%>
			<script>
				failEvent('데이터베이스 오류.(훈련종류)');
			</script>
<%
		}
	}
	
	//교육실 수정
	if( !(request.getParameter("trRoom").equals("")) &&
			!(request.getParameter("chRoom").equals("")))
	{
		TrainingRoomDAO tRoomDAO = new TrainingRoomDAO();
		result = tRoomDAO.updateRoom(training.getTrRoom(), request.getParameter("chRoom"));
		
		if(result == -1)
		{
%>
			<script>
				failEvent('존재하는 이름입니다.(교육실)');
			</script>
<%
		}
		else if(result == -2)
		{
%>
			<script>
				failEvent('데이터베이스 오류.(교육실)');
			</script>
<%
		}
	}
	
	//훈련명 수정
	if( !(request.getParameter("trName").equals("")) &&
			!(request.getParameter("chName").equals("")))
	{
		TrainingNameDAO tNameDAO = new TrainingNameDAO();
		result = tNameDAO.updateName(training.getTrName(), request.getParameter("chName"));
		
		if(result == -1)
		{
%>
			<script>
				failEvent('존재하는 이름입니다.(훈련명)');
			</script>
<%
		}
		else if(result == -2)
		{
%>
			<script>
				failEvent('데이터베이스 오류.(훈련종류)');
			</script>
<%
		}
	}
%>
<!-- 수정 완료 -->
<script>
	sucessEvent('수정 완료','TrainingDefine.jsp');
</script>