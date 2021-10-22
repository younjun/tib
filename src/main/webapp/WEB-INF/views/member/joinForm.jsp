<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
<script src="//code.jquery.com/jquery-1.12.4.min.js"></script>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>tib - Together is Better</title>

  <!-- Custom fonts for this template-->
  <link href="resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="resources/css/sb-admin-2.min.css" rel="stylesheet">

<!-- 회원가입 관련 자바스크립트 -->
<script>
$(function(){
   $("#alert-success").hide();
   $("#alert-fail").hide();
   $("input[name='mpwd2']").keyup(function(){
      var pwd1 = $("#exampleInputPassword").val();
      var pwd2 = $("#exampleRepeatPassword").val();
      if(pwd1!=""||pwd2!=""){
         if(pwd1==pwd2){
            $("#alert-success").show();
            $("#alert-fail").hide();
            $("#submit").removeAttr("disabled");//버튼 활성화
         }else if(pwd1!=pwd2){
            $("#alert-success").hide();
            $("#alert-fail").show();
            $("#submit").attr("disabled","disabled");//버튼  비활성화
         }
      }
   });
});
function idCheck(){
    var userid=document.memberJoin.mid.value;
   var param='userid='+userid;
   sendRequest('idCheck.do',param,idCheckResult,'POST');
}
function idCheckResult(){
   if(XHR.readyState==4){
      if(XHR.status==200){
         var data=XHR.responseText;
         var spanNode=document.all.idCheckMsg;
         spanNode.style.color='red';
         data.toString();
         if(data==0){
        	 spanNode.style.color='red';
        	 spanNode.innerHTML='중복된 id 입니다.';
        	 return false;
         }else{
        	 spanNode.style.color='blue';
        	 spanNode.innerHTML='사용가능한 id 입니다.';
        	 return true;
         }
      }
   }
   
}

function univ(){
   var userUniv = document.getElementById('useruniv');
   var selectValue = userUniv.options[userUniv.selectedIndex].value;
   
   var divNode = document.getElementById('univEmail');
   var inputNode = document.createElement('input');
   inputNode.setAttribute('type','text');
   inputNode.setAttribute('name','uemail');
   inputNode.setAttribute('class','form-control form-control-user');
   inputNode.setAttribute('value',selectValue);
   inputNode.setAttribute('readonly','readonly');
   var childNode =  divNode.firstChild;
   if(childNode){
      divNode.removeChild(childNode);
   }
   
   divNode.appendChild(inputNode);
}
</script>

</head>

<body class="bg-gradient-primary">

  <div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5">
      <div class="card-body p-0">
        <!-- Nested Row within Card Body -->
        <div class="row">
          <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
          <div class="col-lg-7">
            <div class="p-5">
              <div class="text-center">
                <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
              </div>
              <form class="user" name="memberJoin" action="memberJoin.do" method="POST" onsubmit="return idCheckResult();">
              	<input type="hidden" id="univcode">
                <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <input maxlength="30" type="text" name="mid" class="form-control form-control-user" id="exampleFirstName" onkeyup="idCheck()" placeholder="Id" oninvalid="this.setCustomValidity('아이디를 입력해 주세요~')" oninput="setCustomValidity('')">
                  <!-- 추가 부분 위에 oninvalid부터 -->  <span id="idCheckMsg"></span>
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="mname" class="form-control form-control-user" id="exampleLastName" placeholder="Name">
                  </div>
                </div>
                  <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <input type="password" name="mpwd" class="form-control form-control-user" id="exampleInputPassword" placeholder="Password"
                    maxlength="12" oninvalid="this.setCustomValidity('비밀번호를 입력해 주세요~')" oninput="setCustomValidity('')">
                  </div>
                  <div class="col-sm-6">
                    <input type="password" name="mpwd2" class="form-control form-control-user" id="exampleRepeatPassword" placeholder="Repeat Password"
                    maxlength="12" oninvalid="this.setCustomValidity('비밀번호확인을 입력해 주세요~')" oninput="setCustomValidity('')">
                  </div>
                  <span id="alert-success">비밀번호가 일치합니다.</span>
                  <span id="alert-fail">비밀번호가 일치하지 않습니다.</span>
                </div>
                <!-- 
                <div class="form-group">
                  <input type="email" name="memail" class="form-control form-control-user" id="exampleInputEmail" placeholder="Email Address">
                </div>
                 -->
                 <div class="form-group">
                  <input type="text" name="mtel" class="form-control form-control-user" placeholder="Tel">
                </div>
                 <div class="form-group">
                 <!--  <input type="text" class="form-control form-control-user dropdown-toggle" data-toggle="dropdown"  placeholder="대학교 드랍다운 추가"> --> 
                  <select class="form-control" id="useruniv" onchange="univ()" >
                  		<option value="">학교를 선택해주세요</option>
                     <c:forEach var="tmpuniv" items="${univs}">
                        <option value="${tmpuniv.uemail}">${tmpuniv.uname}</option>
                     </c:forEach>
                  </select>
                  </div>
                  <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                     <input type="text" name="memail" class="form-control form-control-user" placeholder="Email" maxlength="12" required>
                  </div>
                  <div class="col-sm-6">
                     <div class="form-group" id="univEmail"></div>
                  </div>
                </div>
                  
            
                <input type="submit" id="submit" class="btn btn-primary btn-user btn-block" disabled="disabled">
                  Register Account
              </form>
              <hr>
              <div class="text-center">
                <a class="small" href="pwdSearch.do">Forgot Password?</a>
              </div>
              <div class="text-center">
                <a class="small" href="login.do">Already have an account? Login!</a>
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

  <!-- 여기부터 추가 -->
  <script type="text/javascript" src="js/httpRequest.js"></script>
  <script src="http://code.jquery.com/jquery-latest.js"></script>
</body>

</html>