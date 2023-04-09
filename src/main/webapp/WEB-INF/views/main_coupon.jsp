<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>  
 <c:set var="path" value="${pageContext.request.contextPath }"/> 
<!DOCTYPE html>
<html>
<head>
<title>SHOOKREAM</title>
<meta charset="UTF-8">
<!-- 네이버 아이디 로그인 -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> -->
<link href="${path}/resources/css/main.css" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
<!-- slick 슬라이드 작업, jquery -->
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> 
<script src="https://kit.fontawesome.com/498a54c4c7.js"
	crossorigin="anonymous"></script>

<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />
<script type="text/javascript">


</script>
<style>
.w3-sidebar a {font-family: "Noto Sans KR", sans-serif}
body,h1,h2,h3,h4,h5,h6,.w3-wide {font-family: "Noto Sans KR", sans-serif;}
</style>

<style type="text/css">
#logintvar{
	float: right;
}

#main_category{
	text-align: center;
	padding-bottom: 60px;
	font-size: x-large;
}

#product_brand {
	margin-bottom: 1.5px; 
	margin-top:2px; 
	font-weight: bold
}

#product_name {
	margin-bottom: 3.5px;
	color: gray;
}

#price {
	margin-bottom:20px;
}

#product_price {
	text-decoration: line-through; 
	font-size: small;
}

#product_discount_price {
	color: red; 
	font-size: big; 
	float: right;
}

/* .img-div { */
/* 	position: relative; */
/* } */

/* .text-div { */
/* z-index: -1; */
/* } */
</style>
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script type="text/javascript">

function downCoupon(cb){
	
	var checkLogin = '<%=(String)session.getAttribute("sId")%>';
	
	if( checkLogin == "null"){
		alert("로그인 후 이용 가능합니다.");
		return;
	}
		
	var idx = cb.id.replace("couponImg","");
	var coupon_idx = $("#coupon_idx"+ idx).val();
	
	
	//쿠폰 수량 검사
	$.ajax({
			type: "post", 
			url: "CouponCountCheck.po?coupon_idx="+coupon_idx, 
			data: { 
				member_idx: '${sessionScope.member_idx}',
// 				coupon_idx: coupon_idx
			},	
			dataType: "html", 
			success: function(data) { 
				
				if(data < 0){
					alert("쿠폰이 모두 소진되었습니다.");
					
					idx = null;
				
				} else {
					// 쿠폰 중복 검사
					$.ajax({
							type: "post", 
							url: "CouponDownCheck.po?coupon_idx="+coupon_idx, 
							data: { 
								member_idx: '${sessionScope.member_idx}',
//				 				coupon_idx: coupon_idx
							},	
							dataType: "html", 
							success: function(data) { 
								
								if(data == 1){
								alert("이미 발급된 쿠폰입니다!");
								
								idx = null;
								
								} else {
									
									$.ajax({
										type: "post", 
										url: "CouponDownPro.po?coupon_idx="+coupon_idx, 
										data: { 
											member_idx: '${sessionScope.member_idx}',
//				 							coupon_idx: coupon_idx
										},	
										dataType: "html", 
										success: function(data) { 
											if(data == 1){
											alert("쿠폰이 발급되었습니다");
											
											idx = null;
											}
										}, 
										error: function(xhr, textStatus, errorThrown) {
											alert("쿠폰 발급 실패"); 
										}
									});
									
								}
							}, 
							error: function(xhr, textStatus, errorThrown) {
								alert("오류가 발생했습니다. 다시 시도해주세요."); 
							}
						});
				}
	
			}, 
			error: function(xhr, textStatus, errorThrown) {
				alert("오류가 발생했습니다. 다시 시도해주세요."); 
			}
		});
	
}
</script>
</head>
<body class="w3-content" style="max-width:95%; background-color: #dcdcdc;" >

<!-- Sidebar/menu -->

<!-- Top menu on small screens -->

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left: 25px;">

  <!-- Push down content on small screens -->
  <div class="w3-hide-large" ></div>
  

	<div id="main_category">
<!-- 		<p>Coupon Download</p> -->
	</div>
	
	
  <!-- Product grid -->
<div class="w3-row w3-grayscale"  id="coupon_list">
<%-- 		<c:forEach var="couponList" items="${couponList }" varStatus="status"> --%>
<!-- 			<div class="w3-col l3 s6" style="width: 320px"> -->
<!-- 				<div class="w3-container" > -->
<!-- 							<div class="w3-display-container img-div"  > -->
							
<%-- 							<c:choose> --%>
<%-- 								<c:when test="${member_coupon.coupon_content eq couponList.coupon_content }"> --%>
<!-- 									<span class="coupon"> -->
<%-- 									<img src="${path}/resources/images/coupon_down.png" alt="..." style="width:300px"> --%>
<!-- 									</span> -->
<%-- 								</c:when> --%>
<%-- 								<c:otherwise> --%>
<!-- 									<span class="coupon"> -->
<%-- 									<img src="${path}/resources/images/coupon.png" alt="..." style="width:300px"> --%>
<!-- 									</span> -->
<!-- 									<div class="w3-display-middle w3-display-hover"> -->
<%-- 									<button id="btnDown${status.index }" class="w3-button w3-black" onclick="downCoupon()"> --%>
<!-- 									다운로드 <i class="fa-regular fa-circle-down"></i> -->
<!-- 									</button> -->
<!-- 									</div> -->
<%-- 								</c:otherwise> --%>
<%-- 							</c:choose> --%>
							
						  <div class="w3-row w3-grayscale" id="coupon_list">
							  <c:forEach var="couponList" items="${couponList}" varStatus="status">
							    <div class="w3-col l3 s6" style="width: 320px">
							      <div class="w3-container">
							        <div class="w3-display-container img-div" style="position: relative;">
							          <img src="${path}/resources/images/coupon_new.png" id="couponImg${status.index}" alt="..." style="width: 350px; cursor: pointer;" onclick="downCoupon(this)">
							          <div class="text-div" style="position: absolute; top: 25px; left: 40px;  ">
							            <span style="font-weight: bold; font-size: 13px;">${couponList.coupon_name}</span>
							            <input type="hidden" id="coupon_content${status.index}" value="${couponList.coupon_content}">
							            <input type="hidden" id="coupon_idx${status.index}" value="${couponList.coupon_idx}">
							          </div>
							          <div class="text-div" style="position: absolute; top: 25px; left: 188px; ">
							            <span style="font-weight: bold; font-size: 12px;">${couponList.coupon_benefit}</span>
							          </div>
							          <div class="text-div" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -60%); ">
							            <span style="font-weight: bold; font-size: 40px;"><fmt:formatNumber value="${couponList.coupon_benefit_price}" pattern="#,###" /> ${couponList.coupon_benefit_unit}</span>
							          </div>
							          <div class="text-div" style="position: absolute; top: 135px; left: 40px; ">
							            <span style="font-weight: bold; font-size: 12px;"><fmt:formatNumber value="${couponList.coupon_min_price}" pattern="#,###" /> 원 이상 구매시 사용 가능</span>
							          </div>
							        </div>
							      </div>
							    </div>
							  </c:forEach>
							</div>
							
<!-- 						</div> -->
<!-- 					</div> -->
<%-- 				</c:forEach> --%>
			</div>
  
   	 </div>
  <!-- footer -->
<script>
// Accordion 
function myAccFunc() {
  var x = document.getElementById("demoAcc");
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
  } else {
    x.className = x.className.replace(" w3-show", "");
  }
}

function myAccFunc1() {
	  var x = document.getElementById("cusAcc");
	  if (x.className.indexOf("w3-show") == -1) {
	    x.className += " w3-show";
	  } else {
	    x.className = x.className.replace(" w3-show", "");
	  }
	}

// Click on the "Jeans" link on page load to open the accordion for demo purposes
document.getElementById("myBtn").click();



<!-- Channel Plugin Scripts -->
<script>
  (function() {
    var w = window;
    if (w.ChannelIO) {
      return (window.console.error || window.console.log || function(){})('ChannelIO script included twice.');
    }
    var ch = function() {
      ch.c(arguments);
    };
    ch.q = [];
    ch.c = function(args) {
      ch.q.push(args);
    };
    w.ChannelIO = ch;
    function l() {
      if (w.ChannelIOInitialized) {
        return;
      }
      w.ChannelIOInitialized = true;
      var s = document.createElement('script');
      s.type = 'text/javascript';
      s.async = true;
      s.src = 'https://cdn.channel.io/plugin/ch-plugin-web.js';
      s.charset = 'UTF-8';
      var x = document.getElementsByTagName('script')[0];
      x.parentNode.insertBefore(s, x);
    }
    if (document.readyState === 'complete') {
      l();
    } else if (window.attachEvent) {
      window.attachEvent('onload', l);
    } else {
      window.addEventListener('DOMContentLoaded', l, false);
      window.addEventListener('load', l, false);
    }
  })();
  ChannelIO('boot', {
    "pluginKey": "552ea0bb-d4a5-4c70-8ba7-463b7682c434"
  });
</script>






</body>
</html>
