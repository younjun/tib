package tib.univ.model;


public class UnivDTO {

   private int univCode; 
   private String uname; 
   private String ustartdate; 
   private String uenddate;
   private String uemail;
   public UnivDTO() {
      super();
   }
   public UnivDTO(int univCode, String uname, String ustartdate, String uenddate, String uemail) {
      super();
      this.univCode = univCode;
      this.uname = uname;
      this.ustartdate = ustartdate;
      this.uenddate = uenddate;
      this.uemail = uemail;
   }
   public int getUnivCode() {
      return univCode;
   }
   public void setUnivCode(int univCode) {
      this.univCode = univCode;
   }
   public String getUname() {
      return uname;
   }
   public void setUname(String uname) {
      this.uname = uname;
   }
   public String getUstartdate() {
      return ustartdate;
   }
   public void setUstartdate(String ustartdate) {
      this.ustartdate = ustartdate;
   }
   public String getUenddate() {
      return uenddate;
   }
   public void setUenddate(String uenddate) {
      this.uenddate = uenddate;
   }
   public String getUemail() {
      return uemail;
   }
   public void setUemail(String uemail) {
      this.uemail = uemail;
   } 
   
   
}