package tib.services.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

public class ServicesDAOImple implements ServicesDAO {
   
   private SqlSessionTemplate sst;

   public ServicesDAOImple(SqlSessionTemplate sst) {
      super();
      this.sst = sst;
   }
   /* #servicesAllList
    * 메인페이지에 출력될 컨텐츠 전부를 추출
    */
   public List servicesAllList() {
      List list = sst.selectList("servicesAllList");
      return list;
   }
   
   /* #servicesUpdate
    * 메인페이지 컨텐츠 수정 기능
    */
   public int servicesUpdate(ServicesDTO dto) {
      int count = sst.update("servicesUpdate", dto);
      return count;
   }

}