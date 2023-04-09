package com.chaehwi.shookream.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chaehwi.shookream.vo.CouponVo;
import com.chaehwi.shookream.vo.MemberVo;
import com.chaehwi.shookream.vo.OrderVo;
import com.chaehwi.shookream.vo.ProductVo;
import com.chaehwi.shookream.vo.imageVo;

public interface AdminMapper {

	// 1. 상품 등록
	// => 파라미터 : ProductVO 객체    리턴타입 : int
	public int insertProduct(ProductVo product);

	// 2. 상품 이미지 등록
	// => 파라미터 : ImageVO 객체    리턴타입 : int
	public int insertImage(@Param("image") imageVo image, 
					@Param("product_idx")int product_idx);

	// 3. 상품 수정
	public int modifyProduct(
			@Param("product_idx")int product_idx, 
			@Param("product") ProductVo product,
			@Param("image") imageVo image);
	
	// 3-1. 상품 수정 시 이미지 수정
//	public int modifyImage(
//			@Param("product_idx") int product_idx,
//			@Param("product") ProductVo product,
//			@Param("image") imageVo image);

	// 4. 상품 삭제
	public int removeProduct(int product_idx);
	
	// 5. 상품 목록 조회
	public List<ProductVo> selectProductList();
	
	// 6. 이미지 조회
	public List<imageVo> selectImgList(int product_idx);
//	public List<imageVo> selectImgList();
	
	public ProductVo selectProduct(int product_idx);

	public imageVo selectImage(int product_idx);

	// 회원목록 조회
	public List<MemberVo> selectMember();

	// 주문목록 조회
	public List<OrderVo> selectOrderList();

	// 주문목록 삭제
	public int delectOrder(int order_idx);

	
	

	
}
