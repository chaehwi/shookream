<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
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
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css">
<!-- slick 슬라이드 작업, jquery -->
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> 
<script src="https://kit.fontawesome.com/498a54c4c7.js"
	crossorigin="anonymous"></script>

<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />
<script type="text/javascript">
// $(function() {
// 	$('.post-wrapper').slick({
// 		  dots: true,
// 		  infinite: true,
// 		  autoplay: true,
// 		  autoplaySpeed: 2000,
// 		  slidesToShow: 1,
// 		  adaptiveHeight: true
// 		});
				
// });

</script>
<style>
.w3-sidebar a {font-family: "Roboto", sans-serif}
body,h1,h2,h3,h4,h5,h6,.w3-wide {font-family: "Montserrat", sans-serif;}
</style>

<style type="text/css">
#logintvar{
	float: right;
}

#main_category{
	text-align: center;
	padding-top: 50px;
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
</style>
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script type="text/javascript">

function downCoupon(){
	var checkLogin = '<%=(String)session.getAttribute("sId")%>';
	
	if( checkLogin == "null"){
		alert("로그인 후 이용 가능합니다.");
		location.href="LoginMember.me";
		
	}else {
		
		$.ajax({
			type: "post", 
			url: "CouponDownPro.po", 
			data: { 
				member_idx: '${sessionScope.member_idx}',
				coupon_content: $("#coupon_content").val()
			},	
			dataType: "html", 
			success: function(data) { 
				alert("쿠폰이 발급되었습니다");
				$("#coupon").html('<img id="coupondown" alt="" src="images/coupon_down.png" onclick="addWish()" style="width: 100%;"/>');
			}, 
			error: function(xhr, textStatus, errorThrown) {
				alert("쿠폰 발급 실패"); 
			}
		});
	}
}
</script>
</head>
<body class="w3-content" style="max-width:1200px" >

<!-- Sidebar/menu -->
<jsp:include page="./inc/side.jsp"/>

<!-- Top menu on small screens -->
<header class="w3-bar w3-top w3-hide-large w3-black w3-xlarge">
  <div class="w3-bar-item w3-padding-24 w3-wide">SHOOKREAM</div>
  <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-24 w3-right" onclick="w3_open()"><i class="fa fa-bars"></i></a>
</header>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:250px">

  <!-- Push down content on small screens -->
  <div class="w3-hide-large" style="margin-top:83px"></div>
  
  <!-- Top header -->
  <jsp:include page="./inc/top.jsp"/>
  <br>

  <!-- ./images header -->
  <div class ="post-wrapper">
<!--   	<div><img src="images/jeans.jpg" height="700" width="900" onclick="location.href=''"></div> -->
  	<div><img src="images/${param.coupon_content }.jpg" height="700" width="900"></div>
  
  </div>
<!--   <div class="w3-container w3-text-grey" id="jeans"> -->
<!--     <p>BEST</p> -->
<!--   </div> -->

	<div id="main_category">
		<p>Coupon Download</p>
<!-- 		<img src="images/coupon_5000.png" alt="..." style="width: 500px"> -->
	</div>
	
	
  <!-- Product grid -->
<div class="w3-row w3-grayscale" style="padding-bottom: 500px" >
		<c:forEach var="couponList" items="${couponList }">
			<div class="w3-col l3 s6" >
				<div class="w3-container" >
							<div class="w3-display-container"  >
								<img src="images/coupon.png" id="coupon" alt="..." style="width:100%">
								<div class="w3-display-middle w3-display-hover">
									<button class="w3-button w3-black" onclick="downCoupon()">
									다운로드 <i class="fa-regular fa-circle-down"></i>
									</button>
								</div>
							</div>
							<div>
							<span id="product_brand" >${couponList.coupon_name }</span>
							<span id="product_discount_price" ><fmt:formatNumber value="${couponList.coupon_price }" pattern="#,###" /> 원 할인</span>
							<input type="hidden" id="coupon_content" value="${couponList.coupon_content }">
							</div>
							
						</div>
					</div>
				</c:forEach>
			</div>
   	 </div>
  <!-- footer -->
<%--     <jsp:include page="./inc/footer.jsp"/> --%>
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


// Open and close sidebar
function w3_open() {
  document.getElementById("mySidebar").style.display = "block";
  document.getElementById("myOverlay").style.display = "block";
}
 
function w3_close() {
  document.getElementById("mySidebar").style.display = "none";
  document.getElementById("myOverlay").style.display = "none";
}
</script>
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

<!-- 로그인 드롭다운 기능! -->
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
<!-- 네이버 아이디 로그인 -->
<script type="text/javascript">
  var naver_id_login = new naver_id_login("nSNLHIW18gDjrrJsFDeE", "http://localhost:8080/Project/index.jsp");
  // 접근 토큰 값 출력
//   alert(naver_id_login.oauthParams.access_token);
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
    alert(naver_id_login.getProfileData('email'));
  }
</script>
<!-- End Channel Plugin -->




</body>
</html>
