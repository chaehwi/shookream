<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri ="http://java.sun.com/jsp/jstl/fmt" %>
 <c:set var="path" value="${pageContext.request.contextPath }"/>   

<!DOCTYPE html>
<html>
<head>
<title>장바구니</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- font 굵기 -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
<!-- icon CDN -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
<!-- 네이버아이디로그인 -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://kit.fontawesome.com/ca93809e69.js" crossorigin="anonymous"></script>
<!-- 구글 아이디 로그인 -->
<meta name="google-signin-client_id" content="1047574308186-h6ehte2k4901kjn1u3g5vnonbf2g56on.apps.googleusercontent.com">
<script src="https://kit.fontawesome.com/ca93809e69.js" crossorigin="anonymous"></script> <!-- 폰트어썸 스크립트 -->
<script type="text/javascript">
//-------장바구니에서 상품 삭제 버튼 클릭 시 확인창을 띄운 후 삭제하는 함수--------
function deleteCart(cb) {
	var idx = cb.id.replace("cart_delete_btn", "");
	//cart_idx 변수 선언
	var cart_idx_value = $("#cart_idx_hidden"+idx).val();
// 	alert(cart_idx_value);-
	var confirmDelete = confirm("해당 상품을 장바구니에서 삭제 하시겠습니까? ")
	if(confirmDelete){
		location.href='CartDeletePro.ca?cart_idx=' + cart_idx_value
	}
}

//---------상세 페이지에서 수량 +, - 버튼에 따른 수량 변동 작업 --------
function amount_adjust_plus(type) {
 	var idx = type.id.replace("plus_btn", "");

	var cart_count = parseInt($("#cart_count_id" + idx).val());
 	var cart_idx = $("#cart_idx_hidden" + idx).val();
	cart_count = cart_count + 1;
		
	 	$.ajax({
			type: "get",
			url: "amount_adjust.ca",
			data: {
				cart_idx: cart_idx,
				type: "plus"
			},
			dataType: "html",
			success: function(data) {
				 if(data == "성공"){
					 alert("수량이 변경되었습니다.")
					 $("#form_area").load(window.location.href + " #form_area");
					
				 }else if(data == "실패"){
					 alert("수량변경에 실패했습니다.")
				 }
			}
		});

}//amount_adjust_plus 끝

function amount_adjust_minus(type) {
 	var idx = type.id.replace("minus_btn", "");

	var cart_count = parseInt($("#cart_count_id" +idx).val());
 	var cart_idx = $("#cart_idx_hidden" + idx).val();
//  	alert(cart_count);
	if(cart_count > 1){
		$.ajax({
			type: "get",
			url: "amount_adjust.ca",
			data: {
				cart_idx: cart_idx,
				type: "minus"
			},
			dataType: "html",
			success: function(data) {
				 if(data == "성공"){
					 alert("수량이 변경되었습니다.")
					 $("#form_area").load(window.location.href + " #form_area");
				 }else if(data == "실패"){
					 alert("수량변경에 실패했습니다.")
				 }
					
	 		}//success 끝
 		});//ajax 끝
	}else{
		alert("주문 가능한 최소 수량은 1개 입니다.")
	}
	 	
				
}//amount_adjust_minus 끝

//체크박스 선택 jQuery
$(document).ready(function() {
	$("#chkAll").click(function() {
		if($("#chkAll").is(":checked")){
			//전체 체크박스 활성화
			$("input[name=cartCheckBox]").prop("checked", true);
			//cart_idx의 값들을 배열로 저장하기 위해 선언
			var cart_idxArr = new Array();
			
			var cart_price_sum = 0
			var cart_discount_sum = 0
			var cart_order_price_sum = 0
			
			$("input[name=cart_price]").each(function() {
				cart_price_sum += parseInt(this.value);
			});
			
			$("input[name=cart_order_price]").each(function() {
				cart_order_price_sum += parseInt(this.value);
			});
			//할인 금액 계산
			cart_discount_sum = parseInt(cart_price_sum-cart_order_price_sum)
			
			//, 붙여주기
			cart_price_sum = cart_price_sum.toLocaleString("en-US")
			cart_order_price_sum = cart_order_price_sum.toLocaleString("en-US")
			cart_discount_sum = cart_discount_sum.toLocaleString("en-US")
			
		
// 			alert("총 상품 금액 : " + cart_price_sum)
// 			alert("총 할인 금액 : " + cart_discount_sum)
// 			alert("총 주문 금액 : " + cart_order_price_sum)
	
			$("#total_product_area").text(cart_price_sum);
			$("#discount_area").text(cart_discount_sum);
			$("#total_order_area").text(cart_order_price_sum);

				//전체 금액 계산
			} else {
				//전체 체크박스 비활성화 
				$("input[name=cartCheckBox]").prop("checked", false);

				$("#total_product_area").text(0);
				$("#discount_area").text(0);
				$("#total_order_area").text(0); 
			}

		});

	});

	function check_function(cb) {
		//-------변수 선언------------
		var idx = cb.id.replace("cartCheckBox", "");
		var cart_idx = $("#cartCheckBox" + idx).val();
		//체크박스 상태 판별 (해제했을 경우 합계 금액에서 제외 )
		var checked = $('#cartCheckBox' + idx).is(':checked');
		//상품금액(금액의 경우 , 가 붙어있기에 정규표현식을 사용하여 ,가 붙은 항목들을 "" 처리 한 뒤 정수형으로 변환)
		var total_price = parseInt($("#total_product_area").text().replace(
				/,/g, ""));
		//총 결제금액(금액의 경우 , 가 붙어있기에 정규표현식을 사용하여 ,가 붙은 항목들을 "" 처리 한 뒤 정수형으로 변환)
		var total_order_price = parseInt($("#total_order_area").text().replace(
				/,/g, ""));

		var total = $("input[name=cartCheckBox]").length;
		var checked_length = $("input[name=cartCheckBox]:checked").length;

		if (total != checked_length)
			$("#chkAll").prop("checked", false);
		else
			$("#chkAll").prop("checked", true);
		//--------체크박스 상태에 따른 처리---------	
		if (!checked) {
			//checked 해제에 따른 처리로 minus 타입을 넘김
			$.ajax({
						type : "get",
						url : "ChangeTotalPrice.ca",
						data : {
							cart_idx : cart_idx,
							type : "minus",
							total_price : total_price,
							total_order_price : total_order_price
						},
						dataType : "json",
						success : function(data) {
							//총 주문금액 
							total_price = data.cart_total_price
									.toLocaleString("en-US");

							//총 할인금액 
							total_discount_price = (data.cart_total_price - data.cart_order_total_price)
									.toLocaleString("en-US");

							//총 상품금액
							total_order_price = data.cart_order_total_price
									.toLocaleString("en-US");

							//주문, 할인, 상품 금액 넣기
							$("#total_product_area").text(total_price);
							$("#discount_area").text(total_discount_price);
							$("#total_order_area").text(total_order_price);

						}//success 끝
					});//ajax 끝
		} else {
			//checked 됐을경우에 따른 처리로 plus 타입을 넘김
			$
					.ajax({
						type : "get",
						url : "ChangeTotalPrice.ca",
						data : {
							cart_idx : cart_idx,
							type : "plus",
							total_price : total_price,
							total_order_price : total_order_price
						},
						dataType : "json",
						success : function(data) {
							//총 주문금액 
							total_price = data.cart_total_price
									.toLocaleString("en-US");

							//총 할인금액 
							total_discount_price = (data.cart_total_price - data.cart_order_total_price)
									.toLocaleString("en-US");

							//총 상품금액
							total_order_price = data.cart_order_total_price
									.toLocaleString("en-US");

							//주문, 할인, 상품 금액 넣기
							$("#total_product_area").text(total_price);
							$("#discount_area").text(total_discount_price);
							$("#total_order_area").text(total_order_price);

						}//success 끝
					});//ajax 끝

		}

	}//check_function 끝

	// 체크된 cart_idx 값을 넘기는 작업
	function goOrder() {
		var check = $('input[name=cartCheckBox]:checked');
		let chk_arr = new Array();
		$('input[name=cartCheckBox]:checked').each(function(i) {
			chk_arr.push($(this).val());
		});
		if (chk_arr.length > 0) {
			alert("구매페이지로 이동합니다.");
			location.href = "CartOrderDetail.ca?cart_idx=" + chk_arr;

		} else {
			alert("선택된 상품이 없습니다. 구매하실 상품을 선택하세요.")
		}

	}
	
	
	function selected_delete() {
		var selectedArr = new Array();
		$("input[name=cartCheckBox]:checked").each(function(i) {
			selectedArr.push($(this).val());
		})
// 		alert(selectedArr.length)
		var confirmDelete = confirm("선택한 상품을 장바구니에서 삭제 하시겠습니까? ")
		if(confirmDelete){
			location.href='CartDeletePro.ca?cart_idxArr=' + selectedArr
		}
		
	}
</script>
<style type="text/css">
#sform {
          display: inline-block;
          text-align: center;
        }
.td_cart{
	font-size: 18px;
	text-align: center;
	vertical-align : middle;
	height: 50px;
}

.th_cart{
	font-size: 20px;
	text-align: center;
	background-color: #DCEBFF;
	height: 60px;
	vertical-align: middle;
}
</style>
<style type="text/css">
#table {	
   	text-align: center;
}
</style>
<style>
    .paging {
        text-align: center;
    }
    .paging a {
        /*
        display: inline-block 인라인 요소의 특징과 블록 요소의 특징을 모두 갖는다
        크기를 가질 수 있으며 텍스트 정렬도 적용받는다
        */
        display: inline-block;
        
        font-weight: bold;
        text-decoration: none;
        padding: 5px 8px;
        border: 1px solid #ccc;
       	color: #000; 
/*         background-color: #F5F5DC; */
    }
    /* 현재 페이징에 select 클래스를 적용한다*/
    .paging a.select {
/*         color: #fff; */
/*         background-color: #FFA7A7; */
    }
    </style>

<style>
/* .w3-sidebar a {font-family: "Roboto", sans-serif} */
body,h1,h2,h3,h4,h5,h6,.w3-wide {font-family: "Noto Sans KR", sans-serif;} 
</style>

<style>
    
    .footer {
    	padding: 50px;
    }
    
    .top_circle {
    	 
	    border-radius: 50%;
	    
	    width: 100px;
	    height: 100px;
	    margin: 0px 7px;
/* 	    padding-bottom: 24%; */
	    
	    position: relative;
    }
    
    .top_circle_h {
    	 position : absolute;
    	 top: 20%;
	    left : 19%;
	    bottom :30%;
	    
	    font-size: 18px;
	    text-align: center;
	    font-weight: bold;
    }
    
    #order_circle {
    	background-color: #d2d2d2;
    }
    #cart_circle {
    	background-color: #DCEBFF;
    }
    #com_circle {
    	background-color: #d2d2d2;
    }
    
  .cb {
    font-size: 23px;
    }
    
    #no_cart {
    	padding: 50px 0px;
    }
    #form_area{
	  height: auto;
	  min-height: 100%;
	  padding-bottom: 300px;
	}
	    </style>
    <style>
#Demo{
font-size: 70%;
}
</style>
</head>
<body class="w3-content" style="max-width:95% ">
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
	 <div style="float: right;">
	 <jsp:include page="../inc/top.jsp"/>
	</div>
	
	<!--   <header class="w3-container w3-xlarge"> -->
	
	
	
	
	  <header class="w3-container w3-xlarge" style="padding: 80px 50px;  z-index: -1">
	    <p class="w3-left" style="font-size: 37px">
	    <i class="fa-solid fa-bag-shopping" ></i>
	<!--     <i class="fa-solid fa-cart-shopping"></i> -->
	    &nbsp;장바구니</p>
	<!--     <div class="w3-right out-div"> -->
		    <div class="top_circle w3-right" id="order_circle"><h3 class="top_circle_h"><b class="cb">03</b><br>주문완료</h3></div>
		    <div class="top_circle w3-right" id="com_circle"><h3 class="top_circle_h"><b class="cb">02</b><br>주문/결제</h3></div>
		    <div class="top_circle w3-right" id="cart_circle"><h3 class="top_circle_h"><b class="cb">01</b><br>장바구니</h3></div>
	<!--     <i id="cart_circle" class="fa-solid fa-circle"></i> -->
	<!--     </div> -->
	</header>
	   <hr size="25px">
	<!--   Footer -->
	<!--   <footer class="w3-padding-64 w3-small w3-center" id="footer"> -->
	<div id="form_area">
	
	  <table class="table" style="height: 50px; padding: 40px; margin-top:20px; font-weight: bold;">
		<thead>
		    <tr>
		      <th scope="col" colspan="8" style="font-size: x-large;">장바구니 목록</th>
		    </tr>
	   </thead>
	  <thead  class="table-primary" >
	    <tr>
	      <th scope="col" class ="th_cart"><input type="checkbox" class ="form-check-input"  id="chkAll" checked="checked"></th>
	      <th scope="col" class ="th_cart"colspan="2">상품명</th>
	<!--       <th scope="col">상품명</th> -->	
	      <th scope="col"  class ="th_cart">상품금액</th>
	      <th scope="col"  class ="th_cart">할인금액</th>
	      <th scope="col"  class ="th_cart">주문금액</th>
	      <th scope="col"  class ="th_cart">수량</th>
	      <th scope="col"  class ="th_cart">배송정보</th>
	      <th scope="col"  class ="th_cart"><button type="button" class="btn btn-light" style="font-weight: bold;" onclick="selected_delete()">선택 삭제</button></th>
	    </tr>
	  </thead>
	  <tbody>
	  	<!-- 카트 리스트가 없을 때 처리 -->
	    <c:if test="${cartlist eq null or empty cartlist}">
				<tr>
					<td colspan="8" style="text-align: center;"><b>담긴 상품이 없습니다.</b></td>
				</tr>
		</c:if>
		<!-- 카트 리스트가 있을 때 처리 -->
		<c:if test="${cartlist ne null and not empty cartlist}">
		<!-- 카트 목록(foreach로 처리) -->
	    <c:forEach var="cart" items="${cartlist }" varStatus="status">
		    <tr>
		      <!-- 체크박스 -->
		      <input type="hidden" id="cart_idx_hidden${status.index }" value="${cart.cart_idx }">
			  <td class ="td_cart"><input type="checkbox" class ="form-check-input" id="cartCheckBox${status.index }" name ="cartCheckBox" checked="checked" value="${cart.cart_idx }" onclick="check_function(this)"></td> 
		      <td>
			      <a href="ProductInfoForm.po?product_idx=${cart.product_idx }">
			      <img src="${path}/resources/upload/${cart.cart_product_image }"  onError="this.onerror=null; this.src='resources/images/noImg.JPG';"  alt="..." class="img-thumbnail" width="150" height="150" >
<%-- 			      <img src="${path}/resources/upload/${productBestList.image_main_file }" onError="this.onerror=null; this.src='resources/images/noImg.JPG';"  alt="..." style="width: 100%"> --%>
			      </a>
		      </td>
		      <td class ="td_cart" style="text-align:left;">
		      <span style="font-size: 20px; font-weight: bold;"> ${cart.cart_product_name }<br></span>
		      <span style="color: #91949A;">색상 : ${cart.cart_color } / 사이즈 : ${cart.cart_size }</span>
		      </td>
			  <td class ="td_cart" id="cart_price${status.index }"><fmt:formatNumber value="${cart.cart_price }" pattern="#,###원"></fmt:formatNumber></td>
			  <input type="hidden" name="cart_price" value="${cart.cart_price }">
			  <input type="hidden" name="cart_order_price" value="${cart.cart_order_price }">
		      <td class ="td_cart" id="cart_discount_price"><fmt:formatNumber value="${cart.cart_price * (cart.cart_discount / 100)}" pattern="#,###원"></fmt:formatNumber></td>
		      <td class ="td_cart" id="cart_order_price${status.index }" ><fmt:formatNumber value="${cart.cart_order_price}" pattern="#,###원"></fmt:formatNumber></td> 
		      <td class ="td_cart" style="vertical-align: middle;">
		      <button id="minus_btn${status.index }" class="btn btn-outline-dark btn-sm" onclick="amount_adjust_minus(this)"  style ="width: 30px; height: 35px; font-size: 15px;">-</button>
			  <input type="text" class="form-control" id="cart_count_id${status.index }" name="cart_count" value="${cart.cart_count }" required="required" readonly="readonly" style="width: 40px; text-align: center; display: inline-block;">
		      <button id="plus_btn${status.index }"class="btn btn-outline-dark btn-sm" onclick="amount_adjust_plus(this)"  style ="width: 30px; height: 35px; font-size: 15px;">+</button>
		      </td>
		      <td class ="td_cart">무료배송</td>
		      <td class ="td_cart">
		      <button type="button" id="cart_delete_btn${status.index }" class="btn btn-primary" onclick="deleteCart(this)">삭제</button>
		      </td>
		    </tr>
	    </c:forEach>
	    </c:if>
	  </tbody>
	</table>
	<!-- 페이징 처리 -->	
		<div class="paging">
	        <c:choose>
				<c:when test="${param.pageNum > 1}">
					<a href="CartList.ca?pageNum=${param.pageNum - 1 }&member_idx=${member_idx }">이전</a>
				</c:when>
				<c:otherwise>
					<a href="javascript:void(0)">이전</a>
				</c:otherwise>
			</c:choose>
			
			<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
				<!-- 단, 현재 페이지 번호는 링크 없이 표시 -->
				<c:choose>
					<c:when test="${param.pageNum eq i}">
						${i }
					</c:when>
					<c:otherwise>
						<a href="CartList.ca?pageNum=${i }&member_idx=${member_idx }">${i }</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			<c:choose>
				<c:when test="${param.pageNum < pageInfo.maxPage}">
					<a href="CartList.ca?pageNum=${param.pageNum + 1 }&member_idx=${member_idx }">다음</a>
				</c:when>
				<c:otherwise>
					<a href="javascript:void(0)">다음</a>
				</c:otherwise>
			</c:choose>
	    </div>
	    <!-- 결제금액 영역 -->
		<div class="container px-4 text-center" id="totalResult" style="margin-top: 30px; font-size: 25px;">
		  <div class="row gx-5" >
		    <div class="col">
				<div class="p-3 border bg-light" style="font-size: 25px; ">
					<span style="margin-right: 12px">상품 금액</span> 
					<span style="font-size: 27px;" id="total_product_area">
						<fmt:formatNumber pattern="#,###" value="${cart_total_price }"></fmt:formatNumber>
					</span>
					<span style="font-size: 27px; margin-right: 25px;">원</span>
					<span class="material-symbols-outlined" style="margin-right: 30px; font-size: 25px">do_not_disturb_on</span>					
					<span style="margin-right: 12px">할인 금액</span> 
					<span style="font-size: 27px;" id="discount_area">
						<fmt:formatNumber pattern="#,###" value="${cart_total_price-cart_order_total_price }"></fmt:formatNumber>
					</span>
					<span style="font-size: 27px; margin-right: 25px;">원</span>
					
					<span class="material-symbols-outlined" style="margin-right: 30px; font-size: 25px">equal</span>
					<span style="margin-right: 12px">총 결제금액</span> 
					<span style="font-size: 27px; color: blue;" id="total_order_area">
						<fmt:formatNumber pattern="#,###" value="${cart_order_total_price }"></fmt:formatNumber>
					</span>
					<span style="font-size: 27px; margin-right: 25px;">원</span>
					
					<br>
		      	<input type="button" class="btn btn-primary btn-lg" onclick="goOrder()" value="구매하기" style="margin-top: 30px; width: 100px" >
				</div>	    
		    </div>
		  </div>
	    </div>
	
   	</div>
	  	<jsp:include page="../inc/footer.jsp"/>
 </div>
	  
	  
	
	
	
	<!-- Newsletter Modal -->
	<div id="newsletter" class="w3-modal">
	  <div class="w3-modal-content w3-animate-zoom" style="padding:32px">
	    <div class="w3-container w3-white w3-center">
	      <i onclick="document.getElementById('newsletter').style.display='none'" class="fa fa-remove w3-right w3-button w3-transparent w3-xxlarge"></i>
	      <h2 class="w3-wide">NEWSLETTER</h2>
	      <p>Join our mailing list to receive updates on new arrivals and special offers.</p>
	      <p><input class="w3-input w3-border" type="text" placeholder="Enter e-mail"></p>
	      <button type="button" class="w3-button w3-padding-large w3-red w3-margin-bottom" onclick="document.getElementById('newsletter').style.display='none'">Subscribe</button>
	    </div>
	  </div>
	</div>


<!-- ------------------------------------------------------------------------------------------------------------>
<!-- 자바스크립트 부분 -->

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


<script type="text/javascript">


// $(document).ready(function(){
// 	let listArr = new Array();
//     let list = $("input[name='cartCheckBox']:checked");
    
//     for(var i = 0; i < list.length; i++){
//         if(list[i].checked){
//            listArr.push(list[i].value);
//            alert("배열값 = "+ listArr);
//         }
//      }
// }); 
</script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript">
function iamport(){
	// 	
		//가맹점 식별코드
		IMP.init('imp77718215');
		IMP.request_pay({
		    pg : 'kakaopay',
		    pay_method : 'cart',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : 'SHOOKREAM' , //결제창에서 보여질 이름
		    amount : '${total }', //실제 결제되는 가격
		    buyer_name : '${sessionScope.sId}',
		}, function(rsp) {
			console.log(rsp);
		    if ( rsp.success ) {
		    	var msg = '결제가 완료되었습니다.';
		        msg += '고유ID : ' + rsp.imp_uid;
		        msg += '상점 거래ID : ' + rsp.merchant_uid;
		        msg += '결제 금액 : ' + rsp.paid_amount;
		        msg += '카드 승인번호 : ' + rsp.apply_num;
		        location.href="ProductOrderPro.po?order_category=주문완료&order_progress=배송완료&member_idx=${member_idx}&product_idx=${product.product_idx}&product_amount=${product.product_amount}&product_sell_count=${product.product_sell_count} ";
		    } else {
		    	 var msg = '결제에 실패하였습니다.';
		         msg += '에러내용 : ' + rsp.error_msg;
		         window.history.back();
		    }
		    alert(msg);
		    
		});
	}

	
</script>
<script>
//드롭다운 기능
   function myFunction() {
     var x = document.getElementById("Demo");
     if (x.className.indexOf("w3-show") == -1) { 
       x.className += " w3-show";
     } else {
       x.className = x.className.replace(" w3-show", "");
     }
   }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>
