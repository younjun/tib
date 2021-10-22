 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>tib - Together is Better</title>            

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">   

  <!-- Custom styles for this template -->
  <link href="css/scrolling-nav.css" rel="stylesheet">
  <link href="css/faq.css" rel="stylesheet">
<style>
::-webkit-scrollbar{width: 16px;}
::-webkit-scrollbar-track {background-color:#f1f1f1;}
::-webkit-scrollbar-thumb {background-color:#7dc3c5;border-radius: 10px;}
::-webkit-scrollbar-thumb:hover {background: #555;}
::-webkit-scrollbar-button:start:decrement,::-webkit-scrollbar-button:end:increment {
width:16px;height:16px;background:#f1f1f1;} 

#tib_main_logo{
width:150px;height:60px;
}
#mainHeader{
background-color: #7dc3c5 !important;
}
</style>
</head>
<script src="https://kit.fontawesome.com/5d936cace7.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="js/httpRequest.js"></script>
<script>
window.onload = function() {
    document.getElementById('pencilBtn').onclick = function() {
        document.getElementById('faqUpdate').submit();
        return false;
    };
};
function faqDel(fidx){
   var result = window.confirm('삭제 하시겠습니까?');
   if(result){
      location.href='faqDel.do?fidx='+fidx;
   }
}
</script>
<body id="page-top">

  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
    <div class="container">
      <a class="navbar-brand js-scroll-trigger" href="#page-top"><img id="tib_main_logo" src="img/mainlogo.png"></a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#about">About</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#services">Services</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#contact">Contact</a>
          </li>
          <c:if test="${empty sessionScope.user }">
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="login.do">Login</a> <!-- 로그인 후 tib 페이지로 이동 -->
          </li>
          </c:if>
          <c:if test="${!empty sessionScope.user }">
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="logout.do">Logout</a> <!-- 로그인 후 tib 페이지로 이동 -->
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="indexTib.do">tib</a> <!-- 로그인 후 tib 페이지로 이동 -->
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="indexAdmin.do">tib(관리자)</a> <!-- 로그인 후 tib 페이지로 이동 -->
          </li>
          </c:if>
        </ul>
      </div>
    </div>
  </nav>

  <header class="bg-primary text-white" id="mainHeader">
    <div class="container text-center">
      <h1>Together is Better</h1>
      <p class="lead">Coming together is a beginning<br>Keeping together is progress<br>Working together is success</p>
    </div>
  </header>

  <section id="about" style="padding: 10%">
    <div class="container">
      <div class="row">
        <div class="col-lg-4 mx-auto">
          <h2>공과 사를 분리해주는<BR> <strong>학생</strong>을위한 메신져</h2>
          <p class="lead">This is a great place to talk about your webpage. This template is purposefully unstyled so you can use it as a boilerplate or starting point for you own landing page designs! This template features:</p>
          <ul>
            <li>Clickable nav links that smooth scroll to page sections</li>
            <li>Responsive behavior when clicking nav links perfect for a one page website</li>
            <li>Bootstrap's scrollspy feature which highlights which section of the page you're on in the navbar</li>
            <li>Minimal custom CSS so you are free to explore your own unique design options</li>
          </ul>
        </div>
         <div class="col-lg-4 mx-auto">
       <img src="img/chat.png" alt="메인이미지" height="80%">
        </div>
      </div>
    </div>
  </section>

  <section id="services" class="bg-light" style="padding: 6%;">
    <div class="container">
      <div class="row">
         <div class="col-lg-12 mx-auto">
            <iframe src="mainIndexAdmin2.do" style="display:block; width:60vw; height: 80vh; border: none;" ></iframe>
         </div>
      </div>
    </div>
  </section>

  <section id="contact" style="padding:6%">
    <div class="container">
      <div class="row">
        <div class="col-lg-8 mx-auto">
           <h3>  (FAQ)자주묻는 질문</h3> 
            <div class="FAQ">
               <ul class="FAQlist">
                  <c:forEach var="dto" items="${lists }">
                     <li>
                        <form name="faqUpdate" id="faqUpdate" action="faqUpdate.do">
                          <input type="hidden" name="fidx" value="${dto.fidx }">
                          <label class="FAQtitle">
                          <input class="form-control bg-light border-0 small" type="text" name="fsubject" value="${dto.fsubject }">
                          </label>
                            <div class="FAQdesc">
                               <div><textarea class="form-control bg-light border-0 small" name="fcontent" rows="5" cols="10">${dto.fcontent }</textarea></div>
                            </div>
                            
                            
                            <div class="btn btn-success btn-icon-split">
                             <i class="fas fa-pencil-alt" id="pencilBtn"></i></div>
                             <input type="button" value="삭제하기" onclick="faqDel('${dto.fidx}');">
                         </form>
                      </li>
                      <br><br>
                   </c:forEach>
                   <hr>
                   <li>
                         <h3>질문 추가하기</h3>
                   </li>
                    <li>
                        <form name="addFaq" action="addFaq.do">
                          <label class="FAQtitle">
                          <input class="form-control bg-light border-0 small" type="text" name="fsubject">
                          </label>
                            <div class="FAQdesc">
                               <div><textarea class="form-control bg-light border-0 small" name="fcontent" rows="5" cols="10"></textarea></div>
                            </div>
                           <input type="submit" value="추가하기">
                         </form>
                      </li>
               <!-- 개행 -->
       <h2>카카오톡으로 문의하기 </h2><!-- ul추가안하고 li로만추가함 -->
           <li>
            <input type="radio" name="list" class="FAQlist-checkbox" id="list-inputKAKAO" checked/>
            <label for="list-inputKAKAO" class="FAQtitle">
               <strong>Tib</strong>카카오톡 플러스로 1:1 문의하기
            </label>
               <div class="FAQdesc">
                  <div>
                        업무시간은 <strong>09:00~18:00시</strong> 까지이며 <br>점심시간<strong>12:00~13:00</strong>에는
                        업무 양이 많아 원할한 상담이 어려울수 있습니다. <br> 
                        <a href="http://pf.kakao.com/_CxoBgxb/chat"> 
                           <img src="img/FAQ/kakaotalk.png" alt="메인이미지" width="30" height="30">
                           카카오톡으로 문의하기 
                        </a>
                  </div>
               </div>
            </li>
             <li>
                <input type="radio" name="list" class="FAQlist-checkbox" id="list-inputKAKAOQR" checked />
                       <label for="list-inputKAKAOQR" class="FAQtitle"><strong>Tib</strong>고객센터 모바일 전용 QR코드</label>
                       <div class="FAQdesc">
                         <div> <img src="img/FAQ/chatingQRcode.png" width="150" height="150"> <br> </div>
                       </div>
              </li>
          </ul>
       </div>
     </div>
   </div>
 </div>
</section>


  <!-- Footer -->
  <footer class="py-5 bg-dark">
    <div class="container">
      <p class="m-0 text-center text-white">Copyright &copy; Your Website 2020</p>
    </div>
    <!-- /.container -->
  </footer>

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Plugin JavaScript -->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom JavaScript for this theme -->
  <script src="js/scrolling-nav.js"></script>

</body>
</html>