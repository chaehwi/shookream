package com.chaehwi.shookream.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.chaehwi.shookream.service.MemberService;
import com.chaehwi.shookream.service.ProductService;
import com.chaehwi.shookream.vo.BoardVo;
import com.chaehwi.shookream.vo.CouponVo;
import com.chaehwi.shookream.vo.MemberVo;
import com.chaehwi.shookream.vo.OrderVo;
import com.chaehwi.shookream.vo.OrderdeliveryVo;
import com.chaehwi.shookream.vo.PageInfo;
import com.chaehwi.shookream.vo.ProductVo;
import com.chaehwi.shookream.vo.ReviewVo;
import com.chaehwi.shookream.vo.WishVo;
import com.chaehwi.shookream.vo.imageVo;

@Controller
public class ProductController {

	@Autowired
	private ProductService service;
	
	@Autowired
	private MemberService service_member;
	
	List<imageVo> imageList;
	
	// 상품 상세 정보
	@GetMapping(value = "/ProductInfoForm.po")
	public String productInfo(
			@ModelAttribute ProductVo product, 
			@ModelAttribute WishVo wish, 
			@ModelAttribute imageVo image,
			@RequestParam(defaultValue = "0") int product_idx,
//			@RequestParam int member_idx,
			Model model, HttpSession session) {
		
		// 임시 값 지정 (추후 수정 필요)
//		int product_idx = product.getProduct_idx();
//		int product_idx = 2;
		
		// ================= wish 정보 조회 ====================
		String sId = (String)session.getAttribute("sId");
//		String sId = "admin";
		
		if(sId != null) {
		// 로그인 후 session 에 member_idx 저장할 시 불필요한 과정
		int member_idx = service.getMemberIdx(sId);
		System.out.println("member_idx = " + member_idx);
		
		// ================= 멤버 Wish 조회 =====================
		wish = service.getWishInfo(product_idx, member_idx);
		
		if(wish != null) {
			model.addAttribute("wish", wish);
		} else {
			model.addAttribute("wish", null);
		}
		System.out.println("wish 조회 : " + wish);
		}
		// =====================================================
		
		
		// ================= 상품 정보 조회 =====================
		product = service.getProduct(product_idx);
		System.out.println("product 조회 : " + product);
		imageList = new ArrayList<imageVo>();
		
		image = service.getImage(product_idx);
		System.out.println("image 조회 : " + image);
		System.out.println(image);
		if(imageList != null) {
			imageList.add(image);
			session.setAttribute("imageList", imageList);
		} else {
			imageList.set(0, imageList.get(1));
			imageList.set(1, imageList.get(2));
			imageList.add(image);
		}
		
		
		
		System.out.println("fileNames : "+ imageList);
		System.out.println("imageListSize 조회 : " + imageList.size());
		
		session.setAttribute("product_idx", product_idx);
		
		System.out.println("session : "+session.getAttribute("image"));
		
		
		System.out.println("이거다"+session.getAttribute("image"));
		model.addAttribute("product_idx", product_idx);
		model.addAttribute("product", product);
		model.addAttribute("image", image);
		model.addAttribute("imageList", imageList);
		
		// ======================================================
		
		
		// ================= 상품별 카테고리 조회 =====================
		//상품별 카테고리 가져오기
		List<String> categorylist =  service.getCategoryList(product.getProduct_name());
		System.out.println("카테고리 : " + categorylist);
		List<String> colorlist = service.getColorList(product.getProduct_name());
		
		//이미지 리스트 출력
		List<imageVo> imagelist = service.getImageList(product.getProduct_name());
		System.out.println(imagelist);
		
		
		model.addAttribute("categorylist", categorylist);
		model.addAttribute("colorlist", colorlist);
		model.addAttribute("imagelist", imagelist);
		// ======================================================
		
		// ================= 리뷰 조회 =====================
		List<ReviewVo> reviewList = service.getReviewList(product.getProduct_idx());
		
		model.addAttribute("reviewList", reviewList);
		// ======================================================
		
		
		return "product/Product_info";
	} // 상세 정보 끝
	
	
	
	
	// 주문 상세 페이지
	@GetMapping(value = "/OrderDetailForm.po")
	public String orderDetail(
			@ModelAttribute ProductVo product, 
			@ModelAttribute WishVo wish, 
			@ModelAttribute imageVo image, 
			@ModelAttribute MemberVo member, 
			@RequestParam(defaultValue = "0") int product_idx,
			Model model, HttpSession session) {
		
		// 임시 값 지정 (추후 수정 필요)
//		int product_idx = 2;
//		int member_idx = 1;
//		String sId = "admin";
		
		String sId = (String)session.getAttribute("sId");		
//		// 로그인 후 session 에 member_idx 저장할 시 불필요한 과정
//		int member_idx = service.getMemberIdx(sId);
		
		product = service.getProduct(product_idx);
		image = service.getImage(product_idx);
		member = service_member.getMemberInfo(sId);
		System.out.println("member : "+member);
		model.addAttribute("product", product);
		model.addAttribute("member", member);
		model.addAttribute("image", image);
		
		return "product/order_form";
	} // 주문 상세 페이지 끝
	
	
	
	
	// 주매 구문
	@GetMapping(value = "/ProductOrderPro.po")
	public String orderPro(@ModelAttribute OrderVo order, Model model, 
			@RequestParam(defaultValue = "0") int coupon_idx,
			@RequestParam(defaultValue = "0") int product_idx,
			@RequestParam(defaultValue = "0") int product_price,
			HttpSession session, OrderdeliveryVo delivery) {
		System.out.println(order);
		String sId = (String)session.getAttribute("sId");		
		int member_idx = service.getMemberIdx(sId);
//		order.setOrder_member_idx(member_idx);
//		order.setOrder_product_idx(product_idx);
//		order.setOrder_product_price(product_price);
		System.out.println("delivery :"+delivery);
		// 쿠폰 임시 값 지정 (추후 수정 필요)
		if(model.getAttribute("coupon_idx") != "") {
			order.setOrder_coupon_idx(coupon_idx);
		}
		
		System.out.println("구매 order : " + order);
		
		int insertOrder = service.InsertOrder(order);
		
		if(insertOrder > 0) {
			int insertOrder2 = service.InsertOrderDetail(order,delivery);
			 
			if(insertOrder2 > 0) {
				service.updatePro(order);
				service.updateMem(order);
			}
			
			return "redirect:/ProductOrderList.po?member_idx"+member_idx;
			
		} else {
//			
			model.addAttribute("msg", "일시적 오류로 구매에 실패했습니다.");
			return "fail_back";
		}
		
	} // 주문 구매 끝
	
	
	
	
	// 회원별(주문시) 쿠폰 리스트
	@GetMapping(value = "/CouponListForm.po")
	public String CouponList(Model model, HttpSession session,@RequestParam(defaultValue = "0")int product_price ) {
		
		String sId = (String)session.getAttribute("sId");		
//		System.out.println("sid: "+sId);
		int member_idx = service.getMemberIdx(sId);
		
		List<CouponVo> couponList = service.getCouponList(member_idx, product_price);
		
		model.addAttribute("couponList", couponList);
		
		return "product/Product_couponlist";
	}// 회원별 쿠폰 리스트 끝
	
	
	
	
	// 회원 주문 목록
	@GetMapping(value = "/ProductOrderList.po")
	public String OrderList(Model model, HttpSession session,@RequestParam(defaultValue = "1")int pageNum) {
		
		String sId = (String)session.getAttribute("sId");		
		int member_idx = service.getMemberIdx(sId);
		
		int listLimit = 5;
		int startRow = (pageNum - 1) * listLimit;
		List<OrderVo> orderList = service.getOrderList(member_idx,listLimit,startRow);
		
		int listCount = service.getListCount(member_idx);
		int pageListLimit =3;
		int maxPage = listCount / listLimit 
				+ (listCount % listLimit == 0 ? 0 : 1); 


		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;

		int endPage = startPage + pageListLimit - 1;

		if(endPage > maxPage) {
			endPage = maxPage;
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		System.out.println(orderList);
		
		
		model.addAttribute("orderList", orderList);
		model.addAttribute("pageInfo", pageInfo);
		return "product/Product_orderlist";
	}// 회원 주문 목록 끝
	
	
	//주문내역 상세 정보(팝업창)
	@GetMapping(value = "/ProductOrderDeliveryPro.po")
	public String OrderDelivery(Model model, HttpSession session,@RequestParam(defaultValue = "1")int pageNum) {
		
		
		return "product/deliveryDetailForm";
	}// 회원 주문 목록 끝
			
}
