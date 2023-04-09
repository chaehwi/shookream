package com.chaehwi.shookream.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chaehwi.shookream.service.CouponService;
import com.chaehwi.shookream.service.ProductService;
import com.chaehwi.shookream.vo.CouponVo;

@Controller
public class CouponController {
	
	@Autowired 
	private CouponService service;
	
	@Autowired 
	private ProductService service_product;
	
	
	// =========================== 쿠폰 ==============================
	
		// ------------ 쿠폰 목록 --------------------
		@GetMapping("CouponList.po")
		public String couponList(Model model) {
			
			List<CouponVo> couponList = service.getCouponList();
			
			model.addAttribute("couponList",couponList);
			
			return "admin/admin_coupon_list";
		}
		
		// ------------ 쿠폰 수정 폼 --------------------
		@GetMapping("CouponModifyForm.po")
		public String couponModifyForm(Model model, @RequestParam(defaultValue = "0") int coupon_idx) {
			
			
			CouponVo coupon = service.getCouponInfo(coupon_idx);
			
			model.addAttribute("coupon",coupon);
			
			return "admin/admin_coupon_modify_form";
		}
		
		// ------------ 쿠폰 수정 --------------------
		@PostMapping("CouponModifyPro.po")
		public String couponModifyPro(Model model, @RequestParam(defaultValue = "0") int coupon_idx, @RequestParam(defaultValue = "") String coupon_banner, @ModelAttribute CouponVo coupon) {
			
			System.out.println("coupon : " + coupon);
			
			if(!coupon_banner.equals("")) {
			coupon.setCoupon_content(coupon_banner + " / " + coupon.getCoupon_content());
		}
		
			int updateCount = service.updateCoupon(coupon);
			
			if(updateCount > 0) {
				return "redirect:/CouponList.po";
			} else {
				model.addAttribute("msg", "수정 실패!");
				return "fail_back";
			}
			
		}
		
		// ------------ 쿠폰 삭제 --------------------
		@GetMapping("CouponDeletePro.po")
		public String couponDeletePro(Model model, @RequestParam(defaultValue = "0") int coupon_idx) {
			
			int deleteCount = service.deleteCoupon(coupon_idx);
			
			if(deleteCount > 0) {
				return "redirect:/CouponList.po";
			} else {
				model.addAttribute("msg", "삭제 실패!");
				return "fail_back";
			}
			
		}
		
		//----------- 쿠폰 등록 폼----------------------
		@GetMapping("CouponInsertForm.po") 
		public String CouponForm() {
			return "admin/admin_coupon_insert";
		}
		
		
		//----------- 쿠폰 등록----------------------
		@PostMapping("CouponInsertPro.po") 
		public String insertCoupon(Model model, @ModelAttribute CouponVo coupon,
				@RequestParam(defaultValue = "") String coupon_banner) {
			
			System.out.println("coupon : " + coupon);
			
			if(!coupon_banner.equals("")) {
				coupon.setCoupon_content(coupon_banner + " / " + coupon.getCoupon_content());
			}
			
			
			int insertCount = service.insertCoupon(coupon);
			
			if(insertCount > 0) {
				return "redirect:/CouponList.po";
			} else {
				model.addAttribute("msg", "등록 실패!");
				return "fail_back";
			}
			
		}
		
		// ========================== 쿠폰 끝 ================================
	
	
	
	// 배너 쿠폰 목록
	@RequestMapping(value = "/CouponMainList.po", method= {RequestMethod.GET, RequestMethod.POST})
	public String CouponMainList(
			@RequestParam(defaultValue = "1")String coupon_content
			, Model model , HttpSession session
			) {
		
		String sId = (String)session.getAttribute("sId");
		
		int member_idx = service_product.getMemberIdx(sId);
		System.out.println("member_idx = " + member_idx);
		
		
		// 배너 쿠폰 목록
		List<CouponVo> couponList = service.getMainCouponList(coupon_content);
		
		model.addAttribute("couponList", couponList);
		
		// 회원별 쿠폰 보유 검사
//		CouponVo member_coupon = service.getMemberCoupon(coupon_content, member_idx);
//		
//		if(member_coupon != null) {
//			model.addAttribute("member_coupon", member_coupon);
//		} else {
//			model.addAttribute("member_coupon", null);
//		}
		
		
		return "main_coupon";
		
	}
	
	// 쿠폰 다운
	@RequestMapping(value = "/CouponDownPro.po", method= {RequestMethod.GET, RequestMethod.POST})
	public void CouponDown(HttpSession session, HttpServletResponse response,
			@RequestParam(defaultValue = "0")int coupon_idx) {
		
		String sId = (String)session.getAttribute("sId");
		
		int member_idx = service_product.getMemberIdx(sId);
//		System.out.println("member_idx = " + member_idx);
		
		CouponVo coupon = service.getCouponInfo(coupon_idx);
		
		int insertCount = service.downCoupon(member_idx, coupon);
		
		if(insertCount > 0) {
			service.updateCouponCount(coupon_idx);
		}
		
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(insertCount);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	
	// 쿠폰 다운 - 중복 검사
	@RequestMapping(value = "/CouponDownCheck.po", method= {RequestMethod.GET, RequestMethod.POST})
	public void CouponDownCheck(HttpSession session, HttpServletResponse response,Model model,
			@RequestParam(defaultValue = "0")int coupon_idx) {
		
		String sId = (String)session.getAttribute("sId");
		
		int member_idx = service_product.getMemberIdx(sId);
		
		int checkCount = service.couponCheck(coupon_idx, member_idx);
		
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(checkCount);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	// 쿠폰 다운 - 수량 검사
	@RequestMapping(value = "/CouponCountCheck.po", method= {RequestMethod.GET, RequestMethod.POST})
	public void CouponCountCheck(HttpSession session, HttpServletResponse response,Model model,
			@RequestParam(defaultValue = "0")int coupon_idx) {
		
		
		int checkCount = service.couponCountCheck(coupon_idx);
		
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(checkCount);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	// 마이페이지 쿠폰함
	@RequestMapping(value = "/CouponListMypage.po", method= {RequestMethod.GET, RequestMethod.POST})
	public String CouponListMypage(HttpSession session, HttpServletResponse response,Model model
			) {
		String sId = (String)session.getAttribute("sId");
		
		int member_idx = service_product.getMemberIdx(sId);
		List<CouponVo> couponList = service.getMyCouponList(member_idx);
		
		model.addAttribute("couponList", couponList);
		
		
		return "member/my_couponlist";
	}
	
	
}
