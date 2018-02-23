<!-- 과정 수정 -->
<!-- request : prNo -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.Member" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="training.Training" %>
<%@ page import="training.TrainingTypeDAO" %>
<%@ page import="training.TrainingRoomDAO" %>
<%@ page import="training.TrainingNameDAO" %>
<%@ page import="training.Process" %>
<%@ page import="training.ProcessDAO" %>
<%@ page import="training.RelationField" %>
<%@ page import="training.RelationFieldDAO" %>
<%@ page import="training.ProcessField" %>
<%@ page import="training.ProcessFieldDAO" %>
<%@ page import="training.ProcessState" %>
<%@ page import="training.ProcessStateDAO" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="SessionConfig.jsp" %><!-- 세션 관리 -->
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE HTML>
<html>
<head>
    <link rel="stylesheet" href="./css/intraAdmin.css">
    <meta charset="utf-8">
    <title>휴먼교육센터</title>
    <script src="./js/Admin.js"></script>
    <style>
    	.article
    	{
    		height: 600px;
    	}
        #first-box
        {
            top: 150px;
            left: 50px;
            width: 700px;
            height: 350px;
        }
        .begin-table
        {
            position: absolute;
            top: 10px;
            left: 15px;
        }
        .begin-label
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
        .begin-component-select
        {
            width: 214px;
            height: 30px;
            letter-spacing: 1px;
        }
        .begin-component-text
        {
            width: 210px;
            height: 25px;
            letter-spacing: 1px;
        }
        .begin-component-checkbox
        {
        	margin-right: 10px;
        }
        .begin-submit
        {
            position: absolute;
            top: 250px;
            left: 20px;
            background-color: #0076ff;
            border: none;
            width: 660px;
            height: 35px;
            font-size: 20px;
            font-weight: bold;
            letter-spacing: 3px;
            color: white;
        }
        #begin-submit-update
        {
        	top: 250px;
        }
        #begin-submit-delete
        {
        	top: 300px;
        }
    </style>
</head>
<body>
<%
	MemberDAO mDAO = new MemberDAO();
	TrainingTypeDAO tTypeDAO = new TrainingTypeDAO();
	TrainingRoomDAO tRoomDAO = new TrainingRoomDAO();
	TrainingNameDAO tNameDAO = new TrainingNameDAO();
	ProcessDAO pDAO = new ProcessDAO();
	RelationFieldDAO rfDAO = new RelationFieldDAO();
	ProcessFieldDAO pfDAO = new ProcessFieldDAO();
	ProcessStateDAO psDAO = new ProcessStateDAO();
	
	ArrayList<Member> mList = new ArrayList<Member>();
	ArrayList<Training> trList = new ArrayList<Training>();
	ArrayList<Process> pList = new ArrayList<Process>();
	ArrayList<RelationField> rfList = new ArrayList<RelationField>();
	ArrayList<ProcessField> pfList = new ArrayList<ProcessField>();
	ArrayList<ProcessState> psList = new ArrayList<ProcessState>();
	
	pList = pDAO.getData(Integer.parseInt(request.getParameter("prNo")));
	pfList = pfDAO.getList(Integer.parseInt(request.getParameter("prNo")));
%>
<div class="container"><!-- 틀  -->
    <div class="article"><!-- 내용 -->
        <div class="article-mark"><!-- 북마크 -->
            <img src="./images/bookmark1.png" class="bookmark-img">
            <span class="bookmark-text">TRAINING</span>
        </div><!-- 북마크 끝 -->
        <button class="btn-move" id="btn-move-one" type="button" onclick="movePage('TrainingDefine.jsp');">옵션 추가하기</button>  <!-- 옵션 추가하기 -->
        <button class="btn-move" id="btn-move-two" type="button" onclick="movePage('TrainingBeginConfig.jsp');">개강 확인하기</button>  <!-- 개강 확인하기 -->
        <div class="article-mark-move"><!-- MEMBER 페이지 이동 -->
            <a href="MemberJoin.jsp" class="mark-move" id="mark-move-one">
                <img src="./images/bookmark2.png" class="mark-move-img">
                <span class="mark-move-text">MEMBER</span>
            </a>
        </div><!-- MEMBER 페이지 이동 끝 -->
        <div class="article-mark-move"><!-- Student 페이지 이동 -->
            <a href="StudentDefine.jsp" class="mark-move" id="mark-move-two">
                <img src="./images/bookmark2.png" class="mark-move-img">
                <span class="mark-move-text">STUDENT</span>
            </a>
        </div><!-- Student 페이지 이동 끝 -->
        <div class="article-mark-move"><!-- 메인 페이지 이동 -->
            <a href="../Main.jsp" class="mark-move" id="mark-move-three">
                <img src="./images/bookmark3.png" class="mark-move-img">
                <span class="mark-move-text">HOME</span>
            </a>
        </div><!-- 메인 페이지 이동 끝 -->
        
        <div class="content" id="first-box"><!-- 수정 폼 -->
            <div class="content-comment">
                <img src="./images/comment.png" class="comment-img">
                <span class="comment-text">수정</span>
            </div>
            <form name="tbUpdate" action="TrainingBeginUpdateActive.jsp" method="post"><!-- 수정 양식 -->
	            <table class="begin-table">
	                <tr>
	                    <td class="begin-label">
	                        <label for="trType">훈련구분</label>
	                    </td>
	                    <td>
	                        <select class="begin-component-select" name="trType">
			                	<option>훈련구분 선택</option>
			                	<%
									trList = tTypeDAO.getList();
								
									for(int i = 0; i < trList.size(); i++){
										if(trList.get(i).getTrType().equals(pList.get(0).getTrType())){			//훈련구분 목록
								%>
											<option value="<%=trList.get(i).getTrType() %>" selected><%=trList.get(i).getTrType() %></option>
								<%		
										}else{
								%>
											<option value="<%=trList.get(i).getTrType() %>"><%=trList.get(i).getTrType() %></option>
								<%		}
									}
								%>
	                        </select>
	                    </td>
	                    <td	class="begin-label">
	                    	<label for="prStateName">훈련상태</label>
	                    </td>
	                    <td>
	                    	<select class="begin-component-select" name="prStateName">
	                    		<option></option>
	                    		<%
	                    			psList = psDAO.getList();
	                    			
	                    			for(int i = 0; i < psList.size(); i++){			//훈련상태 목록
	                    				if(psList.get(i).getPrStateName().equals(pList.get(0).getPrStateName())){
	                    		%>
	                    					<option value="<%=psList.get(i).getPrStateName()%>" selected><%=psList.get(i).getPrStateName()%></option>
	                    		<%		
	                    				}else{
	                    		%>
	                    					<option value="<%=psList.get(i).getPrStateName()%>"><%=psList.get(i).getPrStateName()%></option>
	                    		<% 		}
	                    			}
	                    		%>
	                    	</select>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="begin-label">
	                        <label for="trName">훈련명</label>
	                    </td>
	                    <td>
	                        <select class="begin-component-select" name="trName">
	                        	<option>훈련명 선택</option>
	                        	<%
									trList = tNameDAO.getList();
							
									for(int i = 0; i < trList.size(); i++){			//훈련명 목록
										if(trList.get(i).getTrName().equals(pList.get(0).getTrName())){
								%>
											<option value="<%=trList.get(i).getTrName() %>" selected><%=trList.get(i).getTrName() %></option>
								<%		
										}else{
								%>
											<option value="<%=trList.get(i).getTrName() %>"><%=trList.get(i).getTrName() %></option>
								<%		}
									}
								%>
	                        </select>
	                    </td>
	                    <td class="begin-label">
	                        <label for="memId">담당교사</label>
	                    </td>
	                    <td>
	                        <select class="begin-component-select" name="memId">
	                        	<%
									mList = mDAO.getListDep("교사");
	                        		
									for(int i = 0; i < mList.size(); i++){				//담당교사목록 (교사만)
										String str = mList.get(0).getMemTel();
										String divis = "[-]";
										String[] tel = str.split(divis);
										
										if(mList.get(i).getMemId().equals(pList.get(0).getMemId())){
								%>
											<option value="<%=mList.get(i).getMemId()%>" selected><%=mList.get(i).getMemName() + "(" + tel[2] + ")"%></option>
								<%			
										}else{
								%>
											<option value="<%=mList.get(i).getMemId() %>"><%=mList.get(i).getMemName() + "(" + tel[2] + ")"%></option>
								<%		}
									}
								%>
	                        </select>
	                    </td>
	                </tr>
	                <%
	                	String totalDate = pList.get(0).getPrDate();
	                	String divisDate = "/";
	                	String[] date = totalDate.split(divisDate);
	                %>
	                <tr>
	                    <td class="begin-label">
	                        <label for="sDate">개강일</label>
	                    </td>
	                    <td>
	                        <input class="begin-component-text" type="text" name="sDate" placeholder="ex. 2017-01-01" maxlength="10" value="<%=date[0]%>">
	                    </td>
	                    <td class="begin-label">
	                        <label for="eDate">수료일</label>
	                    </td>
	                    <td>
	                        <input class="begin-component-text" type="text" name="eDate" placeholder="ex. 2017-01-01" maxlength="10" value="<%=date[1]%>">
	                    </td>
	                </tr>
	                <tr>
	                    <td class="begin-label">
	                        <label for="prQueta">과정정원</label>
	                    </td>
	                    <td>
	                        <input class="begin-component-text" type="text" name="prQueta" placeholder="숫자만 기입" maxlength="3" value="<%=pList.get(0).getPrQueta()%>">
	                    </td>
	                    <td class="begin-label">
	                        <label for="trRoom">교육실</label>
	                    </td>
	                    <td>
	                        <select class="begin-component-select" name="trRoom">
	                        	<option>교육실 선택</option>
	                        	<%
									trList = tRoomDAO.getList();
								
									for(int i = 0; i < trList.size(); i++){			//교육실 목록
										if(trList.get(i).getTrRoom().equals(pList.get(0).getTrRoom())){
								%>
											<option value="<%=trList.get(i).getTrRoom() %>" selected><%=trList.get(i).getTrRoom() %></option>
								<%			
										}else{
								%>
											<option value="<%=trList.get(i).getTrRoom() %>"><%=trList.get(i).getTrRoom() %></option>
								<%		}
									}
								%>
	                        </select>
	                    </td>
	                </tr>
	                <tr>
	                	<td class="begin-label">
                			<label for="fName">관련분야</label>
	                	</td>
	                	<td colspan=3>
	                		<%
	                			rfList = rfDAO.getList();
                					
	                			for(int i = 0; i < rfList.size(); i++){			//관련 분야 목록
	                				int check = 0;
	                				
	                				if( i % 6 == 0){
	                					out.print("<br>");
	                				}
	                				
	                				for(int j = 0; j < pfList.size(); j++){
	                					if(rfList.get(i).getfName().equals(pfList.get(j).getfName())){
	                						check = 1;
	                		%>
	                						<input class="begin-component-checkbox" name="fName" type="checkbox" value="<%=rfList.get(i).getfName() %>" checked><%=rfList.get(i).getfName() %>
	                		<%			}
	                				}
	                				
	                				if(check == 0){
	                		%>
	                						<input class="begin-component-checkbox" name="fName" type="checkbox" value="<%=rfList.get(i).getfName() %>"><%=rfList.get(i).getfName() %>
	                		<%		}
	                			}
	                		%>
	                	</td>
	                </tr>
	                <tr>
	                	<td colspan=4>
	                		<input type="hidden" name="prNo" value="<%=request.getParameter("prNo") %>">
			            	<input class="begin-submit" id="begin-sbmit-update" type="submit" value="수정">
	                	</td>
	                </tr>
	                <tr>
	                	<td>
			            	<input class="begin-submit" id="begin-submit-delete" type="button" value="제거" onclick="deleteEvent('TrainingBeginDeleteActive.jsp','prNo','<%=request.getParameter("prNo")%>');">
			            </td>
	                </tr>
	            </table>
           	</form><!-- 수정 양식 끝 -->
        </div><!-- 수정 폼 끝 -->
    </div><!-- 내용 끝 -->
</div><!-- 틀 끝 -->
</body>
</html>