<%@ page import="model.UserBean" %>
<%@ page session="true" %>

<%
    UserBean loginUser =
        (UserBean) session.getAttribute("loginUser");

    if(loginUser == null ||
       !"admin".equalsIgnoreCase(loginUser.getRole())){

        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

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

/* ADMIN CARD */

.admin-profile-card{

    background:linear-gradient(
        135deg,
        #FFF7FB,
        #F6FFEE
    );

    border:2px solid var(--green);

    border-radius:30px;

    padding:32px 20px;

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

    box-shadow:0 10px 24px rgba(244,136,130,0.28);
}

.admin-name{

    color:var(--coral);

    font-size:30px;

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

.logout-card{

    margin-top:12px;

    border:2px solid #F4B2A8;
}

/* MAIN */

.main-content{

    margin-left:270px;

    width:calc(100% - 270px);

    padding:45px 40px;
}

/* TOP */

.top-title{

    margin-bottom:35px;
}

.top-title h1{

    color:var(--coral);

    font-size:48px;

    margin-bottom:10px;
}

.top-title p{

    color:#666;

    font-size:17px;
}

/* DASHBOARD */

.dashboard-grid{

    display:grid;

    grid-template-columns:
        repeat(auto-fit,minmax(240px,1fr));

    gap:25px;
}

.dashboard-card{

    background:white;

    border-radius:30px;

    padding:30px;

    border:2px solid var(--green);

    box-shadow:0 10px 26px rgba(0,0,0,0.08);

    transition:0.25s;
}

.dashboard-card:hover{

    transform:translateY(-6px);

    border-color:var(--pink);

    box-shadow:0 16px 34px rgba(0,0,0,0.12);
}

.dashboard-link{

    display:block;

    text-decoration:none;

    color:inherit;
}

.card-top{

    display:flex;

    justify-content:space-between;

    align-items:center;

    margin-bottom:24px;
}

.card-icon{

    width:68px;
    height:68px;

    border-radius:22px;

    background:linear-gradient(
        135deg,
        var(--pink),
        var(--coral)
    );

    color:white;

    display:flex;
    align-items:center;
    justify-content:center;

    font-size:28px;
}

.card-number{

    font-size:44px;

    color:var(--coral);

    font-weight:bold;
}

.card-title{

    color:#555;

    font-size:20px;

    font-weight:bold;

    margin-bottom:10px;
}

.card-desc{

    color:#777;

    line-height:1.6;

    font-size:15px;
}

/* RESPONSIVE */

@media(max-width:950px){

    .sidebar{

        width:100%;

        height:auto;

        position:relative;

        border-right:none;

        border-bottom:3px solid var(--green);
    }

    .page-wrapper{

        flex-direction:column;
    }

    .main-content{

        margin-left:0;

        width:100%;

        padding:30px 18px;
    }

    .top-title h1{

        font-size:38px;
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

        <div class="top-title">

            <h1>
                Dashboard
            </h1>

            <p>
                Manage your cheatsheet website easily.
            </p>

        </div>

        <!-- DASHBOARD -->

        <div class="dashboard-grid">

            <!-- USERS -->

            <a href="${pageContext.request.contextPath}/ManageUsersServlet"
               class="dashboard-card dashboard-link">

                <div class="card-top">

                    <div class="card-icon">
                        <i class="fa-solid fa-users"></i>
                    </div>

                    <div class="card-number">
                        ${totalUsers}
                    </div>

                </div>

                <div class="card-title">
                    Total Users
                </div>

                <div class="card-desc">
                    Manage registered users
                    and user activities.
                </div>

            </a>

            <!-- CATEGORIES -->

            <a href="${pageContext.request.contextPath}/CategoriesServlet"
               class="dashboard-card dashboard-link">

                <div class="card-top">

                    <div class="card-icon">
                        <i class="fa-solid fa-layer-group"></i>
                    </div>

                    <div class="card-number">
                        ${totalCategories}
                    </div>

                </div>

                <div class="card-title">
                    Categories
                </div>

                <div class="card-desc">
                    Create and manage
                    cheatsheet categories.
                </div>

            </a>
            
            <!-- CHEATSHEETS -->

<a href="${pageContext.request.contextPath}/CheatsheetRecordServlet"
   class="dashboard-card dashboard-link">

    <div class="card-top">

        <div class="card-icon">
            <i class="fa-solid fa-book"></i>
        </div>

        <div class="card-number">
            ${totalCheatsheets}
        </div>

    </div>

    <div class="card-title">
        Cheatsheets
    </div>

    <div class="card-desc">
        View all cheatsheet
        records and activities.
    </div>

</a>
            
            

            <!-- PENDING -->

            <a href="${pageContext.request.contextPath}/PendingCheatsheetServlet"
               class="dashboard-card dashboard-link">

                <div class="card-top">

                    <div class="card-icon">
                        <i class="fa-solid fa-file-lines"></i>
                    </div>

                    <div class="card-number">
                        ${pendingCheatsheets}
                    </div>

                </div>

                <div class="card-title">
                    Pending Cheatsheets
                </div>

                <div class="card-desc">
                    Review and approve
                    publish requests.
                </div>

            </a>

        </div>

    </div>

</div>

</body>
</html>