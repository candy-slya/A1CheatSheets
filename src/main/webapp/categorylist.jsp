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
<title>Category List</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

:root{
    --pink:#DD9BCF;
    --light-pink:#FFF7FB;
    --peach:#FAD2CC;
    --green:#C6FAD2;
    --coral:#F48882;
}

body{
    font-family:Arial,sans-serif;
    background:linear-gradient(
        135deg,
        #F6FFEE,
        #FFF7FB,
        #FAD2CC
    );
    min-height:100vh;
    color:#333;
}

.page-wrapper{
    display:flex;
    min-height:100vh;
}

/* SIDEBAR */

.sidebar{

    width:270px;

    background:rgba(255,255,255,0.92);

    backdrop-filter:blur(10px);

    border-right:3px solid var(--green);

    padding:30px 18px;

    box-shadow:6px 0 22px rgba(0,0,0,0.06);

    position:fixed;

    top:0;
    left:0;
    bottom:0;
}

.admin-profile-card{

    background:linear-gradient(
        135deg,
        #FFF7FB,
        #F6FFEE
    );

    border:2px solid var(--green);

    border-radius:30px;

    padding:32px 20px;

    text-align:center;

    margin-bottom:35px;

    box-shadow:0 10px 24px rgba(0,0,0,0.08);
}

.profile-avatar-large{

    width:100px;
    height:100px;

    margin:auto;

    border-radius:50%;

    background:linear-gradient(
        135deg,
        var(--pink),
        var(--coral)
    );

    color:white;

    display:flex;
    align-items:center;
    justify-content:center;

    font-size:40px;

    font-weight:bold;

    margin-bottom:18px;
}

.admin-name{

    color:var(--coral);

    font-size:30px;

    font-weight:bold;
}

.sidebar-menu{

    display:flex;

    flex-direction:column;

    gap:16px;
}

.menu-card{

    display:flex;

    align-items:center;

    gap:16px;

    padding:16px 18px;

    border-radius:20px;

    text-decoration:none;

    background:linear-gradient(
        135deg,
        #FFF7FB,
        #F6FFEE
    );

    border:2px solid var(--green);

    color:#444;

    font-weight:bold;

    transition:0.25s;
}

.menu-card:hover{

    transform:translateY(-4px);

    border-color:var(--pink);

    box-shadow:0 10px 22px rgba(0,0,0,0.08);
}

.menu-icon{

    width:48px;
    height:48px;

    border-radius:15px;

    background:linear-gradient(
        135deg,
        var(--pink),
        var(--coral)
    );

    display:flex;
    align-items:center;
    justify-content:center;

    color:white;

    font-size:18px;
}

.logout-card{

    margin-top:12px;

    border:2px solid #F4B2A8;
}

/* MAIN */

.main-content{

    margin-left:270px;

    width:calc(100% - 270px);

    padding:45px 40px;
}

/* TOP */

.top-bar{

    display:flex;

    justify-content:space-between;

    align-items:center;

    flex-wrap:wrap;

    gap:15px;

    margin-bottom:30px;
}

.page-title{

    color:var(--coral);

    font-size:42px;
}

.add-btn{

    text-decoration:none;

    background:linear-gradient(
        135deg,
        var(--pink),
        var(--coral)
    );

    color:white;

    padding:13px 22px;

    border-radius:999px;

    font-weight:bold;
}

/* SEARCH */

.search-box{

    background:white;

    border:2px solid var(--green);

    border-radius:24px;

    padding:18px;

    margin-bottom:25px;

    display:flex;

    gap:12px;

    box-shadow:0 10px 24px rgba(0,0,0,0.08);
}

.search-box input{

    flex:1;

    border:2px solid #F3D5EE;

    border-radius:16px;

    padding:13px 16px;

    font-size:16px;

    outline:none;
}

.search-box button{

    border:none;

    background:var(--coral);

    color:white;

    padding:13px 22px;

    border-radius:16px;

    font-weight:bold;

    cursor:pointer;
}

/* TABLE */

.table-box{

    background:white;

    border:2px solid var(--green);

    border-radius:28px;

    overflow:hidden;

    box-shadow:0 12px 28px rgba(0,0,0,0.08);
}

table{

    width:100%;

    border-collapse:collapse;
}

th{

    background:#FFF7FB;

    color:var(--coral);

    padding:18px;

    text-align:left;

    font-size:16px;

    border-bottom:2px solid var(--peach);
}

td{

    padding:16px 18px;

    border-bottom:1px solid #eee;

    color:#555;
}

tr:hover{

    background:#FFF7FB;
}

.status-badge{

    background:#C6FAD2;

    color:#2B7A40;

    padding:6px 12px;

    border-radius:999px;

    font-size:13px;

    font-weight:bold;
}

.action-btn{

    display:inline-block;

    text-decoration:none;

    padding:9px 14px;

    border-radius:12px;

    font-size:14px;

    font-weight:bold;

    margin-right:8px;
}

.edit-btn{

    background:var(--pink);

    color:white;
}

.delete-btn{

    background:var(--peach);

    color:#C2185B;
}

/* PAGINATION */

.pagination{

    display:flex;

    justify-content:center;

    gap:10px;

    margin-top:28px;

    flex-wrap:wrap;
}

.page-link{

    text-decoration:none;

    background:white;

    border:2px solid var(--peach);

    color:var(--coral);

    padding:10px 15px;

    border-radius:12px;

    font-weight:bold;
}

.page-link.active{

    background:var(--coral);

    color:white;

    border-color:var(--coral);
}

/* EMPTY */

.empty{

    text-align:center;

    padding:35px;

    color:#777;
}

/* RESPONSIVE */

@media(max-width:950px){

    .sidebar{

        width:100%;

        height:auto;

        position:relative;

        border-right:none;

        border-bottom:3px solid var(--green);
    }

    .page-wrapper{

        flex-direction:column;
    }

    .main-content{

        margin-left:0;

        width:100%;

        padding:30px 18px;
    }

    .page-title{

        font-size:34px;
    }

    .search-box{

        flex-direction:column;
    }
}

</style>

</head>

<body>

<div class="page-wrapper">

    <!-- SIDEBAR -->

<jsp:include page="adminSidebar.jsp" />

    <!-- MAIN -->

    <div class="main-content">

        <div class="top-bar">

            <h1 class="page-title">
                Category List
            </h1>

            <a class="add-btn"
               href="${pageContext.request.contextPath}/ManageCategoriesServlet">

                + Add Category

            </a>

        </div>

        <!-- SEARCH -->

        <form class="search-box"
              action="${pageContext.request.contextPath}/CategoriesServlet"
              method="get">

            <input type="text"
                   name="keyword"
                   value="${keyword}"
                   placeholder="Search category name...">

            <button type="submit">

                Search

            </button>

        </form>

        <!-- TABLE -->

        <div class="table-box">

            <table>

                <tr>

                    <th>#</th>

                    <th>Name</th>

                    <th>Description</th>

                    <th>Status</th>

                    <th>Action</th>

                </tr>

                <c:forEach var="c"
                           items="${categories}"
                           varStatus="i">

                    <tr>

                        <td>
                            ${(currentPage - 1) * 5 + i.index + 1}
                        </td>

                        <td>
                            ${c.name}
                        </td>

                        <td>
                            ${c.description}
                        </td>

                        <td>

                            <span class="status-badge">

                                ${c.status}

                            </span>

                        </td>

                        <td>

                            <a class="action-btn edit-btn"

                               href="${pageContext.request.contextPath}/EditCategoryServlet?id=${c.id}">

                                Edit

                            </a>

                            <a class="action-btn delete-btn"

                               onclick="return confirm('Delete this category?')"

                               href="${pageContext.request.contextPath}/DeleteCategoryServlet?id=${c.id}">

                                Delete

                            </a>

                        </td>

                    </tr>

                </c:forEach>

            </table>

            <c:if test="${empty categories}">

                <div class="empty">

                    No categories found.

                </div>

            </c:if>

        </div>

        <!-- PAGINATION -->

        <div class="pagination">

            <c:forEach begin="1"
                       end="${totalPages}"
                       var="p">

                <a class="page-link ${p == currentPage ? 'active' : ''}"

                   href="${pageContext.request.contextPath}/CategoriesServlet?page=${p}&keyword=${keyword}">

                    ${p}

                </a>

            </c:forEach>

        </div>

    </div>

</div>

</body>
</html>