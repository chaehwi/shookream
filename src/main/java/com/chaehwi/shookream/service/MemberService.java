package com.chaehwi.shookream.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chaehwi.shookream.mapper.MemberMapper;
import com.chaehwi.shookream.vo.AuthVo;
import com.chaehwi.shookream.vo.CouponVo;
import com.chaehwi.shookream.vo.MemberVo;
import com.chaehwi.shookream.vo.WishVo;

@Service
public class MemberService {
	@Autowired
	private MemberMapper mapper;
	
	// 로그인을 위한 패스워드 조회
	public String getSelectPass(String id) {
		return mapper.getSelectPass(id);
	}
	// 로그아웃
	

	// 회원 상세 정보 조회 작업 - getMemberInfo()
	// => 파라미터 : 아이디  리턴타입 : MemberVO
	public MemberVo getMemberInfo(String id) {
		return mapper.selectMemberInfo(id);
	}

	// 회원가입
	public int joinMember(MemberVo member) {
		return mapper.insertMember(member);
	}

	// 회원가입 : 회원번호 
	public int selectIdx() {
		return mapper.selectIdx();
	}

	// 회원가입 : id 중복체크
	public int idCheck(String id) {
		return mapper.selectAllId(id);
	}

	// 회원가입 : 이메일 인증1 - 인증번호 전송 : 이메일 전송
	public boolean isAuthUser(AuthVo auth) {
		return mapper.selectAuth(auth);
	}

	// 이메일 인증1 - 인증번호 전송 : 재인증
	public String isMember(AuthVo auth) {
		return mapper.updateAuth(auth);
	}

	// 이메일 인증1 - 인증번호 전송 : 최초 인증
	public String isNewAuth(AuthVo auth) {
		return mapper.insertAuth(auth);
	}
	
	// 이메일 인증2 - 인증코드 비교
	public String selectMember(String authCode, String id) {
		return mapper.selectMember(authCode, id);
	}

	// 회원 정보 수정 
	public int modifyMember(MemberVo member, String newpass1, String id, String member_address) {
		return mapper.updateMember(member,newpass1, id, member_address);
	}

	// 회원 탈퇴
	public int removeMember(MemberVo member) {
		return mapper.deleteMember(member);
	}
	
	// 아이디 찾기
	public String findId(MemberVo vo) {
		return mapper.findId(vo);
	}

	// 아이디 유무 확인
	public boolean isLoginUser(MemberVo vo) {
		return mapper.isLoginUser(vo);
	}


	public boolean updatePass(MemberVo vo, String imsiPw) {
		return mapper.updatePass(vo,imsiPw);
	}


	// wish 조회
	public List<WishVo> getWish(int member_idx) {
		return mapper.selectWish(member_idx);
	}


	// 회원가입 축하 쿠폰 조회
	public CouponVo getWelCouponInfo() {
		return mapper.selectWelCoupon();
	}
	
	// 회원가입 쿠폰 지급 
	public int insertWelCoupon(CouponVo welcomeCoupon, int member_idx) {
		return mapper.insertWelCoupon(welcomeCoupon, member_idx);
	}



}

