<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="//code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
   function addMember() {
      var inputEmail = document.getElementById('inputEmail');

      var inputNode = document.createElement('input');
      inputNode.setAttribute('type', 'email');
      inputNode.setAttribute('name', 'memberEmail');
      inputNode.setAttribute('class', 'form-control form-control-user');
      inputNode.setAttribute('placeholder', 'email');

      inputEmail.appendChild(inputNode);
   }

   function getProfileModal(mid) {
      showModal('chatProfile');
      var param = 'mid=' + mid;
      sendRequest('projectMemberProfile.do', param, projectMemberProfile,'GET');
   }

   function projectMemberProfile() {
      if (XHR.readyState == 4) {
         if (XHR.status == 200) {
            var data = XHR.responseText;
            data = eval('(' + data + ')');
            var idNode = document.getElementById('chatProfileId');
            idNode.innerHTML = data.mdto.mid;
            var nameNode = document.getElementById('chatProfileName');
            nameNode.innerHTML = data.mdto.mname;
            var fileUlNode = document.getElementById('chatProfileFileUl');
            for (var i = 0; i < data.filelist.length; i++) {
               var fileNode = document.createElement('li');
               var fileDownNode = document.createElement('a');
               var fileFullName = data.filelist[i].dname
                     + data.filelist[i].dkind;
               fileDownNode.setAttribute('href', 'fileDown.do?filename='
                     + fileFullName + '&projectNum='
                     + data.filelist[i].pcode);
               var fileDownTextNode = document
                     .createTextNode(data.filelist[i].dname
                           + data.filelist[i].dkind);
               fileDownNode.appendChild(fileDownTextNode);
               fileNode.appendChild(fileDownNode);
               fileUlNode.appendChild(fileNode);
            }
            var fileListNode = document.createElement('a');
            fileListNode.setAttribute('href', 'goFileList.do');
            fileListNode.setAttribute('style', 'font-size:12px;');
            var fileListTextNode = document.createTextNode('더 보기..');
            fileListNode.appendChild(fileListTextNode);
            fileUlNode.appendChild(fileListNode);

            var tablebodyNode = document.getElementById('table_body');

            for (var i = 0; i < data.schedulelist.length; i++) {

               var trNode = document.createElement('tr');
               var tdNode1 = document.createElement('td');
               var tdNode2 = document.createElement('td');

               tdNode1.innerHTML = data.schedulelist[i].schedule_subject;
               tdNode2.innerHTML = data.schedulelist[i].d_day;
               trNode.appendChild(tdNode1);
               trNode.appendChild(tdNode2);
               tablebodyNode.appendChild(trNode);

            }

         }
      }
   }

   /*추가*/
   function search_add_project(memail, mid) {
      var search_add_memberid = document.getElementById('user_id');
      search_add_memberid.innerHTML = mid;

      document.addproject.memail.value = memail;
      showModal('search_add_project');
   }

   function enterPublic(pidx, plock, pname) {
      var result = confirm('프로젝트에 참여하시겠습니까?');
      if (result) {
         if (plock == 0) {
            var param = 'pidx=' + pidx;
            sendRequest('enterPublicProject.do', param,
                  enterPublicProjectCallback, 'GET');
         } else if (plock == 1) {
            document.enterProject.pidx.value = pidx;
            var pnameNode = document.getElementById('pname');
            pnameNode.innerHTML = pname;
            showModal('search_enter_project');
         }

      } else {

      }
   }

   /**/

   function fffff() {
      //var dddNode = document.getElementById('chatProfile');
      //dddNode.style.display='none';
      showModal('addsch');
   }
   function schInfo1(schedule_idx) {
      var param = 'schedule_idx=' + schedule_idx;
      sendRequest('scheduleDetail.do', param, getschInfo, 'GET');

   }
   function getschInfo() {
      if (XHR.readyState == 4) {
         if (XHR.status == 200) {
            var data = XHR.responseText;
            data = eval('(' + data + ')')

            var sch_pidx_Node = document.getElementById('sch_pidx')
            var sch_idx_Node = document.getElementById('sch_idx')
            var sch_sub_Node = document.getElementById('sch_sub')
            var sch_con_Node = document.getElementById('sch_con')
            var sch_date_Node = document.getElementById('sch_date')
            var sch_resp_Node = document.getElementById('sch_resp')
            var sch_color_Node = document.getElementById('sch_color')

            sch_pidx_Node.value = data.dto.pidx;
            sch_idx_Node.value = data.dto.schedule_idx;
            sch_sub_Node.value = data.dto.schedule_subject;
            sch_con_Node.innerHTML = data.dto.schedule_content;
            sch_date_Node.value = data.dto.schedule_date;
            sch_resp_Node.innerHTML = data.dto.schedule_resp;
            sch_color_Node.innerHTML = data.dto.schedule_color;

            showModal('schInfo');
         }
      }
   }

   function toAltSchedule() {

      var sch_sub_Node = document.getElementById('sch_sub');
      sch_sub_Node.removeAttribute('readonly');

      var sch_con_Node = document.getElementById('sch_con');
      sch_con_Node.removeAttribute('readonly');

      var sch_date_Node = document.getElementById('sch_date');
      sch_date_Node.removeAttribute('readonly');
      sch_date_Node.setAttribute('type', 'date');

      var sch_resp_Node = document.getElementById('sch_resp');
      sch_resp_Node.style.display = 'none';
      var sch_resp_Node2 = document.getElementById('sch_resp2');
      sch_resp_Node2.removeAttribute('class')

      var submitBtn_Node = document.getElementById('altSchConfirm');
      submitBtn_Node.setAttribute('type', 'hidden');

      var submitBtn2_Node = document.getElementById('altSchConfirm2');
      submitBtn2_Node.setAttribute('type', 'submit');

   }
   /**/

   function showModal(modalPage) {
      // Get the modal
      modalNode = document.getElementById(modalPage);

      modalNode.style.display = "block";

      window.onclick = function(event) {
         if (event.target == modalNode) {
            modalNode.style.display = "none";
            location.reload();
         }
      }
   }
   
   $(function() {
      $("#alert-success").hide();
      $("#alert-fail").hide();
      $("input[name='mpwd2_profile']").keyup(function() {
         var pwd1 = $("#mpwd1_profile").val();
         var pwd2 = $("#mpwd2_profile").val();
         if (pwd1 != "" || pwd2 != "") {
            if (pwd1 == pwd2) {
               $("#alert-success").show();
               $("#alert-fail").hide();
               $("#submit_profile").removeAttr("disabled");//버튼 활성화
            } else if (pwd1 != pwd2) {
               $("#alert-success").hide();
               $("#alert-fail").show();
               $("#submit_profile").attr("disabled", "disabled");//버튼  비활성화
            }
         }
      });
   });
</script>

<style>
.table-bordered td, .table-bordered th{
border-left: none;
border-right: none;

}
.input-container input {
   border: none;
   box-sizing: border-box;
   outline: 0;
   padding: .75rem;
   position: relative;
   width: 90%;
}

input[type="date"]::-webkit-calendar-picker-indicator {
   background: transparent;
   bottom: 0;
   color: transparent;
   cursor: pointer;
   height: auto;
   left: 0;
   position: absolute;
   right: 0;
   top: 0;
   width: auto;
}
/* The Modal (background) */
#createProject {
   cursor: pointer;
}

/* Modal Content/Box */

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

.modal-content {
   background-color: #fefefe;
   margin: 0px auto; /* 15% from the top and centered */
   padding: 1px;
   border: 1px solid #888;
   width: 100%; /* Could be more or less, depending on screen size */
   height: 60%;
}
</style>
<li class="nav-item"><a class="nav-link collapsed"
   href="javascript:showModal('projectModal')"> <span
      id="createProject">CreateProject</span>
</a></li>

<!-- The Modal -->
<!-- The Modal -->
<div id="projectModal" class="modal">
   <!-- Modal content -->
   <div class="modal-dialog">
      <div class="modal-content" style="margin-top: 5%;">
         <div class="row" style="margin: 2%; margin-top: 8%;">
            <div class="col-xl-10 col-lg-10 col-md-10">
               <h3>Create Project</h3>
            </div>
            <div class="col-xl-2 col-lg-2 col-md-2">
               <span class="close"></span>
            </div>
         </div>

         <form name="projectForm" action="addProjectMember.do" method="POST"   style="margin-top: 30px; margin: 20px" id=projectForm>
            <div class="form-group">
               <input name="pname" type="text"   class="form-control form-control-user" id="projectName"      placeholder="projectName">
            </div>
            <div class="custom-control custom-radio custom-control-inline">
               <input type="radio" id="customRadioInline1" name="lock"   class="custom-control-input" value="1" checked> <label
                  class="custom-control-label" for="customRadioInline1">Private   Project</label>
            </div>
            <div class="custom-control custom-radio custom-control-inline">
               <input type="radio" id="customRadioInline2" name="lock"   class="custom-control-input" value="0"> 
               <label   class="custom-control-label" for="customRadioInline2">Public Project</label>
            </div>
            <hr class="sidebar-divider">
            <a href="#" class="btn btn-primary btn-icon-split"
               onclick="addMember()" style="margin-bottom: 5px;"> <span class="icon text-white-50"> <i class="fas fa-user-plus"></i>
            </span>

            </a> <label style="margin-bottom: 20px;"> Add Project Member</label>
            <div class="inputEmail" id="inputEmail"   style="overflow: scroll; height: 300px;">
               <input name="memberEmail" type="email" class="form-control form-control-user" id="inputMemberEmail"   placeholder="email">
            </div>
            <div class="btn btn-success btn-icon-split"   style="height: 3rem; width: 6rem; line-height: 288%;"onclick="document.getElementById('projectForm').submit()">
               <i class="fas fa-pencil-alt"style="text-align: center; margin-top: 15px;"></i> <span>create</span>
            </div>

         </form>
      </div>
   </div>
</div>
<div class="modal" id="profileModal">
   <div class="col-xl-4 col-lg-4 col-md-4"
      style="border-left-width: 100px; left: 33%; top: 25%;">

      <div class="card o-hidden border-0 shadow-lg my-3">
         <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
               <div class="col-lg-2"></div>
               <div class="col-lg-9">
                  <div class="p-5">
                     <div class="text-center">
                        <h1 class="h4 text-gray-900 mb-4">개인정보 변경</h1>
                     </div>
                     <form class="profile" action="profile.do" method="POST">
                        <div class="form-group">
                           <input type="text" name="mname" class="form-control form-control-user2" value="${user.mname }"   readonly>
                        </div>
                        <div class="form-group">
                           <input type="text" name="mid"   class="form-control form-control-user" value="${user.mid }"   readonly>
                        </div>
                        <div class="form-group">
                           <input type="password" name="mpwd"   class="form-control form-control-user" id="mpwd1_profile"   placeholder="Insert Password">
                        </div>
                        <div class="form-group">
                           <input type="password" name="mpwd2_profile"   class="form-control form-control-user" id="mpwd2_profile"   placeholder="Insert Password">
                        </div>
                        <span id="alert-success">비밀번호가 일치합니다.</span> <span id="alert-fail">비밀번호가 일치하지 않습니다.</span>
                        <div class="form-group">
                           <input type="submit" class="btn btn-primary btn-user btn-block"   value="변경" id="submit_profile" disabled="disabled">
                        </div>
                     </form>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>



<div class="modal" id="chatProfile" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <div class="modal-header text-center">
            <h4 class="modal-title w-100 font-weight-bold">profile</h4>
         </div>
         <div class="modal-body mx-3">

            <div class="md-form mb-3">
               <i class="fas fa-user prefix grey-text"></i> <label   data-error="wrong" data-success="right" for="form34">profile</label>
               <div class=" text-right font-weight-bold" id="profileNode">
                  <ul class="list-unstyled">
                     <li id="chatProfileId"></li>
                     <li id="chatProfileName"></li>
                  </ul>
               </div>

            </div>
            <hr>
            <div class="md-form mb-3">
               <i class="fas fa-user prefix grey-text"></i> <label
                  data-error="wrong" data-success="right" for="form34">file</label>
               <div class=" text-right font-weight-bold" id="fileNode">
                  <ul class="list-unstyled" id="chatProfileFileUl">
                     <li id="chatProfileFile"></li>
                  </ul>
               </div>

            </div>
            <hr>
            <div class="md-form mb-3">
               <i class="fas fa-envelope prefix grey-text"></i> <label
                  data-error="wrong" data-success="right" for="form29">schedule</label>
               <div class=" text-right font-weight-bold" id="scheduleNode">
                  <div style="overflow:scroll; width: 106%;height:16vw;"> 
                  <table  rules="NONE"frame="void" class="table table-bordered dataTable" style="margin-left: 4%;width: 89%; border-top-width: 1px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px;">
                     <thead >
                        <th class="sorting_asc" style=" border-top-width: 0px; border-right-width: 0px; border-bottom-width: 2px; border-left-width: 0px;">업무</th>
                        <th class="sorting_asc" style=" border-top-width: 0px; border-right-width: 0px; border-bottom-width: 2px; border-left-width: 0px;">>D-day</th>
                     </thead>
                     <tbody id="table_body" style=" border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px;">
                     
                     </tbody>
                  </table>
               </div>

               </div>

            </div>
            <div class="modal-footer d-flex justify-content-center">
               <input type="submit" value="업무 할당" class="btn btn-outline-danger"   onclick="fffff()">
            </div>
         </div>
      </div>
   </div>
</div>



<!-- 프로젝트 초대 모달  -->
<div class="modal" id="search_add_project" tabindex="-1" role="dialog"   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <div class="modal-header text-center">
            <h4 class="modal-title w-100 font-weight-bold">project 초대</h4>
         </div>
         <div class="modal-body mx-3">
            <form name="addproject" action="responseProject.do" method="post">
               <input type="hidden" name="memail">
               <div class="md-form mb-3">
                  <i class="fas fa-user prefix grey-text"></i> <label   data-error="wrong" data-success="right" for="form34" id="user_id"></label>
               </div>
               <div class="md-form mb-3">
                  <i class="fas fa-user prefix grey-text"></i> <label
                     data-error="wrong" data-success="right" for="form34">초대할 프로젝트 </label> <select name="projectRoom" id="projectRoom"
                     class="form-control">
                     <c:forEach var="tmp" items="${sessionScope.projectList }">
                        <option value="${tmp.pcode}">${tmp.pname }</option>
                        <c:if test="${tmp.plock==1 }">&nbsp;*lock</c:if>
                     </c:forEach>
                  </select>
               </div>
               <div class="modal-foot text-right" >
                  <input type="submit" value="초대" class="btn btn-outline-primary">
               </div>
            </form>
         </div>
      </div>
   </div>
</div>


<!-- 프로젝트 초대 모달  -->
<div class="modal" id="search_enter_project" tabindex="-1" role="dialog"
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <div class="modal-header text-center">
            <h4 class="modal-title w-100 font-weight-bold">프로젝트 참가</h4>
         </div>
         <div class="modal-body mx-3">
            <form name="enterProject" action="enterProject.do" method="post">
               <input type="hidden" name="pidx">
               <div class="row justify-content-center"
                  style="display: flex; align-items: center; float: none; margin: 0 auto;">
                  <div class="col-xl-12 col-lg-8 col-md-9">
                     <div class="card o-hidden border-0 shadow-lg my-3">
                        <div class="card-body p-0">
                           <!-- Nested Row within Card Body -->
                           <div class="row">

                              <div class="col-lg-12">
                                 <div class="p-5">
                                    <div class="text-center">

                                       <div class="form-group" style="text-align: left;"
                                          id="pname"></div>
                                       <div class="form-group" style="text-align: left;">
                                          <input type="text" name="pcode">
                                       </div>
                                       <div>
                                          <input type="submit"
                                             class="btn btn-primary btn-user btn-block" value="참여하기">
                                          <div style="text-align: left;">
                                             <a href="indexTib.do">home</a>
                                          </div>
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
         </div>
      </div>
   </div>
</div>






<div class="modal" id="addsch" tabindex="-1" role="dialog"
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <div class="modal-header text-center">
            <h4 class="modal-title w-100 font-weight-bold">스케쥴 등록</h4>
            
         </div>
         <div class="modal-body mx-3">
            <form name="addsch" action="addSchedule.do" method="post">
               <input type="hidden" name="pidx" id="hidden_pidx"   value="${sessionScope.projectDTO.pidx }">
               <div class="md-form mb-3">
                  <i class="fas fa-user prefix grey-text"></i> 
                  <label   data-error="wrong" data-success="right" for="form34">업무명</label>
                  <input type="text" name="schedule_subject" class=" form-control bg-light border-0 small" required="required"
                     style="border: solid 1px #e8e8e8 !important;" maxlength="20">
               </div>
               <hr>
               <div class="md-form mb-3">
                  <i class="fas fa-file-alt"></i> 
                  <label data-error="wrong"   data-success="right" for="form34">업무내용</label><br>
                  <textarea name="schedule_content"
                     class=" text-right font-weight-bold form-control"   style="text-align: left !important; width: 100%; background-color: #f8f9fc; border: solid 1px #e8e8e8 !important;"
                     rows="10"></textarea>

               </div>
               <hr>
               <div class="md-form mb-3">
                  <i class="fa fa-calendar" aria-hidden="true"
                     style="text-align: left !important"></i> 
                     <label   data-error="wrong" data-success="right" for="form29">일정</label>
                  <div class="input-container input-group input-group-sm form-group">
                     <input type="date" id="effective-date" name="schedule_date"   class=" text-right font-weight-bold form-control"
                        required="required"   style="text-align: left !important; width: 100%; background-color: #f8f9fc; float: left; border: solid 1px #e8e8e8 !important;"
                        rows="10">
                  </div>
               </div>
               <hr>
               <div class="md-form mb-3">
                  <i class="fas fa-user-plus"></i> 
                  <label data-error="wrong" data-success="right" for="form29">담당자</label>
                  <div class="dropdown text-right">
                     <select name="schedule_resp" class="form-control noshow" style="cursor: pointer;  background-color: #f8f9fc; float: left; border: solid 1px #e8e8e8 !important;"">
                        <option value="팀 업무">팀 업무</option>
                        <c:forEach var="member" items="${sessionScope.memberlist}">
                           <option vlaue="${member.mname}">${member.mname}</option>
                        </c:forEach>
                     </select>
                  </div>
               </div>
               <hr style=" margin-bottom: 10% !important;">
               <hr>
               <div class="md-form mb-3">
                  <i class="fas fa-palette"></i> 
                  <label   data-error="wrong" data-success="right" for="form29" >색상</label> 
                  <input   type="color" class="form-control" name="schedule_color"   required="required" style="cursor: pointer; background-color: #f8f9fc; float: left; border: solid 1px #e8e8e8 !important;"">
               </div>

               <div class="modal-foot text-right" style="margin-top: 13%;">
                  <input type="submit" value="일정 추가" class="btn btn-outline-primary">
               </div>
            </form>
         </div>
      </div>
   </div>
</div>




<div class="modal" id="schInfo" tabindex="-1" role="dialog"
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <div class="modal-header text-center">
            <h4 class="modal-title w-100 font-weight-bold">sch Info</h4>
         </div>
         <form name="sch_success" action="altSchedule.do">
            <div class="modal-body mx-3">


               <input type="hidden" name="pidx" id="sch_pidx" name="pidx">
               <input type="hidden" id="sch_idx" name="schedule_idx">

               <div class="md-form mb-3">
                  <i class="fas fa-user prefix grey-text"></i> <label
                     data-error="wrong" data-success="right" for="form34">업무명</label>
                  <input type="text" readonly="readonly"   class=" text-right font-weight-bold" id="sch_sub" name="schedule_subject">
               </div>
            </div>
            <hr>
            <div class="md-form mb-3">
               <i class="fas fa-user prefix grey-text"></i>
                <label   data-error="wrong" data-success="right" for="form34">업무내용</label><br>
               <textarea class=" text-right font-weight-bold" id="sch_con"   style="width: 100%; resize: none;" readonly="readonly" rows="10" name="schedule_content"></textarea>

            </div>
            <hr>
            <div class="md-form mb-3">
               <i class="fas fa-envelope prefix grey-text"></i> 
               <label   data-error="wrong" data-success="right" for="form29">일정</label>
                <input   type="text" readonly="readonly"   class=" text-right font-weight-bold" id="sch_date"
                  required="required" name="schedule_date">
            </div>
            <hr>
            <div class="md-form mb-3">
               <i class="fas fa-envelope prefix grey-text"></i> 
               <label   data-error="wrong" data-success="right" for="form29">담당자</label>
               <div class=" text-right font-weight-bold" id="sch_resp"></div>
               <div class="d-none" id="sch_resp2">
                  <select name="schedule_resp" class="form-control noshow">
                     <option value="팀 업무">팀 업무</option>
                     <c:forEach var="member" items="${sessionScope.memberlist}">
                        <option vlaue="${member.mname}">${member.mname}</option>
                     </c:forEach>
                  </select>
               </div>
            </div>
            <hr>
            <div class="md-form mb-3">
               <i class="fas fa-envelope prefix grey-text"></i> 
               <label   data-error="wrong" data-success="right" for="form29">표시색상</label>
               <input type="color" readonly="readonly"   class=" text-right font-weight-bold" id="sch_color"   name="schedule_color">
            </div>
            <hr>
            <div class="md-form mb-3">
               <i class="fas fa-envelope prefix grey-text"></i> 
               <label   data-error="wrong" data-success="right" for="form29">수행여부</label>
               <select readonly="readonly" class=" text-right font-weight-bold" id="sch_complete" name="schedule_complete">
                  <option value="N">미완료</option>
                  <option value="Y">완료</option>
               </select>
            </div>
            <div class="modal-footer d-flex justify-content-center">
               <!-- 필요한거로 <input type="hidden" name="univCode" id="deleteunivCode">-->
               <input type="button" value="수정 하기" class="btn btn-outline-danger"   onclick="toAltSchedule()" id="altSchConfirm"> 
               <input   type="hidden" value="일정 변경" class="btn btn-outline-danger"   id="altSchConfirm2">

            </div>
         </form>
      </div>
   </div>
</div>
