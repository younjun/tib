<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>tib - Together is Better</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(function(){
   $("#alert-success").hide();
   $("#alert-fail").hide();
   $("input").keyup(function(){
      var pwd1 = $("#pwd").val();
      var pwd2 = $("#pwdC").val();
      if(pwd1!=""||pwd2!=""){
         if(pwd1==pwd2){
            $("#alert-success").show();
            $("#alert-fail").hide();
            $("#submit").removeAttr("disabled");//버튼 활성화
         }else{
            $("#alert-success").hide();
            $("#alert-fail").show();
            $("#userPwdC").val()="";
            $("#userPwdC").focus();
            $("#submit").Attr("disabled","disabled");//버튼  비활성화
         }
      }
   });
});
</script>
</head>
<body>
<fieldset>
   <legend>비밀번호 변경</legend>
   <form name="pwdUpdate" action="changePwd.do" method="post">
      <input type="hidden" name="userId" value="${mid }">
      변경할 비밀번호 : <input type="password" id="pwd" name="mpwd"><br>
      변경랗 비밀번호 확인 : <input type="password" id="pwdC" name="mpwdC">
      <span id="alert-success">&#9989;</span>
      <span id="alert-fail">&#10060;</span><br>
      <input type="submit" id="submit" value="변경하기">
   </form>
</fieldset>
</body>
</html>