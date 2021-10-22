<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
         <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="mainIndexAdmin.do">
               <div class="sidebar-brand-icon">
                  <img src="img/sublogo.png" class="tib_sub_logo" style="width:50px;height:50px;">
               </div>
               <div class="sidebar-brand-text mx-3"></div>
            </a>
            <!-- Divider -->
            <hr class="sidebar-divider my-0">
            <!-- Heading -->
            
            <div class="sidebar-heading">admin</div>
            <!-- Nav Item - Pages Collapse Menu -->
   
            <li class="nav-item">
               <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#admin" aria-expanded="true" aria-controls="#admin"> 
                  <span>홈페이지관리</span>
               </a>
               <div id="admin" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                     <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Manage</h6> <!--회색깔 살짝알려주는곳  -->
                        <a class="collapse-item" href="addUniv.do">제휴대학추가</a> <!--메뉴들 -->
                        <a class="collapse-item" href="updateUniv.do">제휴대학관리</a> <!--메뉴들 -->
                        <a class="collapse-item" href="allMemberInfo.do">회원정보관리</a> 
                        <a class="collapse-item" href="AllprojectInfo.do">tib프로젝트관리</a> 
                        <a class="collapse-item" href="mainIndexAdmin.do">메인화면설정</a>
                        <a class="collapse-item" href="domesticUnivList.do">전국대학정보</a>
                     </div>
               </div>
            </li>
         
            <!-- Divider -->
            <hr class="sidebar-divider">
                <div class="text-center d-none d-md-inline">
               <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>
         </ul>
          <%@include file="adminModalPage.jsp" %>
         <!-- End of Sidebar -->