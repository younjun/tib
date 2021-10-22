<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>tib - Together is Better</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"> 
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0"/>
<link rel="stylesheet" href="css/index.css">
<script>
function edit_service_content(subject,content){
   subjecNode = document.getElementById(subject);
   contentNode = document.getElementById(content);
   subjecNode.removeChild(subjecNode.firstChild);
   contentNode.removeChild(contentNode.firstChild);
   subjecNode.firstChild.removeAttribute('style');
   contentNode.firstChild.removeAttribute('style');
   
}
</script>
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
   <form name="servicesUpdate"  enctype="multipart/form-data" action="servicesUpdate.do" method="post">
         <input type="file" name="imgUpload">
         <div class="photo">
            <img src="/venti5/tib_img/2/${slists.get(0).simg}" style="position: absolute; top:0; left: 0; width: 100%; height: 100%;">
         </div>
         <div class="text">
            <input type="hidden" name="sidx" value="${slists.get(0).sidx }">
            <h1><input type="text" name="ssubject" value="${slists.get(0).ssubject }"></h1>
            <p><textarea name="scontent" rows="7" cols="40">${slists.get(0).scontent }</textarea></p>
                  
            <div class="btn btn-success btn-icon-split">
                    <i class="fas fa-pencil-alt" id="pencilBtn1"></i></div> 
            <input type="submit" value="수정하기">
         </div>
   </form>
   </article>

   <article class="osaka">
   <form name="servicesUpdate"   enctype="multipart/form-data" action="servicesUpdate.do" method="post">
         <input type="file" name="imgUpload">
         <div class="photo">
            <img src="/venti5/tib_img/3/${slists.get(1).simg}" style="position: absolute; top:0; left: 0; width: 100%; height: 100%;">
         </div>
         <div class="text">
            <input type="hidden" name="sidx" value="${slists.get(1).sidx }">
            <h1><input type="text" name="ssubject" value="${slists.get(1).ssubject }"></h1>
            <p><textarea name="scontent" rows="7" cols="40">${slists.get(1).scontent }</textarea></p>
                  
            <div class="btn btn-success btn-icon-split">
                    <i class="fas fa-pencil-alt" id="pencilBtn1"></i></div> 
            <input type="submit" value="수정하기">
         </div>
      </form>
   </article>

   <article class="kyoto">
   <form name="servicesUpdate"  enctype="multipart/form-data" action="servicesUpdate.do" method="post">
         <input type="file" name="imgUpload">
         <div class="photo">
            <img src="/venti5/tib_img/4/${slists.get(2).simg}" style="position: absolute; top:0; left: 0; width: 100%; height: 100%;">
         </div>
         <div class="text">
            <input type="hidden" name="sidx" value="${slists.get(2).sidx }">
            <h1><input type="text" name="ssubject" value="${slists.get(2).ssubject }"></h1>
            <p><textarea name="scontent" rows="7" cols="40">${slists.get(2).scontent }</textarea></p>
                  
            <div class="btn btn-success btn-icon-split">
                    <i class="fas fa-pencil-alt" id="pencilBtn1"></i></div> 
            <input type="submit" value="수정하기">
         </div>
     </form>
   </article>
</main>
<!-- partial -->
 <script src="js/index.js"></script>
</body>
</html>