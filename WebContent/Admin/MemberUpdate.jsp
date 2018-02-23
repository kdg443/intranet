<!-- 직원 정보 수정 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.Dep" %>
<%@ page import="member.DepDAO" %>
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
    		height: 500px;
    	}
        #first-box
        {
            top: 150px;
            left: 50px;
            width: 700px;
            height: 320px;
        }
        .member-table
        {
            position: absolute;
            top: 10px;
            left: 15px;
        }
        .member-label
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
        .member-component-btn
        {
        	background-color: #0076ff;
        	border: none;
        	width: 100px;
        	height: 25px;
        	font-weight: bold;
        	color: white;
        }
        .member-component-select
        {
            width: 214px;
            height: 30px;
            letter-spacing: 1px;
        }
        .member-component-text
        {
            width: 210px;
            height: 25px;
            letter-spacing: 1px;
        }
        #member-component-tel
        {
            width: 100px;
        }
        .member-component-file
        {
        	text-decoration: none;
        }
        .member-submit
        {
            position: absolute;
            background-color: #0076ff;
            border: none;
            width: 660px;
            height: 35px;
            font-size: 20px;
            font-weight: bold;
            text-align: center;
            letter-spacing: 3px;
            color: white;
        }
        #member-submit-update
        {
        	top: 210px;
        }
        #member-submit-delete
        {
        	left: 18px;
        	top: 260px;
        }
    </style>
</head>
<body>
<%	
	DepDAO dDAO = new DepDAO();
	MemberDAO mDAO = new MemberDAO();
	
	ArrayList<Dep> dList = new ArrayList<Dep>();
	ArrayList<Member> mList = new ArrayList<Member>();
	
	dList = dDAO.getList();
	mList = mDAO.getList(request.getParameter("memId"));
%>
<div class="container"><!-- 틀  -->
    <div class="article"><!-- 내용 -->
        <div class="article-mark"><!-- 북마크 -->
            <img src="./images/bookmark1.png" class="bookmark-img">
            <span class="bookmark-text">MEMBER</span>
        </div><!-- 북마크 끝 -->
        <button class="btn-move" id="btn-move-one" type="button" onclick="movePage('MemberJoin.jsp');">멤버 추가하기</button>  <!-- 멤버 추가하기 -->
        <button class="btn-move" id="btn-move-two" type="button" onclick="movePage('MemberConfig.jsp');">멤버 확인하기</button>  <!-- 멤버 확인하기 -->
        <div class="article-mark-move"><!-- Training 페이지 이동 -->
            <a href="TrainingDefine.jsp" class="mark-move" id="mark-move-one">
                <img src="./images/bookmark2.png" class="mark-move-img">
                <span class="mark-move-text">TRAINING</span>
            </a>
        </div><!-- Training 페이지 이동 끝 -->
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
        
       	<div class="content" id="first-box"><!-- 멤거 수정 폼 -->
            <div class="content-comment"><!-- 멤버 주석 -->
                <img src="./images/comment.png" class="comment-img">
                <span class="comment-text">멤버</span>
            </div><!-- 멤버 주석 끝 -->
            <form action="MemberUpdateActive.jsp" method="post">
            	<input type="hidden" name="memNo" value="<%=mList.get(0).getMemNo() %>">
                <table class="member-table"><!-- 멤버 수정 양식 -->
                    <tr>
                        <td class="member-label">
                            <label for="memId">아이디</label>
                        </td>
                        <td>
                        	<input type="hidden" name="memId" value="<%=mList.get(0).getMemId()%>">
                            <%=mList.get(0).getMemId()%>
                        </td>
                        <td class="member-label">
                            <label for="depName">부서</label>
                        </td>
                        <td>
                            <select class="member-component-select" name="depName">
                            	<option></option>
                            	<%for(int i = 0; i < dList.size(); i++){
                            			if(dList.get(i).getDepName().equals(mList.get(0).getDepName())){
                            	%>
                            				<option value="<%=dList.get(i).getDepName() %>" selected><%=dList.get(i).getDepName() %></option>
                            	<%
                            			}else{
                            	%>
		                    				<option value="<%=dList.get(i).getDepName() %>"><%=dList.get(i).getDepName() %></option>
		                    	<%		}
		                    		} 
		                    	%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="member-label">
                            <label for="memPwd">비밀번호</label>
                        </td>
                        <td>
                            <input class="member-component-text" name="memPwd" type="password" placeholder="비밀번호" maxlength="20" value="<%=mList.get(0).getMemPwd()%>">
                        </td>
                        <td class="member-label">
                        	<label for="memAdmin">권한</label>
                        </td>
                        <td>
                        	<select name="memAdmin">
                       		<%
                       			if(mList.get(0).getMemAdmin() == 0){
                       		%>
                       				<option value="0" selected>X</option>
                       				<option value="1">O</option>
                       		<%
                       			}else if(mList.get(0).getMemAdmin() == 1){
                       		%>
                       				<option value="0">X</option>
                       				<option value="1" selected>O</option>
                       		<%
                       			}
                       		%>
                        	</select>
                        </td>
                    </tr>
                    <tr>
                        <td class="member-label">
                            <label for="memName">이름</label>
                        </td>
                        <td colspan=2>
                            <input class="member-component-text" name="memName" type="text" placeholder="이름" maxlength="10" value="<%=mList.get(0).getMemName()%>">
                        </td>
                    </tr>
                    <tr>
                        <td class="member-label">
                            <label>전화번호</label>
                        </td>
                        <td colspan="3">
                            <select class="member-component-select" id="member-component-tel" name="tel1">
                            <%
                            	String totalTel = mList.get(0).getMemTel();
                            	String divis = "[-]";
                            	String[] tel = totalTel.split(divis);
                            	
                            	if(tel[0].equals("010")){
                            %>
                            		<option value="010" selected>010</option>
                                	<option value="011">011</option>
                                	<option value="017">017</option>
                           	<%
                            	}else if(tel[0].equals("011")){
                            %>
                            	<option value="010">010</option>
                            	<option value="011" selected>011</option>
                            	<option value="017">017</option>
                            <%
                            	}else if(tel[0].equals("017")){
                            %>
                            	<option value="010">010</option>
                            	<option value="011">011</option>
                            	<option value="017" selected>017</option>
                            <%
                            	}
                            %>
                            </select> -
                            <input class="member-component-text" id="member-component-tel" type="text" name="tel2" placeholder="두번째 자리" maxlength="4" value="<%=tel[1]%>"> -
                            <input class="member-component-text" id="member-component-tel" type="text" name="tel3" placeholder="세번째 자리" maxlength="4" value="<%=tel[2]%>">
                        </td>
                    </tr>
                    <tr>
                    	<td class="member-label">
                    		<input name="memResume" type="hidden" value="<%=mList.get(0).getMemResume()%>">
                    		<label for="memResume">이력서</label>
                    	</td>
                    	<td colspan=3>
                    		<%
                    			String dirMember = "/upload/member";				//상대경로
                    			String real = "";									//어플리케이션.절대경로
                    			
                    			ServletContext context = getServletContext();
                    			real = context.getRealPath(dirMember);
                    			
                    			File targetDir = new File(real);
                    			
                    			if(targetDir.exists()){		//폴더 확인
                    				if(mList.get(0).getMemResume() != null){		//이력서 확인
	                    				String dir = application.getRealPath("/upload/member/");
	                    				String[] files = new File(dir).list();
	                    				
	                    				for(String file : files){		//이력서 파일 다운로드 링크
	                    					if(file.equals(mList.get(0).getMemResume())){
	                    						out.write("<a href=\"" + request.getContextPath() + "/downloadAction?file=" +
	                    							java.net.URLEncoder.encode(file, "UTF-8").replace("+","%20") + "&save=member/" + "\">" + "이력서 다운로드" + "</a>");
	                    					}
	                    				}
                    				}else{
                    		%>
                    				등록된 이력서가 없습니다.
                    		<%
                    				}
                    			}else{
                    		%>
                    				폴더가 없습니다.
                    		<%
                    			}
                    		%>
                    		<!-- 이력서 수정 버튼 -->
                    		<input class="member-component-btn" type="button" onclick="movePage('MemberResume.jsp','memId','<%=request.getParameter("memId")%>');" value="갱신하기">
                    	</td>
                    </tr>
                    <tr><td colspan=4 style="height: 30px;"></td></tr>	<!-- 공백 -->
                    <tr>
                    	<td colspan=4>
                    		<input class="member-submit" id="member-submit-update" type="submit" value="수정">
                    	</td>
                    </tr>
                </table><!-- 멤버 수정 양식  끝-->
            </form>
            <form id="memDel" action="MemberDeleteActive.jsp" method="post">
       			<input type="hidden" name="memId" value="<%=mList.get(0).getMemId() %>">
       			<input class="member-submit" id="member-submit-delete" type="button" onclick="submitDeleteEvent('memDel','제거하시겠습니까?');" value="제거">
       		</form>
        </div><!-- 멤거 수정 폼 끝 -->
    </div><!-- 내용 끝 -->
</div><!-- 틀 끝 -->
</body>
</html>