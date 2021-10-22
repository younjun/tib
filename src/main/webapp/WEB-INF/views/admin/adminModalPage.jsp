<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<script src="//code.jquery.com/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="js/httpRequest.js"></script>
<script>

function showProjectInfo(pidx,pcode){
	var param = 'pcode='+pcode+'&pidx='+pidx;
	sendRequest('projectInfo.do',param,getProjectInfo,'GET');
}

function getProjectInfo(){
	if(XHR.readyState==4){
		if(XHR.status==200){
			var data = XHR.responseText;
			data = eval('('+data+')');
			var nameNode = document.getElementById('projectName');
			nameNode.innerHTML = '인원: ' + data.memberList.length +'명';
			var membersNode = document.getElementById('member');
			for(var i=0; i<data.memberList.length; i++){
				var memberNode = document.createElement('p');
				memberNode.innerHTML = data.memberList[i].mname;
				membersNode.appendChild(memberNode);
			}
			showModal('projectMemberInfoModal');
			
		}
	}
}
/*회원 정보 리스트에서 이메일 인증이 되지 않은 사람의 인증여부를 눌렀을 때 열어줄  모달 셋팅*/
function confirmModal1(mname,midx){
	var spanNode  = document.getElementById('confrimContent');
	spanNode.innerHTML = mname+'의 인증 여부를 승인하시겠습니까?'; 
	var hiddenNode  = document.getElementById('confirmTarget');
	hiddenNode.setAttribute('value',midx);
	hiddenNode.setAttribute('name','midx');
	formNode = document.getElementById('confirmForm'); 
	formNode.setAttribute('action','change_certification.do');
	showModal('confirmModal');
}
/*학교 정보 수정에서 계약 해지를 눌렀을 때 열어줄  모달 셋팅*/
function confirmModal2(univCode){
	var spanNode  = document.getElementById('confrimContent');
	spanNode.innerHTML = '정말로 계약 해지를 하시겠습니까?'; 
	var hiddenNode  = document.getElementById('confirmTarget');
	window.alert(univCode);
	hiddenNode.setAttribute('value',univCode);
	hiddenNode.setAttribute('name','univCode');
	formNode = document.getElementById('confirmForm'); 
	formNode.setAttribute('action','deleteUniv.do');
	showModal('confirmModal');
}


function no(){
	modalNode = document.getElementById('memberInfo');
	modalNode.style.display = "none";
}


function memberInfo(mid) {
	var param = 'mid='+mid;
	sendRequest('memberInfo.do',param,getMemberInfo,'GET'); 
	
}

function getMemberInfo(){
	if(XHR.readyState==4){
		if(XHR.status==200){
			var data = XHR.responseText;
			data = eval('('+data+')');
			
			var idxNode  = document.getElementById('idxNode');
			var nameNode  = document.getElementById('nameNode');
			var idNode  = document.getElementById('idNode');
			var pwdNode  = document.getElementById('pwdNode');
			var emailNode  = document.getElementById('emailNode');
			var univNameNode  = document.getElementById('univNameNode');
			var joindateNode  = document.getElementById('joindateNode');
			var certifiNode  = document.getElementById('certifiNode');
			var deleteNode = document.getElementById('deleteIdx');
			deleteNode.setAttribute('value',data.mdto.midx);
			
			idxNode.innerHTML = data.mdto.midx;
			nameNode.innerHTML = data.mdto.mname;
			idNode.innerHTML = data.mdto.mid;
			pwdNode.innerHTML = data.mdto.mpwd;
			emailNode.innerHTML = data.mdto.memail;
			univNameNode.innerHTML = data.udto.uname;
			joindateNode.innerHTML = data.mdto.joindate;
			certifiNode.innerHTML = data.mdto.certification=='y'?'인증됨':'인증안됨';
			showModal('oneMemberInfo');
		}
	}
	
}

function univInfo(univcode){
	var param = 'univcode='+univcode;
	sendRequest('univInfo.do',param,getUnivInfo,'GET'); 	
}

function getUnivInfo(){
	if(XHR.readyState==4){
		if(XHR.status==200){
			var data = XHR.responseText;
			data = eval('('+data+')');
			
			var u_code_Node  = document.getElementById('u_code');
			var u_name_Node  = document.getElementById('u_name');
			var u_email_Node  = document.getElementById('u_email');
			var u_start_Node  = document.getElementById('u_start');
			var u_end_Node  = document.getElementById('u_end');
			
			var deleteUnivNode = document.getElementById('deleteunivCode');
			deleteUnivNode.setAttribute('value',data.dto.univCode);
			
			u_code_Node.innerHTML  = data.dto.univCode;
			u_name_Node.innerHTML  = data.dto.uname;
			u_email_Node.innerHTML  = data.dto.uemail;
			u_start_Node.innerHTML  = data.dto.ustartdate;
		    u_end_Node.innerHTML  = data.dto.uenddate
			
			showModal('UnivInfo');
		}
	}
}



function showModal(modalPage){
		// Get the modal
		modalNode = document.getElementById(modalPage);

		var span = document.getElementsByClassName("close")[0];
	
		modalNode.style.display = "block";
		
		span.onclick = function() {
			modalNode.style.display = "none";
			var membersNode = document.getElementById('member');
			while ( membersNode.hasChildNodes() ) { membersNode.removeChild( membersNode.firstChild ); }
			location.reload();
		}

		window.onclick = function(event) {
			if (event.target == modalNode) {
				var membersNode = document.getElementById('member');
				while ( membersNode.hasChildNodes() ) { membersNode.removeChild( membersNode.firstChild ); }
				modalNode.style.display = "none";
			}
		}
	}

</script>
<style>
/* The Modal (background) */
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

#createProject {
	cursor: pointer;
}

/* Modal Content/Box */
.modal-content_to {
	background-color: #fefefe;
	margin:0px auto; /* 15% from the top and centered */
	padding: 1px;
	border: 1px solid #888;
	width: 100%; /* Could be more or less, depending on screen size */
	height: 60%;
}
/* The Close Button */
.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}


</style>




<div class="modal " id="projectMemberInfoModal" >
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"></h4>
      </div>
       <form  action="delproject.do" method="POST" >
      <div class="modal-body">
    		<div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4" id="projectName"></h1>
            </div>
        	<div class="form-group" id="memberCount"></div>
            <div class="form-group" id="member"></div>
      </div>   
      <div class="modal-footer">
      	<input type="submit" class="btn btn-primary btn-user btn-block" value="변경" id="submit_profile" disabled="disabled">    
      </div>
       </form> 
    </div>
  </div>
 </div>



<!-- Modal -->
<div class="modal " id="confirmModal" >
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"></h4>
      </div>
        <form name="change_certipication" id="confirmForm" >
      <div class="modal-body">
    
        <p class="text-center"><span id="confrimContent"></span></p>     
        <input type="hidden"  id="confirmTarget">
      </div>
     
      <div class="modal-footer">
      	<input type="submit" value="인증" class="btn btn-primary" data-dismiss="modal" >
        <button type="button" class="btn btn-primary" onclick="no()" data-dismiss="modal">취소</button>
        
      </div>
       </form> 
    </div>
  </div>
 </div>


<div class="modal" id="oneMemberInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
  aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header text-center">
        <h4 class="modal-title w-100 font-weight-bold">Info</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body mx-3">
      
       <div class="md-form mb-3">
          <i class="fas fa-user prefix grey-text"></i>
          <label data-error="wrong" data-success="right" for="form34">회원번호</label>
          <div class=" text-right font-weight-bold" id="idxNode"></div>
        
        </div>
        <hr>
        <div class="md-form mb-3">
          <i class="fas fa-user prefix grey-text"></i>
          <label data-error="wrong" data-success="right" for="form34">이름</label>
          <div class=" text-right font-weight-bold" id="nameNode"></div>
          
        </div>
<hr>
        <div class="md-form mb-3">
          <i class="fas fa-envelope prefix grey-text"></i>
           <label data-error="wrong" data-success="right" for="form29">ID</label>
           <div class=" text-right font-weight-bold" id="idNode"></div>
         
        </div>
        <hr>
        <div class="md-form mb-3">
          <i class="fas fa-envelope prefix grey-text"></i>
          <label data-error="wrong" data-success="right" for="form29">PWD</label>
      	  <div class=" text-right font-weight-bold" id="pwdNode"></div>
          
        </div>
        <hr>
         <div class="md-form mb-3">
          <i class="fas fa-envelope prefix grey-text"></i>
           <label data-error="wrong" data-success="right" for="form29">Email</label>
          <div class=" text-right font-weight-bold" id="emailNode"></div>
         
        </div>
<hr>
        <div class="md-form mb-3">
          <i class="fas fa-tag prefix grey-text"></i>
           <label data-error="wrong" data-success="right" for="form32">Univercity</label>
          <div class=" text-right font-weight-bold" id="univNameNode"></div>
         
        </div>
      <hr>  
         <div class="md-form mb-3">
          <i class="fas fa-tag prefix grey-text"></i>
           <label data-error="wrong" data-success="right" for="form32">joindate</label>
         <div class=" text-right font-weight-bold" id="joindateNode"></div>
         
        </div>
<hr>
        <div class="md-form">
          <i class="fas fa-pencil prefix grey-text"></i>
           <label data-error="wrong" data-success="right" for="form8">certification</label>
         	<div class=" text-right font-weight-bold" id="certifiNode"></div>
         
        </div>

      </div>
      <div class="modal-footer d-flex justify-content-center">
      	<form name="memberdel" action="deleteMember.do">
      	<input type="hidden" name="midx" id="deleteIdx">
        <input type="submit" value="회원 삭제" class="btn btn-outline-danger">
        </form>
      </div>
    </div>
  </div>
</div>




<div class="modal" id="UnivInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
  aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header text-center">
        <h4 class="modal-title w-100 font-weight-bold">Univ Info</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body mx-3">
      
       <div class="md-form mb-3">
          <i class="fas fa-user prefix grey-text"></i>
          <label data-error="wrong" data-success="right" for="form34">학교 번호</label>
          <div class=" text-right font-weight-bold" id="u_code"></div>
        
        </div>
        <hr>
        <div class="md-form mb-3">
          <i class="fas fa-user prefix grey-text"></i>
          <label data-error="wrong" data-success="right" for="form34">학교</label>
          <div class=" text-right font-weight-bold" id="u_name"></div>
          
        </div>
<hr>
        <div class="md-form mb-3">
          <i class="fas fa-envelope prefix grey-text"></i>
           <label data-error="wrong" data-success="right" for="form29">이메일 형식</label>
           <div class=" text-right font-weight-bold" id="u_email"></div>
         
        </div>
        <hr>
        <div class="md-form mb-3">
          <i class="fas fa-envelope prefix grey-text"></i>
          <label data-error="wrong" data-success="right" for="form29">계약일</label>
      	  <div class=" text-right font-weight-bold" id="u_start"></div>
          
        </div>
        <hr>
         <div class="md-form mb-3">
          <i class="fas fa-envelope prefix grey-text"></i>
           <label data-error="wrong" data-success="right" for="form29">만료일</label>
          <div class=" text-right font-weight-bold" id="u_end"></div>
         
        </div>

      <div class="modal-footer d-flex justify-content-center">
      	<form name="univdel" action="deleteuniv.do">
      	<input type="hidden" name="univCode" id="deleteunivCode">
        <input type="submit" value="계약 해지" class="btn btn-outline-danger">
        </form>
      </div>
    </div>
  </div>
</div>
</div>
