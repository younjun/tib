package tib.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import tib.calendar.model.scheduleDTO;
import tib.file.model.FileDTO;
import tib.mail.PostMail;
import tib.member.model.MemberDTO;
import tib.project.model.ProjectDAO;
import tib.project.model.ProjectDTO;
import tib.search.SearchDAO;

@Controller
public class SearchController {

    @Autowired
    private SearchDAO searchDao; 
    
    @Autowired
    private ProjectDAO projectDao; 
    
    @Autowired
    private PostMail postMail; 
    
    /*	#searchFile
     * 검색창에서 파일을 검색해주는 기능
     * 검색돤 파일의 목록을 list에 담아서 반환한다.
     * */
   @RequestMapping("/searchFile.do")
   public ModelAndView searchFile(@RequestParam("searchInput")String content,HttpServletRequest req) {      
      ModelAndView mav = new ModelAndView(); 
      
      HttpSession session = req.getSession(); 
      	MemberDTO mdto = (MemberDTO)session.getAttribute("user"); 
      		int midx= mdto.getMidx();
      		
      HashMap map  = new HashMap<String,Object>();													
      	map.put("midx", midx); 
      		content = "%"+content+"%";															
      	map.put("content", content); 
      	
      ArrayList<FileDTO> list = (ArrayList<FileDTO>)searchDao.searchFile(map);						
      
      mav.addObject("filelist",list);
      mav.addObject("option","file");
      mav.setViewName("search/searchResult");
      return mav; 
   }
   
   /* #searchMember
    * 검색창에서 회원을 검색해주는 기능 
    * 검색된 회원들의 목록을 list에 담아 반환한다.
    * */
   @RequestMapping("/searchMember.do")
   public ModelAndView searchMember(@RequestParam("searchInput")String content) {
      ModelAndView mav = new ModelAndView(); 
      
      content = "%"+content+"%";
      
      ArrayList<MemberDTO> list = (ArrayList<MemberDTO>) searchDao.searchMember(content);		
      
      mav.addObject("memberlist",list);
      mav.addObject("option","member");
      mav.setViewName("search/searchResult");
      return mav; 
   }
   
   /* #searchProject
    * 검색창에서 프로젝트를 검색해주는 기능
    * 검색된 프로젝트 목록을 list에 담아 반환한다.
    * */
   @RequestMapping("/searchProject.do")
   public ModelAndView searchProject(@RequestParam("searchInput")String content) {
      ModelAndView mav = new ModelAndView();
      
      content = "%"+content+"%";
      
      ArrayList<ProjectDTO> list = (ArrayList<ProjectDTO>) searchDao.searchProject(content);
      
      mav.addObject("projectlist",list);
      mav.addObject("option","project");
      mav.setViewName("search/searchResult");
      return mav; 
   }
   
   /* #searchSchedule
    * 검색창에서 일정을 검색해주는 기능
    * 검색된 일정 목록을 list에 담아 반환한다.
    * */
   @RequestMapping("/searchSchedule.do")
   public ModelAndView searchSchedule(@RequestParam("searchInput")String content,HttpServletRequest req) {      
      ModelAndView mav = new ModelAndView();
      
      HttpSession session = req.getSession(); 
      	MemberDTO mdto = (MemberDTO)session.getAttribute("user"); 
      		int midx= mdto.getMidx(); 
      
      HashMap map  = new HashMap<String,Object>();
      	map.put("midx", midx); 
      		content = "%"+content+"%";
      	map.put("content", content); 
      	
      ArrayList<scheduleDTO> list = (ArrayList<scheduleDTO>)searchDao.searchSchedule(map);
      
      mav.addObject("schedulelist",list); 
      mav.addObject("option","schedule");
      mav.setViewName("search/searchResult");
      return mav; 
   }
   
   /* #searchAll
    * 검색창에서 전체 검색을 해주는 기능
    * */
   @RequestMapping("/searchAll.do")
   public ModelAndView searchAll(@RequestParam("searchInput")String content,HttpServletRequest req) {   
      ModelAndView mav = new ModelAndView(); 
      
      HttpSession session = req.getSession(); 
      	 MemberDTO mdto = (MemberDTO)session.getAttribute("user"); 
      		int midx= mdto.getMidx();
      		
      HashMap map  = new HashMap<String,Object>();
      	map.put("midx", midx); 
      		content = "%"+content+"%";
      	map.put("content", content);
      	
      ArrayList<FileDTO> list1 = (ArrayList<FileDTO>)searchDao.searchFile(map); 
      ArrayList<MemberDTO> list2 = (ArrayList<MemberDTO>) searchDao.searchMember(content);
      ArrayList<ProjectDTO> list3 = (ArrayList<ProjectDTO>) searchDao.searchProject(content);
      ArrayList<scheduleDTO> list4 = (ArrayList<scheduleDTO>)searchDao.searchSchedule(map);
      
      mav.addObject("filelist",list1);
      mav.addObject("memberlist",list2);
      mav.addObject("projectlist",list3);
      mav.addObject("schedulelist",list4);
      
      mav.addObject("option","all");
      mav.setViewName("search/searchResult");
      return mav; 
   }
   
   /* #sendProjectCode
    * 검색된 회원을 프로젝트에 초대하기 위해 프로젝트 코드를 보내주는 기능
    * */
  @RequestMapping(value = "/responseProject.do", method = RequestMethod.POST)
  public ModelAndView sendProjectCode(ProjectDTO dto,@RequestParam("projectRoom")String pcode,@RequestParam("memail")String[] members,HttpServletRequest req) {
        ModelAndView mav = new ModelAndView();
        
        ProjectDTO pdto = projectDao.projectInfo(pcode);
        
        String page = postMail.mailSendWithProjectKey(members,pdto,req);
        
        mav.setViewName(page);
        
        return mav;
  }
  
  /* #getProjectName
   * 검색창에서 검색된 일정 모달창에 프로젝트 이름을 넣기 위한 기능
   * */
  @RequestMapping("/getProjectName.do")
  public ModelAndView getProjectName(@RequestParam("pidx")int pidx) {
     ModelAndView mav = new ModelAndView();
     
     String pname = searchDao.getProjectName(pidx); 
     
     mav.addObject("pname",pname); 
     mav.setViewName("tibJson");
     return mav; 
  }
}