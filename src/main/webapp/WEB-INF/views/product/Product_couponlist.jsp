<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri ="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
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
	* {
		font-family: "Noto Sans KR", sans-serif;
	}
	
#table {
     text-align: center;
}
</style>
</head>
<body>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-top: 10px;margin-right: 17px;">

 <!-- Push down content on small screens -->
 <div class="w3-hide-large" style="margin-top:83px"></div>
 

 <header class="w3-container w3-xlarge" style="padding: 50px 50px;">
    <p class="w3-left" style="font-size: 37px">
    <i class="fa-solid fa-heart" style="color: #FFC0CB;"></i>
    사용가능한 쿠폰</p>
</header>
    <hr size="25px">
  <!-- Footer -->
  <div class="w3-small w3-center" style="padding: 40px; margin-top:20px; font-weight: bold; ">
  <c:choose>
  	<c:when test="${couponList eq null or empty couponList}">
  		<div id="no_cart" style="padding: 50px;">
<!--   		<i class="fa-solid fa-cart-plus"></i> -->
  		<h5>쿠폰이 없습니다.</h5>
  		</div>
  	</c:when>
  	<c:otherwise>
  <table class="table" style="height: 50px; ">
  <thead class="table-primary" >
    <tr>
<!--       <th scope="col">#</th> -->
      <th scope="col" class ="th_cart">쿠폰명</th>
      <th scope="col" class ="th_cart">할인금액</th>
      <th scope="col" class ="th_cart">최소주문금액</th>
      <th scope="col" class ="th_cart">최대할인금액</th>
      <th scope="col" class ="th_cart">만료일</th>
      <th scope="col" class ="th_cart"></th>
    </tr>
  </thead>
  <tbody>
    
    <c:forEach var="couponList" items="${couponList }">
    <tr>

<%--       <th scope="row">${wish.wish_idx }</th> --%>
<%--       <td class ="td_cart"><a href="ProductInfoForm.po?product_idx=${couponList.product_idx }"><img src="upload/${wish.product_img }" onError="this.onerror=null; this.src='resources/images/noImg.JPG';" alt="없음!"  width="100" height="70"></a></td> --%>
      <td class ="td_cart">${couponList.coupon_name }</td>
      <td class ="td_cart"><fmt:formatNumber value="${couponList.coupon_benefit_price }" pattern="#,###"></fmt:formatNumber> ${couponList.coupon_benefit_unit }</td>
      <td class ="td_cart"><fmt:formatNumber value="${couponList.coupon_min_price }" pattern="#,###"></fmt:formatNumber> 원</td>
      <c:choose>
  		<c:when test="${couponList.coupon_max_discount eq null}">
  			<td class ="td_cart"><fmt:formatNumber value="${couponList.coupon_benefit_price }" pattern="#,###"></fmt:formatNumber> 원</td>
  		</c:when>
  		<c:otherwise>
      <td class ="td_cart"><fmt:formatNumber value="${couponList.coupon_max_discount }" pattern="#,###"></fmt:formatNumber> 원</td>
  		</c:otherwise>
  		</c:choose>
  		
      <c:choose>
  		<c:when test="${couponList.coupon_end eq '9999-12-31'}">
  			<td class ="td_cart"></td>
  		</c:when>
  		<c:otherwise>
      <td class ="td_cart">${couponList.coupon_end }</td>
  		</c:otherwise>
  		</c:choose>
  		
      <c:choose>
  		<c:when test="${couponList.coupon_max_discount eq null}">
	      <td class ="td_cart"><button type="button" class="btn btn-dark" id="useCoupon" value="${couponList.coupon_benefit_price}" onclick="useCoupon(${couponList.coupon_benefit_price},'${couponList.coupon_benefit_unit }',${couponList.coupon_idx})">사용하기</button></td>
  		</c:when>
  		<c:otherwise>
	      <td class ="td_cart"><button type="button" class="btn btn-dark" id="useCoupon" value="${couponList.coupon_benefit_price}" onclick="useCoupon(${couponList.coupon_benefit_price},'${couponList.coupon_benefit_unit }',${couponList.coupon_max_discount },${couponList.coupon_idx})">사용하기</button></td>
  		</c:otherwise>
  		</c:choose>
  		
    </tr>
    </c:forEach>
  </tbody>
</table>
</c:otherwise>
  </c:choose>

</div>
</div>
<!-- <table class="table"> -->
<!--   <thead  class="table-dark" > -->
<!--     <tr> -->
<!--       <th scope="col">#</th> -->
<!--       <th scope="col">name</th> -->
<!--       <th scope="col">price</th> -->
<!--       <th scope="col">Use</th> -->
<!--       <th scope="col">StartDate</th> -->
<!--       <th scope="col">EndDate</th> -->
<!--       <th scope="col">Button</th> -->
<!--     </tr> -->
<!--   </thead> -->
<!--   <tbody> -->
<%--    <c:forEach var="coupon" items="${couponList }"> --%>
<%--      <c:choose> --%>
<%--       	<c:when test="${coupon.coupon_isUse eq 0 }"> --%>
<!--     <tr> -->
<%--       <th scope="row" id="idx">${coupon.coupon_idx }</th> --%>
<%--       <td>${coupon.coupon_name }</td> --%>
<%-- <%--       <td id="price">${coupon.coupon_price }</td> --%> 
<!--       <td>사용 가능</td> -->
<%--       <td>${coupon.coupon_start }</td> --%>
<%--       <td>${coupon.coupon_end }</td> --%>
<!--       <td> -->
<%-- <%--       <button type="button" class="btn btn-dark" id="useCoupon" value="${coupon.coupon_price}" onclick="useCoupon(${coupon.coupon_price},${coupon.coupon_idx})">적용하기</button> --%> 
<!--     </tr> -->
<%--     	</c:when> --%>
<%--       </c:choose> --%>
<%--      </c:forEach> --%>
<!--   </tbody> -->
<!-- </table> -->
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script type="text/javascript">
	function useCoupon(price,unit,max,idx) {
		alert("쿠폰이 적용 되었습니다");
		// 부모창(주문 / 결제페이지)에서 값 가져오기 
		//1. 할인 금액
		var discount_price = parseInt(opener.$("#order_discount_price").val());

		//2. 총 결제금액
		var order_total_price = parseInt(opener.$("#order_total_price").val());
		
			//2-1. 단위 구별하기 
			if(unit === '%'){
				price = order_total_price * (price/100);
				
				if(price > max){
					price = max;
				}
			} else {
				price = price;
			}
		
		if(order_total_price - price > 0){
// 		alert(price);
		
		window.opener.document.getElementById("order_total_price").value = order_total_price - price;
		
		//3. 쿠폰 적용한 할인금액
		 discount_price = (discount_price + price).toLocaleString("en-US");
		//4. 쿠폰 적용한 총 결제금액
		 order_total_price = (order_total_price - price).toLocaleString("en-US");
		//5. priceValue 값에 콤마
		price = price.toLocaleString("en-US");
// 		alert(order_price);
// 		alert(order_total_price);
		//클릭 시 부모창에 값 들어감.
		 window.opener.document.getElementById( "coupon_idx" ).value = idx;
		//상품 할인쿠폰 input 값에 들어감.
		 window.opener.document.getElementById( "priceValue" ).value = price;
		// 마지막 span영역에 쿠폰 적용된 할인가격, 총 결제금액이 들어감.
		 window.opener.document.getElementById( "discount_area" ).innerText = discount_price;
		 window.opener.document.getElementById( "order_total_area" ).innerText = order_total_price;
// 		 window.opener.document.getElementById( "order_total_price_pay" ).value = order_total_price;
		 window.opener.document.getElementById("order_total_price").value = parseInt(order_total_price) * 1000;
		 window.close();
		}else {
			alert("쿠폰을 적용 할 수 없습니다");
			history.back();
		}
	}
	

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>