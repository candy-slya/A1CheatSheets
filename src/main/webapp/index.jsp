<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page session="true" %>

<%@ page import="model.UserBean" %>
<%@ page import="java.util.List" %>
<%@ page import="model.CategoryBean" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cheatsheet Website - Home</title>

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
    min-height:100vh;
    display:flex;
    flex-direction:column;
}

.content{
    flex:1;
    padding:38px 34px 60px;
}

.hero{
    max-width:1200px;
    margin:0 auto 55px;
    min-height:320px;
    border-radius:36px;
    background:linear-gradient(135deg,#FFF7FB,#F6FFEE,#FAD2CC);
    border:3px solid #C6FAD2;
    box-shadow:0 18px 45px rgba(0,0,0,0.10);
    padding:55px;
}

.badge{
    display:inline-block;
    padding:10px 18px;
    background:#C6FAD2;
    color:#2B7A40;
    border-radius:999px;
    font-weight:bold;
    margin-bottom:22px;
}

.hero h1{
    font-size:58px;
    line-height:1.05;
    color:#2B2B2B;
    margin-bottom:20px;
}

.hero h1 span{
    color:#F48882;
}

.hero p{
    color:#666;
    font-size:18px;
    line-height:1.7;
    max-width:700px;
}

.hero-actions{
    display:flex;
    gap:16px;
    flex-wrap:wrap;
    margin-top:28px;
}

.primary-btn,
.secondary-btn{
    text-decoration:none;
    padding:14px 24px;
    border-radius:18px;
    font-weight:bold;
    transition:0.25s;
}

.primary-btn{
    background:linear-gradient(135deg,#DD9BCF,#F48882);
    color:white;
}

.secondary-btn{
    background:white;
    color:#F48882;
    border:2px solid #FAD2CC;
}

.primary-btn:hover,
.secondary-btn:hover{
    transform:translateY(-4px);
    box-shadow:0 10px 22px rgba(0,0,0,0.12);
}

.section-wrap{
    max-width:1200px;
    margin:0 auto;
}

.section-top{
    margin-bottom:25px;
}

.section-title{
    color:#F48882;
    font-size:38px;
}

.section-sub{
    color:#666;
    margin-top:8px;
}

.category-slider-wrap{
    position:relative;
    width:100%;
    overflow:hidden;
}

.category-container{
    display:flex;
    gap:24px;
    overflow-x:auto;
    scroll-behavior:smooth;
    scrollbar-width:none;
}

.category-container::-webkit-scrollbar{
    display:none;
}

.category-link{
    text-decoration:none;
    min-width:calc(25% - 18px);
    flex-shrink:0;
}

.category-card{
    min-height:190px;
    background:white;
    border:2px solid #C6FAD2;
    border-radius:32px;
    padding:34px 26px;
    box-shadow:0 12px 28px rgba(0,0,0,0.08);
    transition:0.25s;
}

.category-card:hover{
    transform:translateY(-8px);
    border-color:#DD9BCF;
}

.category-card h3{
    font-size:32px;
    font-weight:800;
    color:#F48882;
}

.slider-btn{
    position:absolute;
    top:50%;
    transform:translateY(-50%);
    width:54px;
    height:54px;
    border:none;
    border-radius:50%;
    cursor:pointer;
    z-index:5;
    background:white;
    color:#F48882;
    font-size:24px;
    box-shadow:0 8px 18px rgba(0,0,0,0.12);
}

.prev-btn{
    left:-12px;
}

.next-btn{
    right:-12px;
}

.empty{
    color:#777;
    margin-top:20px;
    font-size:18px;
}

.popular-tags-btn-wrap,
.home-action-buttons{
    display:flex;
    justify-content:center;
    gap:16px;
    flex-wrap:wrap;
}

.popular-tags-btn-wrap{
    margin-top:28px;
}

.home-action-buttons{
    margin-top:18px;
    margin-bottom:35px;
}

.popular-tags-link,
.home-action-link{
    display:inline-flex;
    align-items:center;
    justify-content:center;
    padding:14px 26px;
    border-radius:18px;
    text-decoration:none;
    font-size:16px;
    font-weight:bold;
    color:white;
    background:linear-gradient(135deg,#F48882,#DD9BCF);
    box-shadow:0 10px 24px rgba(221,155,207,0.28);
    transition:0.25s;
}

.popular-tags-link:hover,
.home-action-link:hover{
    transform:translateY(-4px);
}

@media(max-width:1000px){
    .hero{
        padding:38px 24px;
    }

    .hero h1{
        font-size:42px;
    }

    .category-link{
        min-width:calc(50% - 12px);
    }
}

@media(max-width:650px){
    .content{
        padding:26px 16px 45px;
    }

    .hero h1{
        font-size:34px;
    }

    .category-link{
        min-width:100%;
    }
}

.top-link-row{
    display:flex;
    flex-wrap:wrap;
    gap:14px;
    margin-bottom:30px;
}

.top-link-btn{
    text-decoration:none;

    background:white;

    color:#F48882;

    border:2px solid #FAD2CC;

    padding:12px 20px;

    border-radius:999px;

    font-weight:bold;

    transition:0.2s;
}

.top-link-btn:hover{
    transform:translateY(-3px);
    border-color:#DD9BCF;
}



</style>
</head>

<body>

<jsp:include page="header.jsp" />

<div class="content">

<%
    UserBean loginUser =
        (UserBean) session.getAttribute("loginUser");

    List<CategoryBean> categories =
        (List<CategoryBean>) request.getAttribute("categories");
%>

<section class="hero">

    <div class="badge">
        Build your own knowledge library
    </div>

<%
    if(loginUser == null){
%>

    <h1>
        Create and explore
        <span>beautiful cheatsheets</span>
    </h1>

    <p>
        Browse public cheatsheets by category and learn faster with clean,
        organized notes made by users.
    </p>

    <div class="hero-actions">
        <a href="#categories" class="primary-btn">
            Explore Categories
        </a>

        <a href="register.jsp" class="secondary-btn">
            Get Started
        </a>
    </div>

<%
    }else{
%>

    <h1>
        Welcome back,
        <span><%= loginUser.getName() %></span>
    </h1>

    <p>
        Create,manage and publish your cheatsheets easily.
    </p>

    <div class="hero-actions">
        <a href="${pageContext.request.contextPath}/CreateCheatsheetServlet"
           class="primary-btn">
            ➕ Create Cheatsheet
        </a>

        <a href="#categories" class="secondary-btn">
            Browse Categories
        </a>
    </div>

<%
    }
%>

</section>

<section class="section-wrap" id="categories">

    <div class="section-top">
        <h2 class="section-title">
            Categories
        </h2>

        <p class="section-sub">
            Choose a category to view public cheatsheets.
        </p>
    </div>

    <div class="category-slider-wrap">

        <button class="slider-btn prev-btn"
                onclick="slideCategories(-1)">
            ❮
        </button>

        <div class="category-container" id="categorySlider">

<%
    if(categories != null && !categories.isEmpty()){
        for(CategoryBean c : categories){
%>

            <a class="category-link"
               href="${pageContext.request.contextPath}/CheatsheetListServlet?categoryId=<%= c.getId() %>">

                <div class="category-card">
                    <h3><%= c.getName() %></h3>
                </div>

            </a>

<%
        }
    }else{
%>

            <p class="empty">
                No categories available.
            </p>

<%
    }
%>

        </div>

        <button class="slider-btn next-btn"
                onclick="slideCategories(1)">
            ❯
        </button>

    </div>

</section>

</div>

<div class="popular-tags-btn-wrap">

    <a class="popular-tags-link"
       href="${pageContext.request.contextPath}/PopularTagsServlet">
        Find by Tags
    </a>

</div>

<div class="home-action-buttons">

    <a class="home-action-link"
       href="${pageContext.request.contextPath}/RecentCheatsheetServlet">
        Latest Cheatsheets
    </a>

    
     <a class="top-link-btn"
       href="${pageContext.request.contextPath}/PopularCheatsheetServlet">

        🔥 Popular Cheatsheets

    </a>
    

</div>

<jsp:include page="footer.jsp" />

<script>
const slider =
    document.getElementById("categorySlider");

function slideCategories(direction){

    const cards =
        document.querySelectorAll(".category-link");

    if(cards.length === 0){
        return;
    }

    const cardWidth =
        cards[0].offsetWidth + 24;

    slider.scrollBy({
        left:direction * cardWidth,
        behavior:"smooth"
    });
}

window.addEventListener("resize",function(){
    slider.scrollTo({
        left:0,
        behavior:"smooth"
    });
});
</script>

</body>
</html>