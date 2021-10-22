package tib.faq.model;

public class FaqDTO {
   private int fidx;
   private String fsubject;
   private String fcontent;
   public FaqDTO() {
      super();
   }
   public FaqDTO(int fidx, String fsubject, String fcontent) {
      super();
      this.fidx = fidx;
      this.fsubject = fsubject;
      this.fcontent = fcontent;
   }
   public int getFidx() {
      return fidx;
   }
   public void setFidx(int fidx) {
      this.fidx = fidx;
   }
   public String getFsubject() {
      return fsubject;
   }
   public void setFsubject(String fsubject) {
      this.fsubject = fsubject;
   }
   public String getFcontent() {
      return fcontent;
   }
   public void setFcontent(String fcontent) {
      this.fcontent = fcontent;
   }


}
   