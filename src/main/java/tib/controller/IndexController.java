package tib.controller;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import tib.faq.model.FaqDAO;
import tib.member.model.MemberDTO;
import tib.project.model.ProjectDAO;
@Controller
public class IndexController {

      @Autowired
      private ProjectDAO projectDao;
      
      @Autowired
      private FaqDAO faqDao;
      
      /**
       * #goIndex
       * 홈페이지 이동 관련 메서드       
       *  * */
      @RequestMapping("/index.do")
      public ModelAndView goIndex() {
         
         ModelAndView mav = new ModelAndView();
         
         List lists = faqDao.faqAllList();     //관리자가 설정 해 놓은 질문및 답변 목록 
         
         mav.addObject("lists", lists);
         mav.setViewName("index");
         
         return mav;
      }
      
      /**
       * #goIndexTib
       * 로그인 후 메인페이지 이동 관련 메서드 
       * */
      @RequestMapping("/indexTib.do")
      public ModelAndView goInexTib(HttpServletRequest req) {
         
         ModelAndView mav = new ModelAndView();
            
         HttpSession session = req.getSession();           
            List publicProject = projectDao.publicProject();                 //공개 프로젝트 목록  
            
          MemberDTO dto = (MemberDTO)session.getAttribute("user");
            int midx = dto.getMidx();
              
          session.setAttribute("publicProject", publicProject);              
          session.setAttribute("projectList", projectDao.projectList(midx)); //해당 유저가 가입되어있는 프로젝트 목록
            
          mav.setViewName("tib/indexTib");
            
          return mav;
          
      }
}