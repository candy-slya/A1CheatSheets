<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:Arial,sans-serif;

    background:linear-gradient(
        135deg,
        #F6FFEE,
        #FFF7FB,
        #FAD2CC
    );

    color:#333;

    min-height:100vh;
}

.main-content{
    margin-left:270px;
    padding:40px;
    min-height:calc(100vh - 82px);
}

.container{
    max-width:1200px;
    margin:0 auto;
}

.page-title{
    color:#F48882;
    font-size:46px;
    margin-bottom:10px;
}

.page-subtitle{
    color:#666;
    font-size:16px;
    margin-bottom:40px;
}

.dashboard-grid{
    display:grid;

    grid-template-columns:
        repeat(auto-fit,minmax(240px,1fr));

    gap:24px;
}

.dashboard-card{
    background:white;

    border:2px solid #C6FAD2;

    border-radius:28px;

    padding:30px;

    text-decoration:none;

    color:#333;

    box-shadow:0 10px 24px rgba(0,0,0,0.08);

    transition:0.25s;
}

.dashboard-card:hover{
    transform:translateY(-6px);
    border-color:#DD9BCF;
}

.card-icon{
    font-size:42px;
    margin-bottom:18px;
}

.card-title{
    font-size:24px;
    font-weight:bold;
    color:#F48882;
    margin-bottom:10px;
}

.card-desc{
    color:#666;
    line-height:1.6;
}

.user-footer-wrap{
    margin-left:270px;
}

@media(max-width:950px){

    .main-content{
        margin-left:0;
        padding:24px 16px;
    }

    .dashboard-grid{
        grid-template-columns:1fr;
    }

    .user-footer-wrap{
        margin-left:0;
    }
}

</style>

</head>

<body>

<jsp:include page="header.jsp" />

<jsp:include page="userSidebar.jsp" />

<div class="main-content">

    <div class="container">

        <h1 class="page-title">
            Profile
        </h1>

        <p class="page-subtitle">
            Manage your account and cheatsheets.
        </p>

        <div class="dashboard-grid">

            <a href="${pageContext.request.contextPath}/editProfile.jsp"
               class="dashboard-card">

                <div class="card-icon">👤</div>

                <div class="card-title">
                    Edit Name
                </div>

                <div class="card-desc">
                    Change your username
                    and profile information.
                </div>

            </a>

            <a href="${pageContext.request.contextPath}/changePassword.jsp"
               class="dashboard-card">

                <div class="card-icon">🔒</div>

                <div class="card-title">
                    Change Password
                </div>

                <div class="card-desc">
                    Update your password
                    and keep account secure.
                </div>

            </a>

            <a href="${pageContext.request.contextPath}/PublicCheatsheetServlet"
               class="dashboard-card">

                <div class="card-icon">🌍</div>

                <div class="card-title">
                    Public Cheatsheets
                </div>

                <div class="card-desc">
                    View your public cheatsheets.
                </div>

            </a>

            <a href="${pageContext.request.contextPath}/PrivateCheatsheetServlet"
               class="dashboard-card">

                <div class="card-icon">🔐</div>

                <div class="card-title">
                    Private Cheatsheets
                </div>

                <div class="card-desc">
                    View your private cheatsheets.
                </div>

            </a>

            <a href="${pageContext.request.contextPath}/BookmarkListServlet"
               class="dashboard-card">

                <div class="card-icon">🔖</div>

                <div class="card-title">
                    My Bookmarks
                </div>

                <div class="card-desc">
                    View saved public cheatsheets.
                </div>

            </a>
            
            
            <a href="${pageContext.request.contextPath}/RatingRecordListServlet"
   class="dashboard-card">

    <div class="card-icon">⭐</div>

    <div class="card-title">
        Rating Records
    </div>

    <div class="card-desc">
        See who rated your cheatsheets.
    </div>

</a>

           

        </div>

    </div>

</div>


</body>
</html>