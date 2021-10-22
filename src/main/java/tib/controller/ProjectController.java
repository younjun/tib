package tib.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import tib.calendar.model.CalendarDAO;
import tib.calendar.model.scheduleDTO;
import tib.file.model.FileDAO;
import tib.file.model.FileDTO;
import tib.mail.PostMail;
import tib.member.model.MemberDAO;
import tib.member.model.MemberDTO;
import tib.project.model.ProjectDAO;
import tib.project.model.ProjectDTO;
@Controller
public class ProjectController {

   @Autowired
   private ProjectDAO projectDao;
   
   @Autowired
   private PostMail postMail;
   
   @Autowired
   private FileDAO fileDao;
   
   @Autowired
   private MemberDAO memberDao;
   
   @Autowired
   private CalendarDAO calDao;
   
   /* goCreateProjectForm
    * createProject.jsp 로 페이지 이동 기능
    * */
   @RequestMapping("/createProject.do")
   public String createProjectForm() {
      return "project/createProject";
   }
   
   /* #goChatRoom
    * 채팅방 진입 기능
    * pcode와 abspath를 이용해 채팅 데이터가 저장될 공간을 세션에 담는다.
    * */
   @RequestMapping("/chat.do")
   public ModelAndView goChatRoom(HttpServletRequest req,@RequestParam("projectNum")String projectNum) {
      ModelAndView mav = new ModelAndView();
      
      HttpSession session =req.getSession();
      	String abspath = req.getRealPath("/chats/"+projectNum);
      
      session.setAttribute("projectNum",projectNum);
      session.setAttribute("abspath", abspath);
      
      mav.setViewName("chat/chat");
      return mav;
   }
   
   /* #makeProject
    * 프로젝트 생성 기능
    * 공개 프로젝트와 비공개 프로젝트를 구분하여 생성한다.
    * */
   @RequestMapping(value="/addProjectMember.do",method=RequestMethod.POST)
   public ModelAndView makeProject(ProjectDTO dto,@RequestParam("memberEmail")String[] members,HttpServletRequest req,@RequestParam("lock")int lock) {
      ModelAndView mav = new ModelAndView();
      
      HttpSession session = req.getSession(); 
      	MemberDTO mdto = (MemberDTO)session.getAttribute("user");
      	
      dto.setPhost(mdto.getMid());
      dto.setPlock(lock);
	      if(lock==1) {
	    	  dto.setPlimit(10);
	      }else {
	    	  dto.setPlimit(200);
	      }
	      
      String res = projectDao.addProject(dto);
      
      ProjectDTO pdto = projectDao.projectInfo(res);
      
      String page="redirect:indexTib.do";
      int result  = projectDao.addProjectMember(pdto.getPidx(),mdto.getMidx()); 
	      if(res!=null && result>0) {
	         page = postMail.mailSendWithProjectKey(members,pdto,req);
	      }
	      
      mav.setViewName(page);
      return mav;
   }
   
   /* #enterProjectForm 
    * 기존 프로젝트에 참가하는 기능
    * 로그인 유무를 검사하여 비로그인시 ->로그인 / 로그인시 -> 프로젝트 참가양식
    * */
   @RequestMapping(value = "/enterProject.do",method = RequestMethod.GET)
   public ModelAndView enterProjectForm(ProjectDTO dto,HttpServletRequest req) {
      ModelAndView mav = new ModelAndView(); 
      
      HttpSession session = req.getSession(); 
      	MemberDTO mdto = (MemberDTO)session.getAttribute("user"); 
      
      session.setAttribute("project",dto);
      
      if(mdto==null) {													//로그인 유무를 검사하는 조건문
         mav.setViewName("member/login");
      }else {
         mav.setViewName("project/enterProject");
      }
      return mav;
   }
   
   /* #enterProjectSubmit
    * 프로젝트 참가 양식을 거쳐 참가 가능여부를 검사한 후 참가 시키는 기능
    * */
   @RequestMapping(value = "/enterProject.do", method=RequestMethod.POST)
   public ModelAndView enterProjectSubmit(@RequestParam("pidx")int pidx,@RequestParam("pcode")String pcode,HttpServletRequest req) {
      ModelAndView mav = new ModelAndView();
      
      HttpSession session = req.getSession();
      	session.removeAttribute("project");
      	MemberDTO mdto = (MemberDTO)session.getAttribute("user"); 
      
      int result = projectDao.projectMemberCheck(pidx, mdto.getMidx());
	      if(result==0) {														//이미 참가한 프로젝트인지 검사 하는 조건문, if문은 참가하지 않은 프로젝트 / else문은 참가중인 프로젝트
	    	  
	         int okPcode = projectDao.okPcode(pcode, pidx);
	         
	          if(okPcode==1) {													//pcode 일치여부를 검사하는 조건문 if문은 일치 / else문은 불일치
	        	  projectDao.addProjectMember(pidx,mdto.getMidx());  			//해당 프로젝트에 회원을 추가해준다.
	              projectDao.countPlus(pidx);									//프로젝트 인원수를 1 증가 시켜준다.
	              mav.setViewName("redirect:indexTib.do");						//참가 완료 후 리로드 해주면서 메인페이지로 이동한다.
	          }else {
	             mav.addObject("msg","프로젝트 코드가 일치하지 않습니다.");				
	             mav.addObject("goPage","indexTib.do");
	             mav.setViewName("member/memberMsg");
	          }
	          
	      }else {
	         mav.addObject("msg", "이미 참가한 프로젝트입니다.");
	         mav.addObject("goPage","indexTib.do");
	         mav.setViewName("member/memberMsg");
	      }          
      return mav; 
   }
   /* #oepnProject
    * 네비바에서 프로젝트 명을 눌러 드랍다운을 여는 순간 호출되는 기능
    * 프로젝트 클릭 시 드랍다운이 열리면서 해당 프로젝트의 dto가 세션이 등록됨
    * 
    * */
   
   @RequestMapping(value="/openProject.do",method=RequestMethod.GET)
   public ModelAndView openProject(@RequestParam("pcode")String pcode,HttpSession session) {
	   ModelAndView mav = new ModelAndView();
	   
	   ProjectDTO dto = projectDao.projectInfo(pcode);
	   		session.setAttribute("projectDTO", dto);
	  
	   List<MemberDTO> proMemInfo_list = calDao.proMemInfo(dto.getPidx());
	   		session.setAttribute("memberlist", proMemInfo_list);
	   
	   	mav.addObject("msg", "Ok session");
	   mav.setViewName("project/projectOk");
	   return mav;
   }
   
   /* #enterPublicProject
    * 공개프로젝트에 참가하는 기능
    * 참가중인지 여부를 검사 한뒤 처리한다.
    * */
   @RequestMapping("/enterPublicProject.do")
   public ModelAndView enterPublicProject(@RequestParam("pidx")int pidx,HttpServletRequest req) {
	   ModelAndView mav = new ModelAndView();
	 
	   HttpSession session = req.getSession(); 
      		MemberDTO mdto = (MemberDTO)session.getAttribute("user");

      int result = projectDao.projectMemberCheck(pidx, mdto.getMidx());
      
	      if(result==0) {
	         projectDao.addProjectMember(pidx, mdto.getMidx());
	         projectDao.countPlus(pidx);//인원수 추가
	         mav.addObject("msg", "공개 프로젝트에 참가되었습니다.");
	         mav.setViewName("tibJson");
	      }else {
	         mav.addObject("msg", "이미 참가한 프로젝트입니다.");
	         mav.setViewName("tibJson");
	      }
      return mav;
   }
   
   /* #exitProject
    * 프로젝트 탈퇴 기능
    * 회원이 호스트인지 여부를 판단하여 호스트일 경우 방삭제, 멤버일 경우 프로젝트 탈퇴 후 pm테이블에서 인원 수 차감
    * */
   @RequestMapping(value="/exitProject.do",method=RequestMethod.GET)
   public ModelAndView exitProject(@RequestParam("phost")String phost,@RequestParam("mid")String mid,@RequestParam("midx")int midx,@RequestParam("pidx")int pidx) {
      ModelAndView mav = new ModelAndView();
      
      int res = -1;
      String msg = null;
      
      if(phost.equals(mid)) {
        res= projectDao.exitProjectHost(pidx);
      }else {
        res= projectDao.exitProjectMember(pidx, midx);
        projectDao.countMinus(pidx);//인원수 차감
      }
      
      mav.setViewName("redirect:indexTib.do");
      return mav;
   }
   
   /* #chatProfile
    * 채팅창에서 아이디 클릭 시 해당 멤버의 프로필을 보여주는 기능
    * */
   @RequestMapping("projectMemberProfile.do")
   public ModelAndView chatProfile(HttpServletRequest req, @RequestParam("mid")String mid) {
      ModelAndView mav = new ModelAndView();
      
      HttpSession session  = req.getSession(); 
      ProjectDTO pdto = (ProjectDTO)session.getAttribute("projectDTO"); 
      
      	String pcode = pdto.getPcode(); 
      
      MemberDTO mdto = memberDao.memberInfo(mid);
      
      HashMap<String,String> projectMember = new HashMap<String, String>();                //해당 프로젝트의 pcode와 해당 멤버의 mid
      	projectMember.put("pcode", pcode);
      	projectMember.put("mid", mid); 
      
      ArrayList<FileDTO> list = fileDao.profileFileList(projectMember); 					
      
      HashMap<String,Object> schmap = new HashMap<String, Object>();					   //해당 프로젝트 pidx와 해당 멤버의 mname
      	schmap.put("pidx",pdto.getPidx()); 
      	schmap.put("mname",mdto.getMname());
      
      ArrayList<scheduleDTO> schedulelist = (ArrayList)calDao.getprofileScheudle(schmap);
      
      mav.addObject("mdto",mdto);
      mav.addObject("filelist",list);
      mav.addObject("schedulelist",schedulelist); 
      mav.setViewName("tibJson");
      
      return mav; 
   }
}