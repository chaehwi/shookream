<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri ="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>주문 상세 내용</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
<!-- icon CDN -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
<!-- 네이버아이디로그인 -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<!-- 구글 아이디 로그인 -->
<meta name="google-signin-client_id" content="1047574308186-h6ehte2k4901kjn1u3g5vnonbf2g56on.apps.googleusercontent.com">
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
}t-align: center;
}
</style>
<style type="text/css">
#table {	
	margin-top: 150px
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
    #delivery_table td {
		vertical-align : middle;
	}	
	}
	table th {
		vertical-align : middle;
		width: 200px;
	}	
	
/* 	td { */
/* 	vertical-align : baseline; */
/* 	} */
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
    	background-color: #d2d2d2;
    	
    }
    #com_circle {
    	background-color: #DCEBFF;
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
 <script src="../js/jquery-3.6.3.js"></script>
 <script type="text/javascript">
 
	 
	 // 쿠폰 보러가기 클릭 함수
// 	function CouponCheck() {
// 		let url = "CouponListForm.po";
// 		let name = "Coupon List";
// 		let attr = "width=900, height=600, top=200, left=510"
	
// 		window.open(url, name, attr);
// 	}
	function total_discount_cal() {
		
	}

	 
	
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
 <div style="float: right;">
 <jsp:include page="../inc/top.jsp"/>
</div>
  
  <!-- Top header -->
  
  <div style="padding: 100px 100px;">
  <header class="w3-container w3-xlarge">
    <p class="w3-left">주문하기</p>
    <p class="w3-right">
    </p>
</header>
   
   <div id="form_area">
		  <table class="table" style="height: 50px; padding: 40px; margin-top:20px; font-weight: bold;">
			<thead>
			    <tr>
			      <th scope="col" colspan="8" style="font-size: x-large;">주문내역 목록</th>
			    </tr>
		   </thead>
		  <thead  class="table-primary" >
		    <tr>
		      <th scope="col" class ="th_cart"colspan="2">상품명</th>
		<!--       <th scope="col">상품명</th> -->	
		      <th scope="col"  class ="th_cart">상품금액</th>
		      <th scope="col"  class ="th_cart">할인금액</th>
		      <th scope="col"  class ="th_cart">주문금액</th>
		      <th scope="col"  class ="th_cart">수량</th>
		      <th scope="col"  class ="th_cart">배송정보</th>
		    </tr>
		  </thead>
		  <tbody>
		  	<!-- 카트 리스트가 없을 때 처리 -->
		    <c:if test="${product eq null or empty product}">
					<tr>
						<td colspan="8" style="text-align: center;"><b>주문내역이 없습니다.</b></td>
					</tr>
			</c:if>
			<!-- 카트 리스트가 있을 때 처리 -->
			<c:if test="${product ne null and not empty product}">
			<!-- 카트 목록(foreach로 처리) -->
			    <tr>
			      <td><a href="ProductInfoForm.po?product_idx=${product.product_idx }"><img src="upload/${product.image_main_file }"  alt="없음!" class="img-thumbnail" width="150" height="150" ></a></td>
			      <td class ="td_cart" style="text-align:left;">
			      <span style="font-size: 20px; font-weight: bold;"> ${product.product_name }<br></span>
			      <span style="color: #91949A;">색상 : ${product.product_color } / 사이즈 : ${product.product_size }</span>
			      </td>
				  <td class ="td_cart" id="cart_price"><fmt:formatNumber value="${product.product_price }" pattern="#,###원"></fmt:formatNumber></td>
			      <td class ="td_cart" id="cart_discount_price"><fmt:formatNumber value="${product.product_price * (product.product_discount_price / 100)}" pattern="#,###원"></fmt:formatNumber></td>
			      <td class ="td_cart" id="cart_order_price" ><fmt:formatNumber value="${product.product_price - product.product_price * (product.product_discount_price / 100)}" pattern="#,###원"></fmt:formatNumber></td> 
			      <td class ="td_cart" style="vertical-align: middle;">
<%-- 			      <button id="minus_btn${status.index }" class="btn btn-outline-dark btn-sm" onclick="amount_adjust_minus(this)"  style ="width: 30px; height: 35px; font-size: 15px;">-</button> --%>
<%-- 				  <input type="text" class="form-control" id="cart_count_id${status.index }" name="cart_count" value="${param.order_count }" required="required" readonly="readonly" style="width: 40px; text-align: center; display: inline-block;"> --%>
<%-- 			      <button id="plus_btn${status.index }"class="btn btn-outline-dark btn-sm" onclick="amount_adjust_plus(this)"  style ="width: 30px; height: 35px; font-size: 15px;">+</button> --%>
			       		${param.order_count } 개
			      </td>
			      <td class ="td_cart">무료배송</td>
			    </tr>
		    </c:if>
		  </tbody>
		</table>
   
	 <!-- 배송 정보 -->
<table class="table" id="delivery_table" style="border-collapse: separate; border-spacing: 0 13px; font-size: 18px">
	  <thead>
	    <tr>
	      <th scope="col" colspan="8" style="font-size: x-large;">배송 정보</th>
	    </tr>
	  </thead>
	  <tbody>
	   <tr>
	    	<th colspan="2">
	    		주문 하시는 분
	    	</th>
	    	<td colspan="6">
	    		${member.member_id} 님<br>
	    		${member.member_email }<br>
	    		${fn:substring(member.member_phone,0,3) } -  
	    		${fn:substring(member.member_phone,3,7) } -  
	    		${fn:substring(member.member_phone,7,12) }  
	    		<br>
	    	</td>
	   </tr>
	   <tr>
		<th colspan="2">배송지 선택</th>
		<td colspan="6" style="margin-left:500px;">
			<input type="radio" value="order" name="address" checked="checked" id="order"> 기본배송지
			<input type="radio" value="new" name="address"> 새로운 배송지
		</td>
	   </tr>
	   <tr>
	   <th colspan="2">받으시는 분</th>   
	   <td>
	   	  <div id="address">
	   	  <div class="row mb-3">
                <label for="th" id="title_label" class="col-md-2 col-lg-2 col-form-label">성함</label>
                <div class="col-md-8 col-lg-2">
                  <input name="order_name" type="text" class="form-control" id="order_name" value="${member.member_name }">
                </div>
           </div>
	 	 <div class="row mb-3">
               <label for="th" id="title_label" class="col-md-2 col-lg-2 col-form-label">연락처</label>
               <div class="col-md-8 col-lg-2">
                 <input name="order_phone" type="text" class="form-control" id="order_phone" value="${member.member_phone }">
               </div>
           </div>
	 	 <div class="row mb-3">
                <label for="th" id="title_label" class="col-md-2 col-lg-2 col-form-label">주소</label>
                <div class="col-md-8 col-lg-5">
                  <input name="order_addr1" type="text" class="form-control" id="order_addr1" value="${fn:split(member.member_address,',')[0]}">
                </div>
           </div>
	 	 <div class="row mb-3">
              <label for="th" id="title_label" class="col-md-2 col-lg-2 col-form-label"></label>
              <div class="col-md-8 col-lg-5">
                <input name="order_addr2" type="text" class="form-control" id="order_addr2" value="${fn:split(member.member_address,',')[1]}">
              </div>
           </div>
	   </div>
	   
	   <div id="newaddress">
	   	  <div class="row mb-3">
                <label for="th" id="title_label" class="col-md-2 col-lg-2 col-form-label">성함</label>
                <div class="col-md-8 col-lg-2">
                  <input name="order_name" type="text" class="form-control" id="new_order_name">
                </div>
           </div>
	 	 <div class="row mb-3">
               <label for="th" id="title_label" class="col-md-2 col-lg-2 col-form-label">연락처</label>
               <div class="col-md-8 col-lg-2">
                 <input name="order_phone" type="text" class="form-control" id="new_order_phone">
               </div>
           </div>
	 	 <div class="row mb-3">
                <label for="th" id="title_label" class="col-md-2 col-lg-2 col-form-label">주소</label>
                <div class="col-md-8 col-lg-5">
                  <input name="order_addr1" type="text" class="form-control" id="new_order_addr1">
                </div>
           </div>
	 	 <div class="row mb-3">
              <label for="th" id="title_label" class="col-md-2 col-lg-2 col-form-label"></label>
              <div class="col-md-8 col-lg-5">
                <div class="input-group mb-6">
                <input name="order_addr2" type="text" class="form-control" id="new_order_addr2">
              	<button id="address_kakao" class="btn btn-primary" style="float: right;">주소찾기</button>
               </div>
              </div>
           </div>
	   </div>
	   </td>
	   </tr>
	   <tr>
	   	<th colspan="2">배송 메세지</th>
	   	<td>
	   		<select class="form-select" id="order_content" style="width: 300px">
	   			<option>부재시 문 앞에 놓아주세요</option>
	   			<option>경비실에 놔둬주세요. </option>
	   			<option>전화 부탁 드립니다</option>
	   			<option>소화전에 넣어 주세요</option>
	   		</select>
	   	 </td>
	   </tr>
	  </tbody>
	</table>
	
<!-- 할인 정보 및 총 결제가격 표시	 -->

<!-- 배송 정보 -->
<table class="table" id="delivery_table" style="border-collapse: separate; border-spacing: 0 13px; font-size: 18px">
  	  <input type="hidden" id="coupon_idx" >
	  <thead>
	    <tr>
	      <th scope="col" colspan="6" style="font-size: x-large;">할인 금액</th>
	    </tr>
	  </thead>
	  <tbody>
	   <tr>
		<th colspan="2">즉시 할인금액</th>
		<td><input type="text" class="form-control" readonly="readonly" value="<fmt:formatNumber value='${product.product_price * (product.product_discount_price / 100)}'></fmt:formatNumber>" style="width: 100px; display: inline-block; text-align: right; font-size: 18px ">원 할인 
	   	</td>
	   </tr>
	   <tr>
		<th colspan="2">상품 할인쿠폰</th>
		<td><input type="text" class="form-control" id="priceValue" readonly="readonly" value="0" style="width: 100px; display: inline-block; text-align: right; font-size: 18px">원 할인 
	   	<button type="button" class="btn btn-outline-danger" onclick="CouponCheck()">쿠폰함</button>
	   	</td>
	   </tr>
	   </tbody>
 </table>
   
	 
	 <!-- 결제금액 영역 -->
		<div class="container px-4 text-center" id="totalResult" style="margin-top: 30px; font-size: 25px;">
		  <div class="row gx-5" >
		    <div class="col">
				<div class="p-3 border bg-light" style="font-size: 25px; ">
					<span style="margin-right: 12px">상품 금액</span> 
					<span style="font-size: 27px;">
						<fmt:formatNumber pattern="#,###" value="${product.product_price }"></fmt:formatNumber>
					</span>
					<span style="font-size: 27px; margin-right: 25px;">원</span>
					
					<span class="material-symbols-outlined" style="margin-right: 30px; font-size: 25px">do_not_disturb_on</span>	
									
					<span style="margin-right: 12px">할인 금액</span> 
					<span style="font-size: 27px;" id="discount_area">
						<fmt:formatNumber pattern="#,###" value="${product.product_price * (product.product_discount_price / 100)}"></fmt:formatNumber>
					</span>
					<span style="font-size: 27px; margin-right: 25px;">원</span>
					
					<span class="material-symbols-outlined" style="margin-right: 30px; font-size: 25px">equal</span>
					
					<span style="margin-right: 12px">총 결제금액</span> 
					<span style="font-size: 27px; color: blue;" id="order_total_area">
						<fmt:formatNumber pattern="#,###" value="${product.product_price - product.product_price * (product.product_discount_price / 100)}"></fmt:formatNumber>
					</span>
					<span style="font-size: 27px; margin-right: 25px;">원</span>
					
					<br>
		      	<input type="button" id="order_button" class="btn btn-primary btn-lg" onclick="iamport()" value="결제" style="margin-top: 30px; width: 100px" >
		      	<input type="hidden" id="order_discount_price" value="${product.product_price * (product.product_discount_price / 100)}">
		      	<input type="hidden" id="order_total_price" value="${product.product_price - product.product_price * (product.product_discount_price / 100)}">
				</div>	    
		    </div>
		  </div>
	    </div>
	    
<!-- </footer> -->
 <footer>
  	<jsp:include page="../inc/footer.jsp"/>
  </footer> 
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
<!-- 카카오 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
window.onload = function(){
    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("new_order_addr1").value = data.address; // 주소 넣기
                document.querySelector("input[id=new_order_addr1]").focus(); //상세입력 포커싱
            }
        }).open();
    });
}
</script>

<!-- 자바스크립트 부분 -->
<script type="text/javascript">
function CouponCheck() {
	let url = "CouponListForm.po?member_idx="+${sessionScope.member_idx}+"&product_price="+${product.product_price - product.product_price * (product.product_discount_price / 100)};  // 테스트용 파라미터임!
	let name = "Coupon List";
	let attr = "width=900, height=600, top=200, left=510"

	window.open(url, name, attr);
}

</script>
<script src="../js/jquery-3.6.3.js"></script>
<script>
$(function() {
	 $("#newaddress").hide();
	 var amount = parseInt("${product.product_amount}");
	 if(amount <= 0){
			alert("재고가 없습니다");
		 history.back();
	 }
	 
});
$("input:radio[name='address']").change(function() {
	let location = $("input:radio[name='address']:checked").val();
	if(location == 'new'){
		$("#newaddress").show();
		$("#address").hide();
	}else if(location == 'order'){
		$("#address").show();
		$("#newaddress").hide();
	}
});// 내부,외부처리


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
<!-- 주문하기 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript">
function iamport(){
	let order_name_value = document.getElementById("order_name").value;
	let order_phone_value =  document.getElementById("order_phone").value; 
	let order_addr1_value =  document.getElementById("order_addr1").value;
	let order_addr2_value= document.getElementById("order_addr2").value;
	let order_content = document.getElementById("order_content").value;
	if(document.getElementById("new_order_name").value != "" || document.getElementById("new_order_name").value == null){
		order_name_value =document.getElementById("new_order_name").value;
	}
	
	if(document.getElementById("new_order_phone").value != "" || document.getElementById("new_order_phone").value == null){
		order_phone_value =document.getElementById("new_order_phone").value;
	}
	
	if(document.getElementById("new_order_addr1").value != "" || document.getElementById("new_order_addr1").value == null){
		order_addr1_value =document.getElementById("new_order_addr1").value;
	}
	
	if(document.getElementById("new_order_addr2").value != "" || document.getElementById("new_order_addr2").value == null){
		order_addr2_value =document.getElementById("new_order_addr2").value;
	}
	
	var price = parseInt(document.getElementById("order_total_price").value);
	//getter
    IMP.init('imp77718215');
//     var money = $('input[name="cp_item"]:checked').val();
//     console.log(money);
    IMP.request_pay({
        pg: 'html5_inicis',
        pay_method : 'card',
        merchant_uid: "order_no_"+ new Date().getTime(), // 상점에서 관리하는 주문 번호를 전달
        name : '${product.product_name}',
        amount : price,
        buyer_email : 'iamport@siot.do',
        buyer_name : '${sessionScope.sId}',
        buyer_tel : '010-1234-5678',
        buyer_addr : '서울특별시 강남구 삼성동',
        buyer_postcode : '123-456',
    }, function(rsp) { // callback 로직
    	console.log(rsp);
	    if ( rsp.success ) {
	    	var msg = '결제가 완료되었습니다.';
	    	$.ajax({
				type: "GET",
				url: "ProductOrderPro.po",
				data : {
					"order_price":price,
					"member_idx":${sessionScope.member_idx},
					"product_idx":${param.product_idx},
					"order_product_name":"${product.product_name}",
					"order_count":${param.order_count},
					"order_size":"${product.product_size}",
					"order_color":"${product.product_color}",
					"order_name":order_name_value,
					"order_phone":order_phone_value,
					"order_addr1":order_addr1_value,
					"order_addr2":order_addr2_value,
					"order_content":order_content
				}
			})
			.done(function(whlist) { // 요청 성공 시
				alert(msg);
				var id = '${sessionScope.sId}';
				location.href="./ProductOrderList.po?id="+id+"&member_idx="+${sessionScope.member_idx}+"&pageNum="+1;
			})
	    } else {
	    	 var msg = '결제에 실패하였습니다.';
// 	         msg += '에러내용 : ' + rsp.error_msg;
// 	         window.history.back();
	    }
    });
	}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>
