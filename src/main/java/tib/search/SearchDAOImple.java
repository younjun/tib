package tib.search;

import java.util.*;
import tib.file.model.*;
import tib.member.model.*;
import tib.project.model.*;
import tib.calendar.model.*;

import org.mybatis.spring.SqlSessionTemplate;

public class SearchDAOImple implements SearchDAO {

   private SqlSessionTemplate sst; 
   
    public SearchDAOImple(SqlSessionTemplate sst) {
      this.sst = sst; 
   }
    /* #searchFile
     * tib_drive 테이블을 검색
     */
    public List searchFile(HashMap map) {
      ArrayList<FileDTO> arr = (ArrayList)sst.selectList("searchFile",map); 
      return arr;
   }
   
    /* #searchMember
     * tib_member 테이블을 검색
     */
    public List searchMember(String content) {
      ArrayList<MemberDTO> arr = (ArrayList)sst.selectList("searchMember",content);        
      return arr;
   }
    
    /* #searchProject
     * tib_project 테이블을 검색
     */ 
   public List searchProject(String content) {
      ArrayList<ProjectDTO> arr = (ArrayList)sst.selectList("searchProject",content); 
      return arr;
   }
   
   /* #searchSchedule
    * tib_schedule 테이블을 검색
    */
   public List searchSchedule(HashMap map) {
      ArrayList<scheduleDTO> arr = (ArrayList)sst.selectList("searchSchedule",map); 
      return arr;
   }
   
   /* #searchProjectName
    * 검색결과에서 일정 클릭 시 모달창에 사용되는 프로젝트 이름을 추출
    */
   public String getProjectName(int pidx) {
      String pname = sst.selectOne("getProjectName",pidx); 
      return pname;
   }
}