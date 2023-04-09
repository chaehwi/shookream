<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="en">
<head>
<title>SHOOKREAM</title>
<meta charset="UTF-8">
<!-- 네이버 아이디 로그인 -->
<!-- <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script> -->
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script> -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<%-- <link href="${path}/resources/css/main.css" rel="stylesheet"> --%>
<!-- <link rel="stylesheet" href="css/main.css"> -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">

<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<!-- slick 슬라이드 작업, jquery -->
<!-- <script src="http://code.jquery.com/jquery-3.3.1.min.js"></script> -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />
<script src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script src="https://kit.fontawesome.com/498a54c4c7.js"
	crossorigin="anonymous"></script>
<!-- <script src="../js/jquery-3.6.3.js"></script>	 -->
<script type="text/javascript">
$(function() {
	$('.post-wrapper').slick({
		  dots: true,
		  infinite: true,
		  autoplay: true,
		  autoplaySpeed: 2000,
		  slidesToShow: 1,
		  adaptiveHeight: true
		});
				
});

</script>
<!-- <script type="text/javascript"> -->
<!-- // local -->
<!-- </script> -->


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
	padding-top: 120px;
/* 	padding-bottom: 30px; */
	font-size: x-large;
	clear:both;
/* 	font-weight: bold; */
}

#product_brand {
	margin-bottom: 1.5px; 
	margin-top:2px; 
	font-weight: bold;
	font-size: 18px;
}

#product_name {
	margin-bottom: 3.5px;
	color: gray;
	font-size: 18px;
}

#price {
font-size: 20px;
}

#product_price {
	text-decoration: line-through; 
	font-size: 18px;
}

#product_discount_price {
	color: #E16A93; 
	font-size: 20px;
	float: right;
	padding-right: 10px;
}

#etcInfo {
	font-size: 15px;
}

body{
margin-top:10px;
}

footer {
/* 	height: 300px; */
	width: 100%;
	clear: both;
	padding-top: 20px;

}
</style>

<script type="text/javascript">

// ================== 찜하기 ========================

let idx = null;
	
// 찜 하기 - best
function plus_wish_btn(cb){
	
	let checkLogin = '<%=(String)session.getAttribute("sId")%>';
	
	if(checkLogin == "null"){
		alert("로그인 후 이용 가능합니다.");
		return;
	}
	
	idx = cb.id.replace("wish_btn","");
	let product_idx = $("#product_idx" + idx).val();
// 	var product_idx = parseInt($(cb).data("product-idx"));
// 	alert(idx);
	
	// 중복 검사
	$.ajax({
		type: "post", 
		url: "LikeInsertCheck.ca?product_idx="+product_idx, 
		data: { 
			member_idx: '${sessionScope.member_idx}',
		},	
		dataType: "html", 
		success: function(data) {
			
			if(data == 1){
			alert("이미 찜한 상품입니다!");
			
			$("#wishBtnId"+idx).removeClass("fa-solid fa-heart").html('<i class="fa-solid fa-heart w3-grayscale" id="wish_minus_btn' + idx + '" onclick="minus_wish_btn(this)" style="font-size: 35px; color: #FFC0CB; cursor: pointer;"></i>');
			
			idx = null;
				
			} else {
				$.ajax({
					type: "post", 
					url: "LikeInsertPro.ca?product_idx="+product_idx, 
					data: { 
						member_idx: '${sessionScope.member_idx}',
//			 			product_idx: $("#product_idx" + idx).val()
//			 			product_idx: product_idx
					},	
					dataType: "html", 
					success: function(data) { 

							
							alert("찜한 상품에 추가되었습니다!");
							
							$("#wishBtnId"+idx).removeClass("fa-solid fa-heart").html('<i class="fa-solid fa-heart w3-grayscale" id="wish_minus_btn' + idx + '" onclick="minus_wish_btn(this)" style="font-size: 35px; color: #FFC0CB; cursor: pointer;"></i>');
					
							idx = null;
							
					}, 
					error: function(xhr, textStatus, errorThrown) {
						alert("찜하기 실패"); 
					}
				});
			}
		},
		error: function(xhr, textStatus, errorThrown) {
			
			alert("오류가 발생했습니다.");
		}
	});


} // function plus_wish_btn() 끝


// 찜 취소 - best
function minus_wish_btn(cb){
	
	let checkLogin = '<%=(String)session.getAttribute("sId")%>';
	
	if(checkLogin == "null"){
		alert("로그인 후 이용 가능합니다.");
		return;
	}
	
	idx = cb.id.replace("wish_minus_btn","");
	let product_idx = $("#product_idx" + idx).val();
// 	var product_idx = parseInt($(cb).data("product-idx"));
// 	alert(idx);
	
	$.ajax({
		type: "post", 
		url: "LikeDeletePro.ca?product_idx="+product_idx, 
		data: { 
			member_idx: '${sessionScope.member_idx}',
// 			product_idx: $("#product_idx" + idx).val()
// 			product_idx: product_idx
		},	
		dataType: "html", 
		success: function(data) { 

				alert("찜한 상품에서 삭제되었습니다!");
				
				$("#wishBtnId"+idx).removeClass("fa-solid fa-heart").html('<i class="fa-regular fa-heart w3-grayscale" id="wish_btn' + idx + '" onclick="plus_wish_btn(this)" style="font-size: 35px; color: #FFC0CB; cursor: pointer;"></i>');
				
				idx = null;
		}, 
		error: function(xhr, textStatus, errorThrown) {
			alert("찜 삭제 실패"); 
		}
	});

} // function plus_wish_btn() 끝


//찜 하기 - new
function new_plus_wish_btn(cb){
	
	let checkLogin = '<%=(String)session.getAttribute("sId")%>';
	
	if(checkLogin == "null"){
		alert("로그인 후 이용 가능합니다.");
		return;
	}
	
	idx = cb.id.replace("wish_btn","");
	let product_idx = $("#new_product_idx" + idx).val();
// 	var product_idx = parseInt($(cb).data("product-idx"));
// 	alert(idx);

	// 중복 검사
	$.ajax({
		type: "post", 
		url: "LikeInsertCheck.ca?product_idx="+product_idx, 
		data: { 
			member_idx: '${sessionScope.member_idx}',
		},	
		dataType: "html", 
		success: function(data) {
			
			if(data == 1){
			alert("이미 찜한 상품입니다!");
			
			$("#new_wishBtnId"+idx).removeClass("fa-solid fa-heart").html('<i class="fa-solid fa-heart w3-grayscale" id="wish_minus_btn' + idx + '" onclick="new_minus_wish_btn(this)" style="font-size: 35px; color: #FFC0CB; cursor: pointer;"></i>');
			
			idx = null;
				
			} else {
				$.ajax({
					type: "post", 
					url: "LikeInsertPro.ca?product_idx="+product_idx, 
					data: { 
						member_idx: '${sessionScope.member_idx}',
//			 			product_idx: $("#product_idx" + idx).val()
//			 			product_idx: product_idx
					},	
					dataType: "html", 
					success: function(data) { 
							
						alert("찜한 상품에 추가되었습니다!");
						
						$("#new_wishBtnId"+idx).removeClass("fa-solid fa-heart").html('<i class="fa-solid fa-heart w3-grayscale" id="wish_minus_btn' + idx + '" onclick="new_minus_wish_btn(this)" style="font-size: 35px; color: #FFC0CB; cursor: pointer;"></i>');
				
						idx = null;
							
					}, 
					error: function(xhr, textStatus, errorThrown) {
						alert("찜하기 실패"); 
					}
				});
			}
		},
		error: function(xhr, textStatus, errorThrown) {
			
			alert("오류가 발생했습니다.");
		}
	});
	

} // function plus_wish_btn() 끝


// 찜 취소 - new
function new_minus_wish_btn(cb){
	
	let checkLogin = '<%=(String)session.getAttribute("sId")%>';
	
	if(checkLogin == "null"){
		alert("로그인 후 이용 가능합니다.");
		return;
	}
	
	idx = cb.id.replace("wish_minus_btn","");
	let product_idx = $("#new_product_idx" + idx).val();
// 	var product_idx = parseInt($(cb).data("product-idx"));
// 	alert(idx);
	
	$.ajax({
		type: "post", 
		url: "LikeDeletePro.ca?product_idx="+product_idx, 
		data: { 
			member_idx: '${sessionScope.member_idx}',
// 			product_idx: $("#product_idx" + idx).val()
// 			product_idx: product_idx
		},	
		dataType: "html", 
		success: function(data) { 

				alert("찜한 상품에서 삭제되었습니다!");
				
				$("#new_wishBtnId"+idx).removeClass("fa-solid fa-heart").html('<i class="fa-regular fa-heart w3-grayscale" id="wish_btn' + idx + '" onclick="new_plus_wish_btn(this)" style="font-size: 35px; color: #FFC0CB; cursor: pointer;"></i>');
				
				idx = null;
		}, 
		error: function(xhr, textStatus, errorThrown) {
			alert("찜 삭제 실패"); 
		}
	});

} // function plus_wish_btn() 끝


// 쿠폰 window 열기
function openModal(coupon_content) {
	
	$("#modal_coupon").modal("show");
	 	var sId = '<%=(String)session.getAttribute("sId")%>' 
	
 	if( sId == 'null'){
 		alert("로그인 후 이용 가능합니다.");
//  		location.href="LoginMember.me";
		return;
 	} else {
 // 		url = "CouponMainList.po?member_idx="+member_idx+"&coupon_content="+coupon_content; 
 		url = "CouponMainList.po?coupon_content="+coupon_content; 
 		let name = "Coupon List";
 		let attr = "width=600px, height=400px, top=50%, left=50%";
 		window.open(url, name, attr);
 	}
}


</script>

</head>
<script type="text/javascript">
localStorage.setItem("z","11");
</script>


<body class="w3-content" style="max-width:95%; margin-top: 20px;">

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
<div class="w3-main" style="margin-left:250px; margin-top: 20px;margin-right: 17px;">

  <!-- Push down content on small screens -->
  <div class="w3-hide-large" style="margin-top:83px"></div>
  
  <!-- Top header -->
  <jsp:include page="./inc/top.jsp"/>
  <br>

  <!-- ./images header -->
  <div class ="post-wrapper" style="margin-top: 18px;">
  	<div><img src="${path}/resources/images/banner(nike).jpg" height="600" width="100%"  onclick="location.href='BrandCG.ma?cg=나이키'" style="cursor: pointer;"></div>
<!--   	<div><a href="CouponMainList.po?coupon_content=banner_1"><img src="images/banner_1.jpg" height="700" width="900"></a></div> -->
  	<div><img src="${path}/resources/images/banner(newbalance).png" height="600" width="100%" onclick="location.href='BrandCG.ma?cg=뉴발란스'" style="cursor: pointer;"></div>
  	<div><img src="${path}/resources/images/banner(adidas).png" height="600" width="100%" onclick="location.href='BrandCG.ma?cg=아디다스'" style="cursor: pointer;"></div>
  	<div>
  	
  	<img id="banner_1" src="${path}/resources/images/banner_1.jpg"  height="600" width="100%" style="cursor: pointer;" onclick="openModal(this.id)" ></div>
  	<div><img id="banner_2" src="${path}/resources/images/banner_2-001 (4).jpg" height="600" width="100%" style="cursor: pointer;" onclick="openModal(this.id)"></div>
  </div>

	<div id="main_category">
		<p>BEST</p>
	</div>
	
	
  <!-- Product grid -->
<div class="w3-row" style="clear:both;">
		<c:forEach var="productBestList" items="${productBestList }" begin="0" end="7" step="1" varStatus="status">
		<input type="hidden" id="product_idx${status.index }" value="${productBestList.product_idx }">
			<div class="w3-col l3 s6">
				<div class="w3-container" style="padding-top: 100px;">
							<div class="w3-display-container">
								<img src="${path}/resources/upload/${productBestList.image_main_file }" onError="this.onerror=null; this.src='resources/images/noImg.JPG';" alt="..." style="width: 100%" >
								<div class="w3-display-middle w3-display-hover">
<%-- 									<button class="w3-button w3-black" onclick="location.href='ProductInfoForm.po?product_idx=${productBestList.product_idx }&member_idx=${sessionScope.member_idx }'"> --%>
									<button class="w3-button w3-black" onclick="location.href='ProductInfoForm.po?product_idx=${productBestList.product_idx }'">
										Buy now <i class="fa fa-shopping-cart" ></i>
									</button>
								</div>
								<!-- 목록에서 찜하기 -->
								<div class="w3-display-topright">
									<c:set var="isWished" value="false" />
								 	<c:forEach var="wish" items="${wish}">
<%-- 								 	<input type="hidden" id="product_idx${status.index }" value="${productBestList.product_idx }"> --%>
									   <c:if test="${wish.product_idx eq productBestList.product_idx}">
									     <c:set var="isWished" value="true" />
									   </c:if>
									</c:forEach>   
								  <!-- 하트 모양 아이콘 표시 -->
									 <c:choose>
									   <c:when test="${isWished}">
									   	<span id="wishBtnId${status.index }">
									     <i class="fa-solid fa-heart w3-grayscale" id="wish_minus_btn${status.index }" onclick="minus_wish_btn(this)" style="font-size: 35px; color: #FFC0CB; cursor: pointer;"></i>
									     </span>
									   </c:when>
									   <c:otherwise>
									   <span id="wishBtnId${status.index }">
									     <i class="fa-regular fa-heart w3-grayscale" id="wish_btn${status.index }" onclick="plus_wish_btn(this)" style="font-size: 35px; color: #FFC0CB; cursor: pointer;"></i>
									     </span>
									   </c:otherwise>
									 </c:choose>
								</div>
							</div>
							<p id="product_brand" onclick="location.href='BrandCG.ma?cg=${productBestList.product_brand }'" style="cursor: pointer;">${productBestList.product_brand }</p>
							<p id="product_name" onclick="location.href='ProductInfoForm.po?product_idx=${productBestList.product_idx }'" style="cursor: pointer;">${productBestList.product_name }<br></p>
							<div>
							<c:choose>
								<c:when test="${productBestList.product_discount_price gt 0}">
									<span id="price">
<%-- 									<c:set var="discounted_price" value="${productBestList.product_price - (productBestList.product_price * productBestList.product_discount_price) }"/> --%>
<%-- 									<c:out value="${discounted_price}" /> --%>
										<fmt:formatNumber value="${productBestList.product_price - (productBestList.product_price * (productBestList.product_discount_price/100)) }" pattern="#,###" />
									</span>
									<span id="product_price">
									<fmt:formatNumber value="${productBestList.product_price }" pattern="#,###" /></span>
									<span id="product_discount_price" ><fmt:formatNumber value="${productBestList.product_discount_price }" pattern="" />%</span>
								</c:when>
								<c:otherwise>
									<span id="price"><fmt:formatNumber value="${productBestList.product_price }" pattern="#,###" /></span>
								</c:otherwise>
							</c:choose>
							</div>
							<div id="etcInfo" style=" padding-bottom: 20px;">
								<span>
									구매 ${productBestList.product_sell_count } &nbsp;
								</span>
								<span>
									<i class="fa-solid fa-heart w3-grayscale" style="color:pink;"></i> ${productBestList.product_wishcount }
								</span>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		

	<!-- 최근 등록 상품 조회 -->
  <div id="main_category">
		<p>NEW</p>
	</div>
	<!-- Product grid -->
  <div class="w3-row" style="clear:both;">
  <c:forEach var="productNewList" items="${productNewList }" begin="0" end="7" step="1" varStatus="status">
  <input type="hidden" id="new_product_idx${status.index }" value="${productNewList.product_idx }">
   <div class="w3-col l3 s6" style="z-index:1;">
      <div class="w3-container" style="padding-top: 100px;">
        <div class="w3-display-container">
          <img src="${path}/resources/upload/${productNewList.image_main_file }" onError="this.onerror=null; this.src='resources/images/noImg.JPG';"  alt="..." style="width:100%">
          		<div class="w3-display-middle w3-display-hover">
<%-- 									<button class="w3-button w3-black" onclick="location.href='ProductInfoForm.po?product_idx=${productNewList.product_idx }&member_idx=${sessionScope.member_idx }'"> --%>
								<button class="w3-button w3-black" onclick="location.href='ProductInfoForm.po?product_idx=${productNewList.product_idx }'">
										Buy now <i class="fa fa-shopping-cart" ></i>
									</button>
								</div>
								<!-- 목록에서 찜하기 -->
								<div class="w3-display-topright">
									<c:set var="isWished" value="false" />
								 	<c:forEach var="wish" items="${wish}">
<%-- 								 	<input type="hidden" id="product_idx${status.index }" value="${productBestList.product_idx }"> --%>
									   <c:if test="${wish.product_idx eq productNewList.product_idx}">
									     <c:set var="isWished" value="true" />
									   </c:if>
									</c:forEach>   
								  <!-- 하트 모양 아이콘 표시 -->
									 <c:choose>
									   <c:when test="${isWished}">
									   	<span id="new_wishBtnId${status.index }">
									     <i class="fa-solid fa-heart w3-grayscale" id="wish_minus_btn${status.index }" onclick="new_minus_wish_btn(this)" style="font-size: 35px; color: #FFC0CB; cursor: pointer;"></i>
									     </span>
									   </c:when>
									   <c:otherwise>
									   <span id="new_wishBtnId${status.index }">
									     <i class="fa-regular fa-heart w3-grayscale" id="wish_btn${status.index }" onclick="new_plus_wish_btn(this)" style="font-size: 35px; color: #FFC0CB; cursor: pointer;"></i>
									     </span>
									   </c:otherwise>
									 </c:choose>
								</div>	
							</div>
							<p id="product_brand" onclick="location.href='BrandCG.ma?cg=${productNewList.product_brand }'" style="cursor: pointer;">${productNewList.product_brand }</p>
							<p id="product_name" onclick="location.href='ProductInfoForm.po?product_idx=${productNewList.product_idx }'" style="cursor: pointer;">${productNewList.product_name }<br></p>
							
							<div id="price">
							<c:choose>
								<c:when test="${productNewList.product_discount_price gt 0}">
									<span>
<%-- 									<c:set var="discounted_price" value="${productBestList.product_price - (productBestList.product_price * productBestList.product_discount_price) }"/> --%>
<%-- 									<c:out value="${discounted_price}" /> --%>
										<fmt:formatNumber value="${productNewList.product_price - (productNewList.product_price * (productNewList.product_discount_price/100)) }" pattern="#,###" />
									</span>
									<span id="product_price">
									<fmt:formatNumber value="${productNewList.product_price }" pattern="#,###" /></span>
									<span id="product_discount_price" ><fmt:formatNumber value="${productNewList.product_discount_price }" pattern="" />%</span>
								</c:when>
								<c:otherwise>
									<span><fmt:formatNumber value="${productNewList.product_price }" pattern="#,###" /></span>
								</c:otherwise>
							</c:choose>
							</div>
							<div id="etcInfo" style=" padding-bottom: 20px;">
								<span>
									구매 ${productNewList.product_sell_count } &nbsp;
								</span>
								<span>
									<i class="fa-solid fa-heart w3-grayscale" style="color:pink;"></i> ${productNewList.product_wishcount }
								</span>
							</div>
						</div>
					</div>
				</c:forEach>
   	 </div>
   	 <div style="padding-top: 100px;">
  		<jsp:include page="./inc/footer.jsp"/>
   	 </div>
   	 </div>

 
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
