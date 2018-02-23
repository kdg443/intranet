<!-- 과정 목록 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="training.Process" %>
<%@ page import="training.ProcessDAO" %>
<%@ page import="java.util.ArrayList" %>
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
    	.content
    	{
    		border: none;
    	}
    	.article
    	{
    		height: 900px;
    	}
        #begin-config
        {
            top: 150px;
            left: 50px;
            width: 700px;
            height: 420px;
        }
        .begin-thead
        {
            background-color: #0076ff;
            font-size: 15px;
            text-align: center;
            color: white;
        }
        .begin-title
        {
            height: 30px;
        }
        .begin-content-text-move
        {
        	text-decoration: none;
        	color: black;
        }
        .begin-content-odd
        {
            text-align: center;
            height: 30px;
        }
        .begin-content-even
        {
        	background-color: lightgrey;
        	text-align: center;
        	height: 30px;
        }
        .begin-content-btn-div
        {
        	background-color: #0076ff;
        	position: absolute;
        	border-bottom: 5px solid grey;
        	border-radius: 5px;
        	width: 80px;
        	height: 40px;
        	transition: all 0.1s;
        }
        .begin-content-btn-div:hover
        {
        	transform: translateY(3px);
        	border-bottom: 2px solid grey;
        }
        .begin-content-btn-text
        {
        	position: absolute;
        	top: 10px;
        	left: 20px;
        	text-decoration: none;
        	font-size: 18px;
        	font-weight: bold;
        	color: white;
        }
        #begin-content-btn-next
        {
        	right: 0px;
        }
        #begin-content-btn-before
        {
        	left: 0px;
        }
        .begin-context-now
        {
        	font-size: 25px;
        	color: #0076ff;
        }
    </style>
</head>
<body>
<%
	int pageNumber = 1;

	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	
	ProcessDAO pDAO = new ProcessDAO();
	ArrayList<Process> pList = new ArrayList<Process>();
%>
<div class="container"><!-- 틀  -->
    <div class="article"><!-- 내용 -->
        <div class="article-mark"><!-- 북마크 -->
            <img src="./images/bookmark1.png" class="bookmark-img">
            <span class="bookmark-text">TRAINING</span>
        </div><!-- 북마크 끝 -->
        <button class="btn-move" id="btn-move-one" type="button" onclick="movePage('TrainingDefine.jsp');">옵션 추가하기</button>  <!-- 옵션 추가하기 -->
        <button class="btn-move" id="btn-move-two" type="button" onclick="movePage('TrainingBegin.jsp');">과정 개설하기</button>  <!-- 과정 개설하기 -->
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

        <div class="content" id="begin-config"><!-- 과정 목록 -->
            <div class="content-comment">
                <img src="./images/comment.png" class="comment-img">
                <span class="comment-text">현황</span>
            </div>
            <table class="">
                <thead class="begin-thead">
                    <tr class="begin-title">
                        <th width="70">
                            No
                        </th>
                        <th width="420">
                         	훈련명
                        </th>
                        <th width="110">
                         	기간
                        </th>
                        <th width="100">
                      		과정상태
                        </th>
                    </tr>
                </thead>
                <tbody><!-- 내용 -->
				<%
					int totalRecord = pDAO.totalRecord();					//총레코드 수
					int numPerPage = 10;									//페이지 당 게시물 출력 수
					int pagePerBlock = 10;									//페이지 당 블록 수
					
					//총 페이지 수
					int totalPage = (totalRecord / numPerPage) + ((totalRecord % numPerPage) > 0? 1 : 0);
					
					//총 블록 수d
					int totalBlock = (totalRecord / (numPerPage * pagePerBlock));
					totalBlock += (totalRecord % (numPerPage * pagePerBlock)) > 0? 1 : 0;
					
					//현재 블록
					int nowBlock = 1;
					if(request.getParameter("nowBlock") != null)
						nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
					
					//시작 게시물 번호
					int beginPerPage = totalRecord - ((pageNumber - 1) * numPerPage);
					
					pList = pDAO.processList(beginPerPage, numPerPage);
					
					//마지막 블록 수
					int numEndBlock = (pagePerBlock * nowBlock);
					
					//첫 블록 수
					int numStartBlock = numEndBlock - (pagePerBlock - 1);
					
					String[] style = { "odd", "even"};
					
					for(int i = 0; i < pList.size(); i++){			//cols배경.	홀수 : 흰색, 짝수 : 회색
						String totalDate = pList.get(i).getPrDate();
						String divisDate = "/";
						String[] date = totalDate.split(divisDate);
				%>
						<tr class="begin-content-<%=style[i % 2] %>">
							<td><%=pList.get(i).getPrNo()%></td>
							<td style="text-align: left;"><a class="begin-content-text-move" href="TrainingBeginUpdate.jsp?prNo=<%=pList.get(i).getPrNo()%>"><%="[" + pList.get(i).getTrType() + "]" + pList.get(i).getTrName()%></a></td>
							<td><%=date[0] + "<br>" + date[1] %></td>
							<td><%=pList.get(i).getPrStateName() %></td>
						</tr>
				<%		
					}
				%>
					<tr>
						<td colspan=4 style="text-align: center;">	<!-- 이전 10개 페이지 확인 -->
						<%
							if(nowBlock != 1 && nowBlock > 0){
						%>
								<a class="begin-content-text-move" href="TrainingBeginConfig.jsp?nowBlock=<%=nowBlock - 1 %>&pageNumber=<%=numEndBlock - (pagePerBlock + 1)%>">[ 이전 10개 ]</a>
						<%
							}
						
							for(int i = numStartBlock; i <= numEndBlock; i++){	//페이지 번호
								if(totalPage >= i){
									if(pageNumber == i){	//페이징 목록과 현제 페이지 비교
						%>
										<span class="begin-context-now"><%=i %></span>
						<%
									}else{
						%>
										<a class="begin-content-text-move" href="TrainingBeginConfig.jsp?nowBlock=<%=nowBlock%>&pageNumber=<%=i %>"><%="[" + i + "]" %></a>
						<%			}
								}
							}
						
							if(totalBlock > nowBlock){		// 다음 10개 페이지 확인
						%>
								<a class="begin-content-text-move" href="TrainingBeginConfig.jsp?nowBlock=<%=nowBlock + 1 %>&pageNumber=<%=numEndBlock + 1%>">[ 다음 10개 ]</a>
						<%
							}
						%>
						</td>
					</tr>
					<tr><td colspan=4 style="height: 100px;"></td></tr>	<!-- 공백 -->
				</tbody>
            </table>
        </div><!-- 과정 목록 끝 -->
    </div><!-- 내용 끝 -->
</div><!-- 틀 끝 -->
</body>
</html>