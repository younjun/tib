package tib.member.model;
import java.util.*;
public interface MemberDAO {
   
   public static final int LOGIN_SUCCESS = 2;
   public static final int EMAIL_INJEONG = 1;
   public static final int LOGIN_FAIL = 0;
   
   public int memberJoin(MemberDTO dto);
   public int idCheck(String mid);
   public int loginSubmit(String mid,String mpwd);
   public MemberDTO memberInfo(String mid);
   public int GetKey(String userid,String userkey);
   public int chagetKey(String userid,String key);
   public String idSearch(String mname,String memail);
   public String pwdEmailSearch(String mid);
   public int pwdUpdate(String mid,String mpwd);
   public List memberList(HashMap pagemap);
   public int countMember();
   public ArrayList<MemberDTO> projectMemberInfo(int pidx);
   public int updateCertification(int midx);
   public int deleteMember(int midx);
}