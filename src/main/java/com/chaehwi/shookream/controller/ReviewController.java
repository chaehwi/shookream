package com.chaehwi.shookream.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.chaehwi.shookream.service.ReviewService;
import com.chaehwi.shookream.vo.PageInfo;
import com.chaehwi.shookream.vo.ReviewVo;
import com.chaehwi.shookream.vo.imageVo;

/**
 * Handles requests for the application home page.
 */
@Controller
public class ReviewController {
	
	@Autowired 
	private ReviewService service;
	
	//========마이페이지 ============
	@GetMapping(value = "/MemberMyPage.me")
	public String mypage(@RequestParam(defaultValue = "1")int member_idx,
						 Model model) {
		int orderCount = service.selectProgress(member_idx);//배송 완료 개수 확인
		System.out.println("orderCount :"+orderCount);
		model.addAttribute("orderCount", orderCount);
		return "member/my_page";
	}
	//========마이페이지 끝============
	
	//========리뷰 리스트 출력============
	@GetMapping(value = "/MyReviewList.me")
	public String reviewList(@RequestParam(defaultValue = "1",value = "member_idx")int member_idx,
							Model model) {
		int listLimit = 5; 
		int pageNum = 1; // 현재 페이지 번호 설정(pageNum 파라미터 사용)
		
		int startRow = (pageNum - 1) * listLimit;
				
		List<ReviewVo> reviewList = service.getMyReviewList(startRow, listLimit, member_idx);//리뷰 리스트 출력
		System.out.println(reviewList);
		
		int listCount = service.getReviewListCount();//리뷰 개수 확인
		
		//========페이징 처리============
		int pageListLimit = 3; 
		
		int maxPage = listCount / listLimit 
						+ (listCount % listLimit == 0 ? 0 : 1); 
		
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		
		int endPage = startPage + pageListLimit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		//========페이징 처리 끝 ============
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		System.out.println("action의 리뷰 리스트 : " + reviewList);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "member/my_review_list";
	}
	//=======리뷰 리스트 출력 끝============
	
	//========리뷰 등록 폼 ============
	@GetMapping(value = "/ReviewWriteForm.me")
	public String reviewWrite() {
		
		return "product/review_write_form";
	}
	//========리뷰 등록 폼 끝============
	
	//========리뷰 등록 하기 ============
	@PostMapping(value="/ReviewWrite.me")
	public String reviewWritePro(@ModelAttribute ReviewVo review,HttpSession session,Model model,
								@RequestParam(defaultValue = "")String product_size,
								@RequestParam(defaultValue = "")String product_color,
								HttpServletResponse response
								) {
		
		String uploadDir = "/resources/upload"; //가상 업로드 위치 지정
		String saveDir = session.getServletContext().getRealPath(uploadDir); //실제 업로드 위치 설정
		System.out.println("실제 업로드 경로 : " + saveDir);
		System.out.println("리뷰 vo :"+review);
		
		review.setRe_order_detail(product_size+","+product_color );//size & color 결합
		// -------------- java.nio 패키지(Files, Path, Paths) 객체 활용 ---------------------------
		Path path = Paths.get(saveDir); // 실제 업로드 경로 지정
		
		try {
			Files.createDirectories(path);//실제 지정된 업로드 경로에 디렉토리 생성
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		//----------------------------------------
		
		MultipartFile[] mFiles = review.getFiles();// 파일 객체에 파일 넣기
		
		String originalFileNames = "";//서버에 등록 될 파일 이름
		String realFileNames = "";//실제 저장될 파일 이름
		
		// 복수개의 파일에 접근하기 위한 반복문
		for(MultipartFile mFile : mFiles) {
			String originalFileName = mFile.getOriginalFilename();
			if(!originalFileName.equals("")) {
			// 파일명 중복 방지 대책
				String uuid = UUID.randomUUID().toString();
				System.out.println("업로드 될 파일명 : " + uuid + "_" + originalFileName);
				
				// 파일명을 결합하여 보관할 변수에 하나의 파일 문자열 결합
				originalFileNames += originalFileName + "/";
				realFileNames += uuid + "_" + originalFileName + "/";
			} else {
				// 파일이 존재하지 않을 경우 널스트링으로 대체(뒤에 슬래시 포함)
				originalFileNames += "/";
				realFileNames += "/";
			}
		}
		// productVO 객체에 원본 파일명과 업로드 될 파일명 저장
//		image.setImage_main_file(originalFileNames);
		review.setReview_img(originalFileNames); // original 파일이름
		review.setReview_real_img(realFileNames); // 실제 파일 이름
		System.out.println("원본 파일명 : " +review.getReview_img() );
		System.out.println("업로드 될 파일명 : " + review.getReview_real_img());
		
		// ProductService 객체의 insertProduct() 메서드 호출
		int reviewExist = service.isReviewExist(review);
		System.out.println("reviewExist : "+reviewExist);
		
		if(reviewExist > 0) { // 실패 시reviewExist
			 model.addAttribute("msg", "이미 작성하신 리뷰가 존재합니다!");
		    }else {
		      // 성공 시 	reviewExist
			   boolean isReviewSuccess = service.insertReview(review);
		       model.addAttribute("msg", "리뷰 작성 성공!");
		       // 글쓰기 실패 시!
		       if(!isReviewSuccess) {
			          File f = new File(saveDir, review.getReview_real_img());
			          if(f.exists()) { //존재할 경우
			             // File객체의 delete() 메서드를 호출하여 해당 파일 삭제
			             f.delete();
			          }
			          model.addAttribute("msg", "리뷰 작성 실패!");
			      }
		    } 
		return "reload_review";
	} 
	//========리뷰 등록 끝 ============
	
	//========리뷰 삭제============
	@GetMapping(value = "ReviewDeletePro.po")
	public String reviewDelete(@RequestParam(defaultValue = "1")int product_idx,
								@RequestParam(defaultValue = "1")int member_idx,
								@RequestParam(defaultValue = "1")int review_idx,
								Model model) {
		boolean deleteReview = service.deleteReview(review_idx);//리뷰 삭제
		System.out.println("deleteReview : "+deleteReview);
		if(deleteReview) {//삭제 성공시
			model.addAttribute("msg", "삭제 되었습니다!");
			model.addAttribute("url","ProductInfoForm.po?product_idx="+product_idx+"&member_idx="+member_idx );
		}else {// 삭제 실패 시 
			model.addAttribute("msg", "삭제 실패했습니다!");
		}
		return "reload_review";	
	}
	//========리뷰 삭제 끝============
}

