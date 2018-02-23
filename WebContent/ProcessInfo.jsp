<!-- 훈련 정보 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.Member" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="training.Process" %>
<%@ page import="training.ProcessDAO" %>
<%@ page import="training.RegProcessDAO" %>
<%@ page import="training.ProcessField" %>
<%@ page import="training.ProcessFieldDAO" %>
<%@ page import="java.util.*" %>
<%@ include file="Default.jsp" %>	<!-- 기본 틀(로고, 상단 메뉴, 사이드 메뉴)-->
<!DOCTYPE HTML>
<html>
<head>
	<link rel="stylesheet" href="./css/intra.css">
    <meta charset="UTF-8">
    <title>휴먼교육센터</title>
    <script src="./js/Intra.js"></script>
   	<style>
	#nav-move-home
	{
	    background-color: rgb(37, 37, 255);
	}
	.content
	{
		position: absolute;
		top: 350px;
		left: 50%;
		margin-left: -400px;
		width: 800px;
		height: 100px;
	}
	.process-table
     {
		position: absolute;
		top: 20px;
		left: 50%;
		margin-left: -400px;
		width: 800px;
     }
	.process-label
	{
		background-color: rgb(255, 255, 255);
		padding-top: 10px;
		padding-bottom: 10px;
		width: 100px;
		text-align: center;
		font-size: 15px;
		font-weight: bold;
		color: #3352ff;
	}
	.process-content
	{
		border-bottom: 1px solid #3352ff;
	}
	.process-cotent-btn
	{
		background-color: #0076ff;
		border: none;
		width: 100%;
		height: 40px;
		font-size: 15px;
		font-weight: bold;
		color: white;
	}
   	</style>
</head>
<body>
<%
	MemberDAO mDAO = new MemberDAO();
	ProcessDAO pDAO = new ProcessDAO();
	ProcessFieldDAO pfDAO = new ProcessFieldDAO();
	RegProcessDAO rpDAO = new RegProcessDAO();
	
	ArrayList<Member> mList = new ArrayList<Member>();
	ArrayList<Process> pList = new ArrayList<Process>();
	ArrayList<ProcessField> pfList = new ArrayList<ProcessField>();
	
	pList = pDAO.getData(Integer.parseInt(request.getParameter("prNo")));
	mList = mDAO.getList(pList.get(0).getMemId());
	pfList = pfDAO.getList(pList.get(0).getPrNo());
%>
<div class="content"><!-- 훈련 정보 -->
	<table class="process-table">
		<tr>
	       	<td class="process-label">
	           	<label for="trType">훈련종류</label>
	       	</td>
        	<td class="process-content">
        		<%=pList.get(0).getTrType() %>
	       	</td>
         	<td class="process-label">
         		<label for="prStateName">훈련상태</label>
         	</td>
         	<td class="process-content">
         		<%=pList.get(0).getPrStateName() %>
        	</td>
     	</tr>
     	<tr>
       		<td class="process-label">
				<label for="trName">훈련명</label>
         	</td>
         	<td class="process-content">
         		<%=pList.get(0).getTrName() %>
        	</td>
         	<td class="process-label">
             	<label for="memId">담당교사</label>
         	</td>
         	<td class="process-content">
         		<%=mList.get(0).getMemName() + " [" + mList.get(0).getMemId() + "]" %>
         	</td>
     	</tr>
     	<tr>
     		<%
     			String totalDate = pList.get(0).getPrDate();
             	String divisDate = "/";
             	String[] date = totalDate.split(divisDate);
     		%>
         	<td class="process-label">
             	<label for="sDate">개강일</label>
         	</td>
         	<td class="process-content">
         		<%= date[0] %>
         	</td>
         	<td class="process-label">
             	<label for="eDate">수료일</label>
       	 	</td>
         	<td class="process-content">
         		<%= date[1] %>
         	</td>
     	</tr>
     	<tr>
         	<td class="process-label">
             	<label for="prQueta">과정정원</label>
         	</td>
         	<td class="process-content">
         		<%=rpDAO.getTotal(pList.get(0).getPrNo()) + pList.get(0).getPrQueta() %>
         	</td>
         	<td class="process-label">
             	<label for="trRoom">교육실</label>
         	</td>
         	<td class="process-content">
         		<%=pList.get(0).getTrRoom() %>
         	</td>
     	</tr>
     	<tr>
     		<td class="process-label">
   				<label for="fName">관련분야</label>
     		</td>
	     	<td colspan=3 class="process-content">
	     	<%
	     		for(int i = 0; i < pfList.size(); i++){
	     			if( i % 6 == 0){
	     				out.println("<br>");
	     			}
	     			
	     			out.println(pfList.get(i).getfName() + " || ");
	     		}
	     	%>
	     	</td>
     	</tr>
     	<tr>
     		<td colspan=4>
     			<input class="process-cotent-btn" type="button" value="훈련생 확인하기" onclick="movePage('Student.jsp','prNo','<%=request.getParameter("prNo")%>');">
     		</td>
     	</tr>
	</table>
</div><!-- 훈련 정보 끝 -->
</body>
</html>