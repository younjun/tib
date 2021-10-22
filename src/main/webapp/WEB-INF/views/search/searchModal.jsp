<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
   <script src="//code.jquery.com/jquery-1.12.4.min.js"></script>
<script>


function search_sch_info(pidx,subject,content,resp,d_day,complete){
   var subNode = document.getElementById('search_sch_sub'); 
    var contentNode=document.getElementById('search_sch_con'); 
    var respNode = document.getElementById('search_sch_resp'); 
    var dateNode = document.getElementById('search_sch_date'); 
    var completeNode = document.getElementById('search_sch_complete'); 
    var goProjectNode = document.getElementById('goProject'); 
    if(complete=='N'){
       complete='진행 중';
    }else{
       complete='수행완료'; 
    }
    subNode.innerHTML = subject; 
    contentNode.innerHTML = content; 
    respNode.innerHTML = resp; 
    dateNode.innerHTML = d_day;
    completeNode.innerHTML = complete; 
    goProjectNode.setAttribute('onclick','location.href="calendar.do?pidx='+pidx+'"'); 
    var param = 'pidx='+pidx;
    sendRequest('getProjectName.do',param,show_search_sch,'GET')
 }
 
 function show_search_sch(){
    
    if(XHR.readyState==4){
       if(XHR.status==200){
          var data = XHR.responseText; 
          data = eval('('+data+')'); 
          var projectNameNode = document.getElementById('projectname'); 
          projectNameNode.innerHTML = data.pname+'- 방'; 
          showModal('search_schInfo');
       }
    }
    
 }
 

</script>
<style>
/* The Modal (background) */

#createProject {
   cursor: pointer;
}

/* Modal Content/Box */

/* The Close Button */
.close {
   color: #aaa;
   float: right;
   font-size: 28px;
   font-weight: bold;
}

.close:hover, .close:focus {
   color: black;
   text-decoration: none;
   cursor: pointer;
}
.modal {
   display: none; /* Hidden by default */
   position: fixed; /* Stay in place */
   z-index: 1; /* Sit on top */
   left: 0;
   top: 0;
   width: 100%; /* Full width */
   height: 100%; /* Full height */
   overflow: auto; /* Enable scroll if needed */
   background-color: rgb(0, 0, 0); /* Fallback color */
   background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}
.modal-content {
   background-color: #fefefe;
   margin:0px auto; /* 15% from the top and centered */
   padding: 1px;
   border: 1px solid #888;
   width: 100%; /* Could be more or less, depending on screen size */
   height: 60%;
}

</style>






<!-- 스케쥴 모달  -->
   <div class="modal" id="search_schInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
  aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header text-center">
        <h4 class="modal-title w-100 font-weight-bold" id="projectname"></h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
            <form name="sch_success" action="altSchedule.do">
      <div class="modal-body mx-3">

      
      <input type="hidden" name="pidx" id="sch_pidx" name="pidx">
      <input type="hidden" id="sch_idx" name="schedule_idx">
      
       <div class="md-form mb-3">
          <i class="fas fa-user prefix grey-text"></i>
          <label data-error="wrong" data-success="right" for="form34">업무명</label>
           <div class=" text-right font-weight-bold" id="search_sch_sub">
          
        </div>
        </div>
        <hr>
        <div class="md-form mb-3">
          <i class="fas fa-user prefix grey-text"></i>
          <label data-error="wrong" data-success="right" for="form34">업무내용</label><br>
          <textarea class=" text-right font-weight-bold" id="search_sch_con" style="width: 100%;"readonly="readonly" rows="10" name="schedule_content"></textarea>
          
        </div>
<hr>
        
         <div class="md-form mb-3">
          <i class="fas fa-envelope prefix grey-text"></i>
          <label data-error="wrong" data-success="right" for="form29">담당자</label>
          <div class=" text-right font-weight-bold" id="search_sch_resp">
             
          </div> 
        </div>
      <hr>
      <div class="md-form mb-3">
          <i class="fas fa-envelope prefix grey-text"></i>
           <label data-error="wrong" data-success="right" for="form29">D-day</label>
            <div class=" text-right font-weight-bold" id="search_sch_date">
        </div>
        </div>
        <hr>
        <div class="md-form mb-3">
          <i class="fas fa-envelope prefix grey-text"></i>
          <label data-error="wrong" data-success="right" for="form29">수행여부</label>
          <div class=" text-right font-weight-bold" id="search_sch_complete">
        </div>
        </div>
        </div>
      <div class="modal-footer d-flex justify-content-center">
         <!-- 필요한거로 <input type="hidden" name="univCode" id="deleteunivCode">-->
         <input type="button" value="다른 일정 보기 " class="btn btn-outline-info" id="goProject">
      
      </div>
        </form>
    </div>
  </div>
</div>












