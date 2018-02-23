<!-- 로그인 확인 -->
<!-- request : memId, memPwd -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.Member" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="utilMade.TimeNow" %>
<%@ page import="java.util.*" %>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="member" class="member.Member" scope="page" />
<jsp:setProperty name="member" property="memId"/>
<jsp:setProperty name="member" property="memPwd"/>
<script src="./js/Intra.js"></script>
<%
	MemberDAO mDAO = new MemberDAO();

	int result = mDAO.login(member.getMemId(), member.getMemPwd());
	
	if(result == 1)
	{
		TimeNow now = new TimeNow();
		ArrayList<Member> mList = new ArrayList<Member>();
		mList = mDAO.getList(member.getMemId());
		
		session.setAttribute("userId", member.getMemId());				//세션등록.ID
		session.setAttribute("connect", now.getyMdhms());				//세션등록.접속시간 ('yyyy-MM-dd hh-mm-ss');
		session.setAttribute("userName", mList.get(0).getMemName());	//세션등록.이름
		session.setAttribute("userAccept", mList.get(0).getMemAdmin());	//세션등록.관리자페이지 접근 권한.	0 : X, 1 : O
		session.setAttribute("stName", "permit");						//훈련생용 잡트라넷 이용 시 필요
%>
		<script>
			movePage('Main.jsp');
		</script>
<%
	}else if(result == 0){
%>
		<script>
			movePage('Login.jsp');
		</script>
<%
	}else if(result == -1){
%>
		<script>
			movePage('Login.jsp');
		</script>
<%
	}else if(result == -2){
%>
		<script>
			movePage('Login.jsp');
		</script>
<%
	}
%>