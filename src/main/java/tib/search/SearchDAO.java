package tib.search;

import java.util.*;

public interface SearchDAO {

   public List searchFile(HashMap map);
   public List searchMember(String content); 
   public List searchProject(String content); 
   public List searchSchedule(HashMap map);
   public String getProjectName(int pidx); 
}