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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chaehwi.shookream.service.ProductService;
import com.chaehwi.shookream.service.WishService;
import com.chaehwi.shookream.vo.PageInfo;
import com.chaehwi.shookream.vo.ProductVo;
import com.chaehwi.shookream.vo.WishVo;
import com.chaehwi.shookream.vo.imageVo;

/**
 * Handles requests for the application home page.
 */
@Controller
public class WishController {
	
	@Autowired 
	private WishService service;
	@Autowired 
	private ProductService service_product;
	
	//========좋아요 중복 검사 ============
	@RequestMapping(value = "/LikeInsertCheck.ca", method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public void LikeInsertCheck(
//			@RequestParam(defaultValue = "1")int member_idx,
			@RequestParam(defaultValue = "1")int product_idx,
			HttpServletResponse response, HttpSession session
			) {
		
		String sId = (String)session.getAttribute("sId");
		
		int member_idx = service_product.getMemberIdx(sId);
		
		int result = service.wishCheck(member_idx, product_idx);
		
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//========좋아요 중복 검사 끝 ============
	
	//========좋아요 등록 하기============
	@RequestMapping(value = "/LikeInsertPro.ca", method= {RequestMethod.GET, RequestMethod.POST})
	public void likeInsert(
//			@RequestParam(defaultValue = "1")int member_idx,
			@RequestParam(defaultValue = "1")int product_idx,
			HttpServletResponse response, HttpSession session
			) {
		String sId = (String)session.getAttribute("sId");
		
		int member_idx = service_product.getMemberIdx(sId);
		
		
		boolean isSuccess = service.InsertLike(member_idx, product_idx);
		try {
			if(isSuccess) {//등록 성공 시
				service.updateWishCount(product_idx);//등록 성공 시 count + 1
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
				out.println("alert('찜한 상품에 추가되었습니다')");
				out.println("</script>");
				
				System.out.println("결과 : " + isSuccess);
			} else {//등록 실패 시
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
				out.println("alert('찜하기를 실패했습니다')");
				out.println("</script>");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//========좋아요 등록 끝 ============
	
	//========좋아요 삭제 하기============
	@RequestMapping(value = "/LikeDeletePro.ca", method= {RequestMethod.GET, RequestMethod.POST})
	public String likedelete(
//			@RequestParam(defaultValue = "1")int member_idx,
			@RequestParam(defaultValue = "1")int product_idx,
			HttpServletResponse response, HttpSession session
			) {
		
		String sId = (String)session.getAttribute("sId");
		
		int member_idx = service_product.getMemberIdx(sId);
		
		boolean isSuccess = service.DeleteWish(member_idx, product_idx);
		try {
			if(isSuccess) {//삭제 성공 시 
				service.DecWishCount(product_idx);//삭제 성공 시 count - 1
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();

				out.println("<script>");
				out.println("alert('찜한 상품에서 삭제되었습니다')");
				out.println("</script>");
				
				System.out.println("idDeleteSuccess? : " + isSuccess);
			} else {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
				out.println("alert('찜 삭제 실패')");
				out.println("</script>");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "redirect:/LikeList.ca?member_idx"+member_idx;
	}
	//========좋아요 삭제 끝============
	
	//========좋아요 리스트 출력============
	@GetMapping(value = "LikeList.ca")
	public String likeList(
//						@RequestParam(defaultValue = "1")int member_idx,
						@RequestParam(defaultValue = "1")int pageNum,
						Model model, HttpSession session) {
		String sId = (String)session.getAttribute("sId");
		
		int member_idx = service_product.getMemberIdx(sId);
		
		//========페이징 처리 ============
		// 페이징 처리를 위한 변수 선언
		int listLimit = 10; // 한 페이지에서 표시할 게시물 목록을 10개로 제한
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행번호 계산

		List<ProductVo> wishlist = service.getWishList(member_idx,startRow, listLimit);
		
		int listCount = service.getWishListCount(member_idx);
		int pageListLimit = 10; // 한 페이지에서 표시할 페이지 목록을 3개로 제한
		
		int maxPage = listCount / listLimit 
						+ (listCount % listLimit == 0 ? 0 : 1);
		
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		
		int endPage = startPage + pageListLimit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		//========페이징 처리 끝============
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		model.addAttribute("wishlist",wishlist);
		model.addAttribute("pageInfo",pageInfo);
		
		return "product/Product_wishlist";
	}
	
	
	
}
