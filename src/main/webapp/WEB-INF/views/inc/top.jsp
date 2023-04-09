<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    

<head>
<style>
#Demo{
font-size: 70%;
}
</style>
<script src="https://kit.fontawesome.com/ca93809e69.js" crossorigin="anonymous"></script>
<script>
	function logout() {
		let isLogout = confirm("로그아웃 하시겠습니까?");
		
		if(isLogout) {
			location.href = "MemberLogout.me";
		}else{
			
		}
	}
</script>

</head>


    
<header class="w3-container w3-xlarge">
	<p class="w3-left"></p> <!-- 카테고리명 페이지마다 추가하기 -->
	<p class="w3-right">


	<!-- 로그인 드롭다운 기능! -->	
	<c:choose>
		<c:when test="${not empty sessionScope.sId }">
			<div id="logintvar" style="padding-right: 35px;">
			<i class="fa-solid fa-heart fa-sm" onclick="location.href='LikeList.ca?id=${sessionScope.sId}&member_idx=${member_idx }&pageNum=1'" style="cursor: pointer;"></i>
			<i class="fa-solid fa-cart-shopping fa-sm" onclick="location.href='CartList.ca?'" style="margin: 10px; cursor: pointer;"></i>
		 <div class="w3-dropdown-click" id="logintvar">
		 <i class="fa-solid fa-user fa-sm" onmouseover="myFunction()" onclick="location.href='MemberMyPage.me?id=${sessionScope.sId }&member_idx=${member_idx }'" style="margin: 10px;"></i>
		  <div id="Demo" class="w3-dropdown-content w3-bar-block w3-border">
		    <button type="button" class="w3-bar-item w3-button" onclick="logout()">로그아웃</button>
		    <a href="BoardList.bo" class="w3-bar-item w3-button">고객센터</a>
		    
		    <c:choose>
		    	<c:when test="${sessionScope.sId eq 'admin' }">
		    		<a href="admin.ad" class="w3-bar-item w3-button">관리자 페이지</a>
		    	</c:when>
		    </c:choose>
		    </div>
		    </div>
		    </div>
		 <div style="float: right;">
	
		</div>
		</c:when>
		<c:otherwise>
		<div id="logintvar" style="margin-right:35px;">
		
<!-- <span style="margin: 0 5px;"><i class="fa-regular fa-heart fa-xl" onclick="location.href='LikeList.ca'"></i></span> -->
			<span><i class="fa-solid fa-heart fa-sm" onclick="location.href='LoginMember.me'" style="cursor: pointer;"></i></span>
			<span><i class="fa-solid fa-cart-shopping fa-sm" onclick="location.href='LoginMember.me'" style="margin: 10px; cursor: pointer;"></i></span>
			<span><i class="fa-solid fa-user fa-sm" onclick="location.href='LoginMember.me'" style="cursor: pointer;"></i></span>

<!-- 		<div><a href="LoginMember.me">login</a> | <a href="MemberJoinForm.me">join</a></div> -->
		</div>
		</c:otherwise>
	</c:choose>	
	</p>
	
</header>


<script>
	function myFunction() {
	  var x = document.getElementById("Demo");
	  if (x.className.indexOf("w3-show") == -1) { 
	    x.className += " w3-show";
	  } else {
	    x.className = x.className.replace(" w3-show", "");
	  }
	}
</script>
