package tib.calendar.model;

import java.util.Map;

public class calendarDTO {

   private String year = "";
   private String month = "";
   private String date = "";
   private String value = "";
   String db_startDate = "";
   String db_endDate = "";   
   scheduleDTO[] schedule_data_arr = new scheduleDTO[5];
   Map<String,Object>[] anniver_arr = (Map<String,Object>[]) new Map[5];
   private int pidx;
   
   
   public calendarDTO() {
      // TODO Auto-generated constructor stub
   }
   // 달력만 사용시 사용될 생성자
   public calendarDTO(String year, String month, String date, String value, int pidx) {
      super();
      if ((month != null && month != "") && (date != null && date != "")) {

         this.year = year;
         this.month = month;
         this.date = date;
         this.value = value;
         this.pidx = pidx;
      }
   }
   // 스케줄 사용시 사용될 생성자
   public calendarDTO(String year, String month, String date, String value, scheduleDTO[] schedule_data_arr, Map<String,Object>[] anniver_arr, int pidx) {
      if ((month != null && month != "") && (date != null && date != "")) {
         this.year = year;
         this.month = month;
         this.date = date;
         this.value = value;
         this.schedule_data_arr = schedule_data_arr;
         this.anniver_arr = anniver_arr;
         this.pidx = pidx;
      }

   }
   

   public String getYear() {
      return year;
   }
   public void setYear(String year) {
      this.year = year;
   }
   public String getMonth() {
      return month;
   }
   public void setMonth(String month) {
      this.month = month;
   }
   public String getDate() {
      return date;
   }
   public void setDate(String date) {
      this.date = date;
   }
   public String getValue() {
      return value;
   }
   public void setValue(String value) {
      this.value = value;
   }
   
   
   
   
   public String getDb_startDate() {
      return db_startDate;
   }
   public void setDb_startDate(String db_startDate) {
      this.db_startDate = db_startDate;
   }
   public String getDb_endDate() {
      return db_endDate;
   }
   public void setDb_endDate(String db_endDate) {
      this.db_endDate = db_endDate;
   }
   public scheduleDTO[] getSchedule_data_arr() {
      return schedule_data_arr;
   }
   public void setSchedule_data_arr(scheduleDTO[] schedule_data_arr) {
      this.schedule_data_arr = schedule_data_arr;
   }
   public Map<String, Object>[] getAnniver_arr() {
      return anniver_arr;
   }
   public void setAnniver_arr(Map<String, Object>[] anniver_arr) {
      this.anniver_arr = anniver_arr;
   }
   public int getPidx() {
      return pidx;
   }
   public void setPidx(int pidx) {
      this.pidx = pidx;
   }
   
   
   @Override
   public String toString() {
      return "DateData [year=" + year + ", month=" + month + ", date=" + date + ", value=" + value + "]";
   }
   
}