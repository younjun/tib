<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="js/httpRequest.js"></script>
<style>
::-webkit-scrollbar {   width: 12px;} <!--스크롤바 넓이-->
::-webkit-scrollbar-track {   background-color: #f1f1f1;}
::-webkit-scrollbar-thumb {   background-color: #7dc3c5;   border-radius: 10px;} <!--스크롤바 선택되는부분  컬러, 동굴동굴하게 10px 많이동글  5px + 위에 13px 각지고 얇게
::-webkit-scrollbar-thumb:hover {   background: #0a1616;}
::-webkit-scrollbar-button:start:decrement, ::-webkit-scrollbar-button:end:increment{   width: 0px;   height:  0px;   background: #f1f1f1;} <!--위아래위로올림버튼 아래로 내림버튼 삭제  -->
</style>

<script>
function getProjectDTO(pcode){
	var param='pcode='+pcode;
	sendRequest('openProject.do',param,showResult,'GET');
	
}
function exitProject(pidx,phost,mid,midx){
	   var result = window.confirm('프로젝트를 나가시겠습니까?')
	   if(result){
	      var param = 'phost='+phost+'&mid='+mid+'&midx='+midx+'&pidx='+pidx;
	      location.href='exitProject.do?'+param;
	   }
	}
function showResult(){
	if(XHR.readyState==4){
		if(XHR.status==200){
			var data = XHR.responseText;
		}
	}
}
</script>
			<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
				<!-- Sidebar - Brand -->
				<br>
					<c:if test="${sessionScope.user.mid=='admin' }">
					<a class="sidebar-brand d-flex align-items-center justify-content-center" href="indexAdmin.do" style="background-color:transparent;">
					</c:if>
					<a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.do" style="background-color:transparent;">
					<div class="sidebar-brand-icon" >
						<img src="img/mainlogo2.png" style="width:90%;">
					</div>
					<div class="sidebar-brand-text mx-3"></div>
				</a>
				<hr class="sidebar-divider my-0">
		            <br>
		            <a class="nav-link collapsed" href="indexTib.do">
		            <div class="sidebar-heading">공개 프로젝트 찾기</div>
		            </a>
		            <br>
				<!-- Divider -->
				<hr class="sidebar-divider my-0">
				<!-- Heading -->
				<br>
				<div class="sidebar-heading">참여중인 프로젝트</div>
				<!-- Nav Item - Pages Collapse Menu -->
				<c:forEach var="tmp" items="${sessionScope.projectList }">
					<c:if test="${tmp.plock==1 }">
						<li class="nav-item">
							<a style="cursor:pointer;" class="nav-link collapsed" onclick="javascript:getProjectDTO('${tmp.pcode}')" data-toggle="collapse" data-target="#${tmp.pcode }" aria-expanded="true" aria-controls="${tmp.pcode }"> 
								<span>${tmp.pname }</span>
							</a>
							<div id="${tmp.pcode }" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
									<div class="bg-white py-2 collapse-inner rounded">
										<h6 class="collapse-header">메뉴</h6>
										<a class="collapse-item" href="chat.do?projectNum=${tmp.pcode}">메신저</a> 
										<a class="collapse-item" href="calendar.do?pidx=${tmp.pidx }">프로젝트 일정</a>                        
										<a class="collapse-item" href="goFileList.do">자료실</a> 
				                        <a class="collapse-item" href="goDashboard.do?pidx=${tmp.pidx }">Dashboard</a> 
				                        <a class="collapse-item" href="javascript:exitProject(${tmp.pidx },'${tmp.phost }','${user.mid }',${user.midx })">프로젝트 종료</a>
				                     </div>
							</div>
						</li>
					</c:if>
				</c:forEach>
				<hr class="sidebar-divider my-0">
            <!-- Heading -->
            <br>
            <div class="sidebar-heading">참여중인 공개 프로젝트</div>
            <!-- Nav Item - Pages Collapse Menu -->
            <c:forEach var="tmp" items="${sessionScope.projectList }">
               <c:if test="${tmp.plock==0 }">
                  <li class="nav-item">
                     <a style="cursor:pointer;" class="nav-link collapsed" onclick="javascript:getProjectDTO('${tmp.pcode}')" data-toggle="collapse" data-target="#${tmp.pcode }" aria-expanded="true" aria-controls="${tmp.pcode }"> 
                        <span>${tmp.pname }</span>
                     </a>
                     <div id="${tmp.pcode }" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                           <div class="bg-white py-2 collapse-inner rounded">
                              <h6 class="collapse-header">Menu</h6>
                              <a class="collapse-item" href="chat.do?projectNum=${tmp.pcode}">메신저</a> 
                              <a class="collapse-item" href="goFileList.do?">자료실</a> 
                              <a class="collapse-item" href="javascript:exitProject(${tmp.pidx },'${tmp.phost }','${user.mid }',${user.midx })">프로젝트 종료</a>
                           </div>
                     </div>
                  </li>
               </c:if>
            </c:forEach>
            <br>
				<!-- Divider -->
				<hr class="sidebar-divider">
				<!-- createProject ModalPopup -->
				<%@include file="../modal/modalPage.jsp" %>
				<!-- Sidebar Toggler (Sidebar) -->
				<div class="text-center d-none d-md-inline">
					<button class="rounded-circle border-0" id="sidebarToggle"></button>
				</div>
			</ul>
			<!-- End of Sidebar -->