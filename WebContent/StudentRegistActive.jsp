<!-- DB. 훈련생 등록 -->
<%@page import="training.Process"%>
<%@page import="training.ProcessDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="student.LicenseDAO" %>
<%@ page import="student.StudentDAO" %>
<%@ page import="training.RegProcessDAO" %>
<%@	page import="utilMade.PatternCheck"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="st" class="student.Student" scope="page" />
<script src="./js/Intra.js"></script>

<%
	StudentDAO stDAO = new StudentDAO();
	ProcessDAO pDAO = new ProcessDAO();
	ArrayList<Process> pList = new ArrayList<Process>();
	
	PatternCheck pc = new PatternCheck();
	String saveFolder = "/upload/img";					//상대경로
	String realFolder = "";								//어플리케이션.절대경로	
	String encType = "UTF-8";							//인코드타입
	int maxSize = 1024 * 1024 * 1024;					//최대사이즈
	
	//컬럼 속성
	String attribute[] = { "memId", "stImg", "stName", "stTyName", "paName", "stStateName", "stPwd", "tel1", "tel2", "tel3", "stBirth", "stAddr", "stCharacter", "stResume" };
	String liName = "";									//자격증 명
	int stNo = 0;										//훈련생 인덱스 번호	
	int prNo = 0;										//과정 인덱스 번호
	int check = 0;										//양식이 비어있는지 확인
	int pattern = 0;									//양식에 맞는지 확인
	
	ServletContext context = getServletContext();
	realFolder = context.getRealPath(saveFolder);
	
	File targetDir = new File(realFolder);
	File file = null;
	
	if(!(targetDir.exists())){
		targetDir.mkdirs();
	}
	
	try{
		MultipartRequest upload = null;
		
		upload = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		
		Enumeration<?> params = upload.getParameterNames();			//type="fiel"을 제외한 type
		
		while(params.hasMoreElements()){
			String name = (String)params.nextElement();
			String value = upload.getParameter(name);
			
			if(attribute[0].equals(name)){st.setMemId(value);}
			if(attribute[2].equals(name)){st.setStName(value);}
			if(attribute[3].equals(name)){st.setStTyName(value);}
			if(attribute[4].equals(name)){st.setPaName(value);}
			if(attribute[5].equals(name)){st.setStStateName(value);}
			if(attribute[6].equals(name)){st.setStPwd(value);}
			if(attribute[7].equals(name)){st.setTel1(value);}
			if(attribute[8].equals(name)){st.setTel2(value);}
			if(attribute[9].equals(name)){st.setTel3(value);}
			if(attribute[10].equals(name)){st.setStBirth(value);}
			if(attribute[11].equals(name)){st.setStAddr(value);}
			if(attribute[12].equals(name)){st.setStCharacter(value);}
			if(attribute[13].equals(name)){st.setStResume(value);}
			if(name.equals("liName")){liName = value;}
			if(name.equals("prNo")){prNo = Integer.parseInt(value);}
			if(name.equals("stNo")){stNo = Integer.parseInt(value);}
			
			if(!(name.equals("liName")))if(value.equals(""))check++;	//자격증을 제외한 나머지 파라미터 중 값이 비어있는지 확인
		}
		
		pList = pDAO.getData(prNo);
				
		if(stDAO.getTotalType(prNo, "총원") >= pList.get(0).getPrQueta()){
		%>
			<script>
				failEvent('인원 초과');
			</script>
		<%
		}
		
		Enumeration<?> files = upload.getFileNames();				//type="file"만
		
		while(files.hasMoreElements()){
			String name = (String)files.nextElement();
			String filename = upload.getFilesystemName(name);
			
			if(attribute[1].equals(name)){st.setStImg(filename);}
			
			if(check > 0){			//파라미터 값이 비어있으면 실행
				//방금 업로드 이미지 파일 삭제
				String save = "/upload/img/";
				save += filename;
				realFolder = context.getRealPath(save);
				
				file = new File(realFolder);
				
				if(file.exists())file.delete();		//파일 확인. 있으면 제거
%>
				<script>
					failEvent('양식이 비어있습니다.');
				</script>
<%
			}else if(!(pc.checkDate(st.getStBirth())) ||
						!(pc.examination(st.getTel1())) ||
						!(pc.examination(st.getTel2())) ||
						!(pc.examination(st.getTel3()))){			//패턴 확인
				//방금 업로드 이미지 파일 삭제
				String save = "/upload/img/";
				save += filename;
				realFolder = context.getRealPath(save);
				
				file = new File(realFolder);
				
				if(file.exists())file.delete();		//파일 확인. 있으면 제거
%>
				<script>
					failEvent('ERROR : 정해진 양식대로 작성');
				</script>
<%
			}
		}
		
		st.setStNo(stNo);
		
		int result = stDAO.createStudent(st);
		
		if(result == -2){
%>
			<script>
				failEvent('데이터베이스 오류(훈련생 생성)');
			</script>
<%
		}else{
			//수강 과정 등록
			RegProcessDAO rpDAO = new RegProcessDAO();
			result = rpDAO.createRegPro(st.getStNo(), prNo);
			
			if(result == -2){
%>
				<script>
					failEvent('데이터베이스 오류(과정연관)');
				</script>
<%
			}else{
				//자격증 등록
				LicenseDAO lDAO = new LicenseDAO();
				
				result = lDAO.createLicense(st.getStNo(), liName);

				if(result == -2){
					stDAO.deleteStudent(st.getStNo());
					lDAO.deleteLicense(st.getStNo());
					rpDAO.deleteRegPro(st.getStNo(), prNo);
%>
					<script>
						failEvent('데이터베이스 오류(자격증)');
					</script>
<%
				}else{
%>
					<script>
						sucessEvent('생성 완료','StudentRegist.jsp');
					</script>
<%
				}
			}
		}
	}catch(Exception e){
%>
		<script>
			failEvent('ERROR !!');
		</script>
<%
	}
%>
<script>
	failEvent('ERROR !!');
</script>