package com.chaehwi.shookream.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chaehwi.shookream.mapper.ProductMapper;
import com.chaehwi.shookream.vo.CouponVo;
import com.chaehwi.shookream.vo.OrderVo;
import com.chaehwi.shookream.vo.OrderdeliveryVo;
import com.chaehwi.shookream.vo.ProductVo;
import com.chaehwi.shookream.vo.ReviewVo;
import com.chaehwi.shookream.vo.WishVo;
import com.chaehwi.shookream.vo.imageVo;

@Service
public class ProductService {
	@Autowired
	private ProductMapper mapper;
	
	
	// ====================== 채휘 ===========================
	public int getMemberIdx(String sId) {
		return mapper.selectMemberIdx(sId);
	}

	// 상품 상세 조회
	public WishVo getWishInfo(int product_idx, int member_idx) {
		return mapper.selectWish(product_idx, member_idx);
	}

	public ProductVo getProduct(int product_idx) {
		return mapper.selectProduct(product_idx);
	}

	public imageVo getImage(int product_idx) {
		return mapper.selectImage(product_idx);
	}

	public List<String> getCategoryList(String product_name) {
		return mapper.selectCategoryList(product_name);
	}

	public List<String> getColorList(String product_name) {
		return mapper.selectColorList(product_name);
	}

	public List<imageVo> getImageList(String product_name) {
		return mapper.selectImageList(product_name);
	}
	
	public List<ReviewVo> getReviewList(int product_idx) {
		return mapper.selectReviewList(product_idx);
	}
	// 상품 상세 조회 끝

	
	// 구매
	public int InsertOrder(OrderVo order) {
		return mapper.insertOrder(order);
	}

	public int InsertOrderDetail(OrderVo order, OrderdeliveryVo delivery) {
		return mapper.insertOrderDetail(order,delivery);
	}

	public void updatePro(OrderVo order) {
		mapper.updaetProduct(order);
	}

	public void updateMem(OrderVo order) {
		mapper.updateMember(order);
	}

	// 구매 끝 
	
	// 쿠폰 목록 조회
	public List<CouponVo> getCouponList(int member_idx, int product_price) {
		return mapper.selectCoupontList(member_idx, product_price);
	}

	// 주문 내역 조회
	public List<OrderVo> getOrderList(int member_idx, int listLimit, int startRow) {
		return mapper.selectOrderList(member_idx,listLimit,startRow);
	}

	public int getListCount(int member_idx) {
		// TODO Auto-generated method stub
		return mapper.getListCount(member_idx);
	}

	// ================== 채휘 끝 ====================
}
