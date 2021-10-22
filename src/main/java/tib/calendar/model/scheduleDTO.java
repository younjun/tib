package tib.calendar.model;

public class scheduleDTO {

   private int pidx;
   private int schedule_idx;
   private String schedule_subject;
   private String schedule_content;
   private String start_date;
   private String end_date;
   private String schedule_date;
   private String schedule_color;
   private String schedule_resp;
   private String schedule_complete;
   private int d_day;
   
   
   public scheduleDTO() {   }

   

   public scheduleDTO(int pidx, int schedule_idx, String schedule_subject, String schedule_content, String start_date,
         String end_date, String schedule_date, String schedule_color, String schedule_resp,
         String schedule_complete,int d_day) {
      super();
      this.pidx = pidx;
      this.schedule_idx = schedule_idx;
      this.schedule_subject = schedule_subject;
      this.schedule_content = schedule_content;
      this.start_date = start_date;
      this.end_date = end_date;
      this.schedule_date = schedule_date;
      this.schedule_color = schedule_color;
      this.schedule_resp = schedule_resp;
      this.schedule_complete = schedule_complete;
      this.d_day = d_day;
   }



   public int getPidx() {
      return pidx;
   }
   public void setPidx(int pidx) {
      this.pidx = pidx;
   }
   public int getSchedule_idx() {
      return schedule_idx;
   }
   public void setSchedule_idx(int schedule_idx) {
      this.schedule_idx = schedule_idx;
   }
   public String getSchedule_subject() {
      return schedule_subject;
   }
   public void setSchedule_subject(String schedule_subject) {
      this.schedule_subject = schedule_subject;
   }
   public String getSchedule_content() {
      return schedule_content;
   }
   public void setSchedule_content(String schedule_content) {
      this.schedule_content = schedule_content;
   }
   public String getStart_date() {
      return start_date;
   }
   public void setStart_date(String start_date) {
      this.start_date = start_date;
   }
   public String getEnd_date() {
      return end_date;
   }
   public void setEnd_date(String end_date) {
      this.end_date = end_date;
   }
   public String getSchedule_date() {
      return schedule_date;
   }
   public void setSchedule_date(String schedule_date) {
      this.schedule_date = schedule_date;
   }
   public String getSchedule_resp() {
      return schedule_resp;
   }
   public void setSchedule_resp(String schedule_resp) {
      this.schedule_resp = schedule_resp;
   }
   public String getSchedule_complete() {
      return schedule_complete;
   }
   public void setSchedule_complete(String schedule_complete) {
      this.schedule_complete = schedule_complete;
   }
   public String getSchedule_color() {
      return schedule_color;
   }
   public void setSchedule_color(String schedule_color) {
      this.schedule_color = schedule_color;
   }



public int getD_day() {
   return d_day;
}



public void setD_day(int d_day) {
   this.d_day = d_day;
}
   
   
}