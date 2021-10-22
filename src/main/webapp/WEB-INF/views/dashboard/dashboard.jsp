<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link href="css/chat.css" rel="stylesheet">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script>
window.onload = function completeStatus(){
   var divList = document.getElementsByTagName('div');
   for(var i =0;i<divList.length; i++){
      var div = divList[i];
      
      if(div.getAttribute('state')=='Y'){
         div.style.textDecoration='line-through';
      }
   }
}
</script>
</head>
<style>
.edit {
   display: none;
}

#diva {
   width: 4rem;
   overflow: hidden;
   word-break: break-all;
}

.bg1 {
   background-color: #EFEFEF;
}

.bg2 {
   background-color: #FFFFFF;
}
</style>
<!--  <script>
window.onload = function completeStatus(){
   var divList = document.getElementsByTagName('div');
   for(var i =0;i<divList.length; i++){
      var div = divList[i];
      
      if(div.getAttribute('state')=='Y'){
         div.style.text-decoration=='line-through';
      }
   }
}
</script>
-->
</head>
<c:set var="user" value="${sessionScope.user}"></c:set>
<body id="page-top">
   <div id="wrapper">
      <%@include file="../tib/navTib.jsp"%>
      <!-- side nav -->
      <div id="content-wrapper" class="d-flex flex-column">
         <div id="content">
            <%@include file="../tib/toolBarTib.jsp"%>
            <!-- top search bar area -->
            <div id="container-fluid">
               <!--  여기부터 작업 -->
               <div class="container-fluid">
                  <div
                     class="d-sm-flex align-items-center justify-content-between mb-4">
                     <h1 class="h3 mb-0 text-gray-800">업무 할당 현황</h1>
                  </div>
                  <div class="row">


         <div style="width: 30%; height: 250px" id="chart-container"></div>
   
         <div style="padding-left: 35px">
             <canvas id="cvs" width="700%" height="250px">[No canvas support]</canvas> </div>

   
   </div>
   <!-- ----------------------------------------------------------------- -->
   <div class="row">
   <div class="col-xl-4 col-md-6 mb-4" onclick="location.href='#'" >          <!--col-xl 카드 가로 -->
                        <div class="card border-left-primary shadow h-100 py-2" style="top:40px;">
                           <div class="card-body" style="height: 300px">
                              <div class="row no-gutters align-items-center">
                                 <div class="col mr-2" style="height: 15rem; overflow:auto;">   <!-- height:카드 세로 -->

                                    <!-- 타이틀수정 --> <!-- 카드 컬럼 -->
                                    <div 
                                       style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 11.5rem; padding-top: 0px; padding: 0rem; font-size: 0.85rem"
                                       class="text-xs font-weight-bold text-primary text-uppercase mb-1">팀 업무
                                      </div>
                                      
                           <c:forEach items="${cardInfo }" var="tmp">
                                    <div
                                       style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 90%; padding: 0.75rem; font-size: 0.75rem"
                                       state="${tmp.schedule_complete }"
                                       class="h5 mb-0 font-weight-bold text-gray-800">
                                       <a href="javascript:schInfo1(${tmp.schedule_idx})">${tmp.schedule_subject } 기한일정:${tmp.d_day }</a>
                                    </div>
                              </c:forEach>
                              
                                 </div>
                              </div>
                           </div>
                        </div>
   </div>
   <c:forEach items="${sessionScope.memberlist }" var="tmp">
   <div class="col-xl-4 col-md-6 mb-4" onclick="location.href='#'" >          <!--col-xl 카드 가로 -->
                        <div class="card border-left-primary shadow h-100 py-2" style="top:40px;">
                           <div class="card-body" style="height: 300px">
                              <div class="row no-gutters align-items-center">
                                 <div class="col mr-2" style="height: 15rem; overflow:auto;">   <!-- height:카드 세로 -->
                           
                            <div 
                                style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 11.5rem; padding-top: 0px; padding: 0rem; font-size: 0.85rem"
                                class="text-xs font-weight-bold text-primary text-uppercase mb-1"><a href="javascript:getProfileModal('${tmp.mid}')">${tmp.mname } </a>
                             </div>
                       
                           <c:forEach items="${cardMInfo}" var ="schedule">
                                <c:if test="${tmp.mname==schedule.schedule_resp}">                                                  
                                    <div 
                                       style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; width: 90%; padding: 0.75rem; font-size: 0.75rem"
                                       state="${schedule.schedule_complete }"
                                       class="h5 mb-0 font-weight-bold text-gray-800">
                                       <a href="javascript:schInfo1(${schedule.schedule_idx})"> ${schedule.schedule_subject }</a>&nbsp;&nbsp;${schedule.d_day }
                                       </div>
                                                                   
                                 </c:if>
                            </c:forEach>
   
                     </div>
                     </div>
                     </div>
                     </div>
                     </div>
      </c:forEach>
   </div>
   </div>
   <br>
   <%@include file="../tib/footerTib.jsp"%>
</div>
</div>
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
<script src="resources/js/demo/chart-pie-demo.js"></script>

<script src="js/chart/RGraph.svg.common.core.js"></script>
<script src="js/chart/RGraph.svg.common.key.js"></script>
<script src="js/chart/RGraph.svg.common.tooltips.js"></script>
<script src="js/chart/RGraph.svg.pie.js"></script>
<script src="js/chart/RGraph.common.core.js"></script>
<script src="js/chart/RGraph.bar.js"></script>

<script>
   $shadow = ${memList};
   $workamt = ${workamt};
    new RGraph.SVG.Pie({
        id: 'chart-container',
        data: $workamt,
        options: {
           
            tooltipsEvent: 'mousemove',
            highlightStyle: 'outline',
            exploded: 5,
            tooltips: $shadow
        }
    }).draw().responsive([
        {maxWidth: 700, width: 350, height: 150, options: {key: null, marginTop: 15, marginBottom: 15, marginLeft: 15, marginRight: 15}},
        {maxWidth: null,width: 500, height: 250, options: {key: $shadow, marginTop: 35, marginBottom: 25, marginLeft: 25, marginRight: 25}}
    ]);
</script>

<script>
   $shadow = ${memList};
   $workamt = ${workamt};
   $TotalWorkAmt = ${totalWorkamt}
    new RGraph.Bar({
        id: 'cvs',
        data: $workamt,
        options: { 
            yaxisScaleMax:  $TotalWorkAmt,//max
            yaxisScaleUnitsPost: ' 개', //맥시멈+개 
            labelsAbove: true,
            labelsAboveDecimals: 0,//소숫점 몇 자리수 까지 표시?
            labelsAboveUnitsPost: '',//몇개이사람이 하고있는지 표시 
            labelsAboveColor: 'gray', // 몇개 글씨 색상 변경 
            labelsAboveSize: 10, //글씨크기 60 엄청크게 40 중간 15 작
            marginInner: 20,
            colors: ['#FF6666','#66FF66','#6666FF','#FFFF66','#66FFFF','#cccccc','#ffc0cb','#ffa500'],
            colorsSequential: true,
            xaxisLabels: $shadow,//이름
            textSize: 10,//하단 글씨 크기
            textColor: 'gray',
            backgroundGridVlines: false,
            backgroundGridHlinesCount: 2,
            backgroundGridBorder: false,
            xaxis: false,
            yaxis: false,
            yaxisLabelsCount: 4,
            title: '',//필요없으면 삭제해도됨  146~152 삭제 가능 
            titleSize: 14,
            titleX: 25,
            titleY: 0,
            titleHalign: 'left',
            titleColor: '#999',
            yaxisLabelsOffsetx: -10
            
        }
    }).grow({frames: 60});
</script>




</html>