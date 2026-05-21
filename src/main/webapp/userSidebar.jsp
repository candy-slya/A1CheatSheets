<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page session="true" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
    prefix="c"%>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

.user-sidebar{
    width:270px;

    background:rgba(255,255,255,0.94);

    border-right:3px solid #C6FAD2;

    padding:30px 18px;

    box-shadow:6px 0 22px rgba(0,0,0,0.06);

    position:fixed;

    top:82px;

    left:0;
    bottom:0;

    overflow-y:auto;

    z-index:20;
}

.user-profile-card{
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

    box-shadow:0 10px 24px rgba(0,0,0,0.08);
}

.user-avatar-large{
    width:95px;
    height:95px;

    margin:0 auto 18px;

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

    font-size:38px;
    font-weight:bold;
}

.sidebar-name{
    color:#F48882;
    font-size:26px;
    font-weight:bold;
}

.sidebar-email{
    margin-top:8px;
    color:#777;
    font-size:14px;
    word-break:break-word;
}

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
    box-shadow:0 10px 22px rgba(0,0,0,0.08);
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

    color:white;

    display:flex;
    align-items:center;
    justify-content:center;

    font-size:18px;
}

.logout-card{
    border-color:#F4B2A8;
}

@media(max-width:950px){

    .user-sidebar{
        width:100%;
        height:auto;
        position:relative;
        top:0;
        border-right:none;
        border-bottom:3px solid #C6FAD2;
    }
}

</style>

<div class="user-sidebar">

    <div class="user-profile-card">

        <div class="user-avatar-large">
            ${sessionScope.loginUser.name.substring(0,1).toUpperCase()}
        </div>

        <div class="sidebar-name">
            ${sessionScope.loginUser.name}
        </div>

        <div class="sidebar-email">
            ${sessionScope.loginUser.email}
        </div>

    </div>

    <div class="sidebar-menu">

        <a href="${pageContext.request.contextPath}/ProfileViewServlet"
           class="menu-card">

            <div class="menu-icon">
                <i class="fa-solid fa-user"></i>
            </div>

            Profile

        </a>

        <a href="${pageContext.request.contextPath}/editProfile.jsp"
           class="menu-card">

            <div class="menu-icon">
                <i class="fa-solid fa-pen"></i>
            </div>

            Edit Name

        </a>

        <a href="${pageContext.request.contextPath}/changePassword.jsp"
           class="menu-card">

            <div class="menu-icon">
                <i class="fa-solid fa-lock"></i>
            </div>

            Change Password

        </a>

        <a href="${pageContext.request.contextPath}/PublicCheatsheetServlet"
           class="menu-card">

            <div class="menu-icon">
                <i class="fa-solid fa-globe"></i>
            </div>

            Public Cheatsheets

        </a>

        <a href="${pageContext.request.contextPath}/PrivateCheatsheetServlet"
           class="menu-card">

            <div class="menu-icon">
                <i class="fa-solid fa-eye-slash"></i>
            </div>

            Private Cheatsheets

        </a>

        <a href="${pageContext.request.contextPath}/BookmarkListServlet"
           class="menu-card">

            <div class="menu-icon">
                <i class="fa-solid fa-bookmark"></i>
            </div>

            My Bookmarks

        </a>
        
        
        <a href="${pageContext.request.contextPath}/RatingRecordListServlet"
   class="menu-card">

    <div class="menu-icon">
        <i class="fa-solid fa-star"></i>
    </div>

    Rating Records

</a>

       

        <a href="${pageContext.request.contextPath}/logout.jsp"
           class="menu-card logout-card">

            <div class="menu-icon">
                <i class="fa-solid fa-right-from-bracket"></i>
            </div>

            Logout

        </a>

    </div>

</div>