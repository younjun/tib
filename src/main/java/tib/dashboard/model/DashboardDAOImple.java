package tib.dashboard.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import tib.calendar.model.scheduleDTO;

public class DashboardDAOImple implements DashboardDAO {
   
   private SqlSessionTemplate sst;
   
   public DashboardDAOImple(SqlSessionTemplate sst) {
         this.sst = sst;
   }
   
   /**
    * #proMemList
    * 해당프로젝트에 업무할당이 되어있는 회원 목록  관련 메서드 
    * */
   public String proMemList(int pidx) {
     
      List<String> memList = sst.selectList("memList",pidx);       //해당프로젝트에 업무할당이 되어있는 회원 목록  
      
      String list = "";
      
      for(int i=0;i<memList.size();i++) {                          //부트스트랩에서 필요한 형식을 위함 
 
          if(i==memList.size()-1) {
             list += "'"+memList.get(i)+"'";
             break; 
          }          
            list += "'"+memList.get(i)+"'"+", "; 
      }   
      
       list = "["+list+"]";           
             
       return list;
   }

   /**
    * #workamount
    * 
    * */
   public String workamount(int pidx) {
      
      List<String> workamount = sst.selectList("workamount", pidx);      //업무 담당자 별 업무갯수 목록
       
      String list = "";
      
      for(int i=0;i<workamount.size();i++) {
         if(i==workamount.size()-1) {
            list += workamount.get(i);
         }
         list += workamount.get(i)+", ";
       }
          
      list = "["+list+"]";  
      
       return list;
   }

   /**
    * #cardTInfo
    * 팀 전체 업무에 대한 목록 관련 메서드 
    * */
   public List<scheduleDTO> cardTInfo(int pidx) {
     
      List<scheduleDTO> info = sst.selectList("teamWorkList",pidx);
      
      return info;
   }

   /**
    * #cardMInfo
    * 업무 담당자 목록 관련 메서드 
    * */
   public List<scheduleDTO> cardMInfo(int pidx) {
      
      List<scheduleDTO> info = sst.selectList("memWorkList", pidx);
      
      return info;
   }

}