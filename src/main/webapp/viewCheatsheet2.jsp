<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
    prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${sheet.title}</title>

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
    padding:0 22px;
}

.top-bar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    flex-wrap:wrap;
    gap:15px;
    margin-bottom:30px;
}

.action-area{
    display:flex;
    align-items:center;
    gap:14px;
    flex-wrap:wrap;
}

.back-btn,
.pdf-btn,
.bookmark-btn{
    display:inline-flex;
    align-items:center;
    justify-content:center;
    padding:13px 24px;
    border-radius:999px;
    text-decoration:none;
    font-weight:bold;
    transition:0.25s;
}

.back-btn{
    background:white;
    color:#F48882;
    border:2px solid #FAD2CC;
}

.pdf-btn{
    background:linear-gradient(135deg,#F48882,#DD9BCF);
    color:white;
    box-shadow:0 10px 22px rgba(221,155,207,0.28);
}

.bookmark-btn{
    background:#C6FAD2;
    color:#2B7A40;
    box-shadow:0 10px 22px rgba(0,0,0,0.08);
}

.back-btn:hover,
.pdf-btn:hover,
.bookmark-btn:hover{
    transform:translateY(-4px);
}

.header-box{
    background:white;
    border:2px solid #C6FAD2;
    border-radius:30px;
    padding:32px;
    margin-bottom:35px;
    box-shadow:0 14px 32px rgba(0,0,0,0.08);
}

.title{
    font-size:42px;
    color:#F48882;
    margin-bottom:15px;
}

.meta{
    color:#666;
    font-size:17px;
    line-height:1.8;
}

.cheatsheet-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(320px,1fr));
    gap:24px;
}

.section-box{
    background:white;
    border:2px solid #F3D5EE;
    border-radius:24px;
    overflow:hidden;
    box-shadow:0 10px 24px rgba(0,0,0,0.08);
}

.section-title{
    background:#FFF7FB;
    color:#F48882;
    font-size:24px;
    padding:18px 22px;
    border-bottom:2px solid #FAD2CC;
}

.item-table{
    width:100%;
    border-collapse:collapse;
    font-size:17px;
}

.item-table tr:nth-child(odd){
    background:#FFF7FB;
}

.item-table td{
    padding:14px 18px;
    border-bottom:1px solid #eee;
    vertical-align:top;
}

.key-cell{
    width:35%;
    font-weight:bold;
    color:#DD9BCF;
}

.value-cell{
    color:#444;
    line-height:1.7;
    word-break:break-word;
}

.value-cell a{
    color:#8F87F1;
    text-decoration:none;
    font-weight:bold;
}

.value-cell a:hover{
    text-decoration:underline;
}

.raw-note{
    background:white;
    padding:28px;
    border:2px solid #C6FAD2;
    border-radius:24px;
    box-shadow:0 10px 24px rgba(0,0,0,0.08);
    white-space:pre-wrap;
    line-height:1.7;
}

@media(max-width:650px){
    .title{
        font-size:32px;
    }

    .header-box{
        padding:24px;
    }

    .cheatsheet-grid{
        grid-template-columns:1fr;
    }
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

        <div class="action-area">

            <c:if test="${not empty sessionScope.loginUser}">

                <c:if test="${sessionScope.loginUser.id ne sheet.userId}">

                    <a class="bookmark-btn"
                       href="${pageContext.request.contextPath}/ToggleBookmarkServlet?id=${sheet.id}">

                        <c:choose>
                            <c:when test="${bookmarked}">
                                💔 Unbookmark
                            </c:when>

                            <c:otherwise>
                                🔖 Bookmark
                            </c:otherwise>
                        </c:choose>

                        (${bookmarkCount})

                    </a>

                </c:if>

            </c:if>

            <a class="pdf-btn"
               href="${pageContext.request.contextPath}/DownloadPdfServlet?id=${sheet.id}">
                Download PDF
            </a>

        </div>

    </div>

    <div class="header-box">

        <h1 class="title">
            ${sheet.title}
        </h1>

        <div class="meta">
            By : ${sheet.username}

            <br>

            Category : ${sheet.categoryname}

            <br>

            Tags : ${sheet.tags}
        </div>

    </div>

    <textarea id="rawData" style="display:none;"><c:out value="${sheet.note}"/></textarea>

    <div id="contentGrid" class="cheatsheet-grid"></div>

</div>

<jsp:include page="footer.jsp" />

<script>
const raw =
    document.getElementById("rawData").value;

const target =
    document.getElementById("contentGrid");

function escapeHtml(text){
    return String(text)
        .replace(/&/g,"&amp;")
        .replace(/</g,"&lt;")
        .replace(/>/g,"&gt;")
        .replace(/"/g,"&quot;")
        .replace(/'/g,"&#039;");
}

function makeLink(text){

    if(!text){
        return "";
    }

    const escaped =
        escapeHtml(text);

    const urlPattern =
        /(https?:\/\/[^\s]+)/g;

    return escaped.replace(
        urlPattern,
        '<a href="$1" target="_blank">$1</a>');
}

try{
    const sections =
        JSON.parse(raw);

    let html = "";

    sections.forEach(function(sec){

        const title =
            sec.title && sec.title !== "false"
            ? sec.title
            : "General";

        html +=
            '<div class="section-box">' +
                '<h3 class="section-title">' +
                    escapeHtml(title) +
                '</h3>' +
                '<table class="item-table">';

        if(sec.items && Array.isArray(sec.items)){

            sec.items.forEach(function(item){

                const key =
                    item.k && item.k !== "false"
                    ? item.k
                    : "";

                const val =
                    item.v && item.v !== "false"
                    ? item.v
                    : "";

                if(key || val){
                    html +=
                        '<tr>' +
                            '<td class="key-cell">' +
                                escapeHtml(key) +
                            '</td>' +
                            '<td class="value-cell">' +
                                makeLink(val) +
                            '</td>' +
                        '</tr>';
                }
            });
        }

        html +=
            '</table></div>';
    });

    target.innerHTML = html;

}catch(e){

    target.className = "";

    target.innerHTML =
        '<div class="raw-note">' +
            escapeHtml(raw) +
        '</div>';
}
</script>

</body>
</html>