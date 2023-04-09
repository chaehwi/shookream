package com.chaehwi.shookream.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chaehwi.shookream.mapper.MainMapper;
import com.chaehwi.shookream.mapper.ProductMapper;
import com.chaehwi.shookream.mapper.ReviewMapper;
import com.chaehwi.shookream.vo.ProductVo;
import com.chaehwi.shookream.vo.ReviewVo;

@Service
public class ReviewService {
	@Autowired
	private ReviewMapper mapper;
	
	//========리뷰 리스트 출력 ============
	public List<ReviewVo> getMyReviewList(int startRow, int listLimit, int member_idx) {
		return mapper.getMyReviewList(startRow,listLimit,member_idx);
	}
	//========리뷰 리스트 출력 끝 ============
	
	//========리뷰 리스트 개수 확인 ============
	public int getReviewListCount() {
		return mapper.getReviewListCount();
	}
	//========리뷰 리스트 개수 확인 끝============
	
	//========작성된 리뷰 확인 ============
	public int isReviewExist(ReviewVo review) {
		// TODO Auto-generated method stub
		return mapper.isReviewExist(review);
	}
	//========작성된 리뷰 확인 끝 ============
	
	
	//========리뷰 작성하기 ============
	public boolean insertReview(ReviewVo review) {
		// TODO Auto-generated method stub
		return mapper.insertReview(review);
	}
	//========리뷰 작성하기 끝 ============
	
	//========리뷰 삭제 하기 ============
	public boolean deleteReview(int review_idx) {
		return mapper.deleteReview(review_idx);
	}
	//========리뷰 삭제 하기 끝 ============
	
	//========배송 완료 개수 확인 ============
	public int selectProgress(int member_idx) {
		return mapper.selectProgress(member_idx);
		
	}
	//========배송 완료 개수 확인 끝============
}
