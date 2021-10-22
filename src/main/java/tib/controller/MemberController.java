package tib.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import tib.mail.PostMail;
import tib.member.model.MemberDAO;
import tib.member.model.MemberDTO;
import tib.univ.model.*;
import tib.project.model.*;
@Controller
public class MemberController {
   
   @Autowired
   private MemberDAO memberDao;
   
   @Autowired
   private PostMail mailsender;
   
   @Autowired
   private UnivDAO univDao;
   
   /* #memberJoinForm
    * 회원가입 페이지로 이동하는 기능
    * 대학목록을 가지고 들어간다.
    * 
    * */
   @RequestMapping(value = "/memberJoin.do", method = RequestMethod.GET)
   public ModelAndView memberJoinForm() {
	   ModelAndView mav = new ModelAndView();
	   
	   ArrayList<UnivDTO> univs = univDao.getUnivList();
	   
	   mav.addObject("univs", univs);
	   mav.setViewName("member/joinForm");
			   
      return mav;
   }
   
   /* #memberJoinSubmit
    * 회원가입 페이지에서 submit 하면 호출되는 기능
    * memberDTO 객체와 학교 이메일을 매개변수로 받아 처리한다.
    * 
    * */
   @RequestMapping(value = "/memberJoin.do", method = RequestMethod.POST)
   public ModelAndView memberJoinSubmit(MemberDTO dto, HttpServletRequest req,@RequestParam("uemail")String univ) {
	  ModelAndView mav = new ModelAndView();
	  
      dto.setMemail(dto.getMemail()+univ);
      
      int univcode = univDao.getUnivcode(univ);
      	dto.setUnivcode(univcode);
      
      	int result = memberDao.memberJoin(dto);
     
      String msg = result>0?"tib에 회원이 되신걸 환영합니다. 이메일 인증 후 회원가입이 완료됩니다.":"회원가입에 실패했습니다. 잠시 후 다시 시도해주십시오.";
      
      String page = mailsender.mailSendWithUserKey(dto.getMemail(), dto.getMid(), req); 									//회원가입 신청한 이메일로 인증메일 발송
     
      mav.addObject("msg", msg);
      mav.addObject("goPage", "login.do");
      mav.setViewName(page);
      
      return mav;
   }
   /* #changeInjeong
    * 멤버 테이블의 certification 컬럼을 y로 바꿔준다.
    * y는 인증이 완료된 회원
    * */
   @RequestMapping(value =  "/changeinjeong.do", method = RequestMethod.GET)
   public String changeInjeong(@RequestParam("userId") String mid,@RequestParam("injeong")String key) {
      memberDao.chagetKey(mid, key);
      return "member/confirmJoin";
   }
   
   /* #idCheck
    * 아이디 중복 검사 기능
    * 중복된 아이디 -0 / 중복안된 아이디 -1
    * */
   @RequestMapping("/idCheck.do")//아이디 중복 체크
   public ModelAndView idCheck(@RequestParam(value = "userid",defaultValue = "")String mid) {
	  ModelAndView mav = new ModelAndView();
      
	  int result = memberDao.idCheck(mid);
      
	  String msg = "";
        msg = result>0?"0":"1";
      
      mav.addObject("msg", msg);
      mav.setViewName("member/idCheck_ok");
      
      return mav;
   }
   
   /* #loginForm
    * 로그인 페이지로 이동하는 기능
    * */
   @RequestMapping(value = "/login.do", method = RequestMethod.GET)
   public String loginForm() {
      return "member/login";
   }
   
   /* #loginSubmit
    * 로그인 기능
    * */
   @RequestMapping(value = "/login.do", method = RequestMethod.POST)
   public ModelAndView loginSubmit(@RequestParam("userid")String userid,@RequestParam("userpwd")String userpwd,HttpServletResponse resp,HttpServletRequest req,HttpSession session,MemberDTO dto) {
	   ModelAndView mav = new ModelAndView();
      
     ProjectDTO pdto = (ProjectDTO)session.getAttribute("project");									//프로젝트 초대 메일을 통한 접근인지 검사
     
      int result = memberDao.loginSubmit(userid, userpwd);
	      if(result==memberDao.LOGIN_SUCCESS) {														//로그인 성공
	         
		         if(pdto==null) {
		                MemberDTO info = memberDao.memberInfo(userid);
		                
		                session.setAttribute("user", info);
		                if(info.getMid().equals("admin")) {
		                   mav.setViewName("admin/indexAdmin");
		                }else {
		                   mav.addObject("msg", userid+"님 환영합니다.");
		                    mav.addObject("goPage", "indexTib.do");
		                    mav.setViewName("member/memberMsg");
		                }
		         }else {
		            MemberDTO info = memberDao.memberInfo(userid);
		            session.setAttribute("user", info);
		            mav.setViewName("project/enterProject");
		         }
	      }else if(result==memberDao.EMAIL_INJEONG) {												//로그인은 완료, 메일 인증 미완료
	         mav.addObject("msg", "이메일 인증이 필요합니다. 이메일 인증을 완료해주세요.");
	         mav.addObject("goUrl", "login.do");
	         mav.setViewName("member/memberMsg");
	      }else {																					//로그인 실패, 아이디 또는 비밀번호 잘못됨
	         mav.addObject("msg", "아이디 또는 비밀번호가 잘못되었습니다.");
	         mav.addObject("goUrl", "login.do");
	         mav.setViewName("member/memberMsg");
	      }
      
      return mav;
   }
   
   /* #logout
    * 로그아웃 기능
    * 로그아웃 시 모든 세션을 무효화한다.
    * */
   @RequestMapping("/logout.do")
   public ModelAndView logout(HttpServletRequest req) {
	   ModelAndView mav = new ModelAndView();
	   
      HttpSession session = req.getSession();
      	session.invalidate();
      
      mav.setViewName("redirect:/index.do");
      return mav;
   }
   
   /* #idSearchForm
    * 아이디 찾기 페이지 이동 기능
    * */
   @RequestMapping(value = "/idSearch.do",method = RequestMethod.GET)
   public String idSearchForm() {
      return "member/idSearch";
   }
   
   /* #idSearchSubmit
    * 아이디 찾기 기능
    * 이름과 이메일로 유효성 검사 후 이메일에 인증코드 발송
    * */
   @RequestMapping(value = "/idSearch.do", method = RequestMethod.POST)
   public ModelAndView idSearchSubmit(HttpServletRequest req,@RequestParam("memail")String mail,@RequestParam("mname")String name) {
	   ModelAndView mav = new ModelAndView();
      
	   String result = memberDao.idSearch(name, mail);
	   String page= "member/memberMsg";
	      if(!(result==null||result.equals(""))) {
	    	 page =  mailsender.mailSendWithId(mail, result, req);
	         mav.addObject("msg", "이메일이 발송되었습니다.");
	         mav.addObject("goPage", "index.do");
	      }else {
	         mav.addObject("msg", "이름 또는 이메일을 확인해주세요.");
	         mav.addObject("goUrl", "idSearch.do");
	      }
	      
      mav.setViewName(page);
      return mav;
   }
   
   /* #pwdSearchForm
    * 비밀번호 찾기 페이지 이동
    * */
   @RequestMapping(value = "/pwdSearch.do", method = RequestMethod.GET)
   public String pwdSearchForm() {
      return "member/pwdSearch";
   }
   
   /* #pwdSearchSubmit
    * 아이디를 입력받아 유효성 검사
    * 아이디로 회원의 이메일을 검색하여 인증메일 발송
    * */
   @RequestMapping(value = "/pwdSearch.do", method = RequestMethod.POST)
   public ModelAndView pwdSearchSubmit(HttpServletRequest req,@RequestParam("mid")String mid) {
	   ModelAndView mav = new ModelAndView();
	   
      String email = memberDao.pwdEmailSearch(mid);
      String page="member/memberMsg";
      
      
     
      if(!(email==null||email.equals(""))) {
    	page= mailsender.mailSendWithPwd(email, mid, req);
         mav.addObject("msg", "이메일이 발송되었습니다.");
         mav.addObject("goPage", "index.do");
       
      }else {
         mav.addObject("msg", "존재하지 않는 아이디 또는 잘못된 아이디 입니다.");
         mav.addObject("goPage", "idSearch.do");
      }
      mav.setViewName(page);
      return mav;
   }
   
   /* #changePwdForm
    * 비밀번호 찾기 후 비밀번호 변경 페이지 이동
    * */
   @RequestMapping(value = "/changePwd.do", method = RequestMethod.GET)
   public ModelAndView changePwdForm(@RequestParam("userId")String mid) {
      ModelAndView mav = new ModelAndView();
      
      mav.addObject("mid", mid);
      mav.setViewName("member/pwdUpdate");
      return mav;
   }
   
   /* #changePwdSubmit
    * 비밀번호 찾기 후 비밀번호 변경 기능
    * */
   @RequestMapping(value = "/changePwd.do", method = RequestMethod.POST)
   public ModelAndView changePwdSubmit(@RequestParam("mpwd")String mpwd,@RequestParam("mpwdC")String mpwdC,@RequestParam("userId")String mid) {
	   ModelAndView mav = new ModelAndView();
	   
      int result = memberDao.pwdUpdate(mid, mpwd);
      
	      if(mpwd.equals(mpwdC) && !(mpwd==null||mpwd.equals(""))) {						//비밀번호가 일치하고 공백과 null이 아닌 경우
	         String msg = result>0?"비밀번호가 변경되었습니다.":"비밀번호 변경에 실패했습니다.";		
	         mav.addObject("msg", msg);
	         mav.addObject("goPage", "index.do");
	         mav.setViewName("member/memberMsg");
	      }else if(mpwd==null||mpwd.equals("")){											//비밀번호가 공백이거나 null 인 경우
	         mav.addObject("msg", "비밀번호를 입력하여 주세요.");
	         mav.addObject("goPage", "changePwd.do?userId="+mid);
	         mav.setViewName("member/memberMsg");
	      }else {
	         mav.addObject("msg", "비밀번호가 일치 하지 않습니다.");								//비밀번호가 일치 하지 않는 경우
	         mav.addObject("goPage", "changePwd.do?userId="+mid);
	         mav.setViewName("member/memberMsg");
	      }
      return mav;
   }
   
   /* #profileForm
    * 비밀번호 변경하는 페이지 
    * */
   @RequestMapping(value="profile.do",method=RequestMethod.GET)
   public String profileForm() {
	   return "member/profile";
   }
   
   /* #profileSubmit
    * 비밀번호 변경 기능
    * 
    * */
   @RequestMapping(value="profile.do",method=RequestMethod.POST)
   public ModelAndView profileSubmit(@RequestParam("mpwd")String mpwd,@RequestParam("mid")String mid) {
	    ModelAndView mav = new ModelAndView();
	    
	    int res = memberDao.pwdUpdate(mid, mpwd);
	    
	    String msg="비밀번호 변경에 실패했습니다.";
	    String goPage="profile.do";
	    
		    if(res>0) {
		    	msg="비밀번호 변경에 성공했습니다.";
		    	goPage="indexTib.do";
		    }
		    
	    mav.addObject("msg", msg);
	    mav.addObject("goPage", goPage);
	    mav.setViewName("member/memberMsg");
	    return mav;
   }
}