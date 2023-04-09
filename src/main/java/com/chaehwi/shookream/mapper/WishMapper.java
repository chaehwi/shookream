package com.chaehwi.shookream.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.chaehwi.shookream.vo.ProductVo;
import com.chaehwi.shookream.vo.WishVo;
import com.chaehwi.shookream.vo.imageVo;

@Mapper
public interface WishMapper {
	//========좋아요 등록 하기 ============
	boolean InsertLike(
			@Param("member_idx") int member_idx
			,@Param("product_idx") int product_idx);
	//========좋아요 등록 하기 ============
	
	//========좋아요 삭제 하기============
	boolean DeleteWish(
			@Param("member_idx")int member_idx, 
			@Param("product_idx")int product_idx);
	//========좋아요 삭제 하기 끝============
	
	//========좋아요 리스트 출력============
	List<ProductVo> getWishList(
			@Param("member_idx")int member_idx,
			@Param("startRow")int startRow, 
			@Param("listLimit")int listLimit
			);
	//========좋아요 리스트 출력 끝============
	
	//========좋아요 개수 확인============
	int getWishListCount(int member_idx);
	//========좋아요 개수 확인 끝============
	
	//========좋아요 개수 + 1  ============
	int updateWishCount(int product_idx);
	//========좋아요 개수 + 1  끝============
	
	//========좋아요 개수 - 1  ============
	int DecWishCount(int product_idx);
	//========좋아요 개수 - 1  끝============

	int wishCheck(@Param("member_idx")int member_idx, 
				@Param("product_idx")int product_idx);
}
