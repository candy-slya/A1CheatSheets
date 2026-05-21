<%@ page import="model.UserBean" %>
<%@ page session="true" %>

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

<title>Edit Category</title>

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
}

.container{

    max-width:750px;

    margin:60px auto;

    background:white;

    border:2px solid var(--green);

    border-radius:30px;

    padding:40px;

    box-shadow:0 12px 28px rgba(0,0,0,0.08);
}

.page-title{

    color:var(--coral);

    font-size:38px;

    margin-bottom:30px;
}

label{

    display:block;

    margin-top:18px;

    margin-bottom:8px;

    font-weight:bold;

    color:#555;
}

input,
textarea{

    width:100%;

    padding:15px 18px;

    border:2px solid var(--green);

    border-radius:18px;

    outline:none;

    font-size:15px;
}

textarea{

    resize:none;

    min-height:150px;
}

input:focus,
textarea:focus{

    border-color:var(--pink);
}

.update-btn{

    width:100%;

    border:none;

    background:linear-gradient(
        135deg,
        var(--pink),
        var(--coral)
    );

    color:white;

    padding:16px;

    border-radius:18px;

    font-size:16px;

    font-weight:bold;

    cursor:pointer;

    margin-top:28px;
}

.update-btn:hover{

    opacity:0.9;
}

.back-btn{

    display:inline-flex;

    align-items:center;

    gap:10px;

    margin-bottom:20px;

    text-decoration:none;

    color:var(--coral);

    font-weight:bold;
}

</style>

</head>

<body>

<div class="container">

    <a href="ManageCategoriesServlet"
       class="back-btn">

        <i class="fa-solid fa-arrow-left"></i>

        Back

    </a>

    <h1 class="page-title">
        Edit Category
    </h1>

    <!-- EDIT FORM -->

    <form action="${pageContext.request.contextPath}/EditCategoryServlet"
          method="post">

        <!-- CATEGORY ID -->

        <input type="hidden"
               name="id"
               value="${category.id}">

        <!-- CATEGORY NAME -->

        <label>
            Category Name
        </label>

        <input type="text"
               name="name"
               value="${category.name}"
               required>

        <!-- DESCRIPTION -->

        <label>
            Description
        </label>

        <textarea name="description">${category.description}</textarea>

        <!-- UPDATE BUTTON -->

        <button type="submit"
                class="update-btn">

            Update Category

        </button>

    </form>

</div>

</body>
</html>