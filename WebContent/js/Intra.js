//페이지 이동
//0 : 파일 이름, 1 : 파라미터 이름, 2 : 피리미터 value값
function movePage(){
	var arg = arguments;
	
	if(arg.length == 1){
		location.href=arg[0];
	}else if(arg.length == 3){
		location.href=arg[0]+"?"+arg[1]+"="+arg[2];
	}else if(arg.length == 5){
		location.href=arg[0]+"?"+arg[1]+"="+arg[2]+"&"+arg[3]+"="+arg[4];
	}else if(arg.length == 11){		//상담 기입시
		location.href=arg[0]+"?"+arg[1]+"="+arg[2]+"&"+arg[3]+"="+arg[4]+"&"+arg[5]+"="+arg[6]
		+"&"+arg[7]+"="+arg[8]+"&"+arg[9]+"="+arg[10];
	}
}

//상담기입
//0 : 상담 기입 페이지 파일 경로, 1 : method, 2 : 식별 번호
function adviceAdd(path,method,num){
	var form = document.createElement("form");
	form.setAttribute("action",path);
	form.setAttribute("method",method);
	
	var attr = ["prStateName","stNo","adComment","pageName","prNo"];
	
	for(var i = 0; i < attr.length; i++){
		var id = attr[i];
		var field = null;
		
		if( i < attr.length - 2)id+=num;
		
		if(i == 0){				//type="radio"
			field = document.getElementsByName(id);
		}else{
			field = document.getElementById(id);
		}
		
		var hidden = document.createElement("input");
		hidden.setAttribute("type","hidden");
		hidden.setAttribute("name",attr[i]);
		
		if(i == 0){			//type="radio"
			for(var j = 0; j < field.length; j++){
				if(field[j].checked){			//check 확인
					hidden.setAttribute("value",field[j].value);
				}
			}
		}else{
			hidden.setAttribute("value",field.value);
		}
		
		form.appendChild(hidden);
	}
	
	document.body.appendChild(form);
	form.submit();
}

//페이지 이동. 제거 이벤트
//0 : 파일 이름, 1 : 파라미터 이름, 2 : 피리미터 value 값
function deleteEvent(){
	var arg = arguments;
	
	if(confirm('제거하시겠습니까?') == true){
		if(arg.length == 1){
			location.href=arg[0];
		}else if(arg.length == 3){
			location.href=arg[0]+"?"+arg[1]+"="+arg[2];
		}else if(arg.length == 5){
			location.href=arg[0]+"?"+arg[1]+"="+arg[2]+"&"+arg[3]+"="+arg[4];
		}
	}else{
		return;
	}
}

//세션 만료
//0 : Comment, 1 : 파일 이름
function sessionLimit(){
	var arg = argument;
	
	if(arg.length == 2){
		alert(arg[0]);
		location.href=arg[1];
	}
}

//DB처리 실패
function failEvent(comment){
	alert(comment);
	history.back();
}

//DB처리 성공
//0 : comment, 1 : 파일 이름, 2 : 파라미터 이름, 3 : 파라미터 value 값
function sucessEvent(){
	var arg = arguments;
	
	if(arg.length == 2){
		alert(arg[0]);
		location.href=arg[1];
	}else if(arg.length == 4){
		alert(arg[0]);
		location.href=arg[1]+"?"+arg[2]+"="+arg[3];
	}
}

//StudentInfo.jsp
//버튼 클릭시 내용 출력 유무
function visible(firstId, secondId, param){
	var advice = document.getElementById(firstId);
	var apply = document.getElementById(secondId);
	
	if(param.value == '상담기록'){
		advice.style.visibility = "visible";
		apply.style.visibility = "hidden";
		param.value = '지원현황';
	}else{
		advice.style.visibility = "hidden";
		apply.style.visibility = "visible";
		param.value = '상담기록';
	}
}

//LoginInfo.jsp
//전화번호 첫번째 자리 seleted
//0 : select tag id, 1 : tag, 2 : value
function selectedTel(){
	var arg = argument;
	
	var selectId = document.getElementById(arg[0]);
	var childs = selectId.getElementsByTagName(arg[1]);
	
	for(i = 0; i < childs.length; i++){
		if(childs[i].value == arg[2]){
			childs[i].selected = true;
		}
	}
}