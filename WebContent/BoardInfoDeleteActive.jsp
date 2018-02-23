<!-- DB. 게시물 삭제 -->
<!-- request : bNo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.Board"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.File"%>
<% request.setCharacterEncoding("UTF-8"); %>
<script src="./js/Intra.js"></script>

<% 
	BoardDAO bDAO = new BoardDAO();
	ArrayList<Board> bList = new ArrayList<Board>();
	
	bList = bDAO.getDate(Integer.parseInt(request.getParameter("bNo")));
	
	int result = bDAO.deleteBoard(Integer.parseInt(request.getParameter("bNo")));
	
	if(result == -2){
%>
		<script>
			failEvent('데이터베이스 오류');
		</script>
<%
	}else{								//성공 시, 해당 첨부파일 삭제
		bDAO.indexSort(Integer.parseInt(request.getParameter("bNo")));
		String uploadFolder = "/upload/board/";
		String realFolder = "";
		String fileName = bList.get(0).getbFile();
		uploadFolder += fileName;
		
		ServletContext context = getServletContext();
		realFolder = context.getRealPath(uploadFolder);
		
		File f = new File(realFolder);
		
		if(f.exists())f.delete();
%>
			<script>
				movePage('Board.jsp');
			</script>
<%
	}
%>