package com.chaehwi.shookream.controller;

import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chaehwi.shookream.service.MemberService;
import com.chaehwi.shookream.vo.AuthVo;
import com.chaehwi.shookream.vo.CouponVo;
import com.chaehwi.shookream.vo.MemberVo;
import com.chaehwi.shookream.vo.WishVo;

import mail.GoogleMailAuthenticator;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	//---------로그인 폼-----------
	@GetMapping(value = "LoginMember.me")
	public String LoginForm() {
		return "member/member_login_form";
	}// LoginForm 끝 
	
	//-------------로그인 작업-----------------
	@PostMapping(value = "LoginMemberPro.me")
	public String LoginPro(
//			@RequestParam("id") String id,
//			@RequestParam("pass") String pass,
			@ModelAttribute MemberVo member,
			Model model, 
			HttpSession session
			) {
		// 파라미터로 받은 패스워드 암호화작업
		BCryptPasswordEncoder passwdEncoder = new BCryptPasswordEncoder();
//		String chk = passwdEncoder.encode(member.getMember_pass());
		//비밀번호 일치 여부 확인을 위해 비밀번호 가져오기
		String passwd = service.getSelectPass(member.getMember_id()); // DB저장된 비밀번호 (PASSWD)
		//로그인 작업(비밀번호 일치여부 판별)
		// 
		
//		System.out.println("DB저장 passwd : " + passwd + ", 암호화 : " + chk);
		if(passwd == null || !passwdEncoder.matches(member.getMember_pass(), passwd)) { // 실패
			// Model 객체에 "msg" 속성명으로 "로그인 실패!" 메세지 저장 후
			// fail_back.jsp 페이지로 포워딩
				model.addAttribute("msg", "로그인 실패(아이디 또는 비밀번호를 확인해주세요.)");
				return "fail_back";
		}else { // 성공
			MemberVo member2 = service.getMemberInfo(member.getMember_id()); // DB저장된 비밀번호 (PASSWD)
			//성공 시 세션아이디, member_idx 저장
			session.setAttribute("sId", member.getMember_id());
			session.setAttribute("member_idx", member2.getMember_idx());
			return "redirect:/";
		}
	}//LoginPro 끝 
	
	//-------------로그아웃 작업------------
	@GetMapping(value = "MemberLogout.me")
	public String logout(HttpSession session) {
		// 세션 초기화
		session.invalidate();
		return "redirect:/";
	}//logout 끝
	
	// <<=======================================회원가입 관련 코드=======================================>>
	//--------------- 회원가입 폼 -------------------
	@GetMapping("MemberJoinForm.me")
	public String joinForm() {
		return "member/member_join_form";
	} // joinForm 끝
	
	// --------------- 회원가입 비즈니스 로직 ---------------------
	@PostMapping("MemberJoinPro.me") 
	public String joinPro(@ModelAttribute MemberVo member, Model model,
			@RequestParam("email1") String email1, @RequestParam("email2") String email2,
			@RequestParam("address1") String address1, @RequestParam("address2") String address2) {
		
		// 비밀번호 암호화 작업
		BCryptPasswordEncoder passwdEncoder = new BCryptPasswordEncoder();
		String securePasswd = passwdEncoder.encode(member.getMember_pass());
		System.out.println("평문 암호 : " + member.getMember_pass());
		member.setMember_pass(securePasswd);
		
		// 이메일 결합
		String member_email = email1 + "@" + email2;
		member.setMember_email(member_email);
		// 주소 결합
		String member_address = address1 + "," + address2;
		member.setMember_address(member_address);
//		System.out.println("파라미터 확인 : " + member);
		// 폼파라미터로 전송된 정보들을 해당되는 VO 객체에 바인딩 시키기 위해서는 뷰페이지내의 name 속성이 vo객체의 변수명과 일치해야 함!
		// => 뷰페이지 name속성 변경했음

		// 회원번호 
		int member_idx = service.selectIdx();
		int new_member_idx = member_idx + 1;
		// 회원번호 기존 최대번호 + 1
		member.setMember_idx(new_member_idx);
//		System.out.println("멤버인덱스 확인 : " + member.getMember_idx());
		int joinMember = service.joinMember(member);
		

		if(joinMember > 0) {
			
			// ======= 회원가입 쿠폰 지급 =========
			
			// 회원가입 쿠폰 조회
			CouponVo welcomeCoupon = service.getWelCouponInfo();
			
			// 회원가입 쿠폰 지급
			int insertCoupon = service.insertWelCoupon(welcomeCoupon, new_member_idx);
			
			return "member/member_join_result";
		} else {
			model.addAttribute("msg","회원가입에 실패하였습니다!");
			return "fail_back";
		}
	} // joinPro 끝
	
	// ------------------- 회원가입 id 중복체크 ------------------------------
	@GetMapping("dbCheckId.me")
	public String chkForm(@RequestParam("member_id") String id, Model model) {
		int result = service.idCheck(id);

		model.addAttribute("result",result);			
		return "member/member_checkId";
	}
	
	// -------------------- 이메일 인증1 : 메일 전송 ------------------------------------
	@GetMapping("CheckEmailAddress.me")
	public void authEmail(
			@RequestParam(value="id", required=false) String id,
			@RequestParam("authCode") String authCode,
			@RequestParam("email1") String email1, @RequestParam("email2") String email2,
			@ModelAttribute AuthVo auth) {
		String email = email1 + "@" + email2;
//		System.out.println("인증 아이디확인 : " + id);
		StringBuilder authCd = new  StringBuilder();
		String[] ch = {"0","1","2","3","4","5","6","7","8","9"};
		
		for(int i=0; i < 6; i++) {
			int num = (int)(Math.random()*ch.length);
			authCd.append(ch[num]);
		}

		auth.setAuth_id(id);
		auth.setAuth_authCode(authCd.toString());
		boolean isRightAuth = service.isAuthUser(auth); //service.isAuthUser(auth);
		
		if(isRightAuth) {
			String userExist = service.isMember(auth);
		} else {
			String newMember = service.isNewAuth(auth);
		}
		
		String content = "회원가입창으로 돌아가 인증번호를 입력해 주세요.";
		content += "<hr>";
		content += "<b>"+authCd.toString() +"</b>";
		
		String mailServer = "smtp.gmail.com";
		Properties properties = new Properties();
		properties.put("mail.smtp.host", mailServer);
		properties.put("mail.smtp.auth", true);
		properties.put("mail.smtp.port", "587"); 
		properties.put("mail.smtp.starttls.enable", "true");  
		properties.put("mail.smtp.ssl.protocols", "TLSv1.2");
		Authenticator authenticator = new GoogleMailAuthenticator();
		Session mailSession = Session.getDefaultInstance(properties, authenticator);
		
		try {
			InternetAddress address = new InternetAddress(email); 		// 받는사람 이메일 주소
			Message msg = new MimeMessage(mailSession);					// 메일 관련 정보 작성
			msg.setRecipient(Message.RecipientType.TO, address);		// 받는 사람
			msg.setFrom(new InternetAddress("jcw3241@gmail.com"));		// 보내는 사람(root-context.xml에 맞게 변경해놓은 상태)
			msg.setSubject("[SHOOKREAM] 이메일 인증코드입니다.");		// 메일 제목
			msg.setContent(content, "text/html; charset=UTF-8");		// 데이터 처리
			msg.setSentDate(new Date());								// 보낸 날짜
			Transport.send(msg);
		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		} 

	} // authEmail 
	
	// -------------------- 이메일 인증2 : 전송코드 일치여부 확인 ----------------------------------
	@ResponseBody
	@GetMapping("CompareEmailAddress.me")
	public String authCodeChk(
			@RequestParam(value="id", required=false) String id,
			@RequestParam("authCode") String authCode,
			Model model,
			@ModelAttribute AuthVo auth) {
//		System.out.println("authCode 확인 : " + authCode);
		String code = service.selectMember(authCode, id);
				
//		System.out.println("결과 : " + code);
		if(code.equals(authCode)) {
			return "true";
		} else {
			model.addAttribute("msg","인증코드가 일치하지 않습니다!");
			return "false";
		}
	} // authCodeChk 끝
	//<<===================================== 회원가입 끝=================================================>>
	
	// ------------------- 회원 정보수정 비밀번확인 폼 -----------------------------
	@GetMapping("MemberModifyCheck.me")
	public String modifyCheck() {
		return "member/member_password_modify_form";
	} // modifyCheck
	
	//------------------- 회원 정보수정 비밀번호 확인 비즈니스 로직 ---------------------------------
	@PostMapping("MemberPassCheck.me")
	public String passCheck(@ModelAttribute MemberVo member, Model model) {

		BCryptPasswordEncoder passwdEncoder = new BCryptPasswordEncoder();
			
		//비밀번호 일치 여부 확인을 위해 비밀번호 가져오기
		String passwd = service.getSelectPass(member.getMember_id()); // DB저장된 비밀번호 (PASSWD)
			//로그인 작업(비밀번호 일치여부 판별)
		if(passwd == null || !passwdEncoder.matches(member.getMember_pass(), passwd)) { // 실패
			model.addAttribute("msg", "비밀번호를 확인해주세요");
			return "fail_back";
		}else { // 성공
			//성공 시 세션아이디, member_idx 저장
			return "redirect:/MemberModifyForm.me?id=" + member.getMember_id();
		}	
	}
	
	// ------------------- 회원 정보수정 폼 ----------------------------
	@GetMapping("MemberModifyForm.me")
	public String modifyForm(@RequestParam("id") String id, Model model) {
		
		MemberVo member = service.getMemberInfo(id);
		System.out.println("회원정보수정 memberInfo : " + member);
		model.addAttribute("member",member);
		return "member/member_modify_form";
	} // modifyForm
	
	// ------------------ 회원 정보수정 비즈니스 로직-------------------------
	@PostMapping("MemberModifyPro.me")
	public String modifyPro(@ModelAttribute MemberVo member, @RequestParam("id") String id, @RequestParam String newpass1, 
			@RequestParam("address1") String address1, @RequestParam("address2") String address2, Model model) {
		BCryptPasswordEncoder passwdEncoder = new BCryptPasswordEncoder();
		if(newpass1 != null && !newpass1.equals("")) {
			newpass1 = passwdEncoder.encode(newpass1);
		}
		
		//주소 변경 시 결합
		String member_address = "";
		if(address1 != null && !address1.equals("")) {
			member_address = address1 + " " + address2;
		}
		
		int updateCount = service.modifyMember(member, newpass1, id, member_address);
		
		if(updateCount > 0) { // 성공
			return "redirect:/MemberMyPage.me";
		} else { 
			model.addAttribute("msg", "회원정보 수정에 실패하였습니다");
			return "fail_back";
		}
	} // modifyPro
	
	// ------------------- 회원 탈퇴 확인 폼 ---------------------------
	@GetMapping("MemberDeleteForm.me")
	public String deleteForm() {
		return "member/member_delete_form";
	} // deleteForm 
	
	// 회원 탈퇴 비밀번호 확인
	@PostMapping("MemberDeleteFormCheck.me")
	public String deleteFormChk(@ModelAttribute MemberVo member,
			HttpSession session, Model model) {
		
		BCryptPasswordEncoder passwdEncoder = new BCryptPasswordEncoder();
			
		//비밀번호 일치 여부 확인을 위해 비밀번호 가져오기
		String passwd = service.getSelectPass(member.getMember_id()); // DB저장된 비밀번호 (PASSWD)
			//로그인 작업(비밀번호 일치여부 판별)
		if(passwd == null || !passwdEncoder.matches(member.getMember_pass(), passwd)) { // 실패
			model.addAttribute("msg", "비밀번호를 확인해주세요");
			return "fail_back";
		}else { 
			return "redirect:/MemberDeletePro.me";
		}
		
//		String sId = (String)session.getAttribute("sId");
//		// 세션아이디 권한 판별
//		if(member.getMember_id() != null && !member.getMember_id().equals("") && !member.getMember_id().equals(sId)) {
//			model.addAttribute("msg","권한이 없습니다");
//			return "fail_back";
//		} else if (member.getMember_id().equals("")) {
//			model.addAttribute("msg","잘못된 접근입니다!");
//			return "fail_back";
//		} else {
//			return "redirect:/MemberDeletePro.me";
//		}
	}
	
	//-------------------- 회원 탈퇴 비즈니스 로직----------------------------
	@PostMapping("MemberDeletePro.me")
	public String deletePro(HttpSession session, @ModelAttribute MemberVo member, Model model) {
//		String sId = (String)session.getAttribute("sId");
		int deleteCount = service.removeMember(member);
		if(deleteCount > 0) {			
			session.invalidate();
			return "redirect:/";
		} else {
			model.addAttribute("msg","탈퇴에 실패하였습니다.");
			return "fail_back";
		}
	} // deletePro
	
	//------------아이디 찾기 폼 ------------
	@GetMapping(value = "FindMemberIdForm.me")
	public String FindMemberIdForm() {
		return "member/findIDForm";
	}
	//아이디 찾기 끝
		
	//------------아이디 찾기 PRO ---------
	@PostMapping(value = "FindIdFormAction.me")
	public String FindMemberIdPro(@ModelAttribute MemberVo vo,Model model) {
		String isFindSuccess = service.findId(vo);//아이디 찾아오기
		System.out.println(isFindSuccess);
		model.addAttribute("member", isFindSuccess);
		return "member/findID_result";
	}//아이디 찾기
	
	//------------비밀 번호 찾기 폼 -------------
	@GetMapping(value = "FindPwForm.me")
	public String FindPwForm() {
		return "member/findPassForm";
	}//비밀 번호 찾기 폼 끝
	
	//------------비밀 번호 찾기 Pro -------------
	@PostMapping(value = "FindPwProAction.me")
	public String FindPwPro(@ModelAttribute MemberVo vo,Model model,HttpSession session) {
		System.out.println(vo);
		boolean isRightUser = service.isLoginUser(vo);
		System.out.println(isRightUser);
		
		StringBuilder imsiPw = new  StringBuilder();
		
		// 아이디가 존재 하면
		if(isRightUser) {
			// 임시 문자 배열에 담기
			String[] ch = {
					"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
					"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
					"0","1","2","3","4","5","6","7","8","9"
			};
			
			// ch 배열에서 랜덤 10글자 가져오기
			for(int i=0; i < 10; i++) {
				int num = (int)(Math.random()*ch.length);
				imsiPw.append(ch[num]);
			}
			System.out.println("임시패스워드 : "+imsiPw.toString());
	         
	         String content = "임시 비밀번호로 로그인 한 후, 회원정보 수정에서 비밀번호를 변경하시기 바랍니다.<hr>";
	         content += vo.getMember_id() + " 회원님, 임시 비밀번호가 발급되었습니다.<br>";
	         content += "임시 비밀번호는 ";
	         content += "<b>" + imsiPw.toString() + "</b> 입니다.";
			
			String mailServer = "smtp.gmail.com"; // 메일 서버 지정하기
			Properties properties = new Properties();
			properties.put("mail.smtp.host", mailServer);
			properties.put("mail.smtp.auth", true);
			properties.put("mail.smtp.port", "587"); 
			properties.put("mail.smtp.starttls.enable", "true");  
			properties.put("mail.smtp.ssl.protocols", "TLSv1.2");
			Authenticator authenticator = new GoogleMailAuthenticator(); // 메일서버에서 인증받은 계정 + 비번
			Session mailSession = Session.getDefaultInstance(properties, authenticator); // 메일서버, 계정, 비번이 유효한지 검증
			
			try {
				InternetAddress address = new InternetAddress(vo.getMember_email()); // 받는사람 이메일 주소
				Message msg = new MimeMessage(mailSession);								 // 메일 관련 정보 작성
				msg.setRecipient(Message.RecipientType.TO, address);					 // 받는 사람
				msg.setFrom(new InternetAddress("hz0123hz@gmail.com"));					 // 보내는 사람
				msg.setSubject("[SHOOKREAM] 임시 비밀번호 입니다.");					 // 메일 제목
				msg.setContent(content, "text/html; charset=UTF-8"); 					 // 한글 처리
				msg.setSentDate(new Date());
				Transport.send(msg);
			} catch (AddressException e) {
				e.printStackTrace();
			} catch (MessagingException e) {
				e.printStackTrace();
			}
			
			boolean result = service.updatePass(vo, imsiPw.toString()); 
			System.out.println("result = " + result);
			
			model.addAttribute("msg", "임시 비밀번호가 발송되었습니다.");
			model.addAttribute("msg2", "이메일을 확인한 후 다시 로그인 하시길 바랍니다!");
		}else {
			model.addAttribute("msg", "올바르지 않은 회원 정보입니다!");
		}
		return "reload_email";
	}//비밀 번호 찾기 Pro 끝
}//Controller 끝