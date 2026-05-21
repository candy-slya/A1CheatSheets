<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="model.UserBean" %>

<%@ page session="true" %>

<%@ taglib uri=
"http://java.sun.com/jsp/jstl/core"
prefix="c" %>

<%
    UserBean loginUser =
        (UserBean) session.getAttribute(
            "loginUser");

    if(loginUser == null){

        response.sendRedirect(
            "login.jsp");

        return;
    }
%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<title>
    Change Password
</title>

<style>

body{

    font-family:Arial,sans-serif;

    background:linear-gradient(
        135deg,
        #F6FFEE,
        #FFF7FB,
        #FAD2CC);
}

.box{

    max-width:460px;

    margin:70px auto;

    background:white;

    padding:35px;

    border-radius:24px;

    border:3px solid #C6FAD2;

    box-shadow:
        0 12px 30px
        rgba(0,0,0,0.1);
}

h2{

    color:#F48882;

    margin-bottom:25px;
}

.password-box{

    position:relative;

    margin-bottom:16px;
}

input{

    width:100%;

    padding:
        14px 48px 14px 14px;

    border:2px solid #C6FAD2;

    border-radius:16px;

    font-size:16px;

    outline:none;

    box-sizing:border-box;
}

.eye{

    position:absolute;

    right:15px;

    top:50%;

    transform:translateY(-50%);

    cursor:pointer;
}

.note{

    color:#777;

    font-size:13px;

    margin-bottom:15px;
}

button{

    width:100%;

    margin-top:10px;

    padding:14px;

    border:none;

    border-radius:18px;

    background:#DD9BCF;

    color:white;

    font-weight:bold;

    font-size:16px;

    cursor:pointer;
}

.success{

    background:#C6FAD2;

    padding:12px;

    border-radius:12px;

    margin-bottom:15px;

    color:#2B7A40;

    font-weight:bold;
}

.error{

    background:#FAD2CC;

    padding:12px;

    border-radius:12px;

    margin-bottom:15px;

    color:#b91c1c;

    font-weight:bold;
}

.back{

    display:inline-block;

    margin-top:18px;

    color:#F48882;

    text-decoration:none;

    font-weight:bold;
}

</style>

</head>

<body>

<jsp:include page="header.jsp" />

<div class="box">

    <h2>
        Change Password
    </h2>

    <c:if test=
        "${not empty success}">

        <div class="success">
            ${success}
        </div>

    </c:if>

    <c:if test=
        "${not empty error}">

        <div class="error">
            ${error}
        </div>

    </c:if>

    <form action=
        "${pageContext.request.contextPath}/ChangePasswordServlet"

          method="post"

          onsubmit=
          "return checkPasswordForm()">

        <div class="password-box">

            <input type="password"

                   id="oldPassword"

                   name="oldPassword"

                   placeholder=
                   "Old Password"

                   required>

            <span class="eye"

                  onclick=
                  "togglePassword(
                  'oldPassword',
                  this)">

                👁

            </span>

        </div>

        <div class="password-box">

            <input type="password"

                   id="newPassword"

                   name="newPassword"

                   placeholder=
                   "New Password"

                   minlength="5"

                   required>

            <span class="eye"

                  onclick=
                  "togglePassword(
                  'newPassword',
                  this)">

                👁

            </span>

        </div>

        <div class="note">

            New password must be
            at least 5 characters.

        </div>

        <div class="password-box">

            <input type="password"

                   id="confirmPassword"

                   name="confirmPassword"

                   placeholder=
                   "Confirm New Password"

                   minlength="5"

                   required>

            <span class="eye"

                  onclick=
                  "togglePassword(
                  'confirmPassword',
                  this)">

                👁

            </span>

        </div>

        <button type="submit">

            Change Password

        </button>

    </form>

    <a class="back"

       href=
       "${pageContext.request.contextPath}/ProfileViewServlet">

        ← Back to Profile

    </a>

</div>

<jsp:include page="footer.jsp" />

<script>

function togglePassword(id,icon){

    const input =
        document.getElementById(id);

    if(input.type === "password"){

        input.type = "text";

        icon.textContent = "🙈";

    }else{

        input.type = "password";

        icon.textContent = "👁";
    }
}

function checkPasswordForm(){

    const newPassword =
        document.getElementById(
            "newPassword").value;

    const confirmPassword =
        document.getElementById(
            "confirmPassword").value;

    if(newPassword.length < 5){

        alert(
            "New password must be at least 5 characters.");

        return false;
    }

    if(newPassword !==
       confirmPassword){

        alert(
            "New password and confirm password do not match.");

        return false;
    }

    return true;
}

</script>

</body>
</html>