<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
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
<script>

function pwdCheck(){
	var pwd1=document.getElementById('mpwd1');
	var pwd2=document.getElementById('mpwd2');
	var pwdCheck=document.getElementById('pwdCheck');
	
	if(pwd1.value!=pwd2.value){
		pwdCheck.innerHTML='비밀번호가 일치 하지 않습니다.';
		pwdCheck.style.color='red';
		return false;
	}else if(pwd1.value==pwd2.value){
		pwdCheck.innerHTML='비밀번호가 일치합니다.';
		pwdCheck.style.color='blue';
		return true;
	}
}

</script>
<c:set var="user" value="${sessionScope.user}"></c:set>
<body id="page-top">
	<div id="wrapper">
		<%@include file="../tib/navTib.jsp"%>		<!-- side nav -->
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
			<%@include file="../tib/toolBarTib.jsp" %> <!-- top search bar area -->
				<div id="container-fluid">
					<form id="profile" action="profile.do" method="POST" onsubmit="return pwdCheck();">
						<div>비밀번호 변경</div>
						<div><input type="text" name="mname" value="${user.mname }" readonly="readonly"></div>
						<div><input type="text" name="mid" value="${user.mid }" readonly="readonly"></div>
						<div><input type="password" id="mpwd1" name="mpwd" placeholder="변경할 비밀번호" required="required"></div>
						<div><input type="password" id="mpwd2" name="mpwd2" placeholder="변경할 비밀번호 확인" required="required" ><span id="pwdCheck"></span></div>
					<div>
						<input type="submit" value="변경" >
					</div>
					</form>
				</div>
				</div>
			</div>
			
		</div>
</body>
<%@include file="../tib/footerTib.jsp" %>
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