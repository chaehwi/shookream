package com.chaehwi.shookream.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chaehwi.shookream.vo.AuthVo;
import com.chaehwi.shookream.vo.CouponVo;
import com.chaehwi.shookream.vo.MemberVo;
import com.chaehwi.shookream.vo.WishVo;

public interface MemberMapper {

	// 로그인을 위한 패스워드 조회
	public String getSelectPass(String id);
	
	// 회원 상세 정보 조회 작업 - getMemberInfo()
	public MemberVo selectMemberInfo(String id);
	
	// 회원가입
	public int insertMember(MemberVo member);
	
	// 회원가입 : idx조회
	public int selectIdx();
	
	// 회원가입 : id 중복체크
	public int selectAllId(String id);

	// 회원가입 : 이메일 인증1 - 이전 인증 여부 판단
	public boolean selectAuth(AuthVo auth);

	// 이메일 인증1 - 재인증 시 
	public String updateAuth(AuthVo auth);

	// 이메일 인증1 - 최초인증
	public String insertAuth(AuthVo auth);

	// 이메일 인증 2 - 인증코드 비교
	public String selectMember(@Param("authCode") String authCode,@Param("id") String id);
	
	// 회원정보 수정
	public int updateMember(
			@Param("member") MemberVo member, 
			@Param("newpass1") String newpass1, 
			@Param("id") String id,
			@Param("addr") String member_address);

	// 회원 탈퇴
	public int deleteMember(MemberVo member);
	
	//아이디 찾기
	public String findId(MemberVo vo);
	
	//아이디 유무 확인
	public boolean isLoginUser(MemberVo vo);
	
	//비밀번호 찾기
	public boolean updatePass(@Param("vo") MemberVo vo,@Param("imsiPw") String imsiPw);

	public List<WishVo> selectWish(int member_idx);

	public CouponVo selectWelCoupon();

	public int insertWelCoupon(@Param("coupon") CouponVo coupon, @Param("member_idx") int member_idx);


}













