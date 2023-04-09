<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <c:set var="path" value="${pageContext.request.contextPath }"/>
<head>
<!-- <script src="http://code.jquery.com/jquery-latest.min.js"></script> -->
<style>
    #test_obj {
        position: absolute;
        width: 70px;
        height: 150px;
        right: 50px;
        border-radius: 70px;
        top: 250px;
        border: 1px solid #dddddd;
        z-index: 1;
    }
</style>
 <!-- 플로팅배너 마우스 스크롤 -->
<script>
    $(document).ready(function () {
        var tmp = parseInt($("#test_obj").css('top'));
 
        $(window).scroll(function () {
            var scrollTop = $(window).scrollTop();
            var obj_position = scrollTop + tmp + "px";
 
            $("#test_obj").stop().animate({
                "top": obj_position
            }, 500);
 
        }).scroll();
    });
</script>
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap" rel="stylesheet">
</head>    

<!-- <div id="test_obj"> -->
<%-- 	<img width="150" src="<%=request.getScheme()+"://"+request.getServerName() + ":" + request.getServerPort() +"/"+request.getContextPath()%>/resources/upload/${fn:split(imageList[0].image_main_file,'/')[0]}" --%>
<!--         class="img-thumbnail" onError="this.onerror=null; this.src='resources/images/noImg.JPG';" alt="..." style="width:100px; height:100px;"   -->
<%--         onclick="location.href='ProductInfoForm.po?product_idx=${product_idx}'"/> --%>
        
<!--  <div id= "gotopbtn"  style="cursor:pointer; height:50px;  font-weight: bold; " class="back-to-top d-flex align-items-center justify-content-center active" onclick="window.scrollTo(0,0);">TOP</div> -->
<!-- </div> -->

<nav class="w3-sidebar w3-bar-block w3-white w3-collapse w3-top" style="z-index:3;width:250px" id="mySidebar" >

  <div class="w3-container w3-display-container w3-padding-16">
    <i onclick="w3_close()" class="fa fa-remove w3-hide-large w3-button w3-display-topright"></i>
    <h3 class="w3-wide" onclick="location.href='./'" style="cursor: pointer; font-family: 'Bebas Neue', cursive; font-size: 45px; "><b>SHOOKREAM</b></h3>
  </div>
  
  <!-- 검색창 -->
  	
  <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0" action="keyword.ma">

      <div class="input-group">
          <input class="form-control" type="text" name="keyword" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
          <button class="btn btn-primary" id="btnNavbarSearch" type="submit" ><i class="fa fa-search"></i></button>
      </div>
  </form>
  
  <div class="w3-padding-64 w3-large w3-text-grey" style="font-weight:bold">
  
    <a href="Best.ma" class="w3-bar-item w3-button">Best</a>
    <a href="New.ma" class="w3-bar-item w3-button">New</a>
    <a href="Sale.ma" class="w3-bar-item w3-button">Sale</a>
    <hr>
    <a onclick="myAccFunc()"  href="javascript:void(0)" class="w3-button w3-block w3-white w3-left-align" id="myBtn">
      브랜드 <i class="fa fa-caret-down"></i>
    </a>
    <div id="demoAcc" class="w3-bar-block w3-hide w3-padding-large w3-medium">
      <a href="BrandCG.ma?cg=나이키" class="w3-bar-item w3-button">나이키 &nbsp;<i class="fa fa-caret-right w3-margin-right"></i></a>
      <a href="BrandCG.ma?cg=뉴발란스" class="w3-bar-item w3-button">뉴발란스 &nbsp;<i class="fa fa-caret-right w3-margin-right"></i></a>
      <a href="BrandCG.ma?cg=컨버스" class="w3-bar-item w3-button">컨버스 &nbsp;<i class="fa fa-caret-right w3-margin-right"></i></a>
      <a href="BrandCG.ma?cg=아디다스" class="w3-bar-item w3-button">아디다스 &nbsp;<i class="fa fa-caret-right w3-margin-right"></i></a>
      <a href="BrandCG.ma?cg=반스" class="w3-bar-item w3-button">반스 &nbsp;<i class="fa fa-caret-right w3-margin-right"></i></a>
    </div>
    <hr>
    <a onclick="myAccFunc1()" class="w3-button w3-block w3-white w3-left-align" id="customerBtn">
      고객센터 <i class="fa fa-caret-down"></i>
    </a>
    <div id=cusAcc class="w3-bar-block w3-hide w3-padding-large w3-medium">
	   	<a href="BoardList.bo" class="w3-bar-item w3-button">공지사항</a>
	   	<a href="FAQList.bo" class="w3-bar-item w3-button">자주묻는 질문</a>
   	</div>
  </div>
  
<%--     <input type="button" class ="reportbtn" value="신고하기" onclick="location.href='./ReportFormAction.me?member_idx=${member_idx}&member_id=${sessionScope.sId }'"> --%>
 



 </nav>