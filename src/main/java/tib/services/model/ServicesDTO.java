package tib.services.model;

public class ServicesDTO {

   private int sidx;
   private String ssubject;
   private String scontent;
   private String simg;
   
   public ServicesDTO() {
      super();
   }

   public ServicesDTO(int sidx, String ssubject, String scontent, String simg) {
      super();
      this.sidx = sidx;
      this.ssubject = ssubject;
      this.scontent = scontent;
      this.simg = simg;
   }

   public int getSidx() {
      return sidx;
   }

   public void setSidx(int sidx) {
      this.sidx = sidx;
   }

   public String getSsubject() {
      return ssubject;
   }

   public void setSsubject(String ssubject) {
      this.ssubject = ssubject;
   }

   public String getScontent() {
      return scontent;
   }

   public void setScontent(String scontent) {
      this.scontent = scontent;
   }

   public String getSimg() {
      return simg;
   }

   public void setSimg(String simg) {
      this.simg = simg;
   }
   
}