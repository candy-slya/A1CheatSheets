<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page session="true" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
    prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>My Bookmarks</title>

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

/* MAIN CONTENT */

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
    margin-bottom:35px;
    font-size:16px;
}

/* GRID */

.bookmark-grid{
    display:grid;

    grid-template-columns:
        repeat(auto-fit,minmax(320px,1fr));

    gap:28px;
}

/* CARD */

.bookmark-card{
    background:white;

    border:2px solid #C6FAD2;

    border-radius:28px;

    padding:24px;

    box-shadow:0 10px 26px rgba(0,0,0,0.08);

    transition:0.25s;
}

.bookmark-card:hover{
    transform:translateY(-6px);
    border-color:#DD9BCF;
}

.cs-top{
    display:flex;
    justify-content:space-between;
    align-items:center;
    gap:12px;

    margin-bottom:18px;
}

.category-badge{
    text-decoration:none;

    background:#FFF7FB;

    color:#F48882;

    border:2px solid #FAD2CC;

    padding:8px 14px;

    border-radius:999px;

    font-size:13px;

    font-weight:bold;
}

.view-count{
    color:#777;

    font-size:14px;

    font-weight:bold;

    background:#F6FFEE;

    border:2px solid #C6FAD2;

    padding:7px 12px;

    border-radius:999px;
}

.bookmark-title{
    margin-bottom:14px;
}

.bookmark-title a{
    text-decoration:none;

    color:#F48882;

    font-size:28px;

    font-weight:800;

    line-height:1.3;
}

.bookmark-title a:hover{
    color:#DD9BCF;
}

.meta{
    font-size:15px;
    color:#555;
    margin-bottom:10px;
}

.meta span{
    color:#DD9BCF;
    font-weight:bold;
}

.meta a{
    color:#8F87F1;
    text-decoration:none;
    font-weight:bold;
}

.meta a:hover{
    text-decoration:underline;
}

.publish-time{
    color:#777;
    font-size:14px;
    margin-bottom:18px;
}

/* BUTTONS */

.bookmark-actions{
    display:flex;
    gap:12px;
    flex-wrap:wrap;
}

.view-btn,
.unbookmark-btn{
    text-decoration:none;

    padding:11px 18px;

    border-radius:12px;

    font-size:14px;

    font-weight:bold;

    transition:0.2s;
}

.view-btn{
    background:#DD9BCF;
    color:white;
}

.view-btn:hover{
    background:#CF87C0;
}

.unbookmark-btn{
    background:#FAD2CC;
    color:#C2185B;
}

.unbookmark-btn:hover{
    background:#F4BDB3;
}

/* EMPTY */

.empty-box{
    background:white;

    border:2px solid #C6FAD2;

    border-radius:28px;

    padding:60px 30px;

    text-align:center;

    color:#777;

    box-shadow:0 10px 24px rgba(0,0,0,0.08);
}

/* FOOTER */

.user-footer-wrap{
    margin-left:270px;
}

/* MOBILE */

@media(max-width:950px){

    .main-content{
        margin-left:0;
        padding:24px 16px;
    }

    .user-footer-wrap{
        margin-left:0;
    }

    .bookmark-grid{
        grid-template-columns:1fr;
    }

    .page-title{
        font-size:36px;
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
            My Bookmarks
        </h1>

        <p class="page-subtitle">
            Your saved public cheatsheets.
        </p>

        <c:choose>

            <c:when test="${not empty bookmarkList}">

                <div class="bookmark-grid">

                    <c:forEach var="cs"
                               items="${bookmarkList}">

                        <div class="bookmark-card">

                            <div class="cs-top">

                                <a class="category-badge"
                                   href="${pageContext.request.contextPath}/CheatsheetListServlet?categoryId=${cs.categoryId}">

                                    ${cs.categoryname}

                                </a>

                                <div class="view-count">
                                    👁 ${cs.viewCount}
                                </div>

                            </div>

                            <h2 class="bookmark-title">

                                <a href="${pageContext.request.contextPath}/ViewCheatsheetServlet?id=${cs.id}">

                                    ${cs.title}

                                </a>

                            </h2>

                            <div class="meta">

                                <span>By :</span>

                                <a href="${pageContext.request.contextPath}/UserProfileServlet?userId=${cs.userId}">

                                    ${cs.username}

                                </a>

                            </div>

                            <div class="publish-time">

                                Published :
                                ${cs.createdAt}

                            </div>

                            <div class="bookmark-actions">

                                <a class="view-btn"
                                   href="${pageContext.request.contextPath}/ViewCheatsheetServlet?id=${cs.id}">

                                    View

                                </a>

                                <a class="unbookmark-btn"
                                   onclick="return confirm('Remove this bookmark?')"
                                   href="${pageContext.request.contextPath}/ToggleBookmarkServlet?id=${cs.id}">

                                    Unbookmark

                                </a>

                            </div>

                        </div>

                    </c:forEach>

                </div>

            </c:when>

            <c:otherwise>

                <div class="empty-box">

                    <h2>
                        No bookmarks yet.
                    </h2>

                </div>

            </c:otherwise>

        </c:choose>

    </div>

</div>

<div class="user-footer-wrap">

    <jsp:include page="footer.jsp" />

</div>

</body>
</html>