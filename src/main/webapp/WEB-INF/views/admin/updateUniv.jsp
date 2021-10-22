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
<script type="text/javascript" src="js/httpRequest.js"></script>
<script>
function univ(){
	   var delUniv = document.getElementById('deleteUniv');
	   delUniv.style.display = "block";
	   var userUniv = document.getElementById('univs');
	   var selectValue = userUniv.options[userUniv.selectedIndex].value;
	   var param = 'univcode='+selectValue;
	   sendRequest('univInfo.do',param,showUnivInfo,'GET');	  		
	}
	
function showUnivInfo(){
	if(XHR.readyState==4){
		if(XHR.status==200){
			var data = XHR.responseText; 
			data = eval('('+data+')');
			
			var nameValue = data.dto.uname;
			var codeValue = data.dto.univCode;
			var ustartdate = data.dto.ustartdate;
			var uenddate = data.dto.uenddate;
			var uemail = data.dto.uemail;
			
			var nameNode = document.getElementById('univ_name');
			var codeNode = document.getElementById('univ_code');
			var startNode = document.getElementById('univ_start');
			var endNode = document.getElementById('univ_end');
			var emailNode = document.getElementById('univ_email');
			
			var nameInput = document.getElementById('nameInput');
			var codeInput = document.getElementById('codInput');
			var startInput = document.getElementById('startInput');
			var endInput = document.getElementById('endInput');
			var emailInput = document.getElementById('emailInput');
			
			var buttonNode = document.getElementById('confirmButton');
			
			if(nameInput!=null){
				nameNode.removeChild(nameNode.firstChild);
				codeNode.removeChild(codeNode.firstChild);
				startNode.removeChild(startNode.firstChild);
				endNode.removeChild(endNode.firstChild);
				emailNode.removeChild(emailNode.firstChild);
				buttonNode.removeAttribute('onclick');
			}
			
			window.alert(codeValue);
			buttonNode.setAttribute('onclick','confirmModal2('+codeValue+')');
			
			var inputNode1 = document.createElement('input');
			inputNode1.setAttribute('type','text');
			inputNode1.setAttribute('class','form-control');
			inputNode1.setAttribute('id','nameInput');
			inputNode1.setAttribute('readonly','readonly');
			inputNode1.setAttribute('name','uname');	
			inputNode1.setAttribute('value',nameValue)
			
			var inputNode2 = document.createElement('input');
			inputNode2.setAttribute('type','text');
			inputNode2.setAttribute('class','form-control');
			inputNode2.setAttribute('id','codeInput');
			inputNode2.setAttribute('readonly','readonly');
			inputNode2.setAttribute('name','univCode');	
			inputNode2.setAttribute('value',codeValue);	
			
			var inputNode3 = document.createElement('input');
			inputNode3.setAttribute('type','text');
			inputNode3.setAttribute('class','form-control');
			inputNode3.setAttribute('id','startInput');
			inputNode3.setAttribute('readonly','readonly');
			inputNode3.setAttribute('name','ustartdate');	
			inputNode3.setAttribute('value',ustartdate);	
			
			var inputNode4 = document.createElement('input');
			inputNode4.setAttribute('type','date');
			inputNode4.setAttribute('class','form-control');
			inputNode4.setAttribute('id','endInput');
			inputNode4.setAttribute('name','uenddate');	
			inputNode4.setAttribute('value',uenddate);	
			
			var inputNode5 = document.createElement('input');
			inputNode5.setAttribute('type','text');
			inputNode5.setAttribute('class','form-control');
			inputNode5.setAttribute('id','emailInput');
			inputNode5.setAttribute('name','uemail');	
			inputNode5.setAttribute('value',uemail);	
			
			nameNode.appendChild(inputNode1);
			codeNode.appendChild(inputNode2);
			startNode.appendChild(inputNode3);
			endNode.appendChild(inputNode4);
			emailNode.appendChild(inputNode5);
			
			
		}
	}
}
</script>

<style>
.edti{
display: hidden;
}
</style>
</head>

<body id="page-top">
   <div id="wrapper">
      <%@include file="../admin/adminNavTib.jsp"%>      <!-- side nav -->
      <div id="content-wrapper" class="d-flex flex-column">
         <div id="content">
         <%@include file="../tib/toolBarTib.jsp" %> <!-- top search bar area -->
            <div id="container-fluid">
             <!--  여기부터 작업 -->
              <form name="updateUniv" action="updateUniv.do" method="post">
					 <div class="row justify-content-center" style=" display:flex; align-items:center;  float:none; margin:0 auto;">
					   <div class="col-xl-6 col-lg-8 col-md-9">
					      <div class="card o-hidden border-0 shadow-lg my-3">
					         <div class="card-body p-0">
					            <!-- Nested Row within Card Body -->
					            <div class="row">
					            <div class="col-lg-3"></div>
					            <div class="col-lg-6">
					            <div class="p-5">
					            <div class="text-center">					
					               <div class="form-group">				               
					                  <select class="form-control" id="univs" onchange="univ()" >
					                  		<option value="">학교를 선택해주세요</option>
					                     <c:forEach var="tmpuniv" items="${univs}">
					                        <option value="${tmpuniv.univCode}">${tmpuniv.uname}</option>
					                     </c:forEach>
					                  </select>		
					                	          			
                  					</div>
                  				<div style="display:none;" id="deleteUniv">
                  					<p>학교 이름</p>
                  					<div class="form-group" id="univ_name"></div>
                  					<p>학교 코드</p>
                  					<div class="form-group" id="univ_code"></div>				                  
                  					<p>계약일</p>
                  					<div class="form-group" id="univ_start"></div>				                  
                  					<p>만료일 수정</p>
                  					<div class="form-group" id="univ_end"></div>				                  
                  					<p>이메일 형식 변경</p>
                  					<div class="form-group" id="univ_email"></div>				                  
                  								                  
					               <div>  <input type="submit" class="btn btn-primary btn-user btn-block" value="수정"> 
					               		 	
					              <div style="text-align: left;"><a href="indexAdmin.do">menu</a></div> </div>					        
					               <input type="button" class="edit btn btn-outline-danger btn-block"  value="계약 해지" id="confirmButton" >
					              </div>
					            </div>
					             </div>
					            </div>
					            </div>
					             </div>
					      </div>
					    </div>
					</div>
					
					</form>
			 <!-- 여기까지 컨텐츠 -->
            </div>
         </div>
         <%@include file="../tib/footerTib.jsp" %>
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

</html>