package tib.faq.model;

import java.util.List;

public interface FaqDAO {
   
   public List faqAllList();
   public int addFaq(FaqDTO dto);
   public int faqUpdate(FaqDTO dto);
   public int faqDelete(int fidx);
}