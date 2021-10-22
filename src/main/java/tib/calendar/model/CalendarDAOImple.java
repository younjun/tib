package tib.calendar.model;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import tib.member.model.MemberDTO;

public class CalendarDAOImple implements CalendarDAO {
   
   private SqlSessionTemplate sst;

   public CalendarDAOImple(SqlSessionTemplate sst) {
            this.sst = sst;
   }

   /**
    * #today_info
    * 날짜에 관련된 달력정보 를 가지는 메서드
    * */    
   public Map<String, Integer> today_info(calendarDTO dto) {
                                                                                     
      Map<String, Integer> today_Data = new HashMap<String, Integer>();                //오늘에 해당하는 날짜를 담을 map객체
      
      Calendar cal = Calendar.getInstance();                                           
         cal.set(Integer.parseInt(dto.getYear()), Integer.parseInt(dto.getMonth()), 1); //화면에 출력될 해당년도와 달 

      int startDay = cal.getMinimum(java.util.Calendar.DATE);
      int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
      int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
      
      Calendar todayCal = Calendar.getInstance();                                      //오늘의 해당되는 날짜를 받아올 Calendar객체
         SimpleDateFormat ysdf = new SimpleDateFormat("yyyy");
            int today_year = Integer.parseInt(ysdf.format(todayCal.getTime()));
         
         SimpleDateFormat msdf = new SimpleDateFormat("M");
            int today_month = Integer.parseInt(msdf.format(todayCal.getTime()));    

      int search_year = Integer.parseInt(dto.getYear());                               
      int search_month = Integer.parseInt(dto.getMonth()) + 1;

      int today = -1;
      
      if (today_year == search_year && today_month == search_month) {
        
         SimpleDateFormat dsdf = new SimpleDateFormat("dd");
            today = Integer.parseInt(dsdf.format(todayCal.getTime()));
      }
      
      search_month = search_month-1; 
      
      Map<String, Integer> before_after_calendar = before_after_calendar(search_year,search_month);
      
      // 캘린더 함수 end
      today_Data.put("start", start);
      today_Data.put("startDay", startDay);
      today_Data.put("endDay", endDay);
      today_Data.put("today", today);
      today_Data.put("search_year", search_year);
      today_Data.put("search_month", search_month+1);
      today_Data.put("before_year", before_after_calendar.get("before_year"));
      today_Data.put("before_month", before_after_calendar.get("before_month"));
      today_Data.put("after_year", before_after_calendar.get("after_year"));
      today_Data.put("after_month", before_after_calendar.get("after_month"));
      
      dto.db_startDate = String.valueOf(search_year)+"-"+String.valueOf(search_month+1)+"-"+String.valueOf(startDay);
      dto.db_endDate = String.valueOf(search_year)+"-"+String.valueOf(search_month+1)+"-"+String.valueOf(endDay);
           
      return today_Data;
           
   }
   

   /**
    * #before_after_calendar
    * 이전 달 다음달 및 이전년도 다음 년도 
    * */
   private Map<String, Integer> before_after_calendar(int search_year, int search_month){
     
      Map<String, Integer> before_after_data = new HashMap<String, Integer>();
      
      int before_year = search_year;
       int before_month = search_month-1;
       int after_year = search_year;
       int after_month = search_month+1;
      
       if(before_month<0){
         
          before_month=11;
           before_year=search_year-1;
       }
            
       if(after_month>11){
         
          after_month=0;
           after_year=search_year+1;     
       }
           
       before_after_data.put("before_year", before_year);
       before_after_data.put("before_month", before_month);
       before_after_data.put("after_year", after_year);
       before_after_data.put("after_month", after_month);
      
      return before_after_data;
   }
   
   /**
    * #addSchedule
    * 스케쥴 추가 관련 메서드 
    * */
   public int addSchedule(scheduleDTO dto) {
     
      int count = sst.insert("addSchedule", dto);
     
      return count;
   }
   
   //일정 불러오기
   /**
    * #schedule_list
    * 일정 목록 관련 메서드 
    * */
   public List<scheduleDTO> schedule_list(calendarDTO dto) {
     
      List<scheduleDTO> schedule_list = sst.selectList("schedule_list", dto);
      
      return schedule_list;
   }
   
   //일정 추가페이지에 팀원 내역 호출
   /**
    * #proMemInfo
    * 프로젝트 참여 회원목록 관련 메서드 
    * */
   public List<MemberDTO> proMemInfo(int pidx) {
      
      List<MemberDTO> proMemInfo_list = sst.selectList("proMemInfo", pidx);
      
       return proMemInfo_list;
   }
   
   /**
    * #scheduleInfo
    * 일정 정보 관련 메서드 
    * */
   public scheduleDTO scheduleInfo(int schedule_idx) {
      
      scheduleDTO info = sst.selectOne("scheduleInfo", schedule_idx);
           
      return info;
   }
   
   /**
    * #altSchedule
    * 일정 수정 관련 메서드 
    * */
   public int altSchedule(scheduleDTO dto) {
         
      int count = sst.update("altSchedule",dto);
        
      return count;
   }
   
   /**
    * #getprofileSchedule
    * 프로필 모달 관련  해당 회원 일정목록 관련 메서드 
    * */
   public List<scheduleDTO> getprofileScheudle(HashMap map) {
      
      ArrayList<scheduleDTO> arr = (ArrayList)sst.selectList("profileSchedule",map);
      
      return arr;
   }
   
   /**
    *#scheduleCount
    * 일정 추가 관련 해당 날짜 일정 목록갯수 관련 메서드  
    * */
   public int scheduleCount(HashMap map) {
      
      int count = sst.selectOne("scheduleCount",map); 
      
      return count;
   }
}








