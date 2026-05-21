<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page import="model.UserBean" %>
<%@ page session="true" %>

<%
    UserBean loginUser =
        (UserBean) session.getAttribute("loginUser");

    if(loginUser == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>

<style>
body{
    font-family:Arial,sans-serif;
    background:linear-gradient(135deg,#F6FFEE,#FFF7FB,#FAD2CC);
}

.box{
    max-width:460px;
    margin:70px auto;
    background:white;
    padding:35px;
    border-radius:24px;
    border:3px solid #C6FAD2;
    box-shadow:0 12px 30px rgba(0,0,0,0.1);
}

h2{
    color:#F48882;
    margin-bottom:25px;
}

input{
    width:100%;
    padding:14px;
    border:2px solid #C6FAD2;
    border-radius:16px;
    font-size:16px;
    outline:none;
}

button{
    width:100%;
    margin-top:18px;
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

    <h2>Edit Name</h2>

    <c:if test="${not empty success}">
        <div class="success">${success}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/EditProfileServlet"
          method="post">

        <input type="text"
               name="name"
               value="<%= loginUser.getName() %>"
               required>

        <button type="submit">
            Update Name
        </button>

    </form>

    <a class="back"
       href="${pageContext.request.contextPath}/ProfileViewServlet">
        ← Back to Profile
    </a>

</div>

<jsp:include page="footer.jsp" />

</body>
</html>