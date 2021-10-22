<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="//code.jquery.com/jquery-1.12.4.min.js"></script>
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
<body>
<c:set var="project" value="${sessionScope.project}"></c:set>
<form name="enterProject" action="enterProject.do" method="post">
<input type="hidden" name="pidx" value="${project.pidx}">
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
    
                  <div class="form-group" style="text-align: left;">방: ${project.pname}</div>
                  <div class="form-group" style="text-align: left;">코드입력: <input type="text" name="pcode" value="${project.pcode}"></div>
                  <div>  <input type="submit" class="btn btn-primary btn-user btn-block" value="참여하기"> 
                  <div style="text-align: left;"><a href="indexTib.do">home</a></div> </div>
            </div>
             </div>
            </div>
            </div>
             </div>
      </div>
    </div>
</div>

</form>
</body>
</html>