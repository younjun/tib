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
</head>
<style>

#chatViewArea{
overflow-x:hidden;
background-color: #ccffff;
}
#chatInput{
height: 100px;
width:100%;
resize: none;
}
#chatSubmit{
width: 100px;
}
.chat-box{
overflow: scroll; height:600px; width:50%; margin-left: 25%;
}
.input-group{
width: 50%; margin-left: 25%;
}
.chatMenu{
width:25px; 
height: 25px; 
}
.chatInputDiv{
width:80%;
}
#enterBtn{
width:10%;
}
#chatInputMenu{
align-items:center; width:100%; border-style: none;  float: left; 
}
</style>
<c:set var="memberDto" value="${sessionScope.user }"></c:set>
<c:set var="projectDto" value="${sessionScope.projectDTO }"></c:set>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.js"></script>
<script>

var ws;	




$(function(){
	//192.168.0.138
	ws = new WebSocket('ws://localhost:9090/venti5/chat.ws'); 
	ws.onmessage= onMsg; 
	ws.onclose=onClose;
	ws.onopen=onOpen;
});


function onClose(evt){ 
	//window.alert('연결 끝'); 
}
function onOpen(){
	ws.send('Enter the chat room');
}

function sendMsg(){
	var msg = document.getElementById('chatInput').value;
	if(!msg.toString()==''){
		msg='${memberDto.mid}' +':'+ msg;
		ws.send(1+msg);  
	}
	document.getElementById('chatInput').value='';
}


function cl(){
	ws.close(); 
}

function onMsg(evt){
	var data = evt.data;
	data = data.replace(/\n/gi,"<br>"); 
	var spanText = '';
	var chatViewAreaDivNode = document.getElementById('chatViewArea'); 
	var chatViewAreaUlNode = document.getElementById('chatViewUl');
	var chatViewAreaLiNode = document.createElement('li');
	var chatViewAreaSpanNode = document.createElement('span');
	chatViewAreaSpanNode.style.cursor='pointer';
	var spanText = '';
	
	var textNode=null;
	var urlNode=null;
	let today = new Date();
	var time =document.createTextNode(today.toLocaleDateString()+today.toLocaleTimeString());
	var timeSpanNode=document.createElement('span');
		timeSpanNode.setAttribute('style','font-size:10px;');
		timeSpanNode.appendChild(time);
	if(data.toString().substring(0,1)==2){
		for(var i =1;i<data.toString().length;i++){
			if(data.toString().charAt(i)==':'){
				if(data.toString().substring(1,i)=='${memberDto.mid}'){
					var fName=data.toString().substring(i+1);
					var pNum='${projectDto.pcode}';
					chatViewAreaLiNode.setAttribute('class','even');
					spanText='${memberDto.mid}';
					chatViewAreaSpanNode.setAttribute('onclick','getProfileModal("'+spanText+'")');
					 urlNode=document.createElement('a');
					urlNode.setAttribute('href','fileDown.do?filename='+fName+'&projectNum='+pNum);
					var urlTextNode=document.createTextNode(fName);
					urlNode.appendChild(urlTextNode);
					
				}else{
					var fName=data.toString().substring(i+1);
					var pNum='${projectDto.pcode}';
					chatViewAreaLiNode.setAttribute('class','odd');
					spanText=data.toString().substring(0,i);
					chatViewAreaSpanNode.setAttribute('onclick','getProfileModal("'+spanText+'")');
					 urlNode=document.createElement('a');
					urlNode.setAttribute('href','fileDown.do?filename='+fName+'&projectNum='+pNum);
					var urlTextNode=document.createTextNode(fName);
					urlNode.appendChild(urlTextNode);
				}
			}
		}
		var chatViewAreaSpanTextNode = document.createTextNode(spanText);
		chatViewAreaSpanNode.appendChild(chatViewAreaSpanTextNode);
		chatViewAreaLiNode.appendChild(chatViewAreaSpanNode);
		chatViewAreaLiNode.appendChild(timeSpanNode);
		chatViewAreaLiNode.appendChild(urlNode);
		
	}else if(data.toString().substring(0,1)==1){
	      for(var i=1; i<data.toString().length; i++){
	          if(data.toString().charAt(i)==':'){
	             if(data.toString().substring(1,i)=='${memberDto.mid}'){            
	                chatViewAreaLiNode.setAttribute('class','even');
	                spanText='${memberDto.mid}';
	                chatViewAreaSpanNode.setAttribute('onclick','getProfileModal("'+spanText+'")');
	                chat_text = data.toString().substring(i+1);               
	                var chat_span_text = document.createElement('span'); 
	                chat_span_text.setAttribute('style','display:inline-block; max-width:95%;');
	                chat_span_text.innerHTML =chat_text;
	             }else{
	                chatViewAreaLiNode.setAttribute('class','odd');
	                spanText=data.toString().substring(1,i);
	                chatViewAreaSpanNode.setAttribute('onclick','getProfileModal("'+spanText+'")');
	                chat_text = data.toString().substring(i+1);
	                var chat_span_text = document.createElement('span'); 
	                chat_span_text.setAttribute('style','display:inline-block; max-width:70%;');
	                chat_span_text.innerHTML =chat_text;
	             }
	             break;
	          }
	       }
	       var chatViewAreaSpanTextNode = document.createTextNode(spanText);
	       chatViewAreaSpanNode.appendChild(chatViewAreaSpanTextNode);
	       chatViewAreaLiNode.appendChild(chatViewAreaSpanNode);
	       chatViewAreaLiNode.appendChild(timeSpanNode);
	       //여기부터 
	       var chat_scheduleNode = document.createElement('span'); 
	       chat_scheduleNode.setAttribute('class','dropdown');
	       chat_scheduleNode.setAttribute('style','display-none');
	       chat_scheduleNode.setAttribute('role','button');
	       chat_scheduleNode.setAttribute('data-toggle','dropdown');
	       chat_scheduleNode.setAttribute('id','"'+chat_text+'"');
	       chat_scheduleNode.setAttribute('aria-haspopup','true');
	       chat_scheduleNode.setAttribute('aria-expanded','false');
	       chat_scheduleNode.appendChild(chat_span_text);
	       chatViewAreaLiNode.appendChild(chat_scheduleNode);
	       var drop_div = document.createElement('div');
	       drop_div.setAttribute('class','dropdown-menu dropdown-menu-right shadow animated--grow-in');
	       drop_div.setAttribute('aria-labelledby','"'+chat_text+'"');
	       var drop_a = document.createElement('a'); 
	       drop_a.setAttribute('class','dropdown-item'); 
	       drop_a.setAttribute('href','javascript:chat_schedule_add("'+chat_text+'")');
	       drop_a.innerHTML = '일정 등록'; 
	       drop_div.appendChild(drop_a); 
	       chatViewAreaLiNode.appendChild(drop_div);
	       
	       //여기까지
	       
	       //chatViewAreaLiNode.appendChild(textNode);
	    }
	
	
	chatViewAreaUlNode.appendChild(chatViewAreaLiNode);
	
	chatViewAreaDivNode.scrollTop = chatViewAreaDivNode.scrollHeight;
}

$(function() {
	  $('textarea').on('keydown', function(event) {
	      if (event.keyCode == 13){
	          if (!event.shiftKey){
	             event.preventDefault();
	             var button=document.getElementById('chatSubmit');
	             button.click();
	          }
	      }  
	  });
	 
	});
$(document).ready(function(){
	   var objDragAndDrop=$(".chatInputDiv");
	   
	   $(document).on("dragenter",".chatInputDiv",function(e){ //dragenter 요소가 드래그 영역으로 들어갔을 경우 호출
	      e.stopPropagation(); //이벤트가 상위 엘리먼트에 전달되는 것을 막아준다.
	      e.preventDefault(); //태그의 고유 동작을 중단시킨다.
	   });
	   $(document).on("dragover",".chatInputDiv",function(e){ //dragover 요소가 드래그 영역에 있을 경우 호출
	        e.stopPropagation();
	        e.preventDefault();
		$(this).css('border','2px dotted #0B85A1');
	   });
	   $(document).on("drop",".chatInputDiv",function(e){ //drop 요소가 영역에 드랍되었을 때 호출
	      e.preventDefault();
	        var uploadOk = window.confirm('파일을 공유하시겠습니까?');
	        if(uploadOk==true){
	        	var files = e.originalEvent.dataTransfer.files;
		        handleFileUpload(files,objDragAndDrop);
	        }
	    });
	   $(document).on("dragleave",".chatInputDiv",function(e){
	       e.stopPropagation();
	        e.preventDefault();
	        $(this).css('border','0px');
	   });
	        function sendFileToServer(formData,name){
	            var uploadURL = "fileUpload.do?pcode=${projectDTO.pcode}"; //Upload URL
	            var fileName=name;
	            var extraData ={}; //Extra Data.
	            var jqXHR=$.ajax({
	                    xhr: function() {
	                    var xhrobj = $.ajaxSettings.xhr();
	                    return xhrobj;
	                },
	                url: uploadURL,
	                type: "POST",
	                contentType:false,
	                processData: false,
	                cache: false,
	                data: formData,
	                success: function(data){
	                	ws.send(2+'${memberDto.mid}' +':'+fileName);
	                }
	            });
	        }  
	         
	        function handleFileUpload(files,obj) //파일들과 드래그 영역을 매개변수로 받는다.
	        {
	           for (var i = 0; i < files.length; i++) 
	           {
	                var fd = new FormData();
	                fd.append('file', files[i]);
	         
	                sendFileToServer(fd,files[i].name);
	         
	           }
	        }
			var objfileUploadChat=$(".fileUploadChat");
			
			$(objfileUploadChat).on('click',function(e){
				$('input[type=file]').trigger('click');
			});
			
			$('input[type=file]').on('change',function(e){
				var files = e.originalEvent.target.files;
				handleFileUpload(files,objfileUploadChat);
			});
	    });
$(function(){
    $('#searchChat').on('keydown',function(event){
    	if(event.keyCode==13){
    		window.alert('enter');
    		var value=$(this).val();
    		value=value.replace(/\r\n/g,'');
    		$("span:contains("+value+")").css("text-decoration", "underline");
    		$("span:contains("+value+")")[0].scrollIntoView();
    		//$("span:contains("+value+")").css("background-color", "red");
    		//$("span:contains("+value+")").focus();
    		window.onclick=function(){
    			//$("span:contains("+value+")").css("background-color", "");	
    			$("span:contains("+value+")").css("text-decoration", "");
    		}
    	//	var chatViewAreaDivNode = document.getElementById('chatViewArea'); 
    	//	chatViewAreaDivNode.scrollHeight = $("span:contains("+value+")").position;
    	//	$('#chatViewArea').scrollTop($("span:contains("+value+")").scrollTop);
    		
    		
    	}
    });
});	    

</script>

<body id="page-top">
<c:set var="projectDTO" value="${projectDTO }"></c:set>
<c:set var="user" value="${sessionScope.user }"></c:set>
	<div id="wrapper">
		<%@include file="../tib/navTib.jsp"%>		<!-- side nav -->
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
			<%@include file="../tib/toolBarTib.jsp" %> <!-- top search bar area -->
				<div id="container-fluid">
				<h2>&nbsp;&nbsp;&nbsp;${projectDTO.pname }</h2>
					<div class="chat-box" id="chatViewArea">
						<ul id="chatViewUl">
						<!-- 
							<li class="odd"><span>길동</span>하이</li>
						 -->	
		
						</ul>
					</div>
					<div class="input-group">
                  		<div id="chatInputMenu" style="border: 0px;" >
                        &nbsp;&nbsp;   
                           <input type=file name="dname" style="display: none;" class="fileUploadChat" multiple> 
                           <input type=file name="imgFile" style="display: none;" accept="image/gif, image/jpeg, image/png" class="fileUploadChat" multiple> 
                              <img src="img/index_img2.png" class="chatMenu" onclick="document.all.imgFile.click()"   >
                              <img src="img/index_file.png" class="chatMenu" onclick="document.all.dname.click()"   >
           				 </div>
             				 <div>
           				 	<input type="text" name="searchChat" id="searchChat" placeholder="검색어 입력">
           				 </div>         				 
           				 <div id="fileUpload" class="chatInputDiv" style="float:left;">
						<textarea id="chatInput" type="text" class="form-control bg-light border-0 small" placeholder="'shift+enter 입력 시 줄 바꿈" maxlength="4000"></textarea></div>
							<div class="input-group-append" id="enterBtn" style="float:left;">
								<button id="chatSubmit" class="btn btn-primary" type="button" onclick="sendMsg()" style="height:50%; margin-top:25%; " >enter</button>
							</div>
							<input type="file" name="fileUpload" id="fileUpload" style="display:none;"/>
						</div>	
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
