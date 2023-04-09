package com.chaehwi.shookream.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.chaehwi.shookream.vo.CouponVo;

@Mapper
public interface CouponMapper {

	// 메인 쿠폰 목록
	CouponVo selectMainCoupon(@Param("coupon_content")String coupon_content,@Param("member_idx") int member_idx);

	List<CouponVo> selectMainCouponList(String coupon_content);

	CouponVo selectMemberCoupon(String coupon_content);

	int insertMemberCoupon(@Param("member_idx")int member_idx, @Param("coupon")CouponVo coupon);
	
	
	// 쿠폰목록
	public List<CouponVo> selectCouponList();

	// 쿠폰수정폼
	public CouponVo selectCoupon(int coupon_idx);

	// 쿠폰수정
	public int updateCoupon(CouponVo coupon);

	// 쿠폰삭제
	public int deletCoupon(int coupon_idx);

	// 쿠폰등록
	public int insertCoupon(CouponVo coupon);

	int selectCouponCheck(@Param("coupon_idx") int coupon_idx, @Param("member_idx") int member_idx);

	// 마이페이지 쿠폰
	List<CouponVo> selectMyCouponList(int member_idx);

	void updateCouponCount(int coupon_idx);

	int couponCountCheck(int coupon_idx);


}
