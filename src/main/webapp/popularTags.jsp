<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
    prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Popular Tags</title>

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
}

/* MAIN */

.container{

    max-width:1000px;

    margin:40px auto;

    padding:0 20px 50px;
}

/* TOP BAR */

.top-bar{

    display:flex;

    justify-content:space-between;

    align-items:center;

    margin-bottom:30px;

    flex-wrap:wrap;

    gap:15px;
}

/* BACK BUTTON */

.back-btn{

    text-decoration:none;

    background:white;

    color:#F48882;

    border:2px solid #FAD2CC;

    padding:13px 22px;

    border-radius:999px;

    font-weight:bold;

    transition:0.25s;

    box-shadow:
        0 8px 18px rgba(0,0,0,0.06);
}

.back-btn:hover{

    transform:translateY(-4px);

    border-color:#DD9BCF;
}

/* TITLE */

.page-title{

    color:#F48882;

    font-size:42px;

    margin-bottom:30px;

    font-weight:800;
}

/* TAG WRAP */

.tag-wrap{

    display:flex;

    flex-wrap:wrap;

    gap:16px;
}

/* TAG CARD */

.tag-card{

    text-decoration:none;

    background:white;

    border:2px solid #C6FAD2;

    border-radius:999px;

    padding:14px 20px;

    color:#333;

    font-weight:bold;

    box-shadow:
        0 10px 22px rgba(0,0,0,0.08);

    transition:0.25s;

    display:flex;

    align-items:center;

    gap:10px;
}

.tag-card:hover{

    transform:translateY(-5px);

    border-color:#DD9BCF;

    box-shadow:
        0 16px 30px rgba(221,155,207,0.22);
}

/* TAG NAME */

.tag-name{

    color:#DD9BCF;

    font-size:16px;

    font-weight:800;
}

/* TAG COUNT */

.tag-count{

    background:#FAD2CC;

    color:#555;

    padding:5px 10px;

    border-radius:999px;

    font-size:13px;

    font-weight:bold;
}

/* RESPONSIVE */

@media(max-width:650px){

    .page-title{
        font-size:34px;
    }

    .top-bar{
        justify-content:center;
    }

    .tag-wrap{
        justify-content:center;
    }
}

</style>
</head>

<body>

<jsp:include page="header.jsp" />

<div class="container">

    <!-- TOP -->

    <div class="top-bar">

        <a class="back-btn"
           href="javascript:history.back()">

            ← Back

        </a>

    </div>

    <!-- TITLE -->

    <h1 class="page-title">

        Search By Tags

    </h1>

    <!-- TAGS -->

    <div class="tag-wrap">

        <c:forEach var="tag"
                   items="${popularTags}">

            <a class="tag-card"

               href="${pageContext.request.contextPath}/SearchByTagServlet?tagId=${tag.id}">

                <span class="tag-name">

                    #${tag.name}

                </span>

                <span class="tag-count">

                    ${tag.count}

                </span>

            </a>

        </c:forEach>

    </div>

</div>

<jsp:include page="footer.jsp" />

</body>
</html>