package tib.univ.model;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

public class UnivDAOImple implements UnivDAO {

   @Autowired
   private SqlSessionTemplate sst;
   
   public UnivDAOImple(SqlSessionTemplate sst) {
      super();
      this.sst = sst;
   }
   /* #getUnivList
    * 회원가입 시 제휴되어 있는 대학 리스트를 불러오는 기능
    * */
   public ArrayList<UnivDTO> getUnivList() {
      ArrayList<UnivDTO> arr = (ArrayList)sst.selectList("univList");
      return arr;
   }
   
   /* #getUnivcode
    * 해당학교의 메일주소를 통해 학교코드를 추출
    * */
   public int getUnivcode(String uemail) {
	   return sst.selectOne("getUnivcode",uemail);
	}
   
   /* #addUniv
    * 제휴학교를 추가하는 기능
    * */
   public int addUniv(UnivDTO dto) {
      int result = sst.insert("addUniv",dto);
      return result;
	   }
   /* #univInfo
    * 학교코드를 통해 학교 정보를 추출
    * */   
   public UnivDTO univInfo(int univCode) {
      UnivDTO dto = sst.selectOne("univInfo",univCode); 
      return dto;
	   }
	/* #updateUniv
	 * 학교 정보를 수정
	 */
   public int updateUniv(UnivDTO dto) {
      int result = sst.update("updateUniv",dto);
      return result;
	   }
	/* #deleteUniv
	 * 학교 정보를 삭제
	 */
   public int deleteUniv(int univCode) {
      int result = sst.delete("deleteUniv",univCode);
      return result;
	   }   
}