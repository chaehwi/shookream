package com.chaehwi.shookream.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chaehwi.shookream.mapper.AdminMapper;
import com.chaehwi.shookream.vo.CouponVo;
import com.chaehwi.shookream.vo.MemberVo;
import com.chaehwi.shookream.vo.OrderVo;
import com.chaehwi.shookream.vo.ProductVo;
import com.chaehwi.shookream.vo.imageVo;

@Service
public class AdminService {
	@Autowired
	private AdminMapper mapper;
	
	// 상품 등록 insertProduct() 메서드
		// => 파라미터 : BoardVO 객체    리턴타입 : int(insertCount)
		public int insertProduct(ProductVo product) {
			return mapper.insertProduct(product);
		}
		
		// 상품 이미지 등록 insertProduct() 메서드
		// => 파라미터 : BoardVO 객체    리턴타입 : int(insertCount)
		public int insertImg(imageVo image, int product_idx) {
			return mapper.insertImage(image, product_idx);
		}
		
		// 상품 수정 updateProduct() 메서드
		public int updateProduct(int product_idx, ProductVo product, imageVo image) {
			mapper.modifyProduct(product_idx, product, image);
		    return 1;
		}
		// 상품 수정 - 이미지 수정 updateImage() 메서드
//		public int updateImage(int product_idx, ProductVo product, imageVo image) {
//			return mapper.modifyImage(product_idx, product, image);
//		}

		// 상품 삭제 deleteProduct() 메서드
		public int deleteProduct(int product_idx) {
			return mapper.removeProduct(product_idx);
		}
		// 상품 목록 조회 - getProductList()
		public List<ProductVo> getProductList() {
			return mapper.selectProductList();
		}
		// 이미지 목록 조회 
		public List<imageVo> getImgList(int product_idx) {
			return mapper.selectImgList(product_idx);
		}
//		public List<imageVo> getImgList() {
//			return mapper.selectImgList();
//		}
		
		public ProductVo getProduct(int product_idx) {
			return mapper.selectProduct(product_idx);
		}

		public imageVo getImage(int product_idx) {
			return mapper.selectImage(product_idx);
		}
		
		//회원목록
		public List<MemberVo> getMemberInfo() {
			return mapper.selectMember();
		}

		//주문목록
		public List<OrderVo> getOrderList() {
			return mapper.selectOrderList();
		}
		
		//주문목록 - 삭제
		public int deleteOrder(int order_idx) {
			return mapper.delectOrder(order_idx);
		}

		
	
}
