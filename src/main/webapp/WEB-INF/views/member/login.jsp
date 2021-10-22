<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">
<head>
<script src="//code.jquery.com/jquery-1.12.4.min.js"></script>
<title>tib - Together is Better</title>
</head>
<script>
$(document).ready(function(){
	var remId = getCookie("remId");
	if(remId!=undefined){
		$("input[name='userid']").val(remId);
		$("#customCheck").prop("checked",true);
	}
	
	$("#customCheck").change(function(){
		if($("#customCheck").is(":checked")){
			remId = $("input[name='userid']").val();
			setCookie("remId",remId,7);
		}else{
			deleteCookie("remId");
		}
	});
	$("input[name='userid']").keyup(function(){
		if($("#customCheck").is(":checked")){
			remId = $("input[name='userid']").val();
			setCookie("remId",remId,7);
		}
	});
});
function setCookie(cookieName,value,exdays){
	$.cookie(cookieName,value,exdays);
}
function deleteCookie(cookieName){
	$.removeCookie(cookieName);
}
function getCookie(cookieName){
	return $.cookie(cookieName);

}
</script>
<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>SB Admin 2 - Login</title>

  <!-- Custom fonts for this template-->
  <link href="resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

  <div class="container">

    <!-- Outer Row -->
    <div class="row justify-content-center">

      <div class="col-xl-10 col-lg-12 col-md-9">

        <div class="card o-hidden border-0 shadow-lg my-5">
          <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
              <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
              <div class="col-lg-6">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
                  </div>
                  <form class="user" action="login.do" method="POST">
                    <div class="form-group">
                      <input type="text" name="userid" class="form-control form-control-user" id="exampleInputId" aria-describedby="emailHelp" placeholder="Enter Id...">
                    </div>
                    <div class="form-group">
                      <input type="password" name="userpwd" class="form-control form-control-user" id="exampleInputPassword" placeholder="Password">
                    </div>
                    <div class="form-group">
                      <div class="custom-control custom-checkbox small">
                        <input type="checkbox" class="custom-control-input" id="customCheck">
                        <label class="custom-control-label" for="customCheck" id="customCheckLabel">Remember Me</label>
                      </div>
                    </div>
                    <input type="submit" class="btn btn-primary btn-user btn-block" value="login">
                    <hr>
                  </form>
                  <div class="text-center">
                    <a class="small" href="idSearch.do">Forgot Id?</a>
                  </div>
                  <div class="text-center">
                    <a class="small" href="pwdSearch.do">Forgot Password?</a>
                  </div>
                  <div class="text-center">
                    <a class="small" href="memberJoin.do">Create an Account!</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </div>

  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="resources/vendor/jquery/jquery.min.js"></script>
  <script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="resources/js/sb-admin-2.min.js"></script>

<script src="plugin/jquery.cookie.js"></script>
</body>

</html>
