package tib.mail;

import java.util.*;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import tib.member.model.*;
import tib.project.model.*;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class PostMail {

   @Autowired
   private JavaMailSender mailSender;
  
   @Autowired
   private SqlSessionTemplate sst;
   
   @Autowired
   private MemberDAO memberDao;
   
   private int SIZE = 20;                                                  //난수코드 길이 
   
   /**
    * #getKey 
    * 인증코드 관련 난수 코드 생성 메서드 
    * */
   private String getKey() {
      
      Random ran = new Random();                                            //난수 생성을 위한 랜덤함수 
      StringBuffer sb = new StringBuffer();                              
      
      int num = 0;
           
      do {                                                                  //랜덤함수 객체를 이용하여  지정되어있는 난수코드길이를 만족할 때까지 반복문 시행 
         
         num = ran.nextInt(75) + 48;
         if((num>=48&&num<=57)||(num>=65&&num<=90)||(num>=97&&num<=122)) { //생성된 난수값이 문자의 아스키코드 값을 벗어나지 않았을 경우에만  append 문자가 아닐 시에는 continue로 돌려준다. ( do while문을 사용한 이유) 
            sb.append((char)num);
         }else {
            continue;
         }
         
       }while(sb.length()<SIZE);
       
       return sb.toString();
   }
   
   /**
    * #mailSendWithProjectKey
    * 프로젝트 초대 관련 대상회원에게 메일 전송 메서드 
    * */
   public String mailSendWithProjectKey(String[] emails,ProjectDTO dto, HttpServletRequest request) {
      
      MimeMessage mail = mailSender.createMimeMessage();                                                                           //메일 전송관련   MimeMessage객체 생성 
       
      String htmlStr = "<a href='http://localhost:9090/venti5/enterProject.do?pidx=" +dto.getPidx() + "&pcode=" + dto.getPcode()   //메일에 첨부을 html문을 String변수에 저장 
             + "&pname="+dto.getPname()+"'>" + dto.getPname() + "방 참여하기</a>";
      
      String mav_view = "redirect:indexTib.do";                                                                                    //Controller에서 이동할 페이지 
      
       for (int i = 0; i < emails.length; i++) {                                                                                   //받아온 메일의 갯수만큼 반복문 실행           
          if(!emails[i].equals("")) {             
             try {             
                mail.setSubject("tib 프로젝트 초대  ", "utf-8");
                mail.setText(htmlStr, "utf-8", "html");
                mail.addRecipient(RecipientType.TO, new InternetAddress(emails[i]));
                mailSender.send(mail);                                                                                          //실제 메일 전송 코드          
             } catch (Exception e) {
                e.printStackTrace();
                mav_view="tib/error";                                                                                        //메일 전송 시 exception발생 시 보내줄 페이지 명 저장 
             }
          }
       }
       return mav_view; 
    }
   
   /**
    * #mailSendWithUserKey
    * 회원가입 이메일 인증 관련 인증키 발송 메서드 
    * */
   public String mailSendWithUserKey(String email,String userId,HttpServletRequest req) {
      
      String key = getKey();                                                                                                           //난수값을 이용하여 인증키 생성 
      
      String mav_view = "member/memberMsg";                                                                                            //메일전송이 정상적으로 수행되었을 시 보내줄 페이지 
      
      int result =memberDao.GetKey(userId, key);                                                                                       //해당 유저의 정보를 담고 있는 DB에 생성된 난수코드를 UPDATE
       
      MimeMessage mail = mailSender.createMimeMessage();                                                                               //메일 객체 생성
     
      String htmlStr = "<h2> 안녕하세요 Tib입니다!</h2><br><br>"
            + "<h3>"+userId+"님</h3>"+"<p>인증하기 버튼을 누르면 회원가입이 완료됩니다.</p> : "
            + "<a href='http://localhost:9090"+req.getContextPath()+"/changeinjeong.do?userId="+userId+"&injeong="+key+"'>인증하기</a></p>"  //메일에 첨부을 html문을 String변수에 저장 
            +"<img src='img/mainlogo2.png'>";
      
      try {
            mail.setSubject("[본인인증] Tib의 아이디 인증메일입니다.","utf-8");
            mail.setText(htmlStr,"utf-8", "html");
            mail.addRecipient(RecipientType.TO, new InternetAddress(email));
            mailSender.send(mail);
       } catch (MessagingException e) {
          e.printStackTrace();
          mav_view = "tib/error";                                                                                                        //메일 전송이 정상적으로 수행되지 않았을 경우 보내줄 페이지 
       }
      
      return mav_view; 
   }
   

   /**
    * #mailSendWithId
    * 아이디 찾기 관련 아이디 메일 전송 관련 메서드 
    * */
   public String mailSendWithId(String email,String userId,HttpServletRequest req) {
      
      MimeMessage mail = mailSender.createMimeMessage();                                                                                //메일 객체 생성                              
      
      String mav_view = "member/memberMsg";                                                                                             //메일전송이 정상적으로 수행되었을 시 보내줄 페이지
       
      String htmlStr = "<h2> 안녕하세요 Tib입니다!</h2><br><br>"                                                                              //메일에 첨부을 html문을 String변수에 저장 
            +"<p>회원님의 아이디는 </p> "+ "<h3>'"+userId+"'</h3>"
            + "<p>입니다.</p>"
            + "(잘못 전달된 메일이라면 이 이메일을 무시하셔도 됩니다.)";
      
      try {
          mail.setSubject("[본인인증] Tib의 비밀번호 인증메일입니다.","utf-8");
          mail.setText(htmlStr,"utf-8", "html");
          mail.addRecipient(RecipientType.TO, new InternetAddress(email));
          mailSender.send(mail);
       } catch (MessagingException e) {
          e.printStackTrace();
          mav_view= "tib/error";                                                                                                         //메일 전송이 정상적으로 수행되지 않았을 경우 보내줄 페이지
       }
      
      return mav_view; 
   }
   
   
   /**
    * #mailSEndWithPwd
    * 비밀번호 찾기 관련 메일 전송 메서드 
    * */
   public String mailSendWithPwd(String email,String userId,HttpServletRequest req) {
      
      MimeMessage mail = mailSender.createMimeMessage();                                                                               //메일 객체 생성         
      
      String mav_view = "member/memberMsg";                                                                                            //메일전송이 정상적으로 수행되었을 시 보내줄 페이지 
      
      String htmlStr = "<h2> 안녕하세요 Tib입니다!</h2><br><br>"
            + "<h3>"+userId+"님</h3>"+"<p>인증하기 버튼을 누르시명 로그인을 하실 수 있습니다.</p> : "
            + "<p><a href='http://localhost:9090"+req.getContextPath()+"/changePwd.do?userId="+userId+"'>인증하기</a></p>"                //메일에 첨부을 html문을 String변수에 저장
            + "(잘못 전달된 메일이라면 이 이메일을 무시하셔도 됩니다.)";     
      
      try {
         mail.setSubject("[본인인증] Tib의 인증메일입니다.","utf-8");
         mail.setText(htmlStr,"utf-8", "html");
         mail.addRecipient(RecipientType.TO, new InternetAddress(email));
         mailSender.send(mail);
      } catch (MessagingException e) {
         e.printStackTrace();
         mav_view = "tib/error";                                                                                                       //메일 전송이 정상적으로 수행되지 않았을 경우 보내줄 페이지               
      }
      
      return mav_view; 
   }
}