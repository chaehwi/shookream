package com.chaehwi.shookream.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chaehwi.shookream.mapper.CouponMapper;
import com.chaehwi.shookream.vo.CouponVo;

@Service
public class CouponService {

	@Autowired 
	private CouponMapper mapper;
	
	// 메인 쿠폰 목록
	public CouponVo getMemberCoupon(String coupon_content, int member_idx) {
		return mapper.selectMainCoupon(coupon_content, member_idx);
	}

	public List<CouponVo> getMainCouponList(String coupon_content) {
		return mapper.selectMainCouponList(coupon_content);
	}

	// 쿠폰 다운 (조회)
	public CouponVo getCouponInfo(String coupon_content) {
		return mapper.selectMemberCoupon(coupon_content);
	}

	// 쿠폰 다운 
	public int downCoupon(int member_idx, CouponVo coupon) {
		return mapper.insertMemberCoupon(member_idx, coupon);
	}
	
	//쿠폰목록
	public List<CouponVo> getCouponList() {
		return mapper.selectCouponList();
	}

	//쿠폰수정폼
	public CouponVo getCouponInfo(int coupon_idx) {
		return mapper.selectCoupon(coupon_idx);
	}

	//쿠폰수정
	public int updateCoupon(CouponVo coupon) {
		return mapper.updateCoupon(coupon);
	}

	//쿠폰삭제
	public int deleteCoupon(int coupon_idx) {
		return mapper.deletCoupon(coupon_idx);
	}

	//쿠폰등록
	public int insertCoupon(CouponVo coupon) {
		return mapper.insertCoupon(coupon);
	}

	//쿠폰중복검사
	public int couponCheck(int coupon_idx, int member_idx) {
		return mapper.selectCouponCheck(coupon_idx, member_idx);
	}

	//마이페이지 쿠폰
	public List<CouponVo> getMyCouponList(int member_idx) {
		return mapper.selectMyCouponList(member_idx);
	}

	// 수량 변경
	public void updateCouponCount(int coupon_idx) {
		mapper.updateCouponCount(coupon_idx);
	}

	// 수량 체크
	public int couponCountCheck(int coupon_idx) {
		return mapper.couponCountCheck(coupon_idx);
	}
}
