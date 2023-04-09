<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 전달받은 오류메시지(msg) 출력 후 이전페이지로 돌아가기 --%>
<script>
	var msg ='${msg}';
	var url ='${url}';
	if(msg == "이미 작성하신 리뷰가 존재합니다!"){
		alert(msg);
		history.back();
	}else if(msg == "리뷰 작성 실패!"){
		alert(msg);
		history.back();
	}else if(msg == "삭제 되었습니다!"){
		alert(msg);
		location.href= url;
	}else if(msg =="삭제 실패했습니다!"){
		alert(msg);
		history.back();
	}else {
		alert(msg);
		window.close();
	}
</script> 