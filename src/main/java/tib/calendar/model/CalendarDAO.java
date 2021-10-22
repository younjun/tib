package tib.calendar.model;

import java.util.*;

import tib.member.model.MemberDTO;

public interface CalendarDAO {
   
   public Map<String, Integer> today_info(calendarDTO dto);
   public int addSchedule(scheduleDTO dto);
   public List<scheduleDTO> schedule_list(calendarDTO dto);
   public List<MemberDTO> proMemInfo(int pidx);
   public scheduleDTO scheduleInfo(int schedule_idx);
   public int altSchedule(scheduleDTO dto);
   public List<scheduleDTO> getprofileScheudle(HashMap map);
   public int scheduleCount(HashMap map);
}