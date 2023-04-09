<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<html lang="en">
<head>
<!--         <meta charset="utf-8" /> -->
<!--         <meta http-equiv="X-UA-Compatible" content="IE=edge" /> -->
<!--         <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" /> -->
<!--         <meta name="description" content="" /> -->
<!--         <meta name="author" content="" /> -->
<title>쿠폰등록</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css"
	rel="stylesheet" />
<link href="${path}/resources/css/styles.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js"
	crossorigin="anonymous"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap"
	rel="stylesheet">
<!-- 외부 jQuery 라이브러리 등록 -->
<!-- <script src="http://code.jquery.com/jquery-3.3.1.min.js"></script> -->
<script src="${path}/resources/js/jquery-3.6.3.js"></script>
<script type="text/javascript">
			<%String sId = (String) session.getAttribute("sId");
String id = request.getParameter("id");
if (sId == null || !sId.equals("admin")) {%>
				alert("잘못된 접근입니다!")
				location.href=history.back();
			<%}%>
		</script>
<style type="text/css">
* {
	font-family: "Noto Sans KR", sans-serif;
}
</style>
<script type="text/javascript">
// 		//할인 버튼에 따른 처리
// 		$(function() {
// 			$('input:radio[id="saleRadio1"]').on("click", function() {
// 				$('#testRate').attr('readonly', true);
// 			});
// 			$('input:radio[id="saleRadio2"]').on("click", function() {
// 				$('#testRate').attr('readonly', false);
// 			});
			
			
// 		});
		
// 		//할인율 숫자만 입력
// 		$(function() {
// 			$('input:number[id="discount"]').on("change", function() {
// 				var discount = $('#testRate').val();
				
// 				alert(discount);
// 			});
// 		});
		
		
		// 시작일
		$(function() {
			
			var today = new Date();

			var year = today.getFullYear();
			var month = ('0' + (today.getMonth() + 1)).slice(-2);
			var day = ('0' + today.getDate()).slice(-2);

			var dateString = year + '-' + month  + '-' + day;

			$("#start_date").val(dateString);
			
		});
		
		
		$(function() {
			
			// 사용 혜택
			$("#selectBenefit").on("change", function() {
				
				if($("#selectBenefit").val() == "배송비 무료") {
					$("#discountInput").prop("readonly", true);
					$("#discountInput").val("3000");
					$("#discountSelect").prop("disabled", true);
					$("#discountSelect").val("원");
					$("#maxDiscount").prop("readonly", true);
				} else if($("#selectBenefit").val() == "금액 할인"){
					$("#discountInput").prop("readonly", false);
					$("#discountSelect").prop("disabled", false);
					$("#maxDiscount").prop("readonly", false);
					$("#discountSelect").val("원");
				}
			});
			
			
			$("#discountSelect").on("change", function() {
				
				if($("#discountSelect").val() == "%") {
					$("#maxDiscount").prop("readonly", false);
				} else if($("#discountSelect").val() == "원"){
					$("#maxDiscount").prop("readonly", true);
				}
			});
			
			
			// 사용 기간
		$("#dataCheck").click(function() {
			if($("#dataCheck").is(":checked")){
				$("#start_date").prop("readonly", true);
				$("#end_date").prop("readonly", true);
				$("#end_date").val("9999-12-31");
			} else {
				$("#start_date").prop("readonly", false);
				$("#end_date").prop("readonly", false);
				$("#end_date").val("");
			}
		});	
		
			// 발행 수량
		$("#amountCheck").click(function() {
			if($("#amountCheck").is(":checked") == true){
				$("#amountInput").prop("readonly", true);
				$("#amountInput").val("");
			} else {
				$("#amountInput").prop("readonly", false);
			}
		});
			
		});
		
		
		</script>

<style type="text/css">
.table-secondary {
	font-weight: bold;
	width: 20px;
}
</style>
</head>
<body class="sb-nav-fixed">

	<!-- TOP -->
	<jsp:include page="./inc2/top.jsp"></jsp:include>

	<!-- SIDE -->
	<jsp:include page="./inc2/side.jsp"></jsp:include>
	<div id="layoutSidenav_content">
		<main>
			<div class="container-fluid">
				<h2 style="padding-top: 20px;">쿠폰 등록</h2>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item active"></li>
				</ol>

			</div>


			<!-- 상품 등록 폼 -->
			<form action="CouponInsertPro.po" method="post">
				<table class="table" style="width: 1000px;">
					<tr>
						<td width="20px" align="left" class="table-secondary">쿠폰명</td>
						<td width="100px"><input class="form-control" type="text"
							name="coupon_name" required></td>
					</tr>

					<tr>
						<td width="20px" align="left" class="table-secondary">쿠폰 내용</td>
						<td>
						<div class="form-check">
						  <input class="form-check-input" type="radio" name="coupon_banner" id="flexRadioDefault1" value="banner_1">
						  <label class="form-check-label" for="flexRadioDefault1">
						    banner_1
						  </label>
						</div>
						<div class="form-check">
						  <input class="form-check-input" type="radio" name="coupon_banner" id="flexRadioDefault2" value="banner_2">
						  <label class="form-check-label" for="flexRadioDefault2">
						    banner_2
						  </label>
						</div>
						<textarea class="form-control" style="resize: none"
								rows="5" cols="40" 
								name="coupon_content" required="required"></textarea></td>
						<!--           <td width="300px"><input class="w3-input w3-border" type="" placeholder="Product summary" name="Product summary" required></td> -->
					</tr>

					<tr>
						<td width="20px" align="left" class="table-secondary">사용 혜택</td>
						<td width="30px">
							<div class="row g-2">
								<div class="col-md">
									<select class="form-select" name="coupon_benefit" id="selectBenefit" aria-label="size 1 select example" style="width: 200px;">
										<option selected value="금액 할인">금액 할인</option>
										<option value="배송비 무료">배송비 무료</option>
									</select>
								</div>
								<div class="col-md">
									<input class="form-control" type="number" id="discountInput" placeholder="금액 또는 할인율" name="coupon_benefit_price" style="text-align: right; " required>
								</div>
								<div class="col-md-2">
									<select class="form-select" id="discountSelect" name="coupon_benefit_unit" size="1" id="discountSelect" aria-label="size 1 select example">
										<option selected value="원">원</option>
										<option value="%">%</option>
									</select>
								</div>
							</div>
						</td>
					</tr>
					
					<tr>
						<td width="20px" align="left" class="table-secondary">최소주문금액</td>
						<td><input class="form-control" type="number"
							name="coupon_min_price" required style="width: 200px;"></td>
					</tr>
					
					<tr>
						<td width="20px" align="left" class="table-secondary">최대할인금액</td>
						<td width="100px"><input class="form-control" type="number" name="coupon_max_discount" id="maxDiscount" readonly required style="width: 200px;"> </td>
					</tr>
					<!-- 					<td width="20px" align="left" class="table-secondary">할인 가격</td> -->
					<!-- 						<td><input type="text" id="testPrice" name ="coupon_price" placeholder="할인 가격을 입력하세요"><span>&nbsp;원</span>  -->
					<!-- 					</td>	 -->


					<tr>
						<td width="20px" align="left" class="table-secondary">사용 기간</td>
						<td>
						<div class="row g-2">
							  <div class="col-md" style="float: right;">
							  <div class="form-check"  style="width: 200px;">
								  <input class="form-check-input" type="checkbox" value="" id="dataCheck">
								  <label class="form-check-label" for="flexCheckIndeterminate">
								    기간제한 없음
								  </label>
								</div>
								</div>
							<div class="col-md">
							  <input type="date" id="start_date" class="form-control" name="coupon_start">
							 </div>
							 <div class="col-md-1" style="text-align: center;"> ~ </div>
							  <div class="col-md">
							  <input type="date" id="end_date" class="form-control" name="coupon_end">
							  </div>
							   <div class="col-md">  </div>
						</div>
						</td>
					</tr>
					

					<tr>
						<td width="20px" align="left" class="table-secondary">발행 수량</td>
						<td>
						<div class="row g-2">
							  <div class="col-md" style="float: right;">
							  <div class="form-check" style="width: 200px;" >
								  <input class="form-check-input" type="checkbox" id="amountCheck">
								  <label class="form-check-label" for="flexCheckIndeterminate">
								    개수제한 없음
								  </label>
								</div>
								</div>
							 <div class="col-md-2">
							 <input class="form-control" type="number" id="amountInput" name="coupon_amount"  required style="width: 80px;">
							  </div>
							  <div class="col-md"> </div>
							  <div class="col-md"> </div>
							  <div class="col-md"> </div>
						</div>
						</td>
					</tr>



					<tr>
						<td colspan="2"><button type="submit" class="btn btn-secondary" style="float: right;">등록하기</button></td>
					</tr>
				</table>
			</form>


		</main>
		<jsp:include page="./inc2/footer.jsp"></jsp:include>
	</div>
	<!-- plugin -->

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="${path}/resources/js/scripts.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script src="admin/assets/demo/chart-area-demo.js"></script>
	<script src="admin/assets/demo/chart-bar-demo.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest"
		crossorigin="anonymous"></script>
	<script src="admin/js/datatables-simple-demo.js"></script>
	<!--         <script src="../js/jquery-3.6.3.js"></script> -->





</body>

<!-- 숫자 에 "," 처리를 위한 함수 -->
<script type="text/javascript">
		    function comma(str) {
		        str = String(str);
		        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		    }
		
		    function uncomma(str) {
		        str = String(str);
		        return str.replace(/[^\d]+/g, '');
		    } 
		    
		    function inputNumberFormat(obj) {
		        obj.value = comma(uncomma(obj.value));
		    }
		    
		    function inputOnlyNumberFormat(obj) {
		        obj.value = onlynumber(uncomma(obj.value));
		    }
		    
		    function onlynumber(str) {
			    str = String(str);
			    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g,'$1');
			}
		</script>

</html>