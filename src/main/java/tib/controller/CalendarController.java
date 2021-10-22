package tib.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.IIOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Conditional;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import tib.calendar.model.*;
import tib.member.model.MemberDTO;
import tib.project.model.ProjectDTO;

@Controller
public class CalendarController{
   
   @Autowired
   CalendarDAO calDao;


   /**
    * #calendar
    * 일정관련 메뉴 선택시 페이지 이동 관련 메서드 
    * */
   @RequestMapping(value = "/calendar.do", method = RequestMethod.GET)
   public String calendar(Model model, HttpServletRequest req, calendarDTO dto, HttpSession session,@RequestParam("pidx")int pidx) throws Exception{
      
            Calendar cal = Calendar.getInstance();
           
            calendarDTO calendarData;
            
            //검색 날짜      
            if(dto.getDate().equals("")&&dto.getMonth().equals("")){
               dto = new calendarDTO(String.valueOf(cal.get(Calendar.YEAR)),String.valueOf(cal.get(Calendar.MONTH)),String.valueOf(cal.get(Calendar.DATE)),null, dto.getPidx());
            }
            
            Map<String, Integer> today_info =  calDao.today_info(dto);
            
            List<calendarDTO> dateList = new ArrayList<calendarDTO>(); 
      
            //스케쥴 호출
            List<scheduleDTO> Schedule_list =  calDao.schedule_list(dto);
            
      
            //달력데이터에 넣기 위한 배열 추가
            scheduleDTO[][] schedule_data_arr = new scheduleDTO[32][5];
            if(Schedule_list.isEmpty()!=true){
               
                  int j = 0;
                  
                  for(int i=0; i<Schedule_list.size(); i++){
                        int date = Integer.parseInt(String.valueOf(Schedule_list.get(i).getSchedule_date()).substring(String.valueOf(Schedule_list.get(i).getSchedule_date()).length()-11,String.valueOf(Schedule_list.get(i).getSchedule_date()).length()-9));
                        //System.out.println(date+">>");
                        if(i>0){
                           int date_before = Integer.parseInt(String.valueOf(Schedule_list.get(i-1).getSchedule_date()).substring(String.valueOf(Schedule_list.get(i-1).getSchedule_date()).length()-11,String.valueOf(Schedule_list.get(i-1).getSchedule_date()).length()-9));
                           if(date_before==date){
                              j=j+1;
                              schedule_data_arr[date][j] = Schedule_list.get(i);
                           }else{
                              j=0;
                              schedule_data_arr[date][j] = Schedule_list.get(i);
                           }
                        }else{
                           schedule_data_arr[date][j] = Schedule_list.get(i);
                        }
                   }
            }
            
            //기념일 호출
            HolidayCrawling anniver = new HolidayCrawling();
            List<Map<String,Object>> anniver2 = anniver.getParsedXMLResult(dto);
           
      
            Map<String,Object>[][] anniver_arr = (Map<String,Object>[][]) new Map[32][5];
            
            if(anniver2.isEmpty()!=true) {
                  
               int j=0;
                  
               for(int i=0;i<anniver2.size();i++) {
                       
                        int date = Integer.parseInt(String.valueOf(anniver2.get(i).get("V_TIME")).substring(String.valueOf(anniver2.get(i).get("V_TIME")).length()-2,String.valueOf(anniver2.get(i).get("V_TIME")).length()));
                        //System.out.println(date+">>");
                        if(i>0){
                           int date_before = Integer.parseInt(String.valueOf(anniver2.get(i-1).get("V_TIME")).substring(String.valueOf(anniver2.get(i-1).get("V_TIME")).length()-2,String.valueOf(anniver2.get(i-1).get("V_TIME")).length()));
                           if(date_before==date){
                              j=j+1;
                              anniver_arr[date][j] = anniver2.get(i);
                           }else{
                              j=0;
                              anniver_arr[date][j] = anniver2.get(i);
                           }
                        }else{
                           anniver_arr[date][j] = anniver2.get(i);
                        }
               }
            }
      
            //실질적인 달력 데이터 리스트에 데이터 삽입 시작.
            //일단 시작 인덱스까지 아무것도 없는 데이터 삽입
            for(int i=1; i<today_info.get("start"); i++){
            
               calendarData= new calendarDTO(null, null, null, null, null, null, dto.getPidx());
               dateList.add(calendarData);
            }
      
            //날짜 삽입
            for (int i = today_info.get("startDay"); i <= today_info.get("endDay"); i++) {
               
               scheduleDTO[] schedule_data_arr3 = new scheduleDTO[5];
               schedule_data_arr3 = schedule_data_arr[i];
               
               Map<String,Object>[] anniver_arr3 = (Map<String,Object>[]) new Map[5];
               anniver_arr3 = anniver_arr[i];
         
               if(i==today_info.get("today")){
               calendarData= new calendarDTO(String.valueOf(dto.getYear()), String.valueOf(dto.getMonth()), String.valueOf(i), "today", schedule_data_arr3, anniver_arr3, dto.getPidx());
               }else{
               calendarData= new calendarDTO(String.valueOf(dto.getYear()), String.valueOf(dto.getMonth()), String.valueOf(i), "normal_date", schedule_data_arr3, anniver_arr3, dto.getPidx());
               }
               dateList.add(calendarData);
            }
      
            //달력 빈 곳 빈 데이터로 삽입
            int index = 7-dateList.size()%7;
      
            if(dateList.size()%7!=0){
      
               for (int i = 0; i < index; i++) {
                  calendarData= new calendarDTO(null, null, null, null, dto.getPidx());
                  dateList.add(calendarData);
               }
            }
               
            List<MemberDTO> proMemInfo_list = calDao.proMemInfo(pidx);
            //배열에 담음
            model.addAttribute("dateList", dateList); 
            model.addAttribute("today_info", today_info);
            return "calendar/calendarView";
      }

     /**
      * #addSchedule
      * 일정 업로드 관련 메서드 
      * */
     @RequestMapping(value = "/addSchedule.do", method = RequestMethod.POST)
     public ModelAndView addSchedule(HttpServletRequest req,scheduleDTO dto) {
        
        ModelAndView mav = new ModelAndView();
        
        HashMap schedule_map  = new HashMap<String, Object>();               //추가 날짜의 일정 갯수를 가져오기 위해 프로젝트번호와 추가 일을 MAP에   put
           schedule_map.put("pidx", dto.getPidx()); 
           schedule_map.put("schedule_date", dto.getSchedule_date()); 
       
        int scheduleCount = calDao.scheduleCount(schedule_map) ;             //추가할 날짜의 일정 갯수
        
        int count = 0; 
        
        if(scheduleCount<4) {                                                //하루 일정을 4개로 제한 
           count = calDao.addSchedule(dto);                                 //넘어온 객체를 이용하여 DB에 UPDATE쿼리 실행
        }
                                                  
        String msg = count>0?"일정 등록 성공!":"1일 제한 일정을 초과하였습니다.";
          
        mav.addObject("msg", msg);
        mav.addObject("goPage", "calendar.do?pidx="+dto.getPidx());
        mav.setViewName("calendar/calendarMsg");
         
        return mav;
     }
   
     
     /**
      * #scheduleDetail
      * 스케쥴 모달 관련 정보  메서드 
      * */
     @RequestMapping(value = "/scheduleDetail.do")
     public ModelAndView scheduleDetail(@RequestParam("schedule_idx")int schedule_idx) {
        
        ModelAndView mav = new ModelAndView();                            
       
        scheduleDTO dto = calDao.scheduleInfo(schedule_idx);                           //schedule_idx를 식별자로 DB로 부터 해당 스케줄의 객체정보를 받아온다.
         
        mav.addObject("dto",dto);
         mav.setViewName("tibJson");
       
         return mav;
       
     }
   
     /**
      * #updateSchedule
      * 일정  수정 관련 메서드
      * */
    @RequestMapping(value = "altSchedule.do")
    public ModelAndView updateSchedule(scheduleDTO dto) {
        
       ModelAndView mav = new ModelAndView();
        
       int count = calDao.altSchedule(dto);
       
       String msg = count>0?"일정 변경 성공!":"일정변경 실패...";
     
       mav.addObject("msg", msg);
        mav.addObject("goPage", "calendar.do?pidx="+dto.getPidx());
        mav.setViewName("calendar/calendarMsg");
       
        return mav;
       
    }
}