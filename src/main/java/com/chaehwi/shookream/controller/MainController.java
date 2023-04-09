package com.chaehwi.shookream.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.chaehwi.shookream.service.AdminService;
import com.chaehwi.shookream.service.MainService;
import com.chaehwi.shookream.service.MemberService;
import com.chaehwi.shookream.service.ProductService;
import com.chaehwi.shookream.vo.PageInfo;
import com.chaehwi.shookream.vo.ProductVo;
import com.chaehwi.shookream.vo.WishVo;
import com.chaehwi.shookream.vo.imageVo;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MainController {
	
	@Autowired 
	private MainService service;
	
	@Autowired 
	private MemberService service_member;
	@Autowired 
	private ProductService service_product;
	@Autowired 
	private AdminService service_admin;

	//-----------------------메인 페이지--------------------------------
	@RequestMapping(value = "/main.ma", method = RequestMethod.GET)
	public String main(Model model, HttpServletRequest request, HttpSession session, ProductVo product) {
		int listLimit = 16; // 한 페이지에서 표시할 게시물 목록을 10개로 제한
		int pageNum = 1; // 현재 페이지 번호 설정(pageNum 파라미터 사용)
		
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}

		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행번호 계산
		
		// 베스트 상품 가져오기
		List<ProductVo> productBestList = service.getProductBestList(startRow, listLimit);
		model.addAttribute("productBestList", productBestList);
		
		for(ProductVo product1 : productBestList) {
	        // 일치하는 상품을 찾았을 때 해당 상품에 대한 이미지를 조회
	        List<imageVo> imageList = service_admin.getImgList(product1.getProduct_idx());
	        String fileNames = imageList.get(0).getImage_main_file();
	        String[] splitFileNames = fileNames.split("/");
	        String firstFileName = splitFileNames[0]; // 맨 앞 파일명
	        System.out.println("fileNames :: " + firstFileName);
	        
	        product1.setImage_main_file(firstFileName);
	    }
		
		
		// 최근 등록 상품 가져오기
		List<ProductVo> productNewList = service.getProductNewList(startRow, listLimit);
		model.addAttribute("productNewList", productNewList);
		
		for(ProductVo product2 : productNewList) {
	        // 일치하는 상품을 찾았을 때 해당 상품에 대한 이미지를 조회
	        List<imageVo> imageList = service_admin.getImgList(product2.getProduct_idx());
	        String fileNames = imageList.get(0).getImage_main_file();
	        String[] splitFileNames = fileNames.split("/");
	        String firstFileName = splitFileNames[0]; // 맨 앞 파일명
	        System.out.println("fileNames :: " + firstFileName);
	        
	        product2.setImage_main_file(firstFileName);
	    }
		
		
		String sId = (String)session.getAttribute("sId");
//		String sId = "admin";
		
		if(sId != null) {
		// 로그인 후 session 에 member_idx 저장할 시 불필요한 과정
		int member_idx = service_product.getMemberIdx(sId);
		
		// wish 조회
		List<WishVo> wish = service_member.getWish(member_idx);
		
		if(wish == null) {
			model.addAttribute("wish", null);
		}else {
			model.addAttribute("wish", wish);
		}
		}
		return "main";
	}//main 끝
	
	//---------------------Best 페이지--------------------------
	@RequestMapping(value = "Best.ma", method = RequestMethod.GET)
	public String best(Model model, HttpServletRequest request, HttpSession session,ProductVo product) {
		// 페이징 처리를 위한 변수 선언
		int listLimit = 16; // 한 페이지에서 표시할 게시물 목록을 10개로 제한
		int pageNum = 1; // 현재 페이지 번호 설정(pageNum 파라미터 사용)

		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}

		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행번호 계산
		
		List<ProductVo> productBestList = service.getProductBestList(startRow, listLimit);
		model.addAttribute("productBestList", productBestList);
		
		for(ProductVo product1 : productBestList) {
	        // 일치하는 상품을 찾았을 때 해당 상품에 대한 이미지를 조회
	        List<imageVo> imageList = service_admin.getImgList(product1.getProduct_idx());
	        String fileNames = imageList.get(0).getImage_main_file();
	        String[] splitFileNames = fileNames.split("/");
	        String firstFileName = splitFileNames[0]; // 맨 앞 파일명
	        System.out.println("fileNames :: " + firstFileName);
	        
	        product1.setImage_main_file(firstFileName);
	    }

		String sId = (String)session.getAttribute("sId");
//		String sId = "admin";
		
		if(sId != null) {
		// 로그인 후 session 에 member_idx 저장할 시 불필요한 과정
		int member_idx = service_product.getMemberIdx(sId);
		
		// wish 조회
		List<WishVo> wish = service_member.getWish(member_idx);
		
		if(wish == null) {
			model.addAttribute("wish", null);
		}else {
			model.addAttribute("wish", wish);
		}
		}
		
		
		// ------------------페이징 처리----------------------
		// => 파라미터 : x   리턴타입 : int(listCount)
		//1. 목록 개수
		int listCount = service.getProductListCount();

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

		// PageInfo 객체 생성 후 페이징 처리 정보 저장
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		model.addAttribute("pageInfo", pageInfo);
		

		return "main_best";
	}//best 끝
	
//------------------------------New(최근 상품) 페이지--------------------------------------
	@GetMapping(value = "New.ma")
	public String New(Model model, HttpServletRequest request,HttpSession session, ProductVo product) {
		// 페이징 처리를 위한 변수 선언
				int listLimit = 16; // 한 페이지에서 표시할 게시물 목록을 10개로 제한
				int pageNum = 1; // 현재 페이지 번호 설정(pageNum 파라미터 사용)
			
				if(request.getParameter("pageNum") != null) {
					pageNum = Integer.parseInt(request.getParameter("pageNum"));
				}
			
				int startRow = (pageNum - 1) * listLimit; // 조회 시작 행번호 계산
				
				List<ProductVo> productNewList = service.getProductNewList(startRow, listLimit);
				model.addAttribute("productNewList", productNewList);
				
				for(ProductVo product2 : productNewList) {
			        // 일치하는 상품을 찾았을 때 해당 상품에 대한 이미지를 조회
			        List<imageVo> imageList = service_admin.getImgList(product2.getProduct_idx());
			        String fileNames = imageList.get(0).getImage_main_file();
			        String[] splitFileNames = fileNames.split("/");
			        String firstFileName = splitFileNames[0]; // 맨 앞 파일명
			        System.out.println("fileNames :: " + firstFileName);
			        
			        product2.setImage_main_file(firstFileName);
			    }

				String sId = (String)session.getAttribute("sId");
//				String sId = "admin";
				
				if(sId != null) {
				// 로그인 후 session 에 member_idx 저장할 시 불필요한 과정
				int member_idx = service_product.getMemberIdx(sId);
				
				// wish 조회
				List<WishVo> wish = service_member.getWish(member_idx);
				
				if(wish == null) {
					model.addAttribute("wish", null);
				}else {
					model.addAttribute("wish", wish);
				}
				}
				
				// ------------------페이징 처리----------------------
				// => 파라미터 : x   리턴타입 : int(listCount)
				//1. 목록 개수
				int listCount = service.getProductListCount();
			
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
			
				// PageInfo 객체 생성 후 페이징 처리 정보 저장
				PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
				model.addAttribute("pageInfo", pageInfo);
				
			
				return "main_new";
	}//New 끝
	
//------------------------------Sale 페이지--------------------------------------
	@GetMapping(value = "Sale.ma")
	public String sale(Model model, HttpServletRequest request, HttpSession session,ProductVo product) {
		// 페이징 처리를 위한 변수 선언
		int listLimit = 16; // 한 페이지에서 표시할 게시물 목록을 10개로 제한
		int pageNum = 1; // 현재 페이지 번호 설정(pageNum 파라미터 사용)
	
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
	
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행번호 계산
		
		List<ProductVo> productSaleList = service.getProductSaleList(startRow, listLimit);
		model.addAttribute("productSaleList", productSaleList);
		
		for(ProductVo product2 : productSaleList) {
	        // 일치하는 상품을 찾았을 때 해당 상품에 대한 이미지를 조회
	        List<imageVo> imageList = service_admin.getImgList(product2.getProduct_idx());
	        String fileNames = imageList.get(0).getImage_main_file();
	        String[] splitFileNames = fileNames.split("/");
	        String firstFileName = splitFileNames[0]; // 맨 앞 파일명
	        System.out.println("fileNames :: " + firstFileName);
	        
	        product2.setImage_main_file(firstFileName);
	    }

		String sId = (String)session.getAttribute("sId");
//		String sId = "admin";
		
		if(sId != null) {
		// 로그인 후 session 에 member_idx 저장할 시 불필요한 과정
		int member_idx = service_product.getMemberIdx(sId);
		
		// wish 조회
		List<WishVo> wish = service_member.getWish(member_idx);
		
		if(wish == null) {
			model.addAttribute("wish", null);
		}else {
			model.addAttribute("wish", wish);
		}
		}
		
		// ------------------페이징 처리----------------------
		// => 파라미터 : x   리턴타입 : int(listCount)
		//1. 목록 개수
		int listCount = service.getSaleProductListCount();
	
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
	
		// PageInfo 객체 생성 후 페이징 처리 정보 저장
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		model.addAttribute("pageInfo", pageInfo);
		
	
		return "main_sale";
	}//sale 끝
	//--------------브랜드별 포워딩----------------
	@GetMapping(value = "BrandCG.ma")
	public String brand(Model model, HttpSession session,HttpServletRequest request) {
		String cg = request.getParameter("cg");
		// 페이징 처리를 위한 변수 선언
			int listLimit = 16; // 한 페이지에서 표시할 게시물 목록을 10개로 제한
			int pageNum = 1; // 현재 페이지 번호 설정(pageNum 파라미터 사용)

			if (request.getParameter("pageNum") != null) {
				pageNum = Integer.parseInt(request.getParameter("pageNum"));
			}

			int startRow = (pageNum - 1) * listLimit; // 조회 시작 행번호 계산

			if (cg != null) { // 브랜드별 카테고리 이동

				List<ProductVo> productList = service.getProductCGList(cg, startRow, listLimit);
				model.addAttribute("productList", productList);
				
				for(ProductVo product2 : productList) {
			        // 일치하는 상품을 찾았을 때 해당 상품에 대한 이미지를 조회
			        List<imageVo> imageList = service_admin.getImgList(product2.getProduct_idx());
			        String fileNames = imageList.get(0).getImage_main_file();
			        String[] splitFileNames = fileNames.split("/");
			        String firstFileName = splitFileNames[0]; // 맨 앞 파일명
			        System.out.println("fileNames :: " + firstFileName);
			        
			        product2.setImage_main_file(firstFileName);
			    }

				String sId = (String)session.getAttribute("sId");
//				String sId = "admin";
				
				if(sId != null) {
				// 로그인 후 session 에 member_idx 저장할 시 불필요한 과정
				int member_idx = service_product.getMemberIdx(sId);
				
				// wish 조회
				List<WishVo> wish = service_member.getWish(member_idx);
				
				if(wish == null) {
					model.addAttribute("wish", null);
				}else {
					model.addAttribute("wish", wish);
				}
				}
				
				int listCount = service.getProductCgListCount(cg);
				
				int pageListLimit = 10; // 한 페이지에서 표시할 페이지 목록을 3개로 제한
				
				int maxPage = listCount / listLimit 
								+ (listCount % listLimit == 0 ? 0 : 1);
				
				int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
				
				int endPage = startPage + pageListLimit - 1;
				
				if(endPage > maxPage) {
					endPage = maxPage;
				}
					
				PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
				model.addAttribute("pageInfo", pageInfo); 
			}		
		return "main_cg";
	}//BRANDCG 끝
			
	//----------------------------------검색창(Keyword)----------------------------------------
	@GetMapping(value = "keyword.ma")
	public String search(@RequestParam("keyword") String keyword, Model model, HttpServletRequest request, HttpSession session,ProductVo product) {
		
		
		
		// 페이징 처리를 위한 변수 선언
		int listLimit = 16; // 한 페이지에서 표시할 게시물 목록을 10개로 제한
		int pageNum = 1; // 현재 페이지 번호 설정(pageNum 파라미터 사용)
	
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
	
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행번호 계산
		
		List<ProductVo> productList = service.getProductSearchList(keyword, startRow, listLimit);
		
		for(ProductVo product2 : productList) {
	        // 일치하는 상품을 찾았을 때 해당 상품에 대한 이미지를 조회
	        List<imageVo> imageList = service_admin.getImgList(product2.getProduct_idx());
	        String fileNames = imageList.get(0).getImage_main_file();
	        String[] splitFileNames = fileNames.split("/");
	        String firstFileName = splitFileNames[0]; // 맨 앞 파일명
	        System.out.println("fileNames :: " + firstFileName);
	        
	        product2.setImage_main_file(firstFileName);
	    }
		
		model.addAttribute("productList", productList);
		

		String sId = (String)session.getAttribute("sId");
//		String sId = "admin";
		
		if(sId != null) {
		// 로그인 후 session 에 member_idx 저장할 시 불필요한 과정
		int member_idx = service_product.getMemberIdx(sId);
		
		// wish 조회
		List<WishVo> wish = service_member.getWish(member_idx);
		
		if(wish == null) {
			model.addAttribute("wish", null);
		}else {
			model.addAttribute("wish", wish);
		}
		}
		
		// ------------------페이징 처리----------------------
		// => 파라미터 : x   리턴타입 : int(listCount)
		//1. 목록 개수
		int listCount = service.getProductKeywordListCount(keyword);
	
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
	
		// PageInfo 객체 생성 후 페이징 처리 정보 저장
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		model.addAttribute("pageInfo", pageInfo);
		
	
		return "main_keyword";
	}//sale 끝
	
}//MainController
