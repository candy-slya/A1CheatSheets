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
<title>Cheatsheet Records</title>

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
}

.container{
    max-width:1250px;
    margin:0 auto;
}

.page-title{
    color:#F48882;
    font-size:42px;
    margin-bottom:10px;
}

.page-subtitle{
    color:#666;
    margin-bottom:30px;
}

/* SEARCH */

.search-box{
    width:100%;
    max-width:420px;
    margin-bottom:24px;
}

.search-box input{
    width:100%;
    padding:14px 18px;
    border:2px solid #C6FAD2;
    border-radius:999px;
    outline:none;
    font-size:15px;
    background:white;
}

/* TABLE */

.table-box{
    background:white;
    border:2px solid #C6FAD2;
    border-radius:28px;
    overflow:hidden;
    box-shadow:
        0 12px 28px
        rgba(0,0,0,0.08);
}

table{
    width:100%;
    border-collapse:collapse;
}

th{
    background:#FFF7FB;
    color:#DD9BCF;
    padding:18px 16px;
    text-align:left;
    font-size:15px;
    border-bottom:2px solid #FAD2CC;
}

td{
    padding:18px 16px;
    border-bottom:1px solid #eee;
    color:#555;
    vertical-align:middle;
}

tr:hover{
    background:#F6FFEE;
}

/* BUTTONS */

.view-btn,
.ban-btn,
.unban-btn{

    text-decoration:none;

    padding:9px 14px;

    border-radius:12px;

    font-weight:bold;

    font-size:13px;

    display:inline-block;
}

.view-btn{
    background:#DD9BCF;
    color:white;
}

.ban-btn{
    background:#FAD2CC;
    color:#C2185B;
}

.unban-btn{
    background:#C6FAD2;
    color:#2B7A40;
}

.view-btn:hover,
.ban-btn:hover,
.unban-btn:hover{
    opacity:0.9;
}

/* EMPTY */

.empty{
    background:white;
    border:2px solid #C6FAD2;
    border-radius:24px;
    padding:45px;
    text-align:center;
    color:#777;
}

.empty h2{
    color:#F48882;
    margin-bottom:8px;
}

/* PAGINATION */

.pagination{
    margin-top:24px;
    display:flex;
    justify-content:center;
    align-items:center;
    gap:12px;
}

.page-btn{
    padding:10px 16px;
    border:none;
    border-radius:12px;
    background:#DD9BCF;
    color:white;
    font-weight:bold;
    cursor:pointer;
}

#pageInfo{
    font-weight:bold;
    color:#666;
}

/* RESPONSIVE */

@media(max-width:950px){

    .main-content{
        margin-left:0;
        padding:20px;
    }

    .table-box{
        overflow-x:auto;
    }
}

</style>

</head>

<body>

<jsp:include page="adminSidebar.jsp" />

<div class="main-content">

    <div class="container">

        <h1 class="page-title">
            Cheatsheet Records
        </h1>

        <p class="page-subtitle">
            Public active cheatsheets created by users.
        </p>

        <!-- SEARCH -->

        <div class="search-box">

            <input type="text"
                   id="recordSearch"
                   placeholder="Search records..."
                   onkeyup="filterRecords()">

        </div>

        <c:choose>

            <c:when test="${not empty records}">

                <div class="table-box">

                    <table id="recordTable">

                        <thead>

                            <tr>

                                <th>No</th>

                                <th>User</th>

                                <th>Title</th>

                                <th>Category</th>

                                <th>Created At</th>

                                <th>View</th>

                                <th>Action</th>

                            </tr>

                        </thead>

                        <tbody>

<c:forEach var="r"
           items="${records}"
           varStatus="s">

    <tr>

        <td>${s.index + 1}</td>

        <td>${r.username}</td>

        <td>${r.title}</td>

        <td>${r.categoryname}</td>

        <td>${r.createdAt}</td>

        <td>

            <a class="view-btn"
               href="${pageContext.request.contextPath}/ViewCheatsheetServlet?id=${r.id}">

                View

            </a>

        </td>

        <td>

            <c:choose>

                <c:when test="${r.status eq 'active'}">

                    <a class="ban-btn"
                       onclick="return confirm('Ban this cheatsheet?')"
                       href="${pageContext.request.contextPath}/UpdateCheatsheetStatusServlet?id=${r.id}&status=inactive">

                        Ban

                    </a>

                </c:when>

                <c:otherwise>

                    <a class="unban-btn"
                       onclick="return confirm('Unban this cheatsheet?')"
                       href="${pageContext.request.contextPath}/UpdateCheatsheetStatusServlet?id=${r.id}&status=active">

                        Unban

                    </a>

                </c:otherwise>

            </c:choose>

        </td>

    </tr>

</c:forEach>

                        </tbody>

                    </table>

                </div>

                <!-- PAGINATION -->

                <div class="pagination">

                    <button class="page-btn"
                            onclick="prevPage()">

                        Prev

                    </button>

                    <span id="pageInfo"></span>

                    <button class="page-btn"
                            onclick="nextPage()">

                        Next

                    </button>

                </div>

            </c:when>

            <c:otherwise>

                <div class="empty">

                    <h2>
                        No records found.
                    </h2>

                    <p>
                        Public cheatsheets will appear here.
                    </p>

                </div>

            </c:otherwise>

        </c:choose>

    </div>

</div>

<script>

let currentPage = 1;

const rowsPerPage = 5;

function showPage(page){

    const rows =

        Array.from(
            document.querySelectorAll(
                "#recordTable tbody tr"
            )
        ).filter(
            row => row.dataset.match === "true"
        );

    const totalPages =

        Math.ceil(
            rows.length / rowsPerPage
        ) || 1;

    if(page < 1){
        page = 1;
    }

    if(page > totalPages){
        page = totalPages;
    }

    currentPage = page;

    rows.forEach((row,index) => {

        const start =
            (currentPage - 1) * rowsPerPage;

        const end =
            start + rowsPerPage;

        row.style.display =

            index >= start &&
            index < end

            ? ""
            : "none";
    });

    document.getElementById(
        "pageInfo"
    ).innerText =

        currentPage +
        " / " +
        totalPages;
}

function filterRecords(){

    const keyword =

        document.getElementById(
            "recordSearch"
        ).value.toLowerCase();

    const rows =

        document.querySelectorAll(
            "#recordTable tbody tr"
        );

    rows.forEach(row => {

        const text =
            row.innerText.toLowerCase();

        if(text.includes(keyword)){

            row.dataset.match = "true";

        }else{

            row.dataset.match = "false";

            row.style.display = "none";
        }
    });

    currentPage = 1;

    showPage(currentPage);
}

function nextPage(){

    showPage(currentPage + 1);
}

function prevPage(){

    showPage(currentPage - 1);
}

window.onload = function(){

    document.querySelectorAll(
        "#recordTable tbody tr"
    ).forEach(row => {

        row.dataset.match = "true";
    });

    showPage(1);
}

</script>

</body>
</html>