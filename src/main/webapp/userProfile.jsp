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

<title>${profileUser.name} Profile</title>

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
    max-width:1200px;
    margin:45px auto;
    padding:0 20px;
}

.top-bar{
    margin-bottom:28px;
}

.back-btn{
    display:inline-flex;
    align-items:center;
    justify-content:center;
    text-decoration:none;
    background:white;
    color:#F48882;
    border:2px solid #FAD2CC;
    padding:12px 22px;
    border-radius:999px;
    font-weight:bold;
    box-shadow:0 8px 18px rgba(0,0,0,0.06);
    transition:0.25s;
}

.back-btn:hover{
    transform:translateY(-4px);
    border-color:#DD9BCF;
}

.profile-box{
    background:white;
    border:3px solid #C6FAD2;
    border-radius:30px;
    padding:35px;
    text-align:center;
    box-shadow:0 12px 28px rgba(0,0,0,0.08);
    margin-bottom:35px;
}

.avatar{
    width:95px;
    height:95px;
    border-radius:50%;
    background:linear-gradient(135deg,#DD9BCF,#F48882);
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
    margin-bottom:10px;
}

.join-date{
    color:#666;
    font-size:16px;
}

.section-title{
    color:#F48882;
    font-size:34px;
    margin-bottom:25px;
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

.publish-time{
    color:#777;
    font-size:14px;
    margin-top:10px;
    margin-bottom:18px;
}

.tag-list{
    display:flex;
    flex-wrap:wrap;
    gap:9px;
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

.empty{
    background:white;
    border:2px solid #C6FAD2;
    border-radius:24px;
    padding:45px;
    text-align:center;
    color:#777;
}

</style>

</head>

<body>

<jsp:include page="header.jsp" />

<div class="container">

    <div class="top-bar">

        <a class="back-btn"
           href="javascript:history.back()">
            ← Back
        </a>

    </div>

    <div class="profile-box">

        <div class="avatar">
            ${fn:toUpperCase(fn:substring(profileUser.name,0,1))}
        </div>

        <h1 class="profile-name">
            ${profileUser.name}
        </h1>

        <div class="join-date">
            Joined since : ${profileUser.createdAt}
        </div>

    </div>

    <h2 class="section-title">
        Public Cheatsheets
    </h2>

    <c:choose>

        <c:when test="${not empty publicList}">

            <div class="sheet-grid">

                <c:forEach var="cs"
                           items="${publicList}">

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

                        <div class="publish-time">

                            Published At :
                            ${cs.createdAt}

                        </div>

                        <div class="tag-list">

                            <c:if test="${not empty cs.tagData}">

                                <c:forEach var="tagItem"
                                           items="${fn:split(cs.tagData, ',')}">

                                    <c:set var="parts"
                                           value="${fn:split(tagItem, ':')}" />

                                    <a class="tag-link"
                                       href="${pageContext.request.contextPath}/SearchByTagServlet?tagId=${parts[0]}">

                                        #${parts[1]}

                                    </a>

                                </c:forEach>

                            </c:if>

                        </div>

                    </div>

                </c:forEach>

            </div>

        </c:when>

        <c:otherwise>

            <div class="empty">

                <h2>
                    No public cheatsheets found.
                </h2>

            </div>

        </c:otherwise>

    </c:choose>

</div>

<jsp:include page="footer.jsp" />

</body>
</html>