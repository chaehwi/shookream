<%-- <%@page import="vo.ReviewBean"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri ="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri ="http://java.sun.com/jsp/jstl/functions" %>
<%
pageContext.setAttribute("br", "<br/>");
pageContext.setAttribute("cn", "\n");
%>
<!DOCTYPE html>
<html>
<head>
<title>${product.product_name }</title>
<meta charset="UTF-8">
<!-- 네이버 아이디 로그인 -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?familyMontserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
<style>
.w3-sidebar a {font-family: "Noto Sans KR", sans-serif}
body,h1,h2,h3,h4,h5,h6,.w3-wide,span {font-family: "Noto Sans KR", sans-serif;}
</style>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> 
<script type="text/javascript">
$('.center').slick({
	  centerMode: true,
	  centerPadding: '60px',
	  slidesToShow: 3,
	  responsive: [
	    {
	      breakpoint: 768,
	      settings: {
	        arrows: false,
	        centerMode: true,
	        centerPadding: '40px',
	        slidesToShow: 3
	      }
	    },
	    {
	      breakpoint: 480,
	      settings: {
	        arrows: false,
	        centerMode: true,
	        centerPadding: '40px',
	        slidesToShow: 1
	      }
	    }
	  ]
	});
</script>
<style type="text/css">
#sform { 
		  border:1px;
		  display: inline-block;
          text-align: center;
        margin-left: 100px;
          
        }

#reviewListArea { 
          text-align: center;
          margin-left: 270PX;
          width: 90%;
        }        
 
        
#image{
/* background-color: blue; */
/* padding-left: 50; */
/* float: left; */
}

#title{
align-content: center;
}

#detail{
border:1px;
font-family: "Montserrat","sans-serif", "Helvetica Neue";
font-size:15px;
float: right;
margin-right: 450px;
text-align: left;
width: 300px;
}   
.prod_name{
font-size: 25px;
font-weight: 900px;

}
.prod_title{
font-size: 20px;
font-weight: bold;
display: block;
}


</style>

<style type="text/css">
#logintvar{
	float: right;
}

.reviewContent { 
	width : 90%;
	height: 150px; 
	padding-bottom: 10px;
}

#reAll {
	padding-bottom: 50px;
}

#imgSize {
	width: 9em;
	height: 9em;
}

#delBtn {
	float: right;
}

#product_content {
	padding: 50px;
}

#reviewListArea {
	padding: 100px 50px;
}
</style>

<script type="text/javascript">


	
	function deleteWish() {
		$.ajax({
			type: "post", 
			url: "LikeDeletePro.ca", 
			data: { 
				member_idx: '${sessionScope.member_idx}',
				product_idx: $("#product_idx").val()
			},	
			dataType: "html", 
			success: function(data) { 
	//					$("#btnWishAfterImage").attr("src", "images/before_heart.png");
					alert("찜한 상품에서 삭제되었습니다!");
	//					$('#wishLoad').load(location.href+' #wishLoad')
					$(".wishBtn").html('<img id="beforeHeart" alt="" src="resources/images/before_heart.png" id="btnWishBeforImage" onclick="addWish()" style="width: 30px; height: 30px;"/>');
			}, 
			error: function(xhr, textStatus, errorThrown) {
				alert("찜 삭제 실패"); 
			}
		});
	}
		
	function addWish() {
		
		var checkLogin = '<%=(String)session.getAttribute("sId")%>';
		
		if(checkLogin == "null"){
			alert("로그인 후 이용 가능합니다.");
			location.href="LoginMember.me";
			
		} else {
			
			$.ajax({
				type: "post", 
				url: "LikeInsertPro.ca", 
				data: { 
					member_idx: '${sessionScope.member_idx}',
					product_idx: $("#product_idx").val()
				},	
				dataType: "html", 
				success: function(data) { 
	//						$("#btnWishBeforImage").attr("src", "images/after_heart.png");
	//						$('#wishLoad').load(location.href+' #wishLoad')
		
						alert("찜한 상품에 추가되었습니다!");
						
						$(".wishBtn").html('<img id="afterHeart" alt="" src="resources/images/after_heart.png" id="btnWishAfterImage" onclick="deleteWish()" style="width: 30px; height: 30px; cursor: pointer;"/>');
				}, 
				error: function(xhr, textStatus, errorThrown) {
					alert("찜하기 실패"); 
				}
			});
		}
	}

	//
	function valueCheckCart() {
	 	var color_val = $("#cart_color_id").val();
	 	var size_val = $("#cart_size_id").val();
	 	var cart_count = $("#cart_count_id").val();
	 	var product_idx = $("#product_idx").val()
	 	var member_idx = '<%=session.getAttribute("member_idx")%>';
	 //	색상 선택 여부 판별
	 	if(color_val==""){
	 		alert("색상을 선택 해주세요.");
	 		return false;
	 	//사이즈 선택 여부 판별  
	 	}else if(size_val == ""){
	 		alert("사이즈를 선택 해주세요.");
	 		return false;
	 	//로그인 여부 판별
	 	}else if(member_idx == "null"){
	 		alert("로그인이 필요한 서비스입니다.");
	 		location.href = "LoginMember.me";
	 		return false;
	 	}else{
	 		//문제가 없을 경우 해당 페이지의 상품을 장바구니에 담음.
			$.ajax({
				type: "post", 
				url: "CartInsertPro.ca", 
				data: { 
					product_idx: product_idx,
					cart_count : cart_count
					
				},
				dataType: "html", 
				success: function(data) {
// 					console.log(data);
// 					console.log(typeof(data));
// 					alert(data)
// 					alert('확인')
// 					alert(data == "이미 담긴상품");
					if(data == '이미 담긴상품'){
						var confirm_value = confirm("이미 담은 상품이 있어 추가되었습니다.\n장바구니로 이동하시겠습니까?");
						if(confirm_value){
							location.href = "CartList.ca?pageNum=1"
						}
					
					}else if(data == '새상품'){
						var confirm_value = confirm("상품을 장바구니에 담았습니다.\n장바구니로 이동하시겠습니까?");
						if(confirm_value){
							location.href = "CartList.ca?pageNum=1"
						}
					}
					
				}, 
				error: function(xhr, textStatus, errorThrown) {
					alert("장바구니 담기 실패"); 
				}
				
			});
	 	
	 	}//else
	 	
	}//valueCheckCart 끝
	
	//-------구매하기 버튼 클릭 시 작동되는 함수---------
	function valueCheckPurchase() {
	 	var color = $("#cart_color_id").value;
	 	var size = $("#cart_size_id").value;
	 	var product_idx = $("#product_idx").val();
	 	var member_idx = '<%=session.getAttribute("member_idx")%>';
		var order_count = document.getElementById("cart_count_id").value;
		//색상 선택 여부 판별
	 	if(color==""){
	 		alert("색상을 선택 해주세요.");
	 		return false;
	 	//사이즈 선택 여부 판별  
	 	}else if(size == ""){
	 		alert("사이즈를 선택 해주세요.");
	 		return false;
	 	//로그인 여부 판별
	 	}else if(member_idx == "null"){
	 		alert("로그인 필수 입니다.");
	 		return false;
	 	}
		
	 	location.href="OrderDetailForm.po?product_idx=" + product_idx+"&order_count="+order_count;
	}//valueCheckPurchase 끝


	
	//사이즈 색상 모두 선택 시 개수 밑에 선택한 옵션 + 가격 표시하기
	function changeCheck() {
		var cart_size_val = $("#cart_size_id").val();
		var cart_color_val = ($("#cart_color_id").val()).toUpperCase();
		var cart_prod_name = $("#cart_product_name_id").val();
		var cart_product_release_price = parseInt($("#cart_product_release_price").val());
		var cart_product_price = parseInt($("#cart_product_price").val());

// 		var cart_count = parseInt($("#cart_count_id").val());
		
		var comma_price = cart_product_price.toLocaleString("en-US");
		var comma_release_price = cart_product_release_price.toLocaleString("en-US");
	  	const element = document.getElementById('price_result_area');

		
		if(cart_size_val != "" && cart_color_val != "" ){
			if(cart_product_release_price > 0 ){

			element.innerHTML += 
// 			'<span style="font-weight: bold; font-size: 20px">'+ cart_prod_name + '</span><br>' 
			'<div style="margin-bottom: 12px"><span style="font-weight: bold; font-size: 19px;">사이즈 : ' + cart_size_val + ' / 색상 : ' + cart_color_val + '</span></div>'
			+ '<span style="margin-right: 20px">' 
			+ '<button class="btn btn-outline-dark btn-sm" onclick="amount_adjust(' + "'minus'" + ')" style ="width: 30px; height: 35px; font-size: 15px;">-</button>'
			+ '<input type="text" class="form-control" id="cart_count_id" name="cart_count" value="1" required="required" readonly="readonly" style="width: 40px; text-align: center; display: inline-block;">'
			+ '<button class="btn btn-outline-dark btn-sm" onclick="amount_adjust(' + "'plus'" + ')" style ="width: 30px; height: 35px; font-size: 15px;">+</button>'
			+ '</span>'
			+ '<span id ="total_price_area" style="font-weight: bold; font-size: 20px;">' + '총 금액 : ' + '</span>'
			+ '<span id ="total_price_areas" style="font-weight: bold; font-size: 18px; color:red;">' + comma_release_price + '</span>'
			+ '<span style="font-weight: bold; font-size: 18px;">원</span>'
			+ '<hr>';
			}else{
			element.innerHTML += 
//	 			'<span style="font-weight: bold; font-size: 20px">'+ cart_prod_name + '</span><br>' 
				'<div style="margin-bottom: 12px"><span style="font-weight: bold; font-size: 19px;">사이즈 : ' + cart_size_val + ' / 색상 : ' + cart_color_val + '</span></div>'
				+ '<span style="margin-right: 20px">' 
				+ '<button class="btn btn-outline-dark btn-sm" onclick="amount_adjust(' + "'minus'" + ')" style ="width: 30px; height: 35px; font-size: 15px;">-</button>'
				+ '<input type="text" class="form-control" id="cart_count_id" name="cart_count" value="1" required="required" readonly="readonly" style="width: 40px; text-align: center; display: inline-block;">'
				+ '<button class="btn btn-outline-dark btn-sm" onclick="amount_adjust(' + "'plus'" + ')" style ="width: 30px; height: 35px; font-size: 15px;">+</button>'
				+ '</span>'
				+ '<span id ="total_price_area" style="font-weight: bold; font-size: 20px;">' + '총 금액 : ' + '</span>'
				+ '<span id ="total_price_areas" style="font-weight: bold; font-size: 18px; color:red;">' + comma_price + '</span>'
				+ '<span style="font-weight: bold; font-size: 18px;">원</span>'
				+ '<hr>';
			}
		}
		
	}//changeCheck 끝
	
	//---------상세 페이지에서 수량 +, - 버튼에 따른 수량 변동 작업 --------
	function amount_adjust(type) {
// 		alert("클릭");
	 	var cart_count = parseInt($("#cart_count_id").val());
		var cart_product_release_price = parseInt($("#cart_product_release_price").val());
		var cart_product_price = parseInt($("#cart_product_price").val());

		if(type =="plus"){
			// 최대 개수 미설정(재고 수량을 가져와서 재고수량보다 적게 + 되도록 설정 필요)
			if(cart_product_release_price > 0 ){
				cart_count = cart_count + 1;
				total_comma_price = (cart_product_release_price * cart_count).toLocaleString("en-US");
				$("#cart_count_id").val(cart_count);
				$("#total_price_areas").text(total_comma_price);
			}else{
				cart_count = cart_count + 1;
				total_comma_price = (cart_product_price * cart_count).toLocaleString("en-US");
				$("#cart_count_id").val(cart_count);
				$("#total_price_areas").text(total_comma_price);
			}
		}else if(type ="minus"){
			// 개수가 1미만이 되지 않도록 설정
			if(cart_product_release_price > 0 ){
				cart_count = cart_count - 1;
				total_comma_price = (cart_product_release_price * cart_count).toLocaleString("en-US");
				$("#cart_count_id").val(cart_count);
				$("#total_price_areas").text(total_comma_price);
			}else{
				cart_count = cart_count - 1;
				total_comma_price = (cart_product_price * cart_count).toLocaleString("en-US");
				$("#cart_count_id").val(cart_count);
				$("#total_price_areas").text(total_comma_price);
			}
		}
	 	
	}//amount_adjust 끝
</script>
</head>
<body class="w3-content" style="max-width:95%">

<!-- Sidebar/menu -->
<jsp:include page="../inc/side.jsp"/>

<!-- Top menu on small screens -->
<header class="w3-bar w3-top w3-hide-large w3-black w3-xlarge">
  <div class="w3-bar-item w3-padding-24 w3-wide">SHOOKREAM</div>
  <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-24 w3-right" onclick="w3_open()"><i class="fa fa-bars"></i></a>
</header>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:250px;margin-top: 20px;margin-right: 17px;">

  <!-- Push down content on small screens -->
  <div class="w3-hide-large" style="margin-top:83px"></div>
  
  <!-- Top header -->
  <jsp:include page="../inc/top.jsp"/>
	
  <!-- 섬네일 이미지 -->
  <div id="product_content">
  <div id = "sform">
	<section id="image">
	<div class="w3-content w3-display-container">
<!-- 		  	<div><img src="./images/jeans.jpg"  class="mySlides" width="600px" height="650px"onclick="location.href=''"></div> -->
<!-- 		  	<div><a href="CouponMainList.po?coupon_content=banner_1"><img src="./images/banner_1.jpg"  class="mySlides" width="450px" height="650px"></a></div> -->
<!-- 		  	<div><img src="./images/jeans1.jpg" width="200px"  class="mySlides" height="650px"></div> -->
<!-- 		  	<div><img src="./images/섬네일(슈펜).jpg" width="200px"  class="mySlides" height="650px"></div> -->
<!-- 		  	<div><img src="./images/logo.png" width="200px"  class="mySlides" height="650px"></div> -->
	<c:forEach var="image" items="${imagelist}">
		<div><img src="upload/${image.image_main_file }"  class="mySlides" width="600px" height="650px"onclick="location.href=''"></div>
		<div><img src="upload/${image.image_real_file1 }"  class="mySlides" width="600px" height="650px"onclick="location.href=''"></div>
		<div><img src="upload/${image.image_real_file2 }"  class="mySlides" width="600px" height="650px"onclick="location.href=''"></div>
	</c:forEach>
		  	<button class="w3-button w3-black w3-display-left" onclick="plusDivs(-1)">&#10094;</button>
  			<button class="w3-button w3-black w3-display-right" onclick="plusDivs(1)">&#10095;</button>
	</div>
	</section>
   </div>	
	<!-- 상품 사진 옆 -->
	
	<section id="detail" >
	<!-- 장바구니에 담을 때 필요한 파라미터들 : 상품idx, 멤버idx, 상품가격, 할인율, 주문가격(할인된가격), 상품이름, 섬네일용 사진 -->
		<input type="hidden" id="product_idx" value="${param.product_idx }">
		<input type="hidden" id="member_idx" value="${member_idx }">
		<input type="hidden" id = "cart_product_price" name ="cart_price" value="${product.product_price }">
		<input type="hidden" id = "cart_product_discount_price" name ="cart_discount" value="${product.product_discount_price }">
		<input type="hidden" id = "cart_product_release_price" name ="cart_discount" value="${product.product_release_price }">
      	<input type="hidden" id ="cart_product_name_id" name ="cart_product_name" value="${product.product_name }">
		<input type="hidden" name ="cart_product_image" value="${image.image_main_file }">
	
		<!-- 상품 브랜드, 이름, 번호 -->
		<div class="text"> 
			<p>${product.product_brand}</p>
			<p class ="prod_name" id ="prod_name_id">${product.product_name }</p>
<%-- 			<p>상품번호 : ${product.product_idx }</p>		 --%>
			<hr>	
		</div>

		<div id="price_block" style="display: inline-block; width: 300px; ">
		<p class="prod_title">상품금액</p>
		
		<c:choose>
			
			<c:when test="${product.product_discount_price eq 0 }">
				<div id ="price_div" style="float: left; font-weight: bold; font-size: 30px; margin-right: 5px"><fmt:formatNumber value="${product.product_price }" pattern="#,###원"></fmt:formatNumber></div> 
			</c:when>
			<c:otherwise>
				<div id ="price_div" style="color: red; font-size: 30px; font-weight: bold; float: left; margin-right: 15px">${product.product_discount_price}%</div>
				<div id ="price_div" style="float: left; font-weight: bold; font-size: 30px; margin-right: 5px"><fmt:formatNumber value="${product.product_release_price }" pattern="#,###원"></fmt:formatNumber></div> 
				<div id ="price_div" style="float: left; font-size: 17px; vertical-align: bottom; text-decoration: line-through; height: 45px;"><fmt:formatNumber value="${product.product_price }" pattern="#,###원"></fmt:formatNumber></div> 
			</c:otherwise>
		</c:choose>
			
		</div>
<!-- 		<div id="detail1" style="display: inline-block; width: 300px"> -->
<!-- 			<p class="prod_title">상품금액</p> -->
<%-- 			<div id ="price_div" style="color: red; font-size: 30px; font-weight: bold; float: left; margin-right: 15px">${product.product_discount_price}%</div> --%>
<%-- 			<div id ="price_div" style="float: left; font-weight: bold; font-size: 30px;"><fmt:formatNumber value="${product.product_release_price }" pattern="#,###원"></fmt:formatNumber></div>  --%>
<%-- 			<div id ="price_div" style="float: left; font-size: 17px; text-decoration: line-through; height: 45px; bottom: 0"><fmt:formatNumber value="${product.product_price }" pattern="#,###원"></fmt:formatNumber></div>  --%>
<!-- 		</div> -->
		<hr>	
		<!-- 색상 -->
			<p class="prod_title">색상</p>
			<select id="cart_color_id" name="cart_color" required="required" class="form-select" onchange="changeCheck()" style="font-size: 18px ">
				<option value="" selected>색상을 선택해주세요.</option>
				<c:forEach var="color" items="${colorlist}">
				<option >${color }</option>
				</c:forEach>
			</select>
			<hr>
		<div id="detail2" >
		<!-- 사이즈 -->
			<p class ="prod_title">사이즈</p>
			<select id="cart_size_id" name="cart_size" required="required" class="form-select" onchange="changeCheck()" style="font-size: 18px; ">
				<option value="" selected>사이즈를 선택해주세요.</option>
				<c:forEach var="category" items="${categorylist}">
				<option value="${category}">${category}</option>
				</c:forEach>
			</select>
<!-- 			<button class="btn btn-outline-dark btn-sm" onclick="amount_adjust('minus')">-</button> -->
			<hr>
		<!-- 개수 -->

			<div id="price_result_area"></div>
			<div style="margin-top: 20px">
				<span id="wishLoad" >
					<c:choose>
						<c:when test="${wish.product_idx eq product.product_idx }">
							<span class="wishBtn">
								<img onclick="deleteWish()" id="afterHeart" alt="" src="resources/images/after_heart.png" id="btnWishAfterImage" style="width: 30px; height: 30px; cursor: pointer;"/>
							</span>
						</c:when>
						<c:otherwise>
							<span class="wishBtn">
								<img id="beforeHeart" onclick="addWish()" alt="" src="resources/images/before_heart.png" id="btnWishBeforImage" style="width: 30px; height: 30px; cursor: pointer;"/>&nbsp;
							</span>
						</c:otherwise>
					</c:choose>
					<!-- 재고에 따른 처리 -->
					<c:choose>
						<c:when test="${product.product_amount gt 0}">
							<button type="button" onclick="valueCheckCart()" class="btn btn-dark btn">장바구니</button>
							<button type="button" onclick="valueCheckPurchase()" class="btn btn-dark btn">구매하기</button>
						</c:when>
		
						<c:when test="${product.product_amount le 0}">
							현재 재고가 없는 제품입니다.<br>
							<a href="./">다른 상품 보러가기</a>
						</c:when>
					</c:choose>
				</span>	
			</div>
		</div>
		
	</section>
 </div>
 </div> 
 	
<!--   <table id="detail_table"> -->
<!-- 		<tr> -->
<%-- 			<td><img alt="shoes" src="./upload/${image.image_real_file1}" width="450px"></td> --%>
<!-- 		</tr>	 -->
		
<!-- 		<tr> -->
<%-- 			<td><img alt="shoes" src="./upload/${image.image_real_file2}" width="450px"></td> --%>
<!-- 		</tr> -->
		
<!-- 	</table> -->

	<hr>	 <%-- 리뷰구역 --%> -->
		<div id="reviewListArea" style="z-index:1;">
			<h3>Review</h3>
			<hr>
				<div id="reAll">
					<c:forEach var="review" items="${reviewList }">
						<table class="reviewContent">
							<tr>
								<c:choose>
									<c:when test="${not empty review.review_real_img  }">
										<td rowspan="7" width="20%">
										<img id="imgSize" src="./upload/${review.review_real_img }"width="100px" ></td>
									</c:when>
									<c:otherwise>
										<td rowspan="7" width="20%">
										<img id="imgSize" src="./images/shookream.png" width="100px" ></td>
									</c:otherwise>
								</c:choose>
								<td colspan=""style="text-align:left;" width="65%"><small>상세 사이즈 및 색상 : ${review.re_order_detail }</small></td>							
								<td style="text-align:left;" width="15%">
									<small>
									작성일 : ${review.review_date } <br>
 									주문자 : ${review.member_idx }<br>
 									</small>
								</td>					
							</tr>
							<tr></tr>
							<tr>
								<td colspan="4" style="text-align:left"><br>${fn:replace(review.review_content, cn, br) }</td>
							</tr>
						</table>
						<div style="padding-right: 10px;">
						<c:choose>
							<c:when test="${sessionScope.sId eq 'admin' }">
								<input id="delBtn" type="button" value="리뷰 삭제하기" class="btn btn-dark btn-sm" onclick="location.href='ReviewDeletePro.po?product_idx=${review.product_idx }&member_idx=${sessionScope.member_idx }&review_idx=${review.review_idx}'">								
							</c:when>
							<c:when test="${param.member_idx ne null && param.member_idx ne review.member_idx }">
								<input id="delBtn" type="button"class="btn btn-dark btn-sm" value="신고하기" onclick="location.href='./ReportFormAction.me?member_idx=${member_idx}&member_id=${sessionScope.sId }'">
							</c:when>	
							<c:when test="${param.member_idx eq review.member_idx }" >
								<input id="delBtn" type="button" value="리뷰 삭제하기" class="btn btn-dark btn-sm" onclick="location.href='ReviewDeletePro.po?product_idx=${review.product_idx }&member_idx=${sessionScope.member_idx }&review_idx=${review.review_idx}'">
							</c:when>
						</c:choose>
						</div>		
					</c:forEach>
				</div>
<%--				<section id="pageList" style="text-align:center">				
			<!-- 페이지 번호 목록은 시작 페이지(startPage)부터 끝 페이지(endPage) 까지 표시 -->
			<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
				<!-- 단, 현재 페이지 번호는 링크 없이 표시 -->
				<c:choose>
					<c:when test="${pageNum eq i}">
						${i }
					</c:when>
					<c:otherwise>
						<a href="${i }">${i }</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</section>	--%>
		</div> 	
     <footer style="z-index:-1; text-align:left; width:100%; padding-left:250px">
  		<jsp:include page="../inc/footer.jsp"/>
  	 </footer> 
	

<%-- 	<img src="./upload/${product.product_img }" class="img-thumbnail" alt="..." width="150" height="150"> --%>
<!--  	<table border="1"> -->
<!-- 	 	<tr> -->
<%-- 			 <td width="70"><h1>${product }</h1></td> --%>
<!-- 			 <td width="70"></td> -->
<!-- 	 	</tr> -->
	 
<!-- 	 </table> -->


<%-- 	<img src="./upload/${product.product_img }" class="img-thumbnail" alt="..." width="150" height="150"> --%>
<!--  	<table border="1"> -->
<!-- 	 	<tr> -->
<%-- 			 <td width="70"><h1>${product }</h1></td> --%>
<!-- 			 <td width="70"></td> -->
<!-- 	 	</tr> -->
	 
<!-- 	 </table> -->


  <!-- 제품 상세 페이지 끝 -->
<!--   <!-- Subscribe section --> 
<!--   <div class="w3-container w3-black w3-padding-32"> -->
<!--     <h1>Subscribe</h1> -->
<!--     <p>To get special offers and VIP treatment:</p> -->
<!--     <p><input class="w3-input w3-border" type="text" placeholder="Enter e-mail" style="width:100%"></p> -->
<!--     <button type="button" class="w3-button w3-red w3-margin-bottom">Subscribe</button> -->
<!--   </div> -->
  
  <!-- Footer -->
<%--   <jsp:include page="../inc/footer.jsp"></jsp:include> --%>

<!--   <div class="w3-black w3-center w3-padding-24">Powered by <a href="https://www.w3schools.com/w3css/default.asp" title="W3.CSS" target="_blank" class="w3-hover-opacity">w3.css</a></div> -->

  <!-- End page content -->
<!-- </div> -->

<!-- <!-- Newsletter Modal -->
<!-- <div id="newsletter" class="w3-modal"> -->
<!--   <div class="w3-modal-content w3-animate-zoom" style="padding:32px"> -->
<!--     <div class="w3-container w3-white w3-center"> -->
<!--       <i onclick="document.getElementById('newsletter').style.display='none'" class="fa fa-remove w3-right w3-button w3-transparent w3-xxlarge"></i> -->
<!--       <h2 class="w3-wide">NEWSLETTER</h2> -->
<!--       <p>Join our mailing list to receive updates on new arrivals and special offers.</p> -->
<!--       <p><input class="w3-input w3-border" type="text" placeholder="Enter e-mail"></p> -->
<!--       <button type="button" class="w3-button w3-padding-large w3-red w3-margin-bottom" onclick="document.getElementById('newsletter').style.display='none'">Subscribe</button> -->
<!--     </div> -->
<!--   </div> -->
<!-- </div> -->
<script>
var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  if (n > x.length) {slideIndex = 1}
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";  
  }
  x[slideIndex-1].style.display = "block";  
}
</script>

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

<script type="text/javascript">
	$(document).ready(function(){
	//상품가격의 값 가져오기.
	var originPrice = ${product.product_price}
	//할인율 값 가져오기. 
	var discountRate = ${product.product_discount_price}
 	
	//-----할인 연산결과에 따른 처리-----
	//1. 할인가격
    var discounted = Math.round(originPrice * (discountRate / 100));	// 정수로 출력하기 위해 소수점 아래 반올림 처리
    //2. 할인된 가격 = 원래가격 - 할인가격
    var releasePrice = originPrice - discounted;
    //** 콤마 붙힌 가격 변수 ** 
    var commaReleasePrice = releasePrice.toLocaleString("en-US");
    var commaOriginPrice = originPrice.toLocaleString("en-US");
    document.querySelector('#discountResult').innerText = commaReleasePrice + '원'
    //할인된 가격을 cart_discountprice 라는 id 값의 value에 넣음.
    document.getElementById('cart_order_price').value = releasePrice;	 
// 	    alert("로딩")
	});


</script>



<script type="text/javascript">
document.getElementById("button1").style.backgroundColor ="";
document.getElementById("button2").style.backgroundColor ="";
document.getElementById("button3").style.backgroundColor ="";
document.getElementById("button4").style.backgroundColor ="";

document.getElementById("button1").onclick = function(){
            this.style.backgroundColor ="gray";
            document.getElementById("button2").style.backgroundColor ="";
            document.getElementById("button3").style.backgroundColor ="";
            document.getElementById("button4").style.backgroundColor ="";
        };

document.getElementById("button2").onclick = function(){
            this.style.backgroundColor ="gray";
            document.getElementById("button1").style.backgroundColor ="";
            document.getElementById("button3").style.backgroundColor ="";
            document.getElementById("button4").style.backgroundColor ="";
        };
document.getElementById("button3").onclick = function(){
            this.style.backgroundColor ="gray";
            document.getElementById("button1").style.backgroundColor ="";
            document.getElementById("button2").style.backgroundColor ="";
            document.getElementById("button4").style.backgroundColor ="";
        };
document.getElementById("button4").onclick = function(){
            this.style.backgroundColor ="gray";
            document.getElementById("button2").style.backgroundColor ="";
            document.getElementById("button3").style.backgroundColor ="";
            document.getElementById("button1").style.backgroundColor ="";
        };
</script>
</body>
</html>
