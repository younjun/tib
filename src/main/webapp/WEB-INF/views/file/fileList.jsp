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
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<style>
 
          .dragAndDropDiv {
                width: 100%;
                height: 100%;
                color: #92AAB0;
                vertical-align: middle;
                padding: 10px 0px 10px 10px;
            }
          
            .progressBar {
                width: 200px;
                height: 22px;
                border: 1px solid #ddd;
                border-radius: 5px; 
                overflow: hidden;
                display:inline-block;
                margin:0px 10px 5px 5px;
                vertical-align:top;
            }
             
            .progressBar div {
                height: 100%;
                color: #fff;
                text-align: right;
                line-height: 22px; /* same as #progressBar height if we want text middle aligned */
                width: 0;
                background-color: #0ba1b5; border-radius: 3px; 
            }
            .statusbar{
                border-top:1px solid #A9CCD1;
                min-height:25px;
                width:99%;
                padding:10px 10px 0px 10px;
                vertical-align:top;
            }
            .statusbar:nth-child(odd){
                background:#EBEFF0;
            }
            .filename{
                display:inline-block;
                vertical-align:top;
                width:250px;
            }
            .filesize{
                display:inline-block;
                vertical-align:top;
                color:#30693D;
                width:100px;
                margin-left:10px;
                margin-right:5px;
            }
            .abort{
                background-color:#A8352F;
                -moz-border-radius:4px;
                -webkit-border-radius:4px;
                border-radius:4px;display:inline-block;
                color:#fff;
                font-family:arial;font-size:13px;font-weight:normal;
                padding:4px 15px;
                cursor:pointer;
                vertical-align:top;
            }
</style>
<script type="text/javascript" src="js/httpRequest.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.js"></script>
 <script type="text/javascript">
            $(document).ready(function(){
                var objDragAndDrop = $(".dragAndDropDiv");
                var objinputUpload =$(".inputUpload")
                
                $(document).on("dragenter",".dragAndDropDiv",function(e){
                    e.stopPropagation();
                    e.preventDefault();
                    
                });
                $(document).on("dragover",".dragAndDropDiv",function(e){
                    e.stopPropagation();
                    e.preventDefault();
                });
                $(document).on("drop",".dragAndDropDiv",function(e){
                    e.preventDefault();
                    var files = e.originalEvent.dataTransfer.files;
                    
                    handleFileUpload(files,objDragAndDrop);
                    window.alert('enter upload');
                });
                
                $(objinputUpload).on('click',function(e){
                   $('input[type=file]').trigger('click');
                });
                
                $("input[type=file]").on("change",function(e){
                   var files = e.originalEvent.target.files;
                     handleFileUpload(files,objinputUpload);
                });
                
                function handleFileUpload(files,obj)
                {
                   for (var i = 0; i < files.length; i++) 
                   {
                        var fd = new FormData();
                        fd.append('file', files[i]);
                 
                        var status = new createStatusbar(obj); //Using this we can set progress.
                        status.setFileNameSize(files[i].name,files[i].size);
                        sendFileToServer(fd,status);
                   }
                
                }
                
                var rowCount=0;
                function createStatusbar(obj){
                        
                    rowCount++;
                    var row="odd";
                    if(rowCount %2 ==0) row ="even";
                    this.statusbar = $("<div class='statusbar "+row+"'></div>");
                    this.filename = $("<div class='filename'></div>").appendTo(this.statusbar);
                    this.size = $("<div class='filesize'></div>").appendTo(this.statusbar);
                    this.progressBar = $("<div class='progressBar'><div></div></div>").appendTo(this.statusbar);
                    this.abort = $("<div class='abort'>중지</div>").appendTo(this.statusbar);
                    
                    obj.after(this.statusbar);
                 
                    this.setFileNameSize = function(name,size){
                        var sizeStr="";
                        var sizeKB = size/1024;
                        if(parseInt(sizeKB) > 1024){
                            var sizeMB = sizeKB/1024;
                            sizeStr = sizeMB.toFixed(2)+" MB";
                        }else{
                            sizeStr = sizeKB.toFixed(2)+" KB";
                        }
                 
                        this.filename.html(name);
                        this.size.html(sizeStr);
                    }
                    
                    this.setProgress = function(progress){       
                        var progressBarWidth =progress*this.progressBar.width()/ 100;  
                        this.progressBar.find('div').animate({ width: progressBarWidth }, 10).html(progress + "% ");
                        if(parseInt(progress) >= 100)
                        {
                            this.abort.hide();
                        }
                    }
                    
                    this.setAbort = function(jqxhr){
                        var sb = this.statusbar;
                        this.abort.click(function()
                        {
                            jqxhr.abort();
                            sb.hide();
                        });
                    }
                }
                
                function sendFileToServer(formData,status)
                {
                    var uploadURL = "fileUpload.do?pcode=${projectDTO.pcode}"; //Upload URL
                    var extraData ={}; //Extra Data.
                    var jqXHR=$.ajax({
                            xhr: function() {
                            var xhrobj = $.ajaxSettings.xhr();
                            if (xhrobj.upload) {
                                    xhrobj.upload.addEventListener('progress', function(event) {
                                        var percent = 0;
                                        var position = event.loaded || event.position;
                                        var total = event.total;
                                        if (event.lengthComputable) {
                                            percent = Math.ceil(position / total * 100);
                                        }
                                        //Set progress
                                        status.setProgress(percent);
                                    }, false);
                                }
                            return xhrobj;
                        },
                        url: uploadURL,
                        type: "POST",
                        contentType:false,
                        processData: false,
                        cache: false,
                        data: formData,
                        success: function(data){
                            status.setProgress(100);
                          	location.reload();
                        }
                    }); 
                    status.setAbort(jqXHR);
                }
                
            });

            function deleteFile(didx,dname){
            	var ok = window.confirm(dname+'파일을 삭제하시겠습니까?');
            	if(ok){
            		var param ='didx='+didx;
            		sendRequest("deleteFile.do",param,resultDeleteFile,'GET')
           				}
            }
            function resultDeleteFile(){
            	if(XHR.readyState==4){
            		if(XHR.status==200){
            			var data = XHR.responseText;
						window.alert(data);
						location.reload();
            		}
            	}
            }
        </script>
</head>

<body id="page-top">
<c:set var="projectDTO" value="${projectDTO }"></c:set>
   <div id="wrapper">
      <%@include file="../tib/navTib.jsp"%>      <!-- side nav -->
      <div id="content-wrapper" class="d-flex flex-column">
         <div id="content">
         <%@include file="../tib/toolBarTib.jsp" %> <!-- top search bar area -->
            <div id="container-fluid">
            	<h2>&nbsp;&nbsp;&nbsp;${projectDTO.pname }</h2>
 <!--  여기부터 작업 -->
      <!-- DataTales Example -->
      <c:set var="pdto" value="${sessionScope.projectDTO}"></c:set>
            <div id="fileUpload" class="dragAndDropDiv">업로드 할 파일을 드래그 해주세요.<!-- Drag & Drop Files Here -->
               <div class="card shadow mb-4">
                  <div class="card-header py-3">
                     <h6 class="m-0 font-weight-bold text-primary">${sessionScope.projectDTO.pname } 프로젝트</h6>
                  </div>
                  <div class="card-body">
                     <div class="table-responsive">
                        <div id="dataTable_wrapper"
                           class="dataTables_wrapper dt-bootstrap4">
                           <div class="row">
                              <div class="col-sm-12 col-md-8"> <!--  -->
                                 <div class="dataTables_length" id="dataTable_length">
                                    <input id="fileUpload2" class="inputUpload" type="file" name="upload" style="display: none;" multiple="multiple"> 
                                 <a onclick="document.all.upload.click()" class="btn btn-info btn-icon-split">
                                    <span class="icon text-white-50"><img src="img/clip.png" style="width:25px; height:25px;"> </span>
                                     </a>
                                 </div>
                              </div>
                           </div>
                           <div class="row">
                              <div class="col-sm-12">
                                 <table class="table table-bordered dataTable" id="dataTable"
                                    width="100%" cellspacing="0" role="grid"
                                    aria-describedby="dataTable_info" style="width: 100%;">
                                    <thead>
                                       <tr role="row">
                                          <th class="sorting_asc" tabindex="0"
                                             aria-controls="dataTable" rowspan="1" colspan="1"
                                             aria-sort="ascending"
                                             aria-label="Name: activate to sort column descending"
                                             style="width: 63.6667px;">NO.</th>
                                          <th class="sorting" tabindex="0" aria-controls="dataTable"
                                             rowspan="1" colspan="1"
                                             aria-label="Position: activate to sort column ascending"
                                             style="width: 65px;">ID</th>
                                          <th class="sorting" tabindex="0" aria-controls="dataTable"
                                             rowspan="1" colspan="1"
                                             aria-label="Office: activate to sort column ascending"
                                             style="width: 55.6667px;">File</th>
             							  <th class="sorting" tabindex="0" aria-controls="dataTable"
                                             rowspan="1" colspan="1"
                                             aria-label="Office: activate to sort column ascending"
                                             style="width: 55.6667px;">Extension</th>
                                          <th class="sorting" tabindex="0" aria-controls="dataTable"
                                             rowspan="1" colspan="1"
                                             aria-label="Start date: activate to sort column ascending"
                                             style="width: 68.3333px;">Upload date</th>
                                       </tr>
                                    </thead>
                                    <tfoot>
                                       <tr>
                                          <th rowspan="1" colspan="1">NO.</th>
                                          <th rowspan="1" colspan="1">ID</th>
                                          <th rowspan="1" colspan="1">File</th>
                                          <th rowspan="1" colspan="1">Extension</th>
                                          <th rowspan="1" colspan="1">Upload date</th>
                                       </tr>
                                    </tfoot>
                                    <tbody>
                                    <c:if test="${empty files }">
                                       <tr>
                                          <th class="sorting_1" colspan="5" align="center">No File</th>
                                       </tr>
                                    </c:if>
                                    <c:forEach var="f" items="${files }">
                                       <tr role="row" class="odd">
                                          <td class="sorting_1">${f.didx }</td>
                                          <td>${f.mid }</td>
                                          <td><a href="fileDown.do?filename=${f.dname }&projectNum=${sessionScope.projectDTO.pcode}&dkind=${f.dkind}">${f.dname }</a></td>
                                          <td>${f.dkind }</td>
                                          <td>${f.ddate }&nbsp;&nbsp;
                                          <a onclick="javascript:deleteFile(${f.didx},'${f.dname }')" class="btn btn-danger btn-circle btn-sm"><i class="fas fa-trash"></i></a> 
                                          </td>
                                       </tr>
                                    </c:forEach>
                                    </tbody>
                                 </table>
                              </div>
                           </div>
                           <div class="row">
                              <div class="col-sm-12 col-md-7">
                                 <div class="dataTables_paginate paging_simple_numbers"
                                    id="dataTable_paginate">
                                    <ul class="pagination">
                                      <c:if test="${!empty files }"> ${page }</c:if>
                                    </ul>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
         </div>
 <!-- 여기까지 -->
            </div>
         </div>
         <%@include file="../tib/footerTib.jsp" %>
      </div>
   </div>
</body>
<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</html>