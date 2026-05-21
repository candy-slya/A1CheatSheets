<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="model.UserBean" %>

<%
    UserBean loginUser =
        (UserBean)
        session.getAttribute(
            "loginUser");
%>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

.sidebar{

    width:270px;

    background:rgba(255,255,255,0.92);

    backdrop-filter:blur(10px);

    border-right:3px solid #C6FAD2;

    padding:30px 18px;

    box-shadow:
        6px 0 22px
        rgba(0,0,0,0.06);

    position:fixed;

    top:0;
    left:0;
    bottom:0;

    overflow-y:auto;
}

/* PROFILE */

.admin-profile-card{

    background:linear-gradient(
        135deg,
        #FFF7FB,
        #F6FFEE
    );

    border:2px solid #C6FAD2;

    border-radius:30px;

    padding:32px 20px;

    text-align:center;

    margin-bottom:35px;

    box-shadow:
        0 10px 24px
        rgba(0,0,0,0.08);
}

.profile-avatar-large{

    width:100px;
    height:100px;

    margin:auto;

    border-radius:50%;

    background:linear-gradient(
        135deg,
        #DD9BCF,
        #F48882
    );

    color:white;

    display:flex;

    align-items:center;

    justify-content:center;

    font-size:40px;

    font-weight:bold;

    margin-bottom:18px;

    box-shadow:
        0 10px 24px
        rgba(244,136,130,0.28);
}

.admin-name{

    color:#F48882;

    font-size:28px;

    font-weight:bold;
}

/* MENU */

.sidebar-menu{

    display:flex;

    flex-direction:column;

    gap:16px;
}

.menu-card{

    display:flex;

    align-items:center;

    gap:16px;

    padding:16px 18px;

    border-radius:20px;

    text-decoration:none;

    background:linear-gradient(
        135deg,
        #FFF7FB,
        #F6FFEE
    );

    border:2px solid #C6FAD2;

    color:#444;

    font-weight:bold;

    transition:0.25s;
}

.menu-card:hover{

    transform:translateY(-4px);

    border-color:#DD9BCF;

    box-shadow:
        0 10px 22px
        rgba(0,0,0,0.08);
}

.menu-icon{

    width:48px;
    height:48px;

    border-radius:15px;

    background:linear-gradient(
        135deg,
        #DD9BCF,
        #F48882
    );

    display:flex;

    align-items:center;

    justify-content:center;

    color:white;

    font-size:18px;
}

.logout-card{

    margin-top:10px;

    border:2px solid #F4B2A8;
}

/* RESPONSIVE */

@media(max-width:950px){

    .sidebar{

        width:100%;

        height:auto;

        position:relative;

        border-right:none;

        border-bottom:3px solid #C6FAD2;
    }
}

</style>

<div class="sidebar">

    <div class="admin-profile-card">

        <div class="profile-avatar-large">

            <%= loginUser
                .getName()
                .substring(0,1)
                .toUpperCase() %>

        </div>

        <h2 class="admin-name">
            Welcome Admin
        </h2>

    </div>

    <div class="sidebar-menu">

        <!-- DASHBOARD -->

        <a href="${pageContext.request.contextPath}/AdminDashboardServlet"
           class="menu-card">

            <div class="menu-icon">
                <i class="fa-solid fa-chart-line"></i>
            </div>

            Dashboard

        </a>

        <!-- USERS -->

        <a href="${pageContext.request.contextPath}/ManageUsersServlet"
           class="menu-card">

            <div class="menu-icon">
                <i class="fa-solid fa-users"></i>
            </div>

            Manage Users

        </a>

        <!-- CATEGORIES -->

        <a href="${pageContext.request.contextPath}/ManageCategoriesServlet"
           class="menu-card">

            <div class="menu-icon">
                <i class="fa-solid fa-layer-group"></i>
            </div>

            Categories

        </a>

        <!-- PENDING -->

        <a href="${pageContext.request.contextPath}/PendingCheatsheetServlet"
           class="menu-card">

            <div class="menu-icon">
                <i class="fa-solid fa-file-lines"></i>
            </div>

            Pending Cheatsheets list

        </a>

        <!-- RECORDS -->

        <a href="${pageContext.request.contextPath}/CheatsheetRecordServlet"
           class="menu-card">

            <div class="menu-icon">
                <i class="fa-solid fa-clock-rotate-left"></i>
            </div>

            Cheatsheet Records list

        </a>

        <!-- LOGOUT -->

        <a href="${pageContext.request.contextPath}/logout.jsp"
           class="menu-card logout-card">

            <div class="menu-icon">
                <i class="fa-solid fa-right-from-bracket"></i>
            </div>

            Logout

        </a>

    </div>

</div>