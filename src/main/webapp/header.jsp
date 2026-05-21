<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page session="true" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
    prefix="c" %>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:Arial,sans-serif !important;
    background:#F6FFEE !important;
}

.header{
    width:100%;
    background:#F6FFEE;
    border-bottom:4px solid #C6FAD2;
    padding:18px 30px;
    display:flex;
    align-items:center;
    justify-content:space-between;
    gap:20px;
    box-shadow:0 2px 10px rgba(0,0,0,0.08);
    flex-wrap:nowrap;
    overflow:hidden;
}

.logo{
    text-decoration:none;
    font-size:38px;
    font-weight:800;
    color:#F48882;
    white-space:nowrap;
    flex-shrink:0;
}

.right-area{
    flex:1;
    display:flex;
    align-items:center;
    justify-content:flex-end;
    gap:14px;
    min-width:0;
}

.search-bar{
    flex:1;
    max-width:520px;
    min-width:140px;
}

.search-box{
    width:100%;
    display:flex;
    align-items:center;
}

.search-box input{
    width:100%;
    padding:12px 18px;
    border:2px solid #C6FAD2;
    border-right:none;
    border-radius:30px 0 0 30px;
    outline:none;
    font-size:16px;
    background:white;
    color:#444;
}

.search-box input:focus{
    border-color:#DD9BCF;
}

.search-box button{
    padding:12px 18px;
    border:none;
    border-radius:0 30px 30px 0;
    background:#C6FAD2;
    cursor:pointer;
    font-size:18px;
    transition:0.2s;
}

.search-box button:hover{
    background:#B3F2C2;
}

.nav-link{
    text-decoration:none;
    font-size:15px;
    font-weight:bold;
    padding:11px 18px;
    border-radius:999px;
    transition:0.2s;
    white-space:nowrap;
    flex-shrink:0;
}

.nav-link:hover{
    transform:translateY(-2px);
}

.home-btn,
.create-btn{
    background:#DD9BCF;
    color:white;
}

.login-btn{
    background:#C6FAD2;
    color:#333;
}

.register-btn,
.logout-btn{
    background:#FAD2CC;
    color:#333;
}

.username{
    text-decoration:none;
    color:#F48882;
    font-size:20px;
    font-weight:bold;
    white-space:nowrap;
    flex-shrink:0;
}

.username:hover{
    color:#DD9BCF;
}

@media(max-width:1200px){
    .logo{
        font-size:32px;
    }

    .search-bar{
        max-width:380px;
    }

    .nav-link{
        font-size:14px;
        padding:9px 14px;
    }

    .username{
        font-size:17px;
    }
}

@media(max-width:900px){
    .header{
        padding:14px 16px;
        gap:10px;
    }

    .logo{
        font-size:24px;
    }

    .search-bar{
        max-width:220px;
    }

    .search-box input{
        padding:9px 12px;
        font-size:13px;
    }

    .search-box button{
        padding:9px 12px;
        font-size:13px;
    }

    .nav-link{
        font-size:12px;
        padding:7px 10px;
    }

    .username{
        font-size:14px;
    }

    .right-area{
        gap:8px;
    }
}
</style>

<div class="header">

    <a class="logo"
       href="${pageContext.request.contextPath}/IndexServlet">
        Cheatsheet
    </a>

    <div class="right-area">

        <div class="search-bar">
        
        
            <form class="search-box"
                  action="${pageContext.request.contextPath}/SearchCheatsheetServlet"
                  method="get">

                <input type="text"
                       name="keyword"
                       placeholder="Search cheatsheets or tags..."
                       required>

                <button type="submit">
                    🔍
                </button>
            </form>
        </div>

        <c:choose>

            <c:when test="${empty sessionScope.loginUser}">

                <a class="nav-link home-btn"
                   href="${pageContext.request.contextPath}/IndexServlet">
                    Home
                </a>

                <a class="nav-link login-btn"
                   href="${pageContext.request.contextPath}/login.jsp">
                    Login
                </a>

                <a class="nav-link register-btn"
                   href="${pageContext.request.contextPath}/register.jsp">
                    Register
                </a>

            </c:when>

            <c:when test="${sessionScope.loginUser.role eq 'admin'}">

                <a class="nav-link home-btn"
                   href="${pageContext.request.contextPath}/AdminDashboardServlet">
                    Dashboard
                </a>

                <a class="nav-link logout-btn"
                   href="${pageContext.request.contextPath}/logout.jsp">
                    Logout
                </a>

            </c:when>

            <c:otherwise>

                <a class="nav-link home-btn"
                   href="${pageContext.request.contextPath}/IndexServlet">
                    Home
                </a>

                <a class="nav-link create-btn"
                   href="${pageContext.request.contextPath}/CreateCheatsheetServlet">
                    Create Cheatsheet
                </a>

                <a class="username"
                   href="${pageContext.request.contextPath}/ProfileViewServlet">
                    ${sessionScope.loginUser.name}
                </a>

            </c:otherwise>

        </c:choose>

    </div>

</div>