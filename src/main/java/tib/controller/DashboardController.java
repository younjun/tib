package tib.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import tib.calendar.model.scheduleDTO;
import tib.dashboard.model.DashboardDAO;

@Controller
public class DashboardController {
   
   @Autowired
   DashboardDAO dashDao;

   /**
    * #goDashboard
    * dashboard.jsp 로 페이지 이동 관련 메서드
    * */
   @RequestMapping(value = "/goDashboard.do")
   public ModelAndView goDashboard (@RequestParam("pidx")int pidx,HttpSession session) {
      
      ModelAndView mav = new ModelAndView();
      
       try {
          
          String memList = dashDao.proMemList(pidx);                                   //해당 프로젝트에 일정이 있는 회원들의 목록을 불러온다.
          String workamt = dashDao.workamount(pidx);                                   //해당 프로젝트 멤버의 스케쥴 갯수 목록 
          
          List<scheduleDTO> workTList = dashDao.cardTInfo(pidx);
          List<scheduleDTO> workMList = dashDao.cardMInfo(pidx);
         
          mav.addObject("memList", memList);
          mav.addObject("workamt", workamt);
          mav.addObject("totalWorkamt", workamt.length());
          mav.addObject("cardInfo", workTList);
          mav.addObject("cardMInfo", workMList);
          mav.setViewName("dashboard/dashboard");
       
          return mav;
      
       }catch (Exception e) {                                                           //해당 프로젝트에 일정 등록이 없어 NULL 값이 나왔을 경우 Exception처리 
             
          scheduleDTO dto = new scheduleDTO();
          String msg = "등록된 일정이 없습니다. Calendar에서 일정을 추가해 주세요";
          mav.addObject("msg", msg);
          mav.addObject("goPage", "calendar.do?pidx="+dto.getPidx());
          mav.setViewName("calendar/calendarMsg");
          
          return mav;
      }
   }
}