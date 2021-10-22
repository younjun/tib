package tib.page;

public class PageModule {

   public static String pageMake(String pagename,int totalCnt,int listSize,int pageSize,int cp) {
      
      StringBuffer sb = new StringBuffer();
         
      int pageCnt = totalCnt/listSize+1;//총 페이지수
      if(totalCnt%listSize==0) pageCnt--;
      int userGroup = cp/pageSize;
      if(cp%pageSize==0)userGroup--;
      
      if(userGroup!=0){
    	 sb.append("<li class='paginate_button page-item previous' id='dataTable_previous'>"); 
         sb.append("<a aria-controls='dataTable' data-dt-idx='0' tabindex='0' class='page-link' href='");
         sb.append(pagename);
         sb.append("?cp=");
         int temp = (userGroup-1)*pageSize+pageSize;
         sb.append(temp);
         sb.append("'></a></li>");
      }
      
      for(int i=userGroup*pageSize+1;i<=userGroup*pageSize+pageSize; i++){
    	 sb.append("<li class='paginate_button page-item'>");
         sb.append("<a href='");
         sb.append(pagename);
         sb.append("?cp=");
         sb.append(i);
         sb.append("'");
         sb.append("aria-controls='dataTable' data-dt-idx='");
         sb.append(i);
         sb.append("' tabindex='0' class='page-link'>");
         sb.append(i);
         sb.append("</a></li>");
         
         if(i==pageCnt)break;//마지막 페이지까지만
      }
      
      if(userGroup!=(pageCnt/pageSize-(pageCnt%pageSize==0?1:0))){
    	  sb.append("<li class='paginate_button page-item previous' id='dataTable_previous'>"); 
          sb.append("<a href='");
          sb.append(pagename);
          sb.append("?cp=");
         int temp = (userGroup+1)*pageSize+1;
         sb.append(temp);
         sb.append("' aria-controls='dataTable' data-dt-idx='0' tabindex='0' class='page-link'></a></li>");
      
      }
      
      return sb.toString();//sb가 가지고 있는 문열을 반환
      
   }

}