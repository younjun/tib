<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>tib - Together is Better</title>
</head>
<body>

<img src="img/mainlogo2.png" style="width:30%; height:30%;">
<h3>안녕하세요, ${param.userId} 님</h3><br>
<p>환영합니다!</p><br>
<p>회원가입이 정상적으로 완료되었습니다.</p><br>
<p>로그인 하시면 tib 서비스를 이용하실 수 있습니다.</p><br>
<a href="index.do">메인 페이지로 이동하기</a>
</body>
</html>