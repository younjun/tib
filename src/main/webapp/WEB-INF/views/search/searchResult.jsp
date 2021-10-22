<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<!-- Custom fonts for this template-->
<link href="resources/vendor/fontawesome-free/css/all.min.css"
   rel="stylesheet" type="text/css">
<link
   href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
   rel="stylesheet">
<title>tib - Together is Better</title>
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<script type="text/javascript" src="js/httpRequest.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.js"></script>
 
 <script>
    window.onload=function(){
       var option = '<c:out value="${option}"></c:out>';
       if(option!='all'){
          var divNode = document.getElementById(option); 
          divNode.removeAttribute('class')
       }else if(option=='all'){
           var divNode1 = document.getElementById('file');
           var divNode2 = document.getElementById('project');
           var divNode3 = document.getElementById('member');
           var divNode4 = document.getElementById('schedule');
           divNode1.removeAttribute('class');
           divNode2.removeAttribute('class');
           divNode3.removeAttribute('class');
           divNode4.removeAttribute('class');
        }
    }

    function enterPublicProjectCallback(){
       if(XHR.readyState==4){
          if(XHR.status==200){
             var data = XHR.responseText;
             window.alert(data);
             location.reload();
          }
       }
    }
 </script>
<style>
.edit {
   display: none;
}

#diva {
   width: 4rem;
   overflow: hidden;
   word-break: break-all;
}

.bg1 {
   background-color: #EFEFEF;
}

.bg2 {
   background-color: #FFFFFF;
}
</style>
</head>

<body id="page-top">
<c:set var="projectDTO" value="${projectDTO }"></c:set>
   <div id="wrapper">
      <%@include file="../tib/navTib.jsp"%>      <!-- side nav -->
      <%@include file="searchModal.jsp"%>      <!-- side nav -->
      <div id="content-wrapper" class="d-flex flex-column">
         <div id="content">
         <%@include file="../tib/toolBarTib.jsp" %> <!-- top search bar area -->
            <div id="container-fluid">
               <div id="project" class="d-none">
                  <div class="container-fluid">
                  <h2>프로젝트</h2>
                  <div id="tableLayer" style="overflow-x:hidden; overflow-y:scroll; height:400px;">
                     <div class="row">
                     <c:forEach var="tmp" items="${projectlist}">
                        
                           <div class="col-xl-3 col-md-6 mb-4" onclick="enterPublic('${tmp.pidx}','${tmp.plock}','${tmp.pname}')">
                              <div class="card border-left-primary shadow h-100 py-2">
                                 <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                       <div class="col mr-2" style="height: 8rem">
      
                                          <!-- 타이틀수정 -->
                                          <c:if test="${tmp.plock==1 }">
                                          <div><i class="fas fa-info-circle" style="float:right;"></i></div>
                                          </c:if>
                                          <div
                                             style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 11rem; padding: 0.75rem; font-size: 0.75rem"
                                             class="h5 mb-0 font-weight-bold text-gray-800">NO. ${tmp.pidx }</div>
                                          
                                          <div 
                                             style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 11.5rem; padding-top: 0px; padding: 0rem; font-size: 0.85rem"
                                             title="${tmp.pname }"
                                             class="text-xs font-weight-bold text-primary text-uppercase mb-1">&nbsp;&nbsp;&nbsp;${tmp.pname }</div>
      
                                          <div
                                             style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 11rem; padding: 0.75rem; font-size: 0.75rem"
                                             title="${tmp.phost }"
                                             class="h5 mb-0 font-weight-bold text-gray-800">Host ${tmp.phost }</div>
      
                                          <div
                                             style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 11rem; padding: 0.75rem; font-size: 0.75rem"
                                             class="h5 mb-0 font-weight-bold text-gray-800">Limit ${tmp.pcount}/${tmp.plimit }</div>
                                       </div>
      
      
                                       <div class="col-auto"></div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        
                    </c:forEach>
                     </div>
                     </div>
                  </div>
               </div>
               <div id="file" class="d-none">
                  <div class="container-fluid">
                  <hr>
                  <h2>파일</h2>
                  <div id="tableLayer" style="overflow-x:hidden; overflow-y:scroll; height:400px;">
                  <div class="row">
                  <c:forEach var="tmp" items="${filelist}">
                     <div class="col-xl-4 col-md-6 mb-4">
                     <a href="fileDown.do?filename=${tmp.dname }${tmp.dkind }&projectNum=${tmp.pcode}" style="text-decoration:none;">
                        <div class="card border-left-primary shadow h-100 py-2">
                           <div class="card-body">
                              <div class="row no-gutters align-items-center">
                                 <div class="col mr-2" style="height: 8rem">
      
                                    <!-- 타이틀수정 -->
                                    <div
                                       style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 11rem; padding: 0.75rem; font-size: 0.75rem"
                                       class="h5 mb-0 font-weight-bold text-gray-800">NO. ${tmp.didx }</div>
                                          
                                    <div
                                       style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 11rem; padding: 0.75rem; font-size: 0.75rem"
                                       class="h5 mb-0 font-weight-bold text-gray-800">ID ${tmp.mid }</div>
      
                                  <div 
                                       style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 20.5rem; padding-top: 0px; padding: 0rem; font-size: 0.85rem"
                                        title="${tmp.dname }${tmp.dkind }"
                                       class="text-xs font-weight-bold text-primary text-uppercase mb-1">&nbsp;&nbsp;&nbsp;File ${tmp.dname }${tmp.dkind }</div>
      
                                    <div
                                       style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 11rem; padding: 0.75rem; font-size: 0.75rem"
                                       class="h5 mb-0 font-weight-bold text-gray-800">date ${tmp.ddate }</div>
                                 </div>
      
                           
                                 <div class="col-auto"></div>
                              </div>
                           </div>
                        </div>
                        </a>
                     </div>
                  </c:forEach>
                  </div>
                  </div>
                  </div>   
                  </div>
               <div id="member" class="d-none">
                 <div class="container-fluid">
                 <hr>
                 <h2>멤버</h2>
                 <div id="tableLayer" style="overflow-x:hidden; overflow-y:scroll; height:200px;">
                 <div class="row">
                 <c:set var="mdto" value="${sessionScope.user }"></c:set>
                 <c:forEach var="tmp" items="${memberlist}">
                    <c:if test="${tmp.midx!=18 && mdto.midx!=tmp.midx}">
                     <div class="col-xl-3 col-md-6 mb-4">
                         <a href="javascript:search_add_project('${tmp.memail }','${tmp.mid}')" style="text-decoration:none;">
                        <div class="card border-left-primary shadow h-100 py-2">
                           <div class="card-body">
                              <div class="row no-gutters align-items-center">
                                 <div class="col mr-2" style="height: 8rem">
      
                                    <!-- 타이틀수정 -->
                                    <div 
                                       style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 11.5rem; padding-top: 0px; padding: 0rem; font-size: 0.85rem"
                                       class="text-xs font-weight-bold text-primary text-uppercase mb-1">&nbsp;&nbsp;&nbsp;${tmp.mid }</div>
                                    
                                    <div
                                       style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 11rem; padding: 0.75rem; font-size: 0.75rem"
                                       class="h5 mb-0 font-weight-bold text-gray-800">Name ${tmp.mname }</div>
                                          
                                    <div
                                       style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 15rem; padding: 0.75rem; font-size: 0.75rem"
                                       title="${tmp.memail }"
                                       class="h5 mb-0 font-weight-bold text-gray-800">E-mail ${tmp.memail }</div>
      
                                    <div
                                       style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 11rem; padding: 0.75rem; font-size: 0.75rem"
                                       class="h5 mb-0 font-weight-bold text-gray-800">Tel ${tmp.mtel }</div>
                                 </div>
      
      
                                 <div class="col-auto"></div>
                              </div>
                           </div>
                        </div>
                       </a>
                     </div>
                   </c:if>
                  </c:forEach>
                 </div>
                 </div>
            </div>
            </div>
            
            <div id="schedule" class="d-none">
                 <div class="container-fluid">
                 <hr>
                 <h2>일정 검색 결과</h2>
                 <div id="tableLayer" style="overflow-x:hidden; overflow-y:scroll; height:200px;">
                 <div class="row">
               
                 <c:forEach var="tmp" items="${schedulelist}">              
                     <div class="col-xl-3 col-md-6 mb-4">
                         <a href="javascript:search_sch_info('${tmp.pidx}','${tmp.schedule_subject}','${tmp.schedule_content}','${tmp.schedule_resp}','${tmp.d_day}','${tmp.schedule_complete}')" style="text-decoration:none;">
                        <div class="card border-left-primary shadow h-100 py-2">
                           <div class="card-body">
                              <div class="row no-gutters align-items-center">
                                 <div class="col mr-2" style="height: 8rem">
      
                                    <!-- 타이틀수정 -->
                                    <div 
                                       style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 11.5rem; padding-top: 0px; padding: 0rem; font-size: 0.85rem"
                                       class="text-xs font-weight-bold text-primary text-uppercase mb-1">&nbsp;&nbsp;&nbsp;${tmp.schedule_subject }</div>
                                    
                                    <div
                                       style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 11rem; padding: 0.75rem; font-size: 0.75rem"
                                       class="h5 mb-0 font-weight-bold text-gray-800">Name ${tmp.schedule_content }</div>
                                          
                                    <div
                                       style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 15rem; padding: 0.75rem; font-size: 0.75rem"
                                       class="h5 mb-0 font-weight-bold text-gray-800">마감일  ${tmp.schedule_date }</div>
     
                                 </div>
      
      
                                 <div class="col-auto"></div>
                              </div>
                           </div>
                        </div>
                       </a>
                     </div>                 
                  </c:forEach>
                 </div>
                 </div>
            </div>
           </div>
  <!-- 여기까지 -->

         <%@include file="../tib/footerTib.jsp" %>
      </div>
      </div>
   </div>
   </div>
</body>
<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="resources/vendor/jquery/jquery.min.js"></script>
<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="resources/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="resources/vendor/chart.js/Chart.min.js"></script>

<!-- Page level custom scripts -->
<script src="resources/js/demo/chart-area-demo.js"></script>
<script src="resources/js/demo/chart-pie-demo.js"></script>
<script type="text/javascript">
   $(".border-left-primary ").ready(function() {
      $(".border-left-primary ").hover(function() {
         $(this).css('background-color', ' #e3e6f0');

      }, function() {
         $(this).css('background-color', '#fff');

      });
   });
</script>
</html>