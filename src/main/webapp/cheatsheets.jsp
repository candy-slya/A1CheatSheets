<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
    prefix="c"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
    prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cheatsheets</title>

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
}

.container{
    max-width:1300px;
    margin:45px auto;
    padding:0 20px;
}

.top-row{
    display:flex;
    justify-content:space-between;
    align-items:center;
    gap:15px;
    margin-bottom:28px;
    flex-wrap:wrap;
}

.back-btn{
    text-decoration:none;
    background:white;
    color:#F48882;
    border:2px solid #FAD2CC;
    padding:12px 20px;
    border-radius:999px;
    font-weight:bold;
    transition:0.25s;
}

.back-btn:hover{
    transform:translateY(-4px);
    border-color:#DD9BCF;
}

.page-title{
    font-size:34px;
    color:#F48882;
}

.sheet-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(320px,1fr));
    gap:28px;
}

.sheet-card{
    background:white;
    border:2px solid #C6FAD2;
    border-radius:28px;
    padding:24px;
    box-shadow:0 10px 28px rgba(0,0,0,0.08);
    transition:0.25s;
}

.sheet-card:hover{
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

.sheet-title{
    margin-bottom:14px;
}

.sheet-title a{
    text-decoration:none;
    color:#F48882;
    font-size:28px;
    font-weight:800;
    line-height:1.3;
}

.sheet-title a:hover{
    color:#DD9BCF;
}

.meta{
    font-size:16px;
    color:#555;
    margin-bottom:10px;
}

.meta span{
    color:#DD9BCF;
    font-weight:bold;
}

.username-link{
    color:#8F87F1;
    text-decoration:none;
    font-weight:bold;
}

.username-link:hover{
    text-decoration:underline;
}

.publish-time{
    color:#777;
    font-size:14px;
    margin-bottom:14px;
}

.tag-title{
    color:#DD9BCF;
    font-weight:bold;
    margin-bottom:12px;
}

.tag-list{
    display:flex;
    flex-wrap:wrap;
    gap:9px;
}

.tag-link{
    text-decoration:none;
    background:linear-gradient(135deg,#DD9BCF,#F48882);
    color:white;
    padding:8px 13px;
    border-radius:999px;
    font-size:14px;
    font-weight:bold;
}

.empty{
    text-align:center;
    color:#777;
    margin-top:80px;
}
</style>
</head>

<body>

<jsp:include page="header.jsp" />

<div class="container">

    <div class="top-row">

        <a class="back-btn"
           href="javascript:history.back()">
            ← Back
        </a>

        <h1 class="page-title">
            <c:choose>
                <c:when test="${not empty categoryName}">
                    ${categoryName}
                </c:when>
                <c:otherwise>
                    Cheatsheets
                </c:otherwise>
            </c:choose>
        </h1>

    </div>

    <c:choose>

        <c:when test="${not empty cheatsheets}">

            <div class="sheet-grid">

                <c:forEach var="cs"
                           items="${cheatsheets}">

                    <div class="sheet-card">

                        <div class="cs-top">

                            <a class="category-badge"
                               href="${pageContext.request.contextPath}/CheatsheetListServlet?categoryId=${cs.categoryId}">
                                ${cs.categoryname}
                            </a>

                            <div class="view-count">
                                👁 ${cs.viewCount}
                            </div>

                        </div>

                        <h2 class="sheet-title">
                            <a href="${pageContext.request.contextPath}/ViewCheatsheetServlet?id=${cs.id}">
                                ${cs.title}
                            </a>
                        </h2>

                        <div class="meta">
                            <span>By :</span>

                            <a class="username-link"
                               href="${pageContext.request.contextPath}/UserProfileServlet?userId=${cs.userId}">
                                ${cs.username}
                            </a>
                        </div>

                        <div class="publish-time">
                            Published At : ${cs.createdAt}
                        </div>

                        <div class="tag-title">
                            Tags
                        </div>

                        <div class="tag-list">

                            <c:choose>

                                <c:when test="${not empty cs.tagData}">

                                    <c:forEach var="tagItem"
                                               items="${fn:split(cs.tagData, ',')}">

                                        <c:set var="parts"
                                               value="${fn:split(tagItem, ':')}" />

                                        <a class="tag-link"
                                           href="${pageContext.request.contextPath}/SearchByTagServlet?tagId=${parts[0]}">
                                            #${parts[1]}
                                        </a>

                                    </c:forEach>

                                </c:when>

                                <c:otherwise>

                                    <c:forEach var="tag"
                                               items="${fn:split(cs.tags, ',')}">

                                        <a class="tag-link"
                                           href="${pageContext.request.contextPath}/SearchCheatsheetServlet?keyword=${fn:trim(tag)}">
                                            #${fn:trim(tag)}
                                        </a>

                                    </c:forEach>

                                </c:otherwise>

                            </c:choose>

                        </div>

                    </div>

                </c:forEach>

            </div>

        </c:when>

        <c:otherwise>

            <div class="empty">
                <h2>No cheatsheets found.</h2>
            </div>

        </c:otherwise>

    </c:choose>

</div>

<jsp:include page="footer.jsp" />

</body>
</html>