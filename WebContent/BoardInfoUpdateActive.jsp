<!-- DB. 게시물 내용 수정 -->
<!-- request : bNo, bTitle, bContent -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="b" class="board.Board" scope="page" />
<jsp:setProperty name="b" property="*" />
<script src="./js/Intra.js"></script>

<%
	PrintWriter script = response.getWriter();
	BoardDAO bDAO = new BoardDAO();

	int result = bDAO.updateBoard(b);
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%
	}else{
%>
		<script>
			movePage('BoardInfo.jsp','bNo',<%=b.getbNo()%>);
		</script>
<%
	}
%>