<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>CodePen - Touring Japan</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"> 
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0"/>
<link rel="stylesheet" href="css/index.css">

</head>
<body>
<!-- partial:index.partial.html -->
<nav style="top:56%;">
   <div>
      <button id="prev">←</button>
      <button id="next">→</button>
   </div>
   <div id="pagenumber">
      <span id="pagecurrent">1</span>
      <span id="pagetotal">∕ 1</span>
   </div>
</nav>

<main>
   <article class="tokyo active">
      <div class="photo">
       <img src="/venti5/tib_img/2/${slists.get(0).simg}" style="position: absolute; top:0; left: 0; width: 100%; height: 100%;">
     </div>
      <div class="text">
        <h1>${slists.get(0).ssubject }</h1>
        <p>${slists.get(0).scontent }</p>
      </div>
   </article>
   
    <article class="osaka">
      <div class="photo">
        <img src="/venti5/tib_img/3/${slists.get(1).simg}" style="position: absolute; top:0; left: 0; width: 100%; height: 100%;">
     </div>
      <div class="text">
        <h1>${slists.get(1).ssubject }</h1>
        <p>${slists.get(1).scontent }</p>
      </div>
   </article>
   
    <article class="kyoto">
      <div class="photo">
        <img src="/venti5/tib_img/4/${slists.get(2).simg}" style="position: absolute; top:0; left: 0; width: 100%; height: 100%;">
     </div>
      <div class="text">
        <h1>${slists.get(2).ssubject }</h1>
        <p>${slists.get(2).scontent }</p>
      </div>
   </article>
</main>
<!-- partial -->
 <script src="js/index.js"></script>
</body>
</html>