package tib.member.model;

import org.mybatis.spring.SqlSessionTemplate;
import java.util.*;

public class MemberDAOImple implements MemberDAO {
   
   private SqlSessionTemplate sst;
 
   public MemberDAOImple(SqlSessionTemplate sst) {
      this.sst = sst;
   }
   
   /**
    * #memberJoin
    * 회원 가입 관련 메서드 
    * */
   public int memberJoin(MemberDTO dto) {
     
      int count = sst.insert("memberInsert", dto); 
      return count;
   }
   
   /**
    * #idCheck
    * 회원가입 아이디 중복검사 관련 메서드 
    * */
   public int idCheck(String mid) {
     
      int count = sst.selectOne("idCheckSelect", mid);       
       return count;
   }
   
   /**
    * #loginSubmit
    * 로그인 관련 메서드 
    * */
   public int loginSubmit(String mid,String mpwd) {
     
      MemberDTO dto = sst.selectOne("loginSelect", mid);                                       //mid를 식별자로 MemberDTO 객체 생성  ( 일치하는  mid가 없을 경우 null값 ) 
      
      int count = 0;
      
      if(dto!=null) {
         
         if(dto.getMpwd().equals(mpwd) && dto.getCertification().equals("y")) {              //생성된 dto의 비밀번호가 매개변수로 받아온  비밃번호와 일치하고 이메일 인증 여부가 y일 경우 로그인 성공 값 리턴
              count = LOGIN_SUCCESS;
           }else if(dto.getMpwd().equals(mpwd)&&!dto.getCertification().equals("y")) {         //생성된 dto의 비밀번호가 매개변수로 받아온  비밃번호와 일치하고 이메일 인증 여부가 y가 아닐경우 이메일 인증  값 리턴
              count = EMAIL_INJEONG;
           }else if(!dto.getMpwd().equals(mpwd)) {
              count = LOGIN_FAIL;                                                             //생성된 dto의 비밀번호가 매개변수로 받아온  비밃번호와 일치하지 않을 경우 로그인 실패값 리턴 
           }
         
       }else {
          count = LOGIN_FAIL;
       }
      
      return count;
   }
   
   /**
    * #memberInfo
    * 회원정보 관련 메서드 
    * */
   public MemberDTO memberInfo(String mid) {
      
      MemberDTO  info = sst.selectOne("memberInfoSelect", mid); 
       return info;
   }
   
   /**
    * #GetKey
    * 회원가입 시 생성된 난수 인증키 값을 DB에 UPDATE 
    * */
   public int GetKey(String userId, String userKey) {
      
      Map<String, String> paramMap = new HashMap();             //회원 아이디와 난수인증키 값을 담을 MAP객체 
           paramMap.put("param1", userId);
           paramMap.put("param2", userKey);
       
       int count = sst.update("getKey", paramMap);
       
       return count;
   }
   
   /**
    * #changeKey 
    * 이메일 인증 시 회원정보 테이블 이메일 인증 여부를  update
    * */
   public int chagetKey(String userId, String key) {
     
      Map<String, String> paramMap = new HashMap();              //회원 아이디와 난수인증키 값을 담을 MAP객체       
            paramMap.put("param1", userId);
            paramMap.put("param2", key);
     
      int count = sst.update("alter_userKey", paramMap);
       
      return count;
   }
   
   /**
    * #idSearch
    * 아이디 찾기 관련 메서드 
    * */
   public String idSearch(String mname,String memail) {
     
      Map<String, String> map = new HashMap();                 //회원이름과 회원 이메일을 담을 MAP객
            map.put("mname", mname);
            map.put("memail", memail);
      
      String result = sst.selectOne("idSearchSelect", map);
      
       return result;
   }
   
   /**
    * #pwdEmailSearch
    * 비밀번호 찾기 관련 메서드 
    * */
   public String pwdEmailSearch(String mid) {
       
      String result = sst.selectOne("emailSelect", mid);
       return result;
   }
   
   /**
    * #pwdUpdate
    * 비밀번호 변경 관련 메서드
    * */
   public int pwdUpdate(String mid,String mpwd) {
     
      Map<String, String> map = new HashMap();
         map.put("mpwd", mpwd);
         map.put("mid", mid);
     
     int count = sst.update("pwdUpdate", map);
      
     return count;
   }

   /**
    * #memberList
    * 관리자 페이지 회원목록 관련 메서드 
    * */
   public List memberList(HashMap pagemap) {
   
      ArrayList<MemberDTO> arr = (ArrayList)sst.selectList("memberList",pagemap);      
      return arr;
      
   }
   
   /**
    * #countMember
    * 관리자 페이지 회원목록 페이징 처리를 위한 총 회원수 관련 메서드  
    * */
   public int countMember() {
     
      int count = sst.selectOne("countMember"); 
       return count;
   }
   
   /**
    * #projectMemberInfo
    * 해당 프로젝트에 참가되어있는 회원 목록 관련 메서드 
    * */
   public ArrayList<MemberDTO> projectMemberInfo(int pidx) {
    
      ArrayList<MemberDTO> arr = (ArrayList)sst.selectList("projectMemberInfo",pidx);
       return arr;
   }
   
   /**
    * #updateCertification
    * 관리자 페이지 회원 이메일 인증 변경 관련 메서드 
    * */
   public int updateCertification(int midx) {
     
      int result = sst.update("updateCertification",midx);
       return result;
   }
   
   /**
    * #deleteMember
    * 관리자 페이지 회원 삭제 관련 메서드 
    * */
   public int deleteMember(int midx) {
      
      int result = sst.delete("deleteMember",midx);                
       
      if(result>0) {                                           //회원삭제가 정상적으로 수행 시 PM테이블에서도 해당 midx가 포함된 정보를 삭제 
          int result2 = sst.delete("deleteMemberPm",midx);
       }
     
      return result;
   }
}