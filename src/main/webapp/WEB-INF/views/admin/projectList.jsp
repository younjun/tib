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
<link href="css/admin.css" rel="stylesheet" type="text/css">
<link href="resources/vendor/fontawesome-free/css/all.min.css"
   rel="stylesheet" type="text/css">
<link
   href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
   rel="stylesheet">
<title>tib - Together is Better</title>
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">

<!-- <link href="css/admin.css" rel="stylesheet"> -->


<style>
#diva {
   width: 4rem;
   overflow: hidden;
   word-break: break-all;
}
</style>
</head> 
<c:set var="user" value="${sessionScope.user}"></c:set>
<body id="page-top">
   <div id="wrapper">
      <%@include file="adminNavTib.jsp"%>
      <!-- side nav -->
      <div id="content-wrapper" class="d-flex flex-column">
         <div id="content">
            <%@include file="../tib/toolBarTib.jsp"%>
            <!-- top search bar area -->
            <div id="container-fluid">
               <!--  여기부터 작업 -->
              <div class="card shadow mb-4">
                  <div class="card-header py-3">
                     <h6 class="m-0 font-weight-bold text-primary">프로젝트 정보 확인</h6>

                     <a href="javascript:edit();"
                        class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
                        <i class="fas fa-trash"></i> 파란편집
                     </a>
                     </div>
                  <!-- SHOW영역 -->
                  <div class="card-body">
                     <div class="table-responsive" style="overflow-x: hidden">
                        <div id="dataTable_wrapper"
                           class="dataTables_wrapper dt-bootstrap4">
                           <div class="row">
                             <div class="col-sm-12 col-md-6">
                                 <div class="dataTables_length" id="dataTable_length">
                                  
                                 </div>
                              </div>
                              <!-- 찾기 영역 -->
                            <div class="col-sm-12 col-md-3 text-right" style=" justify-content:space-around ;">
                                 <div id="dataTable_filter" class="dataTables_filter">
                                    <select class="form-control" onchange="select_option()">
                                       <option>공개방</option>
                                       <option>비공개 방</option>
                                    </select>
                                 </div>
                              </div>

                              <!-- 테이블영역 -->
                              <div class="row">
                                 <div class="col-sm-12">
                                   <table frame=void class="rwd-table" style=" width: 60rem;margin-left: 10rem;border-collapse: separatebo;" >  
                                       <thead>
                                          <tr role="row">
                                             <th>상세정보</th>
                                             <th>프로젝트 명</th>
                                             <th>프로젝트 코드</th>
                                             <th>제한인원</th>
                                             <th>공개여부</th>
                                             <th>호스트<th>
                                                                                 
                                       </thead>
                                    
                                       <tbody>
                                      
                                        <c:forEach var="project" items="${projectList}">
                                           <tr role="row" style="width:20px; border-bottom: solid 1px #e3e6f0; border-collapse: separate;">                                               
                                                <td data-th="상세정보"><div class="diva"><a href="javascript:showProjectInfo(${project.pidx},'${project.pcode}');">i</a></div></td>
                                                <td data-th="프로젝트번호"><div class="diva">${project.pname}</div></td>
                                                <td data-th="프로젝트명"><div class="diva">${project.pcode}</div></td>
                                                <td data-th="제한인원"><div class="diva">${project.plimit}</div></td>
                                          <td data-th="공개여부"><div class="diva">  ${project.plock==1?'비공개':'공개'} </div></td>
                                          <td data-th="생성여부"><div class="diva">${project.phost}</div></td>
                                 
                                         </tr>
                                          </c:forEach>
                                       </tbody>                                    
                                    </table>
                                  <div class="row">
                                  <div class="col-sm-12 col-md-7">
                                     <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
                                        <ul class="pagination">
                                          <c:if test="${!empty projectList }"> ${paging }</c:if>
                                         </ul>
                                     </div>
                                  </div>
                               </div>  
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <%@include file="../tib/footerTib.jsp"%>
      </div>
   </div>
   
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


</html>