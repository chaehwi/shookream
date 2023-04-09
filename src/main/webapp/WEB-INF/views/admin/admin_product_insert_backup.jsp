<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="en">
<head>
<!--         <meta charset="utf-8" /> -->
<!--         <meta http-equiv="X-UA-Compatible" content="IE=edge" /> -->
<!--         <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" /> -->
<!--         <meta name="description" content="" /> -->
<!--         <meta name="author" content="" /> -->
<title>상품등록 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<%-- <link href="${path}/admin/css/styles.css" rel="stylesheet" /> --%>
<link href="${path}/resources/css/styles.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="${path}/resources/admin/js/scripts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<script src="${path}/resources/admin/assets/demo/chart-area-demo.js"></script>
<script src="${path}/resources/admin/assets/demo/chart-bar-demo.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
<script src="${path}/resources/admin/js/datatables-simple-demo.js"></script>
        
 <script type="text/javascript">
	<%
		String sId = (String)session.getAttribute("sId");
		String id = request.getParameter("id");
		if(sId == null || !sId.equals("admin")) { 
		%>
		alert("잘못된 접근입니다!")
		location.href=history.back();
	<% 
		} 
	%>
</script>  
<style type="text/css">
	* {
		font-family: "Noto Sans KR", sans-serif;
	}
</style>      
      <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
      <!-- 외부 jQuery 라이브러리 등록 -->
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

<script type="text/javascript">
//할인 버튼에 따른 처리
$(function() {
	// 1. saleRadio1 버튼 : 할인 미선택
	// - 할인 미선택 시 상품가격이 입력되어 있는 지 판별
	// - 입력 : 가격을 그대로 표시 
	// - 미입력 : 라디오버튼 체크 해제 , 상품가격으로 focus
	
	$('input:radio[id="saleRadio1"]').on("click", function() {
		// 할인율 
		$('#testRate').prop('disabled', true);
// 		$('#testRate_0').prop('disabled', false);
		$('#testRate').val('0');
		
		var product_price = $("#prod_price").val();
		if(product_price < 0 || product_price == ""){
			alert("상품 가격을 입력하세요.")
			$('input:radio[id="saleRadio1"]').prop('checked',false);
			$("#prod_price").focus();
			document.querySelector('#testResultBox02').innerText = '';
		}else{
			document.querySelector('#testResultBox02').innerText = product_price + "원";
		}
		
	});
	
	// 2. saleRadio2 버튼 : 할인 선택
	// - 할인 선택 시 상품가격이 입력되어 있는 지 판별
	// - 입력 : 할인율 입력 칸을 readonly 해제 
	// - 미입력 : 라디오버튼 체크 해제 , 상품가격으로 focus
	$('input:radio[id="saleRadio2"]').on("click", function() {
		$('#testRate').prop('disabled', false);
// 		$('#testRate_0').prop('disabled', true);
		$('#testRate').val('');
		var product_price = $("#prod_price").val();
		if(product_price < 0 || product_price == ""){
			alert("상품 가격을 입력하세요.")
			$('input:radio[id="saleRadio2"]').prop('checked',false);
			$("#prod_price").focus();
		}
	});
	
	
});


</script>

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
		    
		    function inputNumberFormat_price(obj) {
		        obj.value = comma(uncomma(obj.value));
		        var uncomma_price = uncomma(obj.value)
// 		        alert(uncomma_price)
		        $("#prod_price_uncomma").val(uncomma_price);
		    }
		  	//할인율 숫자만 입력
		    function inputOnlyNumberFormats(str) {
		  		var discountRate = $("#testRate").val();
		  		if(discountRate > 100 || discountRate < 1){
		  			alert("할인율 범위를 벗어났습니다. ")
		  			$('#testRate').val('')
					document.querySelector('#testResultBox02').innerText ='';

	
		  		}
		  		// 콤마 붙이기
		    	str.value = onlynumber(uncomma(str.value));
		  		
		  		// 할인율 입력할 때마다 판매가격에 할인율을 적용한 가격을 표시.
			    var originPrice = document.querySelector('#prod_price').value;
				if(originPrice == "" || originPrice == null){
					alert('할인율을 입력하세요.')
				}
				//할인율 계산을 위해 콤마 제거 
				var uncommaOriginPrice = originPrice.replace(/[^\d]+/g, '')
				//할인율 값 가져오기. 
			    var discountRate = document.querySelector('#testRate').value;
			 	//연산결과에 따른 처리
			    if(! uncommaOriginPrice || !discountRate) {
			        return false;
			    //할인율 계산식
			    } else {
			    	//할인율에 따른 계산
			        var discounted = Math.round(uncommaOriginPrice * (discountRate / 100));	// 정수로 출력하기 위해 소수점 아래 반올림 처리
			        //판매가격 - 할인율 계산
			        var releasePrice = uncommaOriginPrice - discounted;
			        //콤마를 붙이기 위해 문자열로 변환
			        releasePrice = String(releasePrice)
			        // 할인율 적용 가격에 콤마를 붙여서 출력 
			        var commaReleasePrice = releasePrice.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			        document.querySelector('#testResultBox02').innerText = commaReleasePrice + '원'
			    //할인된 가격을 cart_discountprice 라는 id 값의 value에 넣음.
				    document.getElementById('product_release_price').value = releasePrice;	 
			        
			    }
			 	

		    }
		</script>


<style type="text/css">
.table-secondary{
	font-weight: bold;
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
                    <div class="container-fluid px-4">
                        <h1 class="mt-4" >상품 등록</h1>
                	 </div>
                	 
            <!-- 상품 등록 폼 -->
			<form action="ProductInsertPro.po" method="post" id="product_insert"enctype="multipart/form-data">
				<!-- 상품가격과 할인적용 가격에 ,를 붙이기에 hidden으로 파라미터 넘김 => 우선 할인적용 가격만 넘겨서 처리할 예정-->
<!-- 				<input type="hidden" id = "price" name = "price"> -->
				<input type="hidden" id ="product_release_price" name ="product_release_price" value="0">
				<table class="table">
					<tr>
						<td width="100px" align="left" class="table-secondary">상품명</td>
						<td width="300px">
						<input class="form-control"
							type="text" placeholder="Product Name" name="product_name" id = "product_name" required style="width:200px"></td>
					</tr>
					<tr>
						<td width="100px" align="left" class="table-secondary">상품 브랜드</td>
						<td width="300px">
						<select class="form-select" name="product_brand" id ="product_brand" style="width:200px">
								<option value="" selected>브랜드를 선택하세요</option>
								<option value="나이키">나이키</option>
								<option value="뉴발란스">뉴발란스</option>
								<option value="컨버스">컨버스</option>
								<option value="아디다스">아디다스</option>
								<option value="반스">반스</option>
						</select>
						</td>
					</tr>
					<tr>
						<td width="100px" align="left" class="table-secondary">상품 가격</td>
						<td>
						<input type="text" id="prod_price" class="form-control" placeholder="상품 가격을 입력하세요" style="width:200px;" onkeyup="inputNumberFormat_price(this)">
						<input type="hidden" id="prod_price_uncomma" name ="product_price" value="">
						<span>&nbsp;원</span> 
						</td>
						
					</tr>
					
						
					<tr>
						<td width="100px" align="left" class="table-secondary">할인율</td>
						<td>
						<div class="form-check">
							<input class="form-check-input" type="radio" name="saleRadio" id="saleRadio1" >
							<label class="form-check-label" for="flexRadioDefault2">할인 미선택</label>
<!-- 							<input type="hidden" id ="testRate_0" name ="product_discount_price" value="0" disabled="disabled"> -->
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" name="saleRadio" id="saleRadio2" > 
							<label class="form-check-label" for="flexRadioDefault1">할인 적용 
							<input type="number" id="testRate" name ="product_discount_price" class="form-control" size="1" min = "0" max ="100" style = "text-align:center;" disabled="disabled" onchange="inputOnlyNumberFormats(this)"> <!-- 할인율 입력칸 -->
							<span>%</span>
							</label>
						</div>
						
						</td>
						<td>
						</td>
						
					<tr>
						<td width="150px" align="left" class="table-secondary">판매가격</td>
						
						<td><p id = "testResultBox02"></p></td>
						
					</tr>
	
					<tr>

						<td width="100px" align="left" class="table-secondary">상품 사이즈</td>
						<td width="300px">
						<select class="form-select" name="product_size" id ="product_size" style="width:200px">
								<option value="" selected>사이즈를 선택해주세요.</option>
								<option value="220">220</option>
								<option value="230">230</option>
								<option value="240">240</option>
								<option value="240">250</option>
								<option value="240">260</option>
								<option value="240">270</option>
								<option value="240">280</option>
								<option value="240">290</option>
								<option value="240">300</option>
						</select></td>
					<tr>
						<td width="100px" align="left" class="table-secondary">상품 재고량</td>
						<td width="300px"><input class="form-control" type="number" min="0" max="100" placeholder="수량" id="amount" name="product_amount" onkeyup="inputNumberFormat(this);" required style="width:200px"></td>
					</tr>

					<tr>
						<td width="100px" align="left" class="table-secondary">상품 색상</td>
						<td width="300px">
						<select class="form-select" name="product_color" id ="product_color" style="width:200px">
								<option value="" selected>색상을 선택해주세요.</option>
								<option value="black">BLACK</option>
								<option value="white">WHITE</option>
								<option value="navy">NAVY</option>
								<option value="red">RED</option>
								<option value="blue">BLUE</option>
								<option value="gray">GRAY</option>
						</select></td>
					</tr>

					<tr>
						<td width="100px" align="left" class="table-secondary">요약 설명</td>
						<td><textarea class="form-control" style="resize: none"
								rows="5" cols="40" placeholder="Product summary" id ="exp" name="product_exp"
								required="required"></textarea></td>
						<!--           <td width="300px"><input class="w3-input w3-border" type="" placeholder="Product summary" name="Product summary" required></td> -->
					</tr>

					<tr>
						<td width="100px" align="left" class="table-secondary">상세 설명</td>
						<td><textarea class="form-control" style="resize: none"
								rows="10" cols="150" placeholder="Product detail"
								id="detail_exp" name="product_detail_exp" required="required"></textarea></td>
					</tr>


					<tr>
						<td width="100px" align="left" class="table-secondary">메인 이미지</td>
						<td><input type="file" name="files" required="required"></td>
					</tr>
					<tr>
						<td width="100px" align="left" class="table-secondary">제품 이미지1</td>
						<td><input type="file" name="files" required="required"></td>
					</tr>
					<tr>
						<td width="100px" align="left" class="table-secondary">제품 이미지2</td>
						<td><input type="file" name="files" required="required"></td>
					</tr>

					<tr>
						<td colspan="2"><button type="submit"
								class="btn btn-secondary" onclick="valueCheck(this)">등록하기</button></td>
					</tr>
				</table>
			</form>


		</main>
				<jsp:include page="./inc2/footer.jsp"></jsp:include>
            </div>
        <!-- plugin -->
        
        
    </body>

		
	
		<!-- SELECT 박스 값 변경에 따라 TRUE, FALSE 처리 -->
		<script type="text/javascript">
		var BrandStatus = false;
		var SizeStatus = false;
		var ColorStatus = false;
		var SaleStatus = false;
		$(function() {
			$("#product_brand").on("change", function() {
				var BrandVal = $("#product_brand").val();
				if(BrandVal == ""){
		            BrandStatus = false;
		         }else{
		            BrandStatus = true;
		         }
			});//brand 판별 끝
		});//함수 끝
		
		$(function() {
			$("#product_size").on("change", function() {
				var SizeVal = $("#product_size").val();
				if(SizeVal == "") {
					SizeStatus = false;
				}else{
					SizeStatus = true;
				}
			});//size 판별 끝
		});//함수 끝
			
		$(function() {
			$("#product_color").on("change", function() {
				var ColorVal = $("#product_color").val();
				if(ColorVal == "") {
					ColorStatus = false;
				}else{
					ColorStatus = true;
				}

			});//color 판별 끝
		});	//함수 끝
		
		// 할인여부 판별
		$(function() {
			$("input[name=saleRadio]").on("change", function() {
				var ischecked = $("#saleRadio1").is(':checked');
				var ischecked2 = $("#saleRadio2").is(':checked');
				// 할인 미선택, 할인 적용 라디오버튼을 하나라도 선택하지 않았을 경우 false로 상태를 변경.
				if(!ischecked && !ischecked2){
		            SaleStatus = false;
		         }else{
		            SaleStatus = true;
		         }
			});//brand 판별 끝
		});//함수 끝
		//색상, 사이즈 미선택 시 못넘어가게 하는 구문
		function valueCheck(){
			var prod_name = $("#product_name").val()
			var prod_price = $("#prod_price").val()
			var prod_amount = $("#amount").val()
			var prod_exp = $("#exp").val()
			var prod_detail = $("#detail_exp").val()
			alert($("input[name=product_discount_price]").val())
			alert($("#testRate_0").val())
			
			
			if(BrandStatus == false){
				alert("브랜드를 선택 해주세요")
				event.preventDefault(); // submit 기능 막기
			}else if(SizeStatus == false){
				alert("사이즈를 선택 해주세요");
				event.preventDefault(); // submit 기능 막기
			}else if(ColorStatus == false){
				alert("색상을 선택 해주세요");
				event.preventDefault(); // submit 기능 막기
			}else if(SaleStatus == false){
				alert("할인여부를 선택 해주세요");
				event.preventDefault(); // submit 기능 막기
			}else if(prod_name == ""){
				alert("상품명을 입력하세요");
				event.preventDefault(); // submit 기능 막기
			}else if(prod_price == ""){
				alert("상품가격을 입력하세요");
				event.preventDefault(); // submit 기능 막기
			}else if(prod_price == ""){
				alert("상품가격을 입력하세요");
				event.preventDefault(); // submit 기능 막기
			}else if(prod_amount == ""){
				alert("상품 재고량을 입력하세요");
				event.preventDefault(); // submit 기능 막기
			}else if(prod_exp == ""){
				alert("상품 요약설명을 입력하세요");
				event.preventDefault(); // submit 기능 막기
			}else if(prod_detail == ""){
				alert("상품 상세설명을 입력하세요");
				event.preventDefault(); // submit 기능 막기
			}
			

		}// valueCheck 끝
		
		</script>

     	
</html>