package com.chaehwi.shookream.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chaehwi.shookream.mapper.CartMapper;
import com.chaehwi.shookream.vo.OrderdeliveryVo;
import com.chaehwi.shookream.vo.ProductVo;
import com.chaehwi.shookream.vo.cartVo;
import com.chaehwi.shookream.vo.cartVoArr;

@Service
public class CartService {
	@Autowired
	private CartMapper mapper;
	//카트 이동
	public List<cartVo> getCartlist(int member_idx, int startRow, int listLimit) {
		return mapper.getCartlist(member_idx, startRow, listLimit);
	}
	// 페이징 처리
	// 한 페이지에서 표시할 페이지 목록(번호) 갯수 계산
	// 1. BoardListService - selectBoardListCount() 메서드를 호출하여 전체 게시물 수 조회(페이지 목록 계산에 사용)
	// => 파라미터 : 검색어   리턴타입 : int(listCount)
	public int getCartListCount(int member_idx) {
		return mapper.selectCartCount(member_idx);
	}
	//장바구니 담기
	public int getInsertCart(int product_idx, int member_idx, int cart_count, ProductVo product) {
		return mapper.getInsertCart(product_idx, member_idx, cart_count, product);
	}
	//장바구니 등록 전 확인
	public cartVo getCartSelect(int product_idx, int member_idx) {
		return mapper.getCartSelect(product_idx,member_idx);
	}
	//product_idx 에 맞는 상품을 조회하여 productVo에 저장
	public ProductVo getProduct(int product_idx) {
		return mapper.getProduct(product_idx);
	}
	//장바구니 삭제
	public int getCartDelete(int cart_idx, int member_idx) {
		return mapper.getCartDelete(cart_idx, member_idx);
	}
	//장바구니 삭제(배열)
	public int getCartDeleteArr(int[] cart_idxArr, int member_idx) {
		return mapper.getCartDeleteArr(cart_idxArr, member_idx);
	}
	//이미 담긴 상품이 있는 경우 CART_count 만큼의 수량을 증가
	public int getUpdateCart(int product_idx, int member_idx, int cart_count) {
		return mapper.getUpdateCart(product_idx, member_idx, cart_count);
	}
	//장바구니 -> 구매페이지
	public cartVo getCartOrderlist(String cart_idx, int member_idx) {
		return mapper.getCartOrderList(cart_idx, member_idx);
	}
	//장바구니 수량 조정
	public int getAmountAdjust(int cart_idx, String type, int member_idx) {
		return mapper.getAmountAdjust(cart_idx, type, member_idx);
	}
	
	//다중 구매 작업
	public int insertCartOrder(cartVo vo2) {
		return mapper.insertCartOrder(vo2);
	}
	
	// 상품 수량 빼기 작업
	public void updatePorduct_Amount(cartVo vo2) {
		mapper.updatePorduct_Amount(vo2);
	}
	
	//이미 주문 한 상품이 있는지 확인 작업
	public int getCartOrderCount(cartVo vo2) {
		return mapper.getCartOrderCount(vo2);
	}
	
	//주문 수량 더하기 작업 
	public void updateOrder_Amount(cartVo vo2) {
		mapper.updateOrder_Amount(vo2);		
	}
	public int InsertOrderDetail(cartVo vo2, OrderdeliveryVo delivery) {
		return mapper.insertCartOrderDetail(vo2,delivery);
	}
	
	

}
