<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>

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

.register-wrapper{
    min-height:calc(100vh - 220px);
    display:flex;
    align-items:center;
    justify-content:center;
    padding:70px 20px;
}

.form-container{
    width:100%;
    max-width:460px;
    background:rgba(255,255,255,0.94);
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
    margin-bottom:16px;
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

.password-box{
    position:relative;
}

.password-box input{
    padding-right:54px;
}

.eye-btn{
    position:absolute;
    right:15px;
    top:50%;
    transform:translateY(-50%);
    cursor:pointer;
    color:#888;
    font-size:18px;
    user-select:none;
}

.password-note{
    margin-top:7px;
    font-size:13px;
    color:#777;
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

.login-text{
    text-align:center;
    margin-top:22px;
    color:#666;
    font-size:14px;
}

.login-text a{
    color:#F48882;
    text-decoration:none;
    font-weight:bold;
}

.login-text a:hover{
    color:#DD9BCF;
}

@media(max-width:480px){
    .register-wrapper{
        padding:45px 16px;
    }

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

<div class="register-wrapper">

    <div class="form-container">

        <h2>Register</h2>

        <p class="subtitle">
            Create your Cheatsheet account
        </p>

        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/RegisterServlet"
              method="post"
              onsubmit="return checkRegisterForm()">

            <div class="form-group">
                <input type="text"
                       name="username"
                       placeholder="Username"
                       required>
            </div>

            <div class="form-group">
                <input type="email"
                       name="email"
                       placeholder="Email address"
                       required>
            </div>

            <div class="form-group">

                <div class="password-box">

                    <input type="password"
                           id="password"
                           name="password"
                           placeholder="Password"
                           minlength="5"
                           required>

                    <span class="eye-btn"
                          onclick="togglePassword('password', this)">
                        👁
                    </span>

                </div>

                <div class="password-note">
                    Password must be at least 5 characters.
                </div>

            </div>

            <div class="form-group">

                <div class="password-box">

                    <input type="password"
                           id="confirmPassword"
                           name="confirmPassword"
                           placeholder="Confirm Password"
                           minlength="5"
                           required>

                    <span class="eye-btn"
                          onclick="togglePassword('confirmPassword', this)">
                        👁
                    </span>

                </div>

            </div>

            <button type="submit">
                Register
            </button>

        </form>

        <p class="login-text">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login.jsp">
                Login
            </a>
        </p>

    </div>

</div>

<jsp:include page="footer.jsp" />

<script>
function togglePassword(inputId, icon){

    const input =
        document.getElementById(inputId);

    if(input.type === "password"){
        input.type = "text";
        icon.textContent = "🙈";
    }else{
        input.type = "password";
        icon.textContent = "👁";
    }
}

function checkRegisterForm(){

    const password =
        document.getElementById("password").value;

    const confirmPassword =
        document.getElementById("confirmPassword").value;

    if(password.length < 5){
        alert("Password must be at least 5 characters.");
        return false;
    }

    if(password !== confirmPassword){
        alert("Password and Confirm Password do not match.");
        return false;
    }

    return true;
}
</script>

</body>
</html>