<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>

   function change(){
      var option = document.sch.search_option.value;
      var formNode = document.getElementById('searchForm'); 
      formNode.setAttribute('action','search'+option+'.do'); 
   }
	function searchSubmit(){
		document.sch.submit();
	}
</script>


<style>
.edit{
   display:none;
}
</style>
<div id="profileModal" class="modal">
</div>
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
   <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
      <i class="fa fa-bars"></i>
   </button>
           <form id="searchForm" class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search" name="sch" action ="searchAll.do"> 
         <select name="search_option" onchange="change()" class="form-control" style="Width: 15%;vertical-align: middle; height: 10%; float: left;margin-right: 2%; ">
            <option value="All">All</option>
            <option value="Project">Project</option>
            <option value="Member">Member</option>
            <option value="Schedule">Schedule</option>
         </select>   
         <input type="text" class="form-control bg-light border-0 small"   placeholder="검색어를 입력해주세요 " aria-label="Search" name="searchInput"  aria-describedby="basic-addon2" style="font-size: 1rem;width: 64%;float: left; margin-right: 2%;">
            <button id="searchBtn"class="btn btn-primary" type="button" onclick="searchSubmit()">
               <i class="fas fa-search fa-sm"></i>
            </button>
      </form>
             <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto">

            <!-- Nav Item - Search Dropdown (Visible Only XS) -->
            <li class="nav-item dropdown no-arrow d-sm-none">
              <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-search fa-fw"></i>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in" aria-labelledby="searchDropdown">
                <form class="form-inline mr-auto w-100 navbar-search">
                  <div class="input-group">
                     <select name="search_option" onchange="change()" class="form-control">
                  <option value="All">All</option>
                  <option value="Project">Project</option>
                  <option value="Member">Member</option>
                  <option value="Schedule">Schedule</option>
               </select>   
                    <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                    <div class="input-group-append">
                      <button class="btn btn-primary" type="button">
                        <i class="fas fa-search fa-sm"></i>
                      </button>
                    </div>
                  </div>
                </form>
              </div>
            </li>

            <div class="topbar-divider d-none d-sm-block"></div>

            <!-- Nav Item - User Information -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">${user.mid}</span>
                <img class="img-profile rounded-circle" src="img/sublogo.png">
              </a>
              <!-- Dropdown - User Information -->
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="javascript:showModal('profileModal')">
                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                  	비밀번호변경
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="logout.do">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  	로그아웃
                </a>
              </div>
            </li>
          </ul>
          
  
      
      
      
        
           
</nav>


