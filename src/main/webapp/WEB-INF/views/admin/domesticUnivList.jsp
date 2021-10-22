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
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.univContent{
font-size:12px;
}
</style>
<body>
<!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <a href="indexAdmin.do"><img src="img/mainlogo2.png" style="width:20%; height:20%;"></a>
<div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">전국 대학 리스트</h6>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                   <tr>
					<th>학교종류</th>
					<th>시/도</th>
					<th>학교명</th>
					<th>학교명(영문)</th>
					<th>본/분교</th>
					<th>학교상태</th>
					<th>설립</th>
					<th>우편번호</th>
					<th>주소</th>
					<th>전화번호</th>
					<th>팩스번호</th>
					<th>홈페이지</th>
				   </tr>
                  </thead>

                  <tbody>
			<c:forEach var="tmp" items="${univs }">
					<tr>
						<td class="univContent">${tmp.utype }</td>
						<td class="univContent">${tmp.local }</td>
						<td class="univContent">${tmp.name }</td>
						<td class="univContent">${tmp.nameEn }</td>
						<td class="univContent">${tmp.campus }</td>
						<td class="univContent">${tmp.state }</td>
						<td class="univContent">${tmp.state2 }</td>
						<td class="univContent">${tmp.zip }</td>
						<td class="univContent">${tmp.addr }</td>
						<td class="univContent">${tmp.tel }</td>
						<td class="univContent">${tmp.fax }</td>
						<td class="univContent">${tmp.web }</td>
					</tr>
			</c:forEach>		
                  </tbody>
                </table>
                <div class="row">
                   <div class="col-sm-12 col-md-7">
                      <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
                         <ul class="pagination">
                           <c:if test="${!empty univs }"> ${page }</c:if>
                          </ul>
                      </div>
                   </div>
                </div>                
              </div>
            </div>
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
