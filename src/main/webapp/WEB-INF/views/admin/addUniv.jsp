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

</head>

<body id="page-top">
   <div id="wrapper">
      <%@include file="../admin/adminNavTib.jsp"%>      <!-- side nav -->
      <div id="content-wrapper" class="d-flex flex-column">
         <div id="content">
         <%@include file="../tib/toolBarTib.jsp" %> <!-- top search bar area -->
            <div id="container-fluid">
             <!--  여기부터 작업 -->
              <form name="addUniv" action="addUniv.do" method="post">
					 <div class="row justify-content-center" style=" display:flex; align-items:center;  float:none; margin:0 auto;">
					   <div class="col-xl-6 col-lg-8 col-md-9">
					      <div class="card o-hidden border-0 shadow-lg my-3">
					         <div class="card-body p-0">
					            <!-- Nested Row within Card Body -->
					            <div class="row">
					            <div class="col-lg-3"></div>
					            <div class="col-lg-6">
					            <div class="p-5">
					            <div class="text-center">
					    
					                  <div class="form-group" style="text-align: left;">
					                  	<p>학교</p>
					                  	<input type="text" name="uname" class="form-control">
					                  </div>
					                  <div class="form-group" style="text-align: left;">
					                   	<p>학교 메일 형식</p>
					                   	<input type="text" name="uemail" class="form-control" >
					                  </div>
					                  <div class="form-group" style="text-align: left;">
					                   	<p>계약일</p>
					                   	<input type="date" name="ustartdate" class="form-control" ><br>
					 					<p>계약만료일</p>
					 					<input type="date" name="uenddate" class="form-control" >                 
					                  </div>
					                  
					                  
					                  <div>  <input type="submit" class="btn btn-primary btn-user btn-block" value="학교추가"> 
					                  <div style="text-align: left;"><a href="indexAdmin.do">menu</a></div> </div>
					            </div>
					             </div>
					            </div>
					            </div>
					             </div>
					      </div>
					    </div>
					</div>
					
					</form>
			 <!-- 여기까지 컨텐츠 -->
            </div>
         </div>
         <%@include file="../tib/footerTib.jsp" %>
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