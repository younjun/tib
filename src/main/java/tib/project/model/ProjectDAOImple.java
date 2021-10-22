package tib.project.model;

import java.util.*;

import org.apache.commons.collections.map.HashedMap;
import org.mybatis.spring.SqlSessionTemplate;

public class ProjectDAOImple implements ProjectDAO {

   private SqlSessionTemplate sst;
   
   public ProjectDAOImple(SqlSessionTemplate sst) {
      super();
      this.sst = sst;
   }
   
   /* #getPcode
    * pcode를 랜덤으로 생성해주는 기능
    * 아스키 코드를 통해 영어일 경우에만 StringBuffer에 append 해줘서 반환한다.
    */
   public String getPcode() {
      int size = 0;
      Random ran = new Random();										
      StringBuffer sb = new StringBuffer();
      int num =0;
      do {
         num=ran.nextInt(75)+48;
         if((num<=48&&num<=57)||(num>=65&&num<=90)||(num>=97&&num<=122)){
            sb.append((char)num);
            size++;
         }else {
            continue;
         }
      }while(size<6);
      
      return sb.toString();
   }
   
   /* #addProject
    * 프로젝트 생성시 pcode가 중복인지 검사하여 pcode를 반환한다.
    */
   public String addProject(ProjectDTO dto) {
      String tmpPcode="";
      String checkPcode="";
      
      while(checkPcode!=null) {
         tmpPcode=getPcode();
         checkPcode=sst.selectOne("checkPcode",tmpPcode);
      }
      dto.setPcode(tmpPcode);
      int res = sst.insert("addProject",dto);
      return tmpPcode;
   }
   
   /* #projectList
    * 해당 유저가 참여중인 프로젝트 리스트를 반환한다.
    */
   public ArrayList<ProjectDTO> projectList(int midx) {
      ArrayList<ProjectDTO> al = (ArrayList)sst.selectList("projectList", midx);
      return al;
   }
   
   /* #addProjectMember
    * 유저가 프로젝트에 가입하는 경우 pm 테이블에 추가해주는 기능
    */
   public int addProjectMember(int pidx, int midx) {
      Map<String,Integer> map = new HashMap<String,Integer>();
      map.put("pidx", pidx);
      map.put("midx", midx);
      int result = sst.insert("addProjectMember",map); 
      return result;
   }

   /*#projectinfo
    * 해당 프로젝트의 정보를 반환한다.
    */
   public ProjectDTO projectInfo(String pcode) {
      ProjectDTO dto = sst.selectOne("projectInfo",pcode);
      return dto;
   }
   
   /* #exitProjectHost
    * 프로젝트 생성자가 프로젝트를 나가는 경우 호출
    * 생성자가 나가는 경우 프로젝트는 삭제 된다.
    */
   public int exitProjectHost(int pidx) {
	   sst.delete("projectDelete", pidx);
	   sst.delete("pmDelete", pidx);
	   return 1;
	}
   
   /* #exitProjectMember
    * 일반 유저가 프로젝트를 나가는 경우 호출
    * pm테이블에서만 제거 해준다.
    */
   public int exitProjectMember(int pidx, int midx) {
	   Map map = new HashedMap();
	   map.put("pidx", pidx);
	   map.put("midx", midx);
	   sst.delete("projectMemberDelete", map);
	   return 0;
	}
   
   /* #allProjectList
    * 사이트 내의 존재하는 모든 프로젝트의 리스트를 반환
    */
   public ArrayList<ProjectDTO> allProjectList(HashMap map) {
      ArrayList<ProjectDTO> arr = (ArrayList)sst.selectList("allprojectList",map);
      return arr;
   }
   
   /* #publicProject
    * 공개 프로젝트 리스트를 반환
    */
   public List publicProject() {
      List publicProject = sst.selectList("publicProjectList");
      return publicProject;
   }
   
   /* #projectMemberCheck
    * 유저가 해당 프로젝트의 이미 참가중인지 여부를 검사
    */
   public int projectMemberCheck(int pidx, int midx) {
     Map map = new HashMap();
     map.put("pidx", pidx);
     map.put("midx", midx);
      int count = sst.selectOne("projectMemberCheck", map);
      return count;
   }
   
   /* #countPlus
    * 프로젝트에 유저가 참여 시 해당 프로젝트의 인원수를 증가시키는 기능
    */
   public void countPlus(int pidx) {
	   sst.update("updatePcountPlus", pidx);
      
   }
   
   /* #countMinus
    * 프로젝트에 유저가 참여 시 해당 프로젝트의 인원수를 감소시키는 기능
    */
   public void countMinus(int pidx) {
      sst.update("updatePcountMinus", pidx);
         
   }
   
   /* #countProject
    * 해당 프로젝트의 인원수를 반환
    */
   public int countProject() {
         int count = sst.selectOne("projectCount"); 
         return count;
      }
   
   /* #okPcode
    * pcode 일치 여부를 검사 하는 기능
    */
   public int okPcode(String pcode, int pidx) {
         ProjectDTO dto = sst.selectOne("projectInfo",pcode);
   if(dto!=null) {
      if(pidx==dto.getPidx()) {
           return 1;
        }else {
           return 0;
        } 
   }else {
      return 0;
   }
           
  }
}