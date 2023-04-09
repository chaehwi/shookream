package com.chaehwi.shookream.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.chaehwi.shookream.mapper.WishMapper;
import com.chaehwi.shookream.vo.ProductVo;
import com.chaehwi.shookream.vo.WishVo;
import com.chaehwi.shookream.vo.imageVo;

@Service
public class WishService {
	@Autowired
	private WishMapper mapper;

	//========좋아요 등록 하기 ============
	public boolean InsertLike(int member_idx, int product_idx) {
//		updateWishCount(product_idx);
		return mapper.InsertLike(member_idx,product_idx);
	}
	//========좋아요 등록 하기 끝============

	//========좋아요 삭제 하기============
	public boolean DeleteWish(int member_idx, int product_idx) {
//		DecWishCount(product_idx);
		return mapper.DeleteWish(member_idx,product_idx);
	}
	//========좋아요 삭제 하기 끝============
	
	//========좋아요 리스트 출력============
	public List<ProductVo> getWishList(int startRow, int listLimit, int member_idx) {
		return mapper.getWishList(startRow,listLimit,member_idx);
	}
	//========좋아요 리스트 출력 끝============
	
	//========좋아요 개수 확인============
	public int getWishListCount(int member_idx) {
		return mapper.getWishListCount(member_idx);
	}
	//========좋아요 개수 확인 끝============
	
	//========좋아요 개수 + 1  ============
	public int updateWishCount(int product_idx) {
		return mapper.updateWishCount(product_idx);
	}
	//========좋아요 개수 + 1  끝============

	//========좋아요 개수 - 1  ============
	public int DecWishCount(int product_idx) {
		return mapper.DecWishCount(product_idx);
	}
	//========좋아요 개수 - 1  끝============

	// 좋아요 중복 검사
	public int wishCheck(int member_idx, int product_idx) {
		return mapper.wishCheck(member_idx, product_idx);
	}
	
}
