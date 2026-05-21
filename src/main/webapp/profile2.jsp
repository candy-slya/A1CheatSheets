<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page session="true" %>

<%@ page import="model.UserBean" %>

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
    font-family:Arial, sans-serif;
    background:linear-gradient(135deg,#F6FFEE,#FFF7FB,#FAD2CC);
    color:#333;
    min-height:100vh;
}

.page-wrapper{
    max-width:1100px;
    margin:50px auto;
    padding:0 20px;
}

.profile-top{
    background:rgba(255,255,255,0.92);
    border:3px solid #C6FAD2;
    border-radius:28px;
    padding:35px;
    margin-bottom:35px;
    box-shadow:0 10px 24px rgba(0,0,0,0.08);
    text-align:center;
}

.profile-avatar{
    width:95px;
    height:95px;
    border-radius:50%;
    background:#DD9BCF;
    color:white;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:38px;
    font-weight:bold;
    margin:0 auto 18px;
}

.profile-name{
    font-size:38px;
    color:#F48882;
    font-weight:bold;
    margin-bottom:10px;
}

.profile-email{
    color:#666;
    font-size:17px;
}

.dashboard-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,250px));
    justify-content:center;
    gap:22px;
}

.dashboard-card{
    background:white;
    border-radius:24px;
    padding:24px 20px;
    text-decoration:none;
    transition:0.25s;
    box-shadow:0 8px 22px rgba(0,0,0,0.08);
    border:3px solid transparent;
    text-align:center;
    min-height:210px;
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
}

.dashboard-card:hover{
    transform:translateY(-6px);
    border-color:#DD9BCF;
    box-shadow:0 12px 28px rgba(0,0,0,0.12);
}

.edit-card{
    background:#FFF7FB;
}

.public-card{
    background:#F6FFEE;
}

.private-card{
    background:#FFF5F5;
}

.card-icon{
    font-size:42px;
    margin-bottom:16px;
}

.card-title{
    font-size:22px;
    font-weight:bold;
    color:#F48882;
    margin-bottom:8px;
}

.card-desc{
    color:#666;
    line-height:1.5;
    font-size:14px;
}

.profile-action-row{
    display:flex;
    gap:10px;
    flex-wrap:wrap;
    justify-content:center;
    margin-top:18px;
}

.profile-small-btn{
    text-decoration:none;
    padding:10px 14px;
    border-radius:14px;
    background:#DD9BCF;
    color:white;
    font-size:13px;
    font-weight:bold;
    transition:0.2s;
}

.profile-small-btn:hover{
    background:#F48882;
    transform:translateY(-2px);
}

.password-btn{
    background:#C6FAD2;
    color:#333;
}

.password-btn:hover{
    background:#9BE7B0;
}

.logout-wrapper{
    margin-top:35px;
    display:flex;
    justify-content:center;
}

.logout-btn{
    background:#F48882;
    color:white;
    text-decoration:none;
    padding:14px 34px;
    border-radius:30px;
    font-weight:bold;
    font-size:16px;
    box-shadow:0 8px 20px rgba(0,0,0,0.08);
    transition:0.2s;
}

.logout-btn:hover{
    background:#DD9BCF;
    transform:translateY(-2px);
}

@media(max-width:700px){
    .profile-name{
        font-size:30px;
    }

    .dashboard-grid{
        grid-template-columns:1fr 1fr;
    }
}

@media(max-width:500px){
    .dashboard-grid{
        grid-template-columns:1fr;
    }

    .dashboard-card{
        min-height:190px;
    }

    .profile-top{
        padding:28px 20px;
    }

    .profile-avatar{
        width:80px;
        height:80px;
        font-size:30px;
    }

    .profile-name{
        font-size:26px;
    }

    .profile-email{
        font-size:15px;
    }
}
</style>
</head>

<body>

<jsp:include page="header.jsp" />

<%
    UserBean loginUser =
        (UserBean) session.getAttribute("loginUser");

    if(loginUser == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<div class="page-wrapper">

    <div class="profile-top">

        <div class="profile-avatar">
            <%= loginUser.getName().substring(0,1).toUpperCase() %>
        </div>

        <div class="profile-name">
            <%= loginUser.getName() %>
        </div>

        <div class="profile-email">
            <%= loginUser.getEmail() %>
        </div>

    </div>

    <div class="dashboard-grid">

        <div class="dashboard-card edit-card">

            <div class="card-icon">⚙️</div>

            <div class="card-title">
                Edit Profile
            </div>

            <div class="card-desc">
                Update your name or change your password.
            </div>

            <div class="profile-action-row">

                <a class="profile-small-btn"
                   href="${pageContext.request.contextPath}/editProfile.jsp">
                    Edit Name
                </a>

                <a class="profile-small-btn password-btn"
                   href="${pageContext.request.contextPath}/changePassword.jsp">
                    Change Password
                </a>

            </div>

        </div>

        <a href="${pageContext.request.contextPath}/PublicCheatsheetServlet"
           class="dashboard-card public-card">

            <div class="card-icon">🌍</div>

            <div class="card-title">
                Public Cheatsheets
            </div>

            <div class="card-desc">
                View all your shared cheatsheets.
            </div>

        </a>

        <a href="${pageContext.request.contextPath}/PrivateCheatsheetServlet"
           class="dashboard-card private-card">

            <div class="card-icon">🔒</div>

            <div class="card-title">
                Private Cheatsheets
            </div>

            <div class="card-desc">
                Manage your hidden cheatsheets.
            </div>

        </a>

    </div>

    <div class="logout-wrapper">

        <a href="${pageContext.request.contextPath}/logout.jsp"
           class="logout-btn">
            🚪 Logout
        </a>

    </div>

</div>

<jsp:include page="footer.jsp" />

</body>
</html>