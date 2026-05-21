<%@ page import="model.UserBean" %>
<%@ page session="true" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
<title>Add Category</title>

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
    --peach:#FAD2CC;
    --green:#C6FAD2;
    --coral:#F48882;
}

body{
    font-family:Arial,sans-serif;
    background:linear-gradient(135deg,#F6FFEE,#FFF7FB,#FAD2CC);
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
    border-right:3px solid var(--green);
    padding:30px 18px;
    box-shadow:6px 0 22px rgba(0,0,0,0.06);
    position:fixed;
    top:0;
    left:0;
    bottom:0;
}

.admin-profile-card{
    background:linear-gradient(135deg,#FFF7FB,#F6FFEE);
    border:2px solid var(--green);
    border-radius:30px;
    padding:30px 20px;
    text-align:center;
    margin-bottom:35px;
    box-shadow:0 10px 24px rgba(0,0,0,0.08);
}

.profile-avatar-large{
    width:100px;
    height:100px;
    margin:auto;
    border-radius:50%;
    background:linear-gradient(135deg,var(--pink),var(--coral));
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
    font-size:28px;
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
    background:linear-gradient(135deg,#FFF7FB,#F6FFEE);
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
    background:linear-gradient(135deg,var(--pink),var(--coral));
    display:flex;
    align-items:center;
    justify-content:center;
    color:white;
    font-size:18px;
}

/* MAIN */

.main-content{
    margin-left:270px;
    width:calc(100% - 270px);
    padding:45px 40px;
}

.top-bar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    gap:20px;
    flex-wrap:wrap;
    margin-bottom:35px;
}

.page-title{
    color:var(--coral);
    font-size:42px;
    font-weight:bold;
}

.list-btn{
    text-decoration:none;
    background:linear-gradient(135deg,var(--pink),var(--coral));
    color:white;
    padding:14px 22px;
    border-radius:18px;
    font-weight:bold;
    transition:0.25s;
}

.list-btn:hover{
    transform:translateY(-3px);
    box-shadow:0 10px 22px rgba(0,0,0,0.12);
}

/* FORM */

.form-box{
    max-width:620px;
    background:white;
    border:2px solid var(--green);
    border-radius:30px;
    padding:38px;
    box-shadow:0 12px 28px rgba(0,0,0,0.08);
}

.form-box h2{
    color:var(--coral);
    margin-bottom:28px;
    font-size:32px;
}

label{
    display:block;
    margin-bottom:8px;
    margin-top:18px;
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
    background:#fff;
}

textarea{
    resize:none;
    min-height:130px;
}

input:focus,
textarea:focus{
    border-color:var(--pink);
    box-shadow:0 0 0 4px rgba(221,155,207,0.18);
}

.add-btn{
    width:100%;
    border:none;
    background:linear-gradient(135deg,var(--pink),var(--coral));
    color:white;
    padding:16px;
    border-radius:18px;
    font-size:16px;
    font-weight:bold;
    cursor:pointer;
    margin-top:25px;
    transition:0.25s;
}

.add-btn:hover{
    transform:translateY(-3px);
    box-shadow:0 10px 22px rgba(0,0,0,0.12);
}

@media(max-width:950px){
    .sidebar{
        width:100%;
        position:relative;
        border-right:none;
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

    .form-box{
        max-width:100%;
        padding:28px 20px;
    }
}
</style>
</head>

<body>

<div class="page-wrapper">

<jsp:include page="adminSidebar.jsp" />

    <div class="main-content">

        <div class="top-bar">

            <h1 class="page-title">
                Add Category
            </h1>

            <a href="CategoriesServlet"
               class="list-btn">
                <i class="fa-solid fa-list"></i>
                Category List
            </a>

        </div>

        <div class="form-box">

            <h2>Create New Category</h2>

            <form action="ManageCategoriesServlet"
                  method="post">

                <label>Category Name</label>
                <input type="text"
                       name="name"
                       placeholder="Enter category name"
                       required>

                <label>Description</label>
                <textarea name="description"
                          placeholder="Enter category description"></textarea>

                <button type="submit"
                        class="add-btn">
                    Add Category
                </button>

            </form>

        </div>

    </div>

</div>

</body>
</html>