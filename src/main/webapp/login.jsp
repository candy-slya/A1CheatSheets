<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:Arial, sans-serif;
    background:linear-gradient(135deg, #F6FFEE, #FFF7FB, #FAD2CC);
    min-height:100vh;
    color:#333;
}

.login-wrapper{
    min-height:calc(100vh - 220px);
    display:flex;
    align-items:center;
    justify-content:center;
    padding:70px 20px;
}

.form-container{
    width:100%;
    max-width:420px;
    background:rgba(255,255,255,0.92);
    padding:38px 34px;
    border-radius:24px;
    border:3px solid #C6FAD2;
    box-shadow:0 12px 30px rgba(0,0,0,0.12);
}

.form-container h2{
    text-align:center;
    color:#F48882;
    font-size:36px;
    margin-bottom:8px;
}

.subtitle{
    text-align:center;
    color:#777;
    margin-bottom:28px;
    font-size:15px;
}

.form-group{
    margin-bottom:18px;
}

.form-container input{
    width:100%;
    padding:14px 16px;
    border:2px solid #C6FAD2;
    border-radius:18px;
    outline:none;
    font-size:15px;
    background:#fff;
    color:#333;
    transition:0.2s;
}

.form-container input:focus{
    border-color:#DD9BCF;
    box-shadow:0 0 0 4px rgba(221,155,207,0.2);
}

.form-container button{
    width:100%;
    padding:14px;
    background:#DD9BCF;
    color:white;
    border:none;
    border-radius:20px;
    cursor:pointer;
    font-size:17px;
    font-weight:bold;
    transition:0.2s;
    margin-top:6px;
}

.form-container button:hover{
    background:#F48882;
    transform:translateY(-1px);
}

.error-message{
    background:#FAD2CC;
    color:#b91c1c;
    padding:12px;
    border-radius:14px;
    text-align:center;
    font-weight:bold;
    margin-bottom:18px;
}

.register-text{
    text-align:center;
    margin-top:22px;
    color:#666;
    font-size:14px;
}

.register-text a{
    color:#F48882;
    text-decoration:none;
    font-weight:bold;
}

.register-text a:hover{
    color:#DD9BCF;
}

@media(max-width:480px){
    .form-container{
        padding:30px 22px;
        border-radius:20px;
    }

    .form-container h2{
        font-size:30px;
    }
}
</style>
</head>

<body>

<jsp:include page="header.jsp" />

<div class="login-wrapper">

    <div class="form-container">

        <h2>Login</h2>

        <p class="subtitle">
            Welcome back to Cheatsheet
        </p>

        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/LoginServlet"
              method="post">

            <div class="form-group">
                <input type="email"
                       name="email"
                       placeholder="Email address"
                       required>
            </div>

            <div class="form-group">
                <input type="password"
                       name="password"
                       placeholder="Password"
                       required>
            </div>

            <button type="submit">
                Login
            </button>

        </form>

        <p class="register-text">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/register.jsp">
                Register
            </a>
        </p>

    </div>

</div>

<jsp:include page="footer.jsp" />

</body>
</html>