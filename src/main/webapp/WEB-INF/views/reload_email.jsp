<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 전달받은 오류메시지(msg) 출력 후 이전페이지로 돌아가기 --%>
<script>
	var msg ='${msg}';
	var msg2 ='${msg2}';
	var url ='${url}';
	if(msg == "임시 비밀번호가 발송되었습니다." && msg2 == "이메일을 확인한 후 다시 로그인 하시길 바랍니다!"){
		alert(msg);
		alert(msg2);
		history.back();
	}else if(msg == "올바르지 않은 회원 정보입니다!"){
		alert(msg);
		history.back();
	}
</script> 