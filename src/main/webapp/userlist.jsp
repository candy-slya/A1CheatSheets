<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
    prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Manage Users</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

:root{
    --pink:#DD9BCF;
    --light-pink:#FFF7FB;
    --peach:#FAD2CC;
    --green:#C6FAD2;
    --coral:#F48882;
}

body{

    font-family:Arial,sans-serif;

    background:linear-gradient(
        135deg,
        #F6FFEE,
        #FFF7FB,
        #FAD2CC
    );

    min-height:100vh;

    color:#333;
}

/* LAYOUT */

.page-wrapper{
    display:flex;
    min-height:100vh;
}

/* SIDEBAR */

.sidebar{

    width:270px;

    background:rgba(255,255,255,0.92);

    backdrop-filter:blur(10px);

    border-right:3px solid var(--green);

    padding:30px 18px;

    box-shadow:6px 0 22px rgba(0,0,0,0.06);

    position:fixed;

    top:0;
    left:0;
    bottom:0;
}

.admin-profile-card{

    background:linear-gradient(
        135deg,
        #FFF7FB,
        #F6FFEE
    );

    border:2px solid var(--green);

    border-radius:30px;

    padding:30px 20px;

    text-align:center;

    margin-bottom:35px;

    box-shadow:0 10px 24px rgba(0,0,0,0.08);
}

.profile-avatar-large{

    width:100px;
    height:100px;

    margin:auto;

    border-radius:50%;

    background:linear-gradient(
        135deg,
        var(--pink),
        var(--coral)
    );

    color:white;

    display:flex;
    align-items:center;
    justify-content:center;

    font-size:40px;

    font-weight:bold;

    margin-bottom:18px;
}

.admin-name{

    color:var(--coral);

    font-size:28px;

    font-weight:bold;
}

/* SIDEBAR MENU */

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

    border:2px solid var(--green);

    color:#444;

    font-weight:bold;

    transition:0.25s;
}

.menu-card:hover{

    transform:translateY(-4px);

    border-color:var(--pink);

    box-shadow:0 10px 22px rgba(0,0,0,0.08);
}

.menu-icon{

    width:48px;
    height:48px;

    border-radius:15px;

    background:linear-gradient(
        135deg,
        var(--pink),
        var(--coral)
    );

    display:flex;
    align-items:center;
    justify-content:center;

    color:white;

    font-size:18px;
}

/* MAIN */

.main-content{

    margin-left:270px;

    width:calc(100% - 270px);

    padding:40px;
}

/* TOP */

.top-bar{

    display:flex;

    justify-content:space-between;

    align-items:center;

    gap:20px;

    flex-wrap:wrap;

    margin-bottom:30px;
}

.page-title{

    color:var(--coral);

    font-size:42px;

    font-weight:bold;
}

/* SEARCH */

.search-area{

    display:flex;

    align-items:center;

    gap:14px;

    flex-wrap:wrap;
}

.search-box{

    display:flex;

    align-items:center;

    background:white;

    border:2px solid var(--green);

    border-radius:18px;

    overflow:hidden;

    width:340px;

    max-width:100%;
}

.search-box input{

    flex:1;

    border:none;

    padding:14px 16px;

    outline:none;

    font-size:15px;

    background:transparent;
}

.search-box button{

    border:none;

    background:linear-gradient(
        135deg,
        var(--pink),
        var(--coral)
    );

    color:white;

    width:60px;

    height:50px;

    cursor:pointer;
}

/* BAN USER BUTTON */

.ban-list-btn{

    text-decoration:none;

    background:#FAD2CC;

    color:#B74B4B;

    padding:14px 18px;

    border-radius:18px;

    font-weight:bold;

    display:flex;

    align-items:center;

    gap:10px;

    transition:0.25s;
}

.ban-list-btn:hover{

    background:#F48882;

    color:white;

    transform:translateY(-3px);
}

/* TABLE */

.table-wrapper{

    background:white;

    border-radius:28px;

    border:2px solid var(--green);

    overflow:hidden;

    box-shadow:0 12px 30px rgba(0,0,0,0.08);
}

table{

    width:100%;

    border-collapse:collapse;
}

thead{

    background:linear-gradient(
        135deg,
        var(--pink),
        var(--coral)
    );

    color:white;
}

th{

    padding:20px 16px;

    text-align:left;
}

td{

    padding:18px 16px;

    border-bottom:1px solid #eee;

    color:#444;
}

tr:hover{

    background:#FFF7FB;
}

/* ROLE */

.role{

    color:var(--coral);

    font-weight:bold;
}

/* ACTION */

.action-group{

    display:flex;

    gap:10px;

    flex-wrap:wrap;
}

.action-btn{

    border:none;

    padding:10px 16px;

    border-radius:14px;

    font-weight:bold;

    cursor:pointer;

    transition:0.25s;
}

.remove-btn{

    background:#FAD2CC;

    color:#B74B4B;
}

.remove-btn:hover{

    background:#F48882;

    color:white;
}

.restore-btn{

    background:#C6FAD2;

    color:#2B7A40;
}

.restore-btn:hover{

    background:#89D8A1;

    color:white;
}

.subadmin-btn{

    background:#DD9BCF;

    color:white;
}

.subadmin-btn:hover{

    background:#C97DB8;
}

/* PAGINATION */

.pagination{

    margin-top:28px;

    display:flex;

    justify-content:center;

    gap:12px;

    flex-wrap:wrap;
}

.page-link{

    text-decoration:none;

    padding:12px 18px;

    border-radius:14px;

    background:white;

    border:2px solid var(--green);

    color:#444;

    font-weight:bold;

    transition:0.25s;
}

.page-link:hover{

    background:var(--pink);

    color:white;

    border-color:var(--pink);
}

.active-page{

    background:linear-gradient(
        135deg,
        var(--pink),
        var(--coral)
    );

    color:white;

    border-color:var(--pink);
}

/* RESPONSIVE */

@media(max-width:950px){

    .sidebar{

        width:100%;

        position:relative;

        border-right:none;
    }

    .page-wrapper{
        flex-direction:column;
    }

    .main-content{

        margin-left:0;

        width:100%;

        padding:30px 18px;
    }

    .table-wrapper{
        overflow-x:auto;
    }

    table{
        min-width:850px;
    }

    .page-title{
        font-size:34px;
    }
}

</style>

</head>

<body>

<div class="page-wrapper">

    <!-- SIDEBAR -->

<jsp:include page="adminSidebar.jsp" />

    <!-- MAIN -->

    <div class="main-content">

        <div class="top-bar">

            <h1 class="page-title">
                Manage Users
            </h1>

            <div class="search-area">

                <!-- SEARCH -->

                <form action="ManageUsersServlet"
                      method="get"
                      class="search-box">

                    <input type="text"
                           name="keyword"
                           placeholder="Search users...">

                    <button type="submit">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>

                </form>

                <!-- BAN USER LIST -->

                <a href="BanUserListServlet"
                   class="ban-list-btn">

                    <i class="fa-solid fa-user-slash"></i>

                    Banned Users

                </a>

            </div>

        </div>

        <!-- TABLE -->

        <div class="table-wrapper">

            <table>

                <thead>

                    <tr>

                        <th>#</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Action</th>

                    </tr>

                </thead>

                <tbody>

                    <c:forEach var="u"
                               items="${users}"
                               varStatus="i">

                        <tr>

                            <td>${i.index+1}</td>

                            <td>${u.name}</td>

                            <td>${u.email}</td>

                            <td>

                                <span class="role">
                                    ${u.role}
                                </span>

                            </td>

                            <td>

                                <div class="action-group">

                                    <!-- REMOVE / UNREMOVE -->

                                    <c:choose>

                                        <c:when test="${u.status eq 'active'}">

                                            <form action="BanUserServlet"
                                                  method="post">

                                                <input type="hidden"
                                                       name="id"
                                                       value="${u.id}"/>

                                                <button type="submit"
                                                        class="action-btn remove-btn">

                                                    Remove

                                                </button>

                                            </form>

                                        </c:when>

                                        <c:otherwise>

                                            <form action="UnbanUserServlet"
                                                  method="post">

                                                <input type="hidden"
                                                       name="id"
                                                       value="${u.id}"/>

                                                <button type="submit"
                                                        class="action-btn restore-btn">

                                                    Unremove

                                                </button>

                                            </form>

                                        </c:otherwise>

                                    </c:choose>

                                    <!-- SUB ADMIN -->

                                    <c:if test="${u.role eq 'user'}">

                                        <form action="MakeSubAdminServlet"
                                              method="post">

                                            <input type="hidden"
                                                   name="id"
                                                   value="${u.id}"/>

                                            <button type="submit"
                                                    class="action-btn subadmin-btn">

                                                Sub Admin

                                            </button>

                                        </form>

                                    </c:if>

                                </div>

                            </td>

                        </tr>

                    </c:forEach>

                </tbody>

            </table>

        </div>

        <!-- PAGINATION -->

        <div class="pagination">

            <a href="#"
               class="page-link active-page">
                1
            </a>

            <a href="#"
               class="page-link">
                2
            </a>

            <a href="#"
               class="page-link">
                3
            </a>

        </div>

    </div>

</div>

</body>
</html>