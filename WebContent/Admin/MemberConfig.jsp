<!-- 직원 목록 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.Member" %>
<%@ page import="member.MemberDAO" %>
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
    	.article
    	{
    		height: 700px;
    	}
    	.content
    	{
    		border: none;
    	}
        #member-config
        {
            top: 150px;
            left: 50px;
            width: 700px;
            height: 420px;
        }
        .member-thead
        {
            background-color: #0076ff;
            font-size: 15px;
            text-align: center;
            color: white;
        }
        .member-title
        {
            height: 35px;
        }
        .member-content-text-move
        {
        	text-decoration: none;
        	color: black;
        }
        .member-content-odd
        {
            text-align: center;
            height: 30px;
        }
        .member-content-even
        {
        	background-color: lightgrey;
        	text-align: center;
        	height: 30px;
        }
        .member-context-now
        {
        	font-size: 25px;
        	color: #0076ff;
        }
    </style>
</head>
<body>
<%
	int pageNumber = 1;		//현재 페이지 번호

	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	
	MemberDAO mDAO = new MemberDAO();
	ArrayList<Member> mList = new ArrayList<Member>();
%>
<div class="container"><!-- 틀  -->
    <div class="article"><!-- 내용 -->
        <div class="article-mark"><!-- 북마크 -->
            <img src="./images/bookmark1.png" class="bookmark-img">
            <span class="bookmark-text">MEMBER</span>
        </div><!-- 북마크 끝 -->
        <button class="btn-move" id="btn-move-one" type="button" onclick="movePage('MemberJoin.jsp');">멤버 추가하기</button>  <!-- 이전 페이지로 이동 -->
        <div class="article-mark-move"><!-- TRANING 페이지 이동 -->
            <a href="TrainingDefine.jsp" class="mark-move" id="mark-move-one">
                <img src="./images/bookmark2.png" class="mark-move-img">
                <span class="mark-move-text">TRAINING</span>
            </a>
        </div><!-- TRAINING 페이지 이동 끝 -->
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
        
        <div class="content" id="member-config"><!-- 직원 목록 -->
            <div class="content-comment">
                <img src="./images/comment.png" class="comment-img">
                <span class="comment-text">현황</span>
            </div>
            <table>
                <thead class="member-thead">	<!-- 700px -->
                    <tr>
                        <th class="member-title" width="100">
                            No
                        </th>
                        <th class="member-title" width="100">
                         	부서
                        </th>
                        <th class="member-title" width="250">
                         	이름	<!-- 이름 + ID -->
                        </th>
                        <th class="member-title" width="250">
                      		전화번호
                        </th>
                    </tr>
                </thead>
                <tbody><!-- 내용 -->
				<%
					int totalRecord = mDAO.totalRecord();					//총레코드 수
					int numPerPage = 10;									//페이지 당 게시물 출력 수
					int pagePerBlock = 10;									//페이지 당 블록 수
					
					//총 페이지 수
					int totalPage = (totalRecord / numPerPage) + ((totalRecord % numPerPage) > 0? 1 : 0);
					
					//총 블록 수
					int totalBlock = (totalRecord / (numPerPage * pagePerBlock));
					totalBlock += (totalRecord % (numPerPage * pagePerBlock)) > 0? 1 : 0;
					
					//현재 블록
					int nowBlock = 1;
					if(request.getParameter("nowBlock") != null)
						nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
					
					//시작 게시물 번호
					int beginPerPage = totalRecord - ((pageNumber - 1) * numPerPage);
					
					mList = mDAO.boardList(beginPerPage, numPerPage);
					
					//마지막 블록 수
					int numEndBlock = (pagePerBlock * nowBlock);
					
					//첫 블록 수
					int numStartBlock = numEndBlock - (pagePerBlock - 1);
					
					String[] style = { "odd", "even"};
					
					for(int i = 0; i < mList.size(); i++){			//cols배경.	홀수 : 흰색, 짝수 : 회색
				%>
						<tr class="member-content-<%=style[i % 2] %>">
							<td><%=mList.get(i).getMemNo()%></td>
							<td><%=mList.get(i).getDepName() %></td>
							<td><a class="member-content-text-move" href="MemberUpdate.jsp?memId=<%=mList.get(i).getMemId() %>"><%=mList.get(i).getMemName() + "[" + mList.get(i).getMemId() + "]" %></a></td>
							<td><%=mList.get(i).getMemTel() %></td>
						</tr>
				<%		
					}
				%>
					<tr>
						<td colspan=4 style="text-align: center;">	<!-- 이전 10개 페이지 확인 -->
						<%
							if(nowBlock != 1 && nowBlock > 0){
						%>
								<a class="member-content-text-move" href="MemberConfig.jsp?nowBlock=<%=nowBlock - 1 %>&pageNumber=<%=numEndBlock - (pagePerBlock + 1)%>">[ 이전 10개 ]</a>
						<%
							}
						
							for(int i = numStartBlock; i <= numEndBlock; i++){	//페이지 번호
								if(totalPage >= i){
									if(pageNumber == i){	//페이징 목록과 현제 페이지 비교
						%>
										<span class="member-context-now"><%=i %></span>
						<%
									}else{
						%>
										<a class="member-content-text-move" href="MemberConfig.jsp?nowBlock=<%=nowBlock%>&pageNumber=<%=i %>"><%="[" + i + "]" %></a>
						<%			}
								}
							}
						
							if(totalBlock > nowBlock){		// 다음 10개 페이지 확인
						%>
								<a class="member-content-text-move" href="MemberConfig.jsp?nowBlock=<%=nowBlock + 1 %>&pageNumber=<%=numEndBlock + 1%>">[ 다음 10개 ]</a>
						<%
							}
						%>
						</td>
					</tr>
					<tr><td colspan=4 style="height: 100px;"></td></tr>	<!-- 공백 -->
				</tbody>
			</table>
        </div><!-- 직원 목록 끝 -->
    </div><!-- 내용 끝 -->
</div><!-- 틀 끝 -->
</body>
</html>