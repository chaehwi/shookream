package com.chaehwi.shookream.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.chaehwi.shookream.vo.ProductVo;
import com.chaehwi.shookream.vo.ReviewVo;

@Mapper
public interface ReviewMapper {
	//========리뷰 리스트 출력 ===========
	List<ReviewVo> getMyReviewList(@Param("startRow") int startRow,@Param("listLimit") int listLimit,@Param("member_idx") int member_idx);
	//========리뷰 리스트 출력 끝===========
	
	//========리뷰 리스트 개수 ===========
	int getReviewListCount();
	//========리뷰 리스트 개수 끝 ===========
	
	//========작성 된 리뷰 확인  ===========
	int isReviewExist(ReviewVo review);
	//========작성 된 리뷰 확인 끝 ===========
	
	//========리뷰 등록 하기  ===========
	boolean insertReview(ReviewVo review);
	//========리뷰 등록 끝 ===========
	
	//========리뷰 삭제 하기 ===========
	boolean deleteReview(int review_idx);
	//========리뷰 삭제 끝 ===========
	
	//========배송 완료 개수 확인 ===========
	int selectProgress(int member_idx);
	//========배송 완료 개수 확인===========
}
