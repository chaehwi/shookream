<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri ="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>SHOOKREAM</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
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
<script>
	// 리뷰작성 폼 팝업 
	function reviewForm(re_idx,re_size,re_color,re_name) {
		let url = "ReviewWriteForm.me?member_idx=${sessionScope.member_idx}&product_idx="+re_idx+"&product_size="+re_size+"&product_color="+re_color+"&product_name="+re_name;  // 테스트용 파라미터임!
		let name = "review form";
		let attr = "width=600, height=600, top=200, left=510"
		
		window.open(url, name, attr);
// 		window.open.member_idx = ${sessionScope.member_idx};
// 		window.open.product_idx = idx;
// 		window.open.product_size = size;
// 		window.open.product_color = color;
		
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
  
  <div style="padding: 80px;">
  <header class="w3-container w3-xlarge">
    <p class="w3-left">주문내역</p>
    <p class="w3-right">
    </p>
</header>
   

  <div class="w3-padding-64 w3-small w3-center">
 	 <form action="ReviewWrite.me" method="post">
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
		      <th scope="col"  class ="th_cart"></th>
		    </tr>
		  </thead>
		  <tbody>
		  	<!-- 카트 리스트가 없을 때 처리 -->
		    <c:if test="${orderList eq null or empty orderList}">
					<tr>
						<td colspan="8" style="text-align: center;"><b>주문내역이 없습니다.</b></td>
					</tr>
			</c:if>
			<!-- 카트 리스트가 있을 때 처리 -->
			<c:if test="${orderList ne null and not empty orderList}">
			<!-- 카트 목록(foreach로 처리) -->
		    <c:forEach var="order" items="${orderList }" varStatus="status">
			    <tr>
			      <td><a href="ProductInfoForm.po?product_idx=${order.product_idx }"><img src="upload/${order.image_main_file }"  alt="없음!" class="img-thumbnail" width="150" height="150" ></a></td>
			      <td class ="td_cart" style="text-align:left;">
			      <span style="font-size: 20px; font-weight: bold;"> ${order.order_product_name }<br></span>
			      <span style="color: #91949A;">색상 : ${order.product_color } / 사이즈 : ${order.product_size }</span>
			      </td>
				  <td class ="td_cart" id="cart_price"><fmt:formatNumber value="${order.product_price }" pattern="#,###원"></fmt:formatNumber></td>
			      <td class ="td_cart" id="cart_discount_price"><fmt:formatNumber value="${order.order_price * (order.product_discount_price / 100)}" pattern="#,###원"></fmt:formatNumber></td>
			      <td class ="td_cart" id="cart_order_price" ><fmt:formatNumber value="${order.order_price}" pattern="#,###원"></fmt:formatNumber></td> 
			      <td class ="td_cart" style="vertical-align: middle;">
<%-- 			      <button id="minus_btn${status.index }" class="btn btn-outline-dark btn-sm" onclick="amount_adjust_minus(this)"  style ="width: 30px; height: 35px; font-size: 15px;">-</button> --%>
<%-- 				  <input type="text" class="form-control" id="cart_count_id${status.index }" name="cart_count" value="${cart.cart_count }" required="required" readonly="readonly" style="width: 40px; text-align: center; display: inline-block;"> --%>
<%-- 			      <button id="plus_btn${status.index }"class="btn btn-outline-dark btn-sm" onclick="amount_adjust_plus(this)"  style ="width: 30px; height: 35px; font-size: 15px;">+</button> --%>
			      	  ${order.order_count }개
			      </td>
			      <td class ="td_cart">${order.order_progress }</td>
			      <td class ="td_cart">
			    <input type="button" value="리뷰 작성하기" class="btn btn-primary" onclick="reviewForm(${order.product_idx },'${order.product_size }','${order.product_color }','${order.product_name }')">
			    <input type="button" value="배송 상세정보" class="btn btn-primary" onclick="deliveryDetail()">
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
							<a href="ProductOrderList.po?pageNum=${param.pageNum - 1 }&member_idx=${member_idx }">이전</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:void(0)">이전</a>
						</c:otherwise>
					</c:choose>
					
					<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
						<!-- 단, 현재 페이지 번호는 링크 없이 표시 -->
								<a href="ProductOrderList.po?pageNum=${i }&member_idx=${member_idx }">${i }</a>
					</c:forEach>
					
					<c:choose>
						<c:when test="${param.pageNum < pageInfo.maxPage}">
							<a href="ProductOrderList.po?pageNum=${param.pageNum + 1 }&member_idx=${member_idx }">다음</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:void(0)">다음</a>
						</c:otherwise>
					</c:choose>
		    </div>
	   	</div>
	</form>
	</div>
</div>
<!-- 로그인 화면 폼 -->
  <!-- End page content -->


 <footer>
  	<jsp:include page="../inc/footer.jsp"/>
  </footer>
</div>

<!-- ------------------------------------------------------------------------------------------------------------>
<!-- 자바스크립트 부분 -->


<script type="text/javascript">
function deliveryDetail() {
	alert("감지");
	let url = "ProductOrderDeliveryPro.po";  // 테스트용 파라미터임!
	let name = "주문내역 상세정보";
	let attr = "width=1000, height=1000, top=500, left=510"
	
	window.open(url, name, attr);
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
<script>
//주문리스트 삭제
// function deleteOrder(idx){
// 	let result =  confirm("삭제 하시겠습니까?");
// 	if(result){
// 		location.href="OrderDeletePro.po?order_idx="+idx+"&member_idx=${sessionScope.member_idx}&product_idx=${param.product_idx}";
// 	}
// }



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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>
