<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link href="css/chat.css" rel="stylesheet">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="js/httpRequest.js"></script>
<script>
function enterPublic1(pidx){
   var result = confirm('공개 프로젝트에 참가하시겠습니까?');
   if(result){
      var param = 'pidx='+pidx;
      sendRequest('enterPublicProject.do',param,enterPublicProjectCallback,'GET');
   }else{
      location.href="indexTib.do";
   }
}
function enterPublicProjectCallback(){
	   if(XHR.readyState==4){
	      if(XHR.status==200){
	         var data = XHR.responseText;
	         data = eval('('+data+')');
	         window.alert(data.msg);
	         location.reload();
	      }
	   }
	}
</script>
</head>
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
<c:set var="user" value="${sessionScope.user}"></c:set>
<body id="page-top">
   <div id="wrapper">
      <%@include file="../tib/navTib.jsp"%>
      <!-- side nav -->
      <div id="content-wrapper" class="d-flex flex-column">
         <div id="content">
            <%@include file="../tib/toolBarTib.jsp"%>
            <!-- top search bar area -->
            <div id="container-fluid">
               <!--  여기부터 작업 -->
               <div class="container-fluid">
                  <div
                     class="d-sm-flex align-items-center justify-content-between mb-4">
                     <h1 class="h3 mb-0 text-gray-800">공개 프로젝트</h1>
                  </div>
                  <div id="tableLayer" style="overflow-x:hidden; overflow-y:scroll; height:800px;">
                  <div class="row">


         <!-- for------------------------------------------------------------------------------------ -->
            <c:forEach var="tmp" items="${sessionScope.publicProject }">
               <c:if test="${tmp.plock==0 }">
                     <div class="col-xl-3 col-md-6 mb-4" onclick="enterPublic1('${tmp.pidx}')">
                        <div class="card border-left-primary shadow h-100 py-2">
                           <div class="card-body">
                              <div class="row no-gutters align-items-center">
                                 <div class="col mr-2" style="height: 8rem">

                                    <!-- 타이틀수정 -->
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
                                       class="h5 mb-0 font-weight-bold text-gray-800">프로젝트 생성 ${tmp.phost }</div>

                                    <div
                                       style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 11rem; padding: 0.75rem; font-size: 0.75rem"
                                       class="h5 mb-0 font-weight-bold text-gray-800">제한 인원 ${tmp.pcount}/${tmp.plimit }</div>
                                 </div>


                                 <div class="col-auto"></div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </c:if>
         </c:forEach>
      <!-- /for>  여기까지가 forEach 해줘야 반복함 ↓아래 건드리면 div깨짐주의 -->


   
   </div>
   </div>
   </div>
   </div>
   </div>
   </div>
   </div>


   <%@include file="../tib/footerTib.jsp"%>


</body>
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