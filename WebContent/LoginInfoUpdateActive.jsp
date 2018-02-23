<!-- DB. 직원 정보 수정 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.MemberDAO" %>
<%@ page import="utilMade.PatternCheck" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="member" class="member.Member" scope="page"/>
<jsp:setProperty name="member" property="*" />
<script src="./js/Intra.js"></script>
<%
	String userId = null;
	String connect = null;
	String userName = null;

	if(session.getAttribute("userId") != null){
		userId = (String) session.getAttribute("userId");
		connect = (String) session.getAttribute("connect");
		userName = (String) session.getAttribute("userName");
	}else{
%>
		<script>
			failEvent('로그인 후 이용해 주시기 바랍니다.');
		</script>
<%
	}
%>

<%
	if(session.getAttribute("userId") == null){
%>
		<script>
			failEvent('접근이 제한되어있습니다.');
		</script>
<%
	}

	PatternCheck pCheck = new PatternCheck();
	boolean result;
	
	if(request.getParameter("memId").equals("") ||
			request.getParameter("memPwd").equals("") ||
			request.getParameter("memName").equals("") ||
			request.getParameter("tel1").equals("") ||
			request.getParameter("tel2").equals("") ||
			request.getParameter("tel3").equals(""))
		{
%>
			<script>
				failEvent('비어있는 양식이 있습니다.');
			</script>
<%
		}
		
		result = pCheck.examination(request.getParameter("tel2"));
		
		//전호번호 숫자  검사
		if(!result)	//전화번호 두번째 필드 검사
		{
%>
			<script>
				failEvent('전화번호는 숫자만 기입이 가능합니다.');
			</script>
<%
		}
		else
		{
			result = pCheck.examination(request.getParameter("tel3"));
			
			if(!result)	//전화번호 세번째 필드 검사
			{
%>
				<script>
					failEvent('전화번호는 숫자만 기입이 가능합니다.');
				</script>
<%
			}
			else	//전화번호 문자열 길이 검사
			{
				if(request.getParameter("tel2").length() != 4)	//전화번호 두번째 필드 검사
				{
%>
					<script>
						failEvent('전화번호 두번째 자리 4자리를 기입해주십쇼.');
					</script>
<%
				}
				else if(request.getParameter("tel3").length() != 4)	//전화번호 세번째 필드 검사
				{
%>
					<script>
						failEvent('전화번호 세번째 자리 4자리를 기입해주십쇼.');
					</script>
<%
				}
			}
		}
		
		MemberDAO mDAO = new MemberDAO();
		int sucess = mDAO.updateMember(member);
		
		if(sucess == -2)
		{
%>
			<script>
				failEvent('데이터베이스 오류');
			</script>
<%
		}else{
%>
			<script>
				sucessEvent('수정 완료','LoginInfo.jsp');
			</script>
<%
		}
%>