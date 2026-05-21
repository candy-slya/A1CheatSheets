<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Private Cheatsheets</title>

<style>
*{margin:0;padding:0;box-sizing:border-box;}

body{
    font-family:Arial,sans-serif;
    background:linear-gradient(135deg,#F6FFEE,#FFF7FB,#FAD2CC);
    color:#333;
}

.container{
    max-width:1200px;
    margin:45px auto;
    padding:0 20px;
}

.page-title{
    font-size:38px;
    color:#F48882;
    margin-bottom:28px;
}

.sheet-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(320px,1fr));
    gap:26px;
}

.sheet-card{
    background:white;
    border:2px solid #C6FAD2;
    border-radius:26px;
    padding:24px;
    box-shadow:0 10px 26px rgba(0,0,0,0.08);
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
    font-size:27px;
    font-weight:800;
}

.meta{
    font-size:16px;
    color:#555;
    margin-bottom:12px;
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

.tag-list{
    display:flex;
    flex-wrap:wrap;
    gap:9px;
    margin:14px 0 22px;
}

.tag-link{
    text-decoration:none;
    background:#DD9BCF;
    color:white;
    padding:8px 13px;
    border-radius:999px;
    font-size:14px;
    font-weight:bold;
}

.publish-box{
    border-top:1px solid #eee;
    padding-top:18px;
}

.publish-text{
    color:#666;
    margin-bottom:12px;
    font-size:14px;
}

.action-row{
    display:flex;
    flex-wrap:wrap;
    gap:10px;
}

.action-btn{
    text-decoration:none;
    padding:10px 16px;
    border-radius:12px;
    font-weight:bold;
    font-size:14px;
}

.publish-btn{
    background:#C6FAD2;
    color:#2B7A40;
}

.pending-btn{
    background:#FFF3CD;
    color:#856404;
    pointer-events:none;
}

.edit-btn{
    background:#DD9BCF;
    color:white;
}

.delete-btn{
    background:#FAD2CC;
    color:#C2185B;
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

    <h1 class="page-title">
        Private Cheatsheets
    </h1>

    <c:choose>

        <c:when test="${not empty privateList}">

            <div class="sheet-grid">

                <c:forEach var="cs" items="${privateList}">

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

                        <div class="meta">
                            <span>Tags :</span>
                        </div>

                        <div class="tag-list">

                            <c:choose>

                                <c:when test="${not empty cs.tagData}">

                                    <c:forEach var="tagItem" items="${fn:split(cs.tagData, ',')}">

                                        <c:set var="parts" value="${fn:split(tagItem, ':')}" />

                                        <a class="tag-link"
                                           href="${pageContext.request.contextPath}/SearchByTagServlet?tagId=${parts[0]}">
                                            #${parts[1]}
                                        </a>

                                    </c:forEach>

                                </c:when>

                                <c:otherwise>

                                    <c:forEach var="tag" items="${fn:split(cs.tags, ',')}">

                                        <a class="tag-link"
                                           href="${pageContext.request.contextPath}/SearchCheatsheetServlet?keyword=${fn:trim(tag)}">
                                            #${fn:trim(tag)}
                                        </a>

                                    </c:forEach>

                                </c:otherwise>

                            </c:choose>

                        </div>

                        <div class="publish-box">

                            <p class="publish-text">
                                Publish request status
                            </p>

                            <div class="action-row">

                                <c:choose>

                                    <c:when test="${cs.situation eq 'pending'}">

                                        <span class="action-btn pending-btn">
                                            Wait for admin approval
                                        </span>

                                    </c:when>

                                    <c:otherwise>

                                        <a class="action-btn publish-btn"
                                           href="${pageContext.request.contextPath}/RequestPublishServlet?id=${cs.id}">
                                            Request Publish
                                        </a>

                                    </c:otherwise>

                                </c:choose>

                                <a class="action-btn edit-btn"
                                   href="${pageContext.request.contextPath}/EditCheatsheetServlet?id=${cs.id}">
                                    Edit
                                </a>

                                <a class="action-btn delete-btn"
                                   onclick="return confirm('Are you sure to delete this cheatsheet?')"
                                   href="${pageContext.request.contextPath}/DeleteCheatsheetServlet?id=${cs.id}">
                                    Delete
                                </a>

                            </div>

                        </div>

                    </div>

                </c:forEach>

            </div>

        </c:when>

        <c:otherwise>
            <div class="empty">
                <h2>No private cheatsheets found.</h2>
            </div>
        </c:otherwise>

    </c:choose>

</div>

<jsp:include page="footer.jsp" />

</body>
</html>