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
	}
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
		}
	}else{
		return;
	}
}

//submit
//param : form ID, comment : 설명
function submitDeleteEvent(param, comment){
	var formId = document.getElementById(param);
	
	if(confirm(comment) == true){
		formId.submit();
	}else{
		return;
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


