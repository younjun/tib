<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
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
<style>
   </script>
   <style TYPE="text/css">
      body {
      scrollbar-face-color: #F6F6F6;
      scrollbar-highlight-color: #bbbbbb;
      scrollbar-3dlight-color: #FFFFFF;
      scrollbar-shadow-color: #bbbbbb;
      scrollbar-darkshadow-color: #FFFFFF;
      scrollbar-track-color: #FFFFFF;
      scrollbar-arrow-color: #bbbbbb;
      margin-left:"0px"; margin-right:"0px"; margin-top:"0px"; margin-bottom:"0px";
      }

      td {font-family: "돋움"; font-size: 9pt; color:#595959;}
      th {font-family: "돋움"; font-size: 9pt; color:#000000;}
      select {font-family: "돋움"; font-size: 9pt; color:#595959;}


      .divDotText {
      overflow:hidden;
      text-overflow:ellipsis;
      }

      A:link { font-size:9pt; font-family:"돋움";color:#000000; text-decoration:none; }
      A:visited { font-size:9pt; font-family:"돋움";color:#000000; text-decoration:none; }
      A:active { font-size:9pt; font-family:"돋움";color:red; text-decoration:none; }
      A:hover { font-size:9pt; font-family:"돋움";color:red;text-decoration:none;}
      .day{
         width:100px; 
         height:30px;
         font-weight: bold;
         font-size:15px;
         font-weight:bold;
         text-align: center;
      }
      .sat{
         color:#529dbc;
      }
      .sun{
         color:red;
      }
      .today_button_div{
         float: right;
      }
      .today_button{
         width: 100px; 
         height:30px;
      }
      .calendar{
         width:80%;
         margin:auto;
      }
      .navigation{
         margin-top:100px;
         margin-bottom:30px;
         text-align: center;
         font-size: 25px;
         vertical-align: middle;
      }
      .calendar_body{
         width:100%;
         background-color: #FFFFFF;
         border:1px solid white;
         margin-bottom: 50px;
         border-collapse: collapse;
      }
      .calendar_body .today{
         border:1px solid white;
         height:120px;
         background-color:#c9c9c9;
         text-align: left;
         vertical-align: top;
      }
      .calendar_body .date{
         font-weight: bold;
         font-size: 15px;
         padding-left: 3px;
         padding-top: 3px;
      }
      .calendar_body .sat_day{
         border:1px solid white;
         height:120px;
         background-color:#EFEFEF;
         text-align:left;
         vertical-align: top;
      }
      .calendar_body .sat_day .sat{
         color: #529dbc; 
         font-weight: bold;
         font-size: 15px;
         padding-left: 3px;
         padding-top: 3px;
      }
      .calendar_body .sun_day{
         border:1px solid white;
         height:120px;
         background-color:#EFEFEF;
         text-align: left;
         vertical-align: top;
      }
      .calendar_body .sun_day .sun{
         color: red; 
         font-weight: bold;
         font-size: 15px;
         padding-left: 3px;
         padding-top: 3px;
      }
      .calendar_body .normal_day{
         border:1px solid white;
         height:120px;
         background-color:#EFEFEF;
         vertical-align: top;
         text-align: left;
      }
      .before_after_month{
         margin: 10px;
         font-weight: bold;
      }
      .before_after_year{
         font-weight: bold;
      }
      .this_month{
         margin: 10px;
      }
   </style>
   
   <script type="text/javascript">
   function addScheduleForm(){
      showModal('addsch');
      
      //window.open("addSchedule.do");
   }
   window.onload = function holiCol(){
      var divList = document.getElementsByTagName('div');
      for(var i=0; i<divList.length; i++){
         var div = divList[i];
         
         if(div.getAttribute('state')=='Y'){
            div.style.color='red'
         }
      }
   }
   </script>
</head>

<body id="page-top">
   <div id="wrapper">
      <%@include file="../tib/navTib.jsp"%>      <!-- side nav -->
      <div id="content-wrapper" class="d-flex flex-column">
         <div id="content">
         <%@include file="../tib/toolBarTib.jsp" %> <!-- top search bar area -->
            <div id="container-fluid">
               				<h2>&nbsp;&nbsp;&nbsp;${projectDTO.pname }</h2>
               
<form name="calendarFrm" id="calendarFrm" action="" method="GET"> 

<div class="calendar" >
   <!--날짜 네비게이션  -->
   <div class="navigation">
      <a clas="before_after_year" href="./calendar.do?year=${today_info.search_year-1}&month=${today_info.search_month-1}&pidx=${sessionScope.projectDTO.pidx }">
         &lt;&lt;
      <!-- 이전해 -->
      </a> 
      <a class="before_after_month" href="./calendar.do?year=${today_info.before_year}&month=${today_info.before_month}&pidx=${sessionScope.projectDTO.pidx }">
         &lt;
      <!-- 이전달 -->
      </a> 
      <span class="this_month">
         &nbsp;${today_info.search_year}. 
         <c:if test="${today_info.search_month<10}">0</c:if>${today_info.search_month}
      </span> 
      <a class="before_after_month" href="./calendar.do?year=${today_info.after_year}&month=${today_info.after_month}&pidx=${sessionScope.projectDTO.pidx }">
      <!-- 다음달 -->
         &gt;
      </a> 
      <a class="before_after_year" href="./calendar.do?year=${today_info.search_year+1}&month=${today_info.search_month-1}&pidx=${sessionScope.projectDTO.pidx }">
         <!-- 다음해 -->
         &gt;&gt;
      </a>
   </div>

<!-- <div class="today_button_div"> -->
<!-- <input type="button" class="today_button" onclick="javascript:location.href='/calendar.do'" value="go today"/> -->
<!-- </div> -->
<table class="calendar_body">

<thead>
   <tr bgcolor="#CECECE">
      <td class="day sun" >
         일
      </td>
      <td class="day" >
         월
      </td>
      <td class="day" >
         화
      </td>
      <td class="day" >
         수
      </td>
      <td class="day" >
         목
      </td>
      <td class="day" >
         금
      </td>
      <td class="day sat" >
         토
      </td>
   </tr>
</thead><tbody>
   <tr>
      <c:forEach var="dateList" items="${dateList}" varStatus="date_status"> 
         <c:choose>
            <c:when test="${dateList.value=='today'}">
               <c:if test="${date_status.index%7==0}">
                  <tr>
               </c:if>
               <td class="today">
                  <div class="date" state="${dateList.anniver_arr[0].get('isHoliday') }">
            </c:when>
            <c:when test="${date_status.index%7==6}">
               <td class="sat_day">
                  <div class="sat" state="${dateList.anniver_arr[0].get('isHoliday') }">
            </c:when>   
            <c:when test="${date_status.index%7==0}">
               </tr>
               <tr>   
               <td class="sun_day">
                     <div class="sun" state="${dateList.anniver_arr[0].get('isHoliday') }">
            </c:when>
            <c:otherwise>
               <td class="normal_day">
                  <div class="date" state="${dateList.anniver_arr[0].get('isHoliday') }">
            </c:otherwise>
         </c:choose>
         
                     ${dateList.date} ${dateList.anniver_arr[0].get("BIGO") }
                     
                  </div>
               <div>
                  <c:forEach var="scheduleList" items="${dateList.schedule_data_arr}" varStatus="schedule_data_arr_status"> 
                     <div onclick="javascript:schInfo1('${scheduleList.schedule_idx }')" class="date_subject" style="background-color: ${scheduleList.schedule_color}; color:white;" id = "schInfoModal">
                     ${scheduleList.schedule_subject}
                     
                     </div>
                  </c:forEach>
               </div>
            </td>
      </c:forEach>            
            
</tbody>


<tfoot>
   <tr>
      <td colspan="7" align="right">
         <input type="button" name="addSchedule" value="addSchedule" onclick="addScheduleForm();">
      </td>
   </tr>
</tfoot>
</table>
</div>
</form>
               
               
            
            </div>
         </div>
         <%@include file="../tib/footerTib.jsp" %>
      </div>
   </div>
</body>
<script src="resources/vendor/jquery/jquery.min.js"></script>
<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="resources/js/sb-admin-2.min.js"></script>
<script src="resources/vendor/chart.js/Chart.min.js"></script>
<script src="resources/js/demo/chart-area-demo.js"></script>
<script src="resources/js/demo/chart-pie-demo.js"></script>


</html>

</body>
</html>