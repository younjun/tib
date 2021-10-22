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

<script>


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
                  <!-- SHOW영역 -->
                  <div class="card-body">
                     <div class="table-responsive" style="overflow-x: hidden">
                        <div id="dataTable_wrapper"
                           class="dataTables_wrapper dt-bootstrap4">
                            <div class="row">
                              <div class="col-sm-12 col-md-10">
                                 <div class="dataTables_length" id="dataTable_length">
                                  
                                 </div>
                              </div>
                              <!-- 찾기 영역 -->
                            <div class="col-sm-12 col-md-2" style=" justify-content:space-around ;">
                                 <div id="dataTable_filter" class="dataTables_filter">
                                    <label>찾기: <input type="search"
                                       class="form-control form-control-sm" placeholder=""
                                       aria-controls="dataTable"></label>
                                 </div>
                              </div>

								<!-- modal 구동 버튼 (trigger) -->

								
                              <!-- 테이블영역 -->
                              <div class="row">
                                 
                                   <table frame=void class="rwd-table" style=" width: 58rem;margin-left: 10rem;border-collapse: separatebo;" >                                 
                                          <tr role="row" >
                                             <th class="diva2">회원번호</th>
                                             <th>회원이름</th>
                                             <th>ID</th>
                                             <th>학교코드</th>
                                             <th>인증여부</th>
                                     	 </tr>
                                      
                                       
                                          <c:forEach var="member" items="${memberList}">

                                            <tr role="row" style="width:20px; border-bottom: solid 1px #e3e6f0; border-collapse: separate;">                                           	
                                                <td data-th="회원번호"><div class="diva">${member.midx}<span id="${member.midx}"></span></div></div></td>
                                                <td data-th="회원이름"><div class="diva"><a href="javascript:memberInfo('${member.mid}');">${member.mname}</a></div></td>
                                                <td data-th="ID"><div class="diva">${member.mid}</div></td>
                                                <td data-th="학교코드"><div class="diva"><a href="javascript:univInfo(${member.univcode})">${member.univcode}</a></div></td>                  
												<td data-th="인증여부"><div class="diva">
													<c:if test="${member.certification!='y'}">
	                                                		<a href="javascript:confirmModal1('${member.mname}',${member.midx})">N</a>
	                                                </c:if>
	                                                <c:if test="${member.certification=='y'}">Y</c:if>												
												</div></td>                                                                           
                                             </tr>
                                          </c:forEach>
                                    </table>
     						 <div class="row">
                                  <div class="col-sm-12 col-md-7">
                                     <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
                                        <ul class="pagination">
                                          <c:if test="${!empty memberList }"> ${paging }</c:if>
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
</html>