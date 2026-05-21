<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="model.UserBean" %>
<%@ page session="true" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
    prefix="c"%>

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
<title>Pending Cheatsheets</title>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:Arial,sans-serif;
    background:linear-gradient(135deg,#F6FFEE,#FFF7FB,#FAD2CC);
    color:#333;
    min-height:100vh;
}

.main-content{
    margin-left:270px;
    padding:40px;
}

.container{
    max-width:1200px;
    margin:0 auto;
    padding:0 22px 60px;
}

.top-bar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:35px;
    flex-wrap:wrap;
    gap:15px;
}

.back-btn{
    text-decoration:none;
    background:white;
    color:#F48882;
    border:2px solid #FAD2CC;
    padding:13px 22px;
    border-radius:999px;
    font-weight:bold;
    box-shadow:0 8px 18px rgba(0,0,0,0.06);
    transition:0.25s;
}

.back-btn:hover{
    transform:translateY(-4px);
    border-color:#DD9BCF;
}

.page-title{
    color:#F48882;
    font-size:42px;
    margin-bottom:10px;
}

.page-subtitle{
    color:#666;
    font-size:16px;
    margin-bottom:32px;
}

.success-box{
    background:#C6FAD2;
    color:#2B7A40;
    padding:14px 18px;
    border-radius:16px;
    margin-bottom:25px;
    font-weight:bold;
    border:2px solid #9BE7B0;
}

.sheet-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(320px,1fr));
    gap:28px;
}

.sheet-card{
    background:white;
    border:2px solid #F3D5EE;
    border-radius:30px;
    overflow:hidden;
    box-shadow:0 14px 32px rgba(0,0,0,0.08);
    transition:0.25s;
}

.sheet-card:hover{
    transform:translateY(-8px);
    border-color:#DD9BCF;
    box-shadow:0 22px 42px rgba(221,155,207,0.22);
}

.sheet-title{
    background:#FFF7FB;
    border-bottom:2px solid #FAD2CC;
    padding:24px;
}

.sheet-title a{
    text-decoration:none;
    color:#F48882;
    font-size:28px;
    line-height:1.35;
    font-weight:800;
}

.sheet-title a:hover{
    color:#DD9BCF;
}

.card-content{
    padding:24px;
}

.meta{
    display:inline-flex;
    align-items:center;
    gap:12px;
    margin-bottom:22px;
    padding:10px 16px;
    border-radius:16px;
    background:#FFF7FB;
    border:2px solid #F3D5EE;
    font-size:15px;
    font-weight:bold;
    color:#666;
}

.meta span{
    color:#DD9BCF;
    font-weight:800;
}

.user-badge{
    padding:7px 14px;
    border-radius:999px;
    background:linear-gradient(135deg,#FAD2CC,#FFF7FB);
    color:#F48882;
    font-weight:bold;
}

.tag-title{
    margin-bottom:14px;
    font-size:16px;
    font-weight:800;
    color:#DD9BCF;
}

.tags-text{
    color:#555;
    line-height:1.6;
    margin-bottom:25px;
}

.status-badge{
    display:inline-block;
    background:#FFF3CD;
    color:#856404;
    padding:9px 15px;
    border-radius:999px;
    font-size:14px;
    font-weight:bold;
    margin-bottom:24px;
}

.action-group{
    display:flex;
    flex-wrap:wrap;
    gap:12px;
}

.action-btn{
    text-decoration:none;
    padding:12px 18px;
    border-radius:14px;
    font-size:14px;
    font-weight:bold;
    transition:0.2s;
}

.view-btn{
    background:#DD9BCF;
    color:white;
}

.approve-btn{
    background:#C6FAD2;
    color:#2B7A40;
}

.action-btn:hover{
    transform:translateY(-3px);
}

.empty{
    background:white;
    border:2px solid #C6FAD2;
    border-radius:28px;
    padding:50px;
    text-align:center;
    color:#777;
    box-shadow:0 12px 28px rgba(0,0,0,0.08);
}

.empty h2{
    color:#F48882;
    margin-bottom:10px;
}

@media(max-width:950px){
    .main-content{
        margin-left:0;
        padding:20px;
    }
}

@media(max-width:650px){
    .page-title{
        font-size:34px;
    }

    .sheet-grid{
        grid-template-columns:1fr;
    }

    .sheet-title a{
        font-size:24px;
    }
}
</style>
</head>

<body>

<jsp:include page="adminSidebar.jsp" />

<div class="main-content">

    <div class="container">

       

        <h1 class="page-title">
            Pending Cheatsheets
        </h1>

        <p class="page-subtitle">
            Review user publish requests and approve public cheatsheets.
        </p>

        <c:if test="${param.success eq 'public'}">
            <div class="success-box">
                Public successful.
            </div>
        </c:if>

        <c:choose>

            <c:when test="${not empty pendingList}">

                <div class="sheet-grid">

                    <c:forEach var="cs"
                               items="${pendingList}">

                        <div class="sheet-card">

                            <div class="sheet-title">

                                <a href="${pageContext.request.contextPath}/ViewCheatsheetServlet?id=${cs.id}">
                                    ${cs.title}
                                </a>

                            </div>

                            <div class="card-content">

                                <div class="meta">
                                    <span>By</span>

                                    <div class="user-badge">
                                        ${cs.username}
                                    </div>
                                </div>

                                <div class="tag-title">
                                    Tags
                                </div>

                                <div class="tags-text">
                                    ${cs.tags}
                                </div>

                                <div class="status-badge">
                                    Waiting for admin approval
                                </div>

                                <div class="action-group">

                                    <a class="action-btn view-btn"
                                       href="${pageContext.request.contextPath}/ViewCheatsheetServlet?id=${cs.id}">
                                        View
                                    </a>

                                    <a class="action-btn approve-btn"
                                       onclick="return confirm('Approve this cheatsheet?')"
                                       href="${pageContext.request.contextPath}/ApproveCheatsheetServlet?id=${cs.id}">
                                        Approve
                                    </a>

                                </div>

                            </div>

                        </div>

                    </c:forEach>

                </div>

            </c:when>

            <c:otherwise>

                <div class="empty">
                    <h2>No pending cheatsheets.</h2>
                    <p>Publish requests will appear here.</p>
                </div>

            </c:otherwise>

        </c:choose>

    </div>

</div>

</body>
</html>