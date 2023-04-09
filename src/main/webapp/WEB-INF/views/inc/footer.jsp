<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<%-- <link href="${path}/resources/css/main.css" rel="stylesheet"> --%>
<%-- <link href="${path}/resources/css/main.css" rel="stylesheet"> --%>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
<style type="text/css">
	
	.footerArea {
		font-family: "Noto Sans KR", sans-sef;
		
	}
	
	.footerContent {
		padding: 30px;
	}
	
	h4 {
		display: inline-block;
		font-size: 25px;
	}
	
	footer {
		background-color: #FBFBFB;
		height: 300px;
		width: 100%;
     	position: relative; 
/* 		transform : translateY(-100%); */
		}
/* 	html, body { */
/*     height: 100% */
/* 	} */

	


</style>

<footer>
    <div class="footerArea"> 
      <div class="footerContent">
        <h4 style="font-family: 'Bebas Neue';">SHOOKREAM</h4><br>
        <p><i class="fa fa-fw fa-map-marker"></i> 부산광역시 부산진구 부전동 동천로 109 삼한골드게이트 7층</p>
        <p><i class="fa fa-fw fa-phone"></i> 051-803-0909</p>
        <p><i class="fa fa-fw fa-envelope"></i> shookream@shookream.com</p>
        <p><i class ="fa fa-fw fa-black-tie"></i> 대표자명: TEAM_3 &nbsp; 
        <p><i class ="fa fa-fw fa-id-card"></i> 사업자등록번호: 111-11-11111&nbsp; |  &nbsp;통신판매업신고: 부산 00001호</p>
        <i class="fa fa-facebook-official w3-hover-opacity w3-large"></i>&nbsp;
        <i class="fa fa-instagram w3-hover-opacity w3-large"></i>&nbsp;
        <i class="fa fa-pinterest-p w3-hover-opacity w3-large"></i>&nbsp;
        <i class="fa fa-twitter w3-hover-opacity w3-large"></i>
      </div> 
    </div>
</footer>