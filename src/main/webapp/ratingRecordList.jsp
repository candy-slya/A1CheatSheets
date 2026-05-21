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
<title>Rating Records</title>

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
    padding:120px 44px 40px;
    min-height:calc(100vh - 82px);
}

.container{
    max-width:1200px;
    margin:0 auto;
}

.page-title{
    color:#F48882;
    font-size:44px;
    margin-bottom:10px;
}

.page-subtitle{
    color:#666;
    margin-bottom:30px;
}

.record-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(320px,1fr));
    gap:24px;
}

.record-card{
    background:white;
    border:2px solid #C6FAD2;
    border-radius:28px;
    padding:24px;
    box-shadow:0 10px 26px rgba(0,0,0,0.08);
    transition:0.25s;
}

.record-card:hover{
    transform:translateY(-6px);
    border-color:#DD9BCF;
}

.cheatsheet-title{
    margin-bottom:14px;
}

.cheatsheet-title a{
    color:#F48882;
    text-decoration:none;
    font-size:24px;
    font-weight:bold;
}

.record-meta{
    color:#666;
    font-size:15px;
    margin-bottom:12px;
    line-height:1.6;
}

.record-meta span{
    color:#DD9BCF;
    font-weight:bold;
}

.record-meta a{
    color:#8F87F1;
    text-decoration:none;
    font-weight:bold;
}

.rating-badge{
    display:inline-flex;
    align-items:center;
    background:#FFF7FB;
    border:2px solid #FAD2CC;
    color:#F48882;
    padding:9px 15px;
    border-radius:999px;
    font-weight:bold;
    margin-bottom:12px;
}

.empty-box{
    background:white;
    border:2px solid #C6FAD2;
    border-radius:28px;
    padding:55px 30px;
    text-align:center;
    color:#777;
}

.user-footer-wrap{
    margin-left:270px;
    width:calc(100% - 270px);
}

@media(max-width:950px){

    .main-content{
        margin-left:0;
        padding:100px 16px 24px;
    }

    .record-grid{
        grid-template-columns:1fr;
    }

    .user-footer-wrap{
        margin-left:0;
        width:100%;
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
            Rating Records
        </h1>

        <p class="page-subtitle">
            Users who rated your cheatsheets.
        </p>

        <c:choose>

            <c:when test="${not empty ratingRecordList}">

                <div class="record-grid">

                    <c:forEach var="r"
                               items="${ratingRecordList}">

                        <div class="record-card">

                            <div class="rating-badge">
                                ⭐ ${r.rating} / 5
                            </div>

                            <h2 class="cheatsheet-title">

                                <a href="${pageContext.request.contextPath}/ViewCheatsheetServlet?id=${r.cheatsheetId}">
                                    ${r.cheatsheetTitle}
                                </a>

                            </h2>

                            <div class="record-meta">

                                <span>Rated by :</span>

                                <a href="${pageContext.request.contextPath}/UserProfileServlet?userId=${r.raterId}">
                                    ${r.raterName}
                                </a>

                            </div>

                            <div class="record-meta">

                                <span>Rated At :</span>
                                ${r.createdAt}

                            </div>

                        </div>

                    </c:forEach>

                </div>

            </c:when>

            <c:otherwise>

                <div class="empty-box">
                    <h2>No rating records yet.</h2>
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