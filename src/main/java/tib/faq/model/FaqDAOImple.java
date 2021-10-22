package tib.faq.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;


public class FaqDAOImple implements FaqDAO {
   
   private SqlSessionTemplate sst;
   
   public FaqDAOImple(SqlSessionTemplate sst) {
      super();
      this.sst = sst;
   }

   /**
    * #faqAllList
    * 자주묻는 질문 및 답변 목록 관련 메서드 
    * */
   public List faqAllList() {
      
      List lists = sst.selectList("faqAllList");
      
      return lists;
   }
   
   /**
    * #addFaq
    * 자주묻는 질문 및 답변 추가 관련 메서드 
    * */
   public int addFaq(FaqDTO dto) {
      
      int count =sst.insert("faqInsert", dto);
      
      return count;
   }
   
   /**
    * #updateFaq
    * 자주묻는 질문 및 답변 수정 관련 메서드 
    * */
   public int faqUpdate(FaqDTO dto) {
      
      int count = sst.update("faqUpdate", dto);
      
      return count;
   }
   
   /**
    * #deleteFaq
    * 자주묻는 질문 및 답변 삭제 관련 메서드 
    * */
   public int faqDelete(int fidx) {
      
      int count = sst.delete("faqDelete", fidx);
      
      return count;
   }
   
}