package com.chaehwi.shookream.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.apache.taglibs.standard.tag.el.fmt.RequestEncodingTag;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.server.header.XFrameOptionsServerHttpHeadersWriter.Mode;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.resource.HttpResource;

import com.chaehwi.shookream.service.BoardService;
import com.chaehwi.shookream.service.CartService;
import com.chaehwi.shookream.service.MemberService;
import com.chaehwi.shookream.service.ProductService;
import com.chaehwi.shookream.vo.BoardVo;
import com.chaehwi.shookream.vo.MemberVo;
import com.chaehwi.shookream.vo.OrderdeliveryVo;
import com.chaehwi.shookream.vo.PageInfo;
import com.chaehwi.shookream.vo.ProductVo;
import com.chaehwi.shookream.vo.cartViewVo;
import com.chaehwi.shookream.vo.cartVo;
import com.chaehwi.shookream.vo.cartVoArr;


@Controller
public class CartController {
	@Autowired
	private CartService service;
	
	@Autowired
	private MemberService service_member;
	//장바구니 이동
	@GetMapping(value = "CartList.ca")
	public String cartList(
			HttpServletResponse response,
			HttpServletRequest request,
			HttpSession session,
			Model model) {
		//세션이 없을 경우 로그인 페이지로 이동
		if(session.getAttribute("sId") == null || session.getAttribute("member_idx") == null ) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("url", "LoginMember.me");
			return "reload_cart";
		}
		//세션 아이디와 Member_idx 변수 선언
		String sId = (String)session.getAttribute("sId");
		int member_idx = (int)session.getAttribute("member_idx");
		
		
		// 페이징 처리를 위한 변수 선언
		int listLimit = 10; // 한 페이지에서 표시할 게시물 목록을 10개로 제한
		int pageNum = 1; // 현재 페이지 번호 설정(pageNum 파라미터 사용)
		
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}

		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행번호 계산
		
		List<cartVo> cartlist = service.getCartlist(member_idx,startRow,listLimit);
		int cart_total_price =0;
		int cart_order_total_price =0;
		//반복문을 통해 cart_price합계 계산
		for(int i=0; i<cartlist.size(); i++) {
			cart_total_price += cartlist.get(i).getCart_price();
			cart_order_total_price += cartlist.get(i).getCart_order_price();
		}
			
			// 페이징 처리
			// 한 페이지에서 표시할 페이지 목록(번호) 갯수 계산
			// 1. CartList - getCartListCount() 메서드를 호출하여 전체 게시물 수 조회(페이지 목록 계산에 사용)
			// => 파라미터 : 검색어   리턴타입 : int(listCount)
			int listCount = service.getCartListCount(member_idx);
			//	System.out.println("총 게시물 수 : " + listCount);
			
			// 2. 한 페이지에서 표시할 페이지 목록 갯수 설정
			int pageListLimit = 10; // 한 페이지에서 표시할 페이지 목록을 3개로 제한
			
			// 3. 전체 페이지 목록 수 계산
			int maxPage = listCount / listLimit 
							+ (listCount % listLimit == 0 ? 0 : 1);
			
			// 4. 시작 페이지 번호 계산
			int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
			
			// 5. 끝 페이지 번호 계산
			int endPage = startPage + pageListLimit - 1;
			
			// 6. 만약, 끝 페이지 번호(endPage)가 전체(최대) 페이지 번호(maxPage) 보다
			//    클 경우, 끝 페이지 번호를 최대 페이지 번호로 교체
			if(endPage > maxPage) {
				endPage = maxPage;
			}
		for (cartVo cart : cartlist) {
//			System.out.println("카트 이름 : " + cart.getCart_product_image());
			String[] cart_preview_img = cart.getCart_product_image().split("/");
			String preview_img = cart_preview_img[0];
//			System.out.println("preview 이미지 :"  + preview_img);
			cart.setCart_product_image(preview_img);
		}
				
				// PageInfo 객체 생성 후 페이징 처리 정보 저장
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("cartlist", cartlist);
		request.setAttribute("cart_total_price", cart_total_price);
		request.setAttribute("cart_order_total_price", cart_order_total_price);
		
		return "product/Product_cart";
	}
	
	
	//	상세페이지에서 장바구니 추가
	@ResponseBody
	@PostMapping(value = "CartInsertPro.ca")
	public void CartInsert(
			@RequestParam("product_idx") int product_idx,
			@RequestParam("cart_count") int cart_count,
			Model model,
			HttpSession session,
			HttpServletResponse response
			){
		
		//세션 아이디와 Member_idx 변수 선언
		String sId = (String)session.getAttribute("sId");
		int member_idx = (int)session.getAttribute("member_idx");
		//product_idx 에 맞는 상품을 조회하여 productVo에 저장
		ProductVo product = service.getProduct(product_idx);
		System.out.println("확인용 " + product);
		//동일한 상품일 경우 수량을 증가
		cartVo cart = service.getCartSelect(product_idx, member_idx);
		//null 이 아닐 경우 -> 이미 담긴 상품이 있는 경우 수량만 추가
		if(cart != null) {
			int updateCount = service.getUpdateCart(product_idx, member_idx, cart_count);
			try {
				if(updateCount > 0) {
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.print("이미 담긴상품");
					
				} else {
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.print("장바구니 추가에 실패되었습니다.");
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		//null일 경우 ->담긴 상품이 없기에 새로운 cart를 추가
		}else {
			//장바구니 담기
			int insertCount = service.getInsertCart(product_idx, member_idx, cart_count, product);
			try {
				if(insertCount > 0) {
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					
					out.print("새상품");
					
				} else {
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					
					out.println("<script>");
					out.println("alert('장바구니 등록에 실패되었습니다.')");
					out.println("</script>");
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
			
	}//CartInsert 끝 
	
	
	//------장바구니 삭제-------
	@GetMapping(value = "CartDeletePro.ca")
	public String cartDelete(
			@RequestParam(value = "cart_idx", required = false, defaultValue = "0") int cart_idx,
			@RequestParam(value = "cart_idxArr", required = false, defaultValue = "0") int[] cart_idxArr,
			HttpSession session,
			Model model) {
		int member_idx = (int)session.getAttribute("member_idx");
		// 체크박스 선택 한 상태

		if(cart_idxArr != null && cart_idxArr[0] != 0) {
			System.out.println("!!!!!!!!!이 작업 하면안돼");
			System.out.println(cart_idxArr[0]);
			//만약 1개만 체크한 상태에서 삭제 작업을 했을 경우, 0번지에 있는 값을 cart_idx 에 넣어줌 !
			// -> 배열의 길이가 1보다 작거나 같은 경우(1개만 체크한 경우) 배열 0번지 값을 cart_idx에 넣음.
			if(cart_idxArr.length <= 1) {
				cart_idx = cart_idxArr[0];
			}
			//삭제 작업

			int deleteCount = service.getCartDeleteArr(cart_idxArr, member_idx);
			if(deleteCount > 0) {
				//작업 성공 후 reload_cart.jsp로 이동하여 msg, url 값에 맞게 alert창 출력 후 url에 저장된 주소로 location.href을 통해 이동
				model.addAttribute("msg", "장바구니에서 삭제되었습니다.");
				model.addAttribute("url", "CartList.ca");
				return "reload_cart";
			}else {
				//작업 실패 시 reload_cart.jsp로 이동하여 msg, url 값에 맞게 alert창 출력 후 url에 저장된 주소로 location.href을 통해 이동
				model.addAttribute("msg", "장바구니 삭제 실패.");
				model.addAttribute("url", "CartList.ca");
				return "reload_cart";
				
			}

		}else {

			int deleteCount = service.getCartDelete(cart_idx, member_idx);
			if(deleteCount > 0) {
				//작업 성공 후 reload_cart.jsp로 이동하여 msg, url 값에 맞게 alert창 출력 후 url에 저장된 주소로 location.href을 통해 이동
				model.addAttribute("msg", "장바구니에서 삭제되었습니다.");
				model.addAttribute("url", "CartList.ca");
				return "reload_cart";
			}else {
				//작업 실패 시 reload_cart.jsp로 이동하여 msg, url 값에 맞게 alert창 출력 후 url에 저장된 주소로 location.href을 통해 이동
				model.addAttribute("msg", "장바구니 삭제 실패.");
				model.addAttribute("url", "CartList.ca");
				return "reload_cart";
				
			}

		}
	}//cartDelete 
	
	//------장바구니 -> 구매페이지-------
	@GetMapping(value = "CartOrderDetail.ca")
	public String cartOrderForm(
			@RequestParam("cart_idx") String cart_idx,
			HttpSession session,
			Model model,
			HttpServletRequest request
			) {
		if(session.getAttribute("sId") == null || session.getAttribute("member_idx") == null ) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("url", "LoginMember.me");
			return "reload_cart";
		}
		int member_idx = (int)session.getAttribute("member_idx");
		//세션이 없을 경우 로그인 페이지로 이동
		List<cartVo> cartOrderList = new ArrayList<cartVo>();
		System.out.println("cart_idx :" + cart_idx);
		String[] cart_idxArr = cart_idx.split(",");
		System.out.println(cart_idxArr);
		for(int i=0; i<cart_idxArr.length; i++) {
			cart_idx = cart_idxArr[i];
			System.out.println(cart_idx);
			cartOrderList.add(service.getCartOrderlist(cart_idx, member_idx));
		}
		int cart_total_price =0;
		int cart_order_total_price =0;
		System.out.println(cartOrderList.size());
		//반복문을 통해 cart_price합계 계산
		for(int i=0; i<cartOrderList.size(); i++) {
			cart_total_price += cartOrderList.get(i).getCart_price();
			cart_order_total_price += cartOrderList.get(i).getCart_order_price();
		}
		System.out.println(cartOrderList);
		String sId = (String)session.getAttribute("sId");
		MemberVo member = service_member.getMemberInfo(sId);
		
		model.addAttribute("member", member);
		model.addAttribute("cartOrderList", cartOrderList);
		model.addAttribute("cart_total_price", cart_total_price);
		model.addAttribute("cart_order_total_price", cart_order_total_price);
		
		return "product/order_form_cart";
	}
	
	//------------수량 변동에 따라 수량, 금액 변경--------------
	@ResponseBody
	@GetMapping(value = "amount_adjust.ca")
	public void amount_adjust(
			HttpSession session,
			HttpServletResponse response,
			Model model,
			@RequestParam String type,
			@RequestParam int cart_idx) {
		
		if(session.getAttribute("sId") == null || session.getAttribute("member_idx") == null ) {
			try {
				model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
				model.addAttribute("url", "LoginMember.me");
				
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
				out.println("location.href='reload_cart'");
				out.println("</script>");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			int member_idx = (int)session.getAttribute("member_idx");
			System.out.println(cart_idx);
			System.out.println(type);
			System.out.println(member_idx);
			int updateCount = service.getAmountAdjust(cart_idx, type, member_idx);
			if(updateCount > 0) {
				try {
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					
					out.print("성공");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}else {
				try {
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					
					out.print("실패");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}//else 끝
		
		
	}//amount_adjust 끝
	
	//-----------장바구니 체크박스에 따른 합계금액 변동------------
		@ResponseBody
		@GetMapping(value = "ChangeTotalPrice.ca", produces = "application/json; charset=utf-8")
		private void ChangeTotalPrice(
				HttpSession session,
				HttpServletResponse response,
				Model model,
				@RequestParam String cart_idx,
				@RequestParam String type,
				@RequestParam int total_price,
				@RequestParam int total_order_price
				) {
			if(session.getAttribute("sId") == null || session.getAttribute("member_idx") == null ) {
				try {
					model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
					model.addAttribute("url", "LoginMember.me");
					
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					
					out.println("<script>");
					out.println("location.href='reload_cart'");
					out.println("</script>");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}else {
				//타입이 minus 인 경우(체크박스 해제)
				if(type.equals("minus")) {
					
					int member_idx = (int)session.getAttribute("member_idx");
					//cart_idx와 member_idx에 맞는 카트 정보를 검색
					cartVo cart = service.getCartOrderlist(cart_idx, member_idx);
					//cart_price : 상품금액 , cart_order_price : 결제금액
					int cart_price = cart.getCart_price();
					int cart_order_price = cart.getCart_order_price();
					//minus 인 경우 체크박스 해제로 (전체 금액 - 상품 금액)
					total_price -= cart_price;
					total_order_price -= cart_order_price;
					//JS로 전송하기 위해 JSONObject 객체를 생성
					JSONObject jsonObject = new JSONObject();
					//Object 객체에 계산된 상품 금액, 총 결제 금액을 put 하였음.
					jsonObject.put("cart_total_price", total_price);
					jsonObject.put("cart_order_total_price", total_order_price);
					System.out.println(jsonObject);
					try {
						response.setCharacterEncoding("UTF-8");
						response.getWriter().print(jsonObject); // toString() 생략
					} catch (IOException e) {
						e.printStackTrace();
					}

					
				}else if(type.equals("plus")){
					//타입이 minus 인 경우(체크박스 해제)
					int member_idx = (int)session.getAttribute("member_idx");
					//cart_idx와 member_idx에 맞는 카트 정보를 검색
					cartVo cart = service.getCartOrderlist(cart_idx, member_idx);
					//cart_price : 상품금액 , cart_order_price : 결제금액
					int cart_price = cart.getCart_price();
					int cart_order_price = cart.getCart_order_price();
					//plus 인 경우 체크박스 활성화 (전체 금액 + 상품 금액)
					total_price += cart_price;
					total_order_price += cart_order_price;
					//JS로 전송하기 위해 JSONObject 객체를 생성
					JSONObject jsonObject = new JSONObject();
					//Object 객체에 계산된 상품 금액, 총 결제 금액을 put 하였음.
					jsonObject.put("cart_total_price", total_price);
					jsonObject.put("cart_order_total_price", total_order_price);
					try {
						response.setCharacterEncoding("UTF-8");
						response.getWriter().print(jsonObject); // toString() 생략
					} catch (IOException e) {
						e.printStackTrace();
					}
					
				}
			}
			
		}//ChangeTotalPrice 끝
		
		
	
		//------구매페이지에서 다중 구매 처리 -------
		@GetMapping(value = "CartOrderDetailPro.ca")
		public String cartOrderForm(HttpSession session,Model model,cartVoArr vo,OrderdeliveryVo delivery) {
			if(session.getAttribute("sId") == null || session.getAttribute("member_idx") == null ) {
				model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
				model.addAttribute("url", "LoginMember.me");
				return "reload_cart";
			}
			
			//cartArrvo를 단일 cartVO에 풀기 
			for(int i=0;i<vo.getProduct_idxArr().length;i++) {
				cartVo vo2 = new cartVo();
				vo2.setMember_idx(vo.getMember_idxArr()[i]);
				vo2.setProduct_idx(vo.getProduct_idxArr()[i]);
				vo2.setCart_order_price(vo.getCart_order_priceArr()[i]);
				vo2.setCart_count(vo.getCart_countArr()[i]);
				vo2.setCart_color(vo.getCart_colorArr()[i]);
				vo2.setCart_size(vo.getCart_sizeArr()[i]);
				vo2.setCart_product_name(vo.getCart_product_nameArr()[i]);
				vo2.setCart_idx(vo.getCart_idxArr()[i]);
				int orderSelectCount = service.getCartOrderCount(vo2);// db에 이미 주문 한 상품 있는지 확인
				
				if(orderSelectCount > 0) { //이미 주문한 상품이 있을 시
					int insertOrder2 = service.InsertOrderDetail(vo2,delivery);
					service.updatePorduct_Amount(vo2); //상품 수량 빼기 작업 
					service.updateOrder_Amount(vo2); // 주문 수량 더하기 작업
					service.getCartDelete(vo2.getCart_idx(), vo2.getMember_idx()); // 주문 성공시 카트에 담긴 상품 삭제 작업
				
				}else {//이미 주문한 상품이 없을 시
					int insertOrder2 = service.InsertOrderDetail(vo2,delivery);
					int insertCount = service.insertCartOrder(vo2);// insert 작업
					if(insertCount > 0) {//insert 성공 시
						service.updatePorduct_Amount(vo2); // 상품 수량 빼기 작업
						service.getCartDelete(vo2.getCart_idx(), vo2.getMember_idx());// 주문 성공시 카트에 담긴 상품 삭제 작업
					} 
				}
				
			}
			return "product/order_form_cart";
		}// 다중 주문 끝
}//CartController 끝
		
	
	

	
	

