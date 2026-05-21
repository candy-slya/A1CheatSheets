<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.UserBean" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Cheatsheet</title>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:Arial, sans-serif;
    background:linear-gradient(135deg, #F6FFEE, #FFF7FB, #FAD2CC);
    color:#333;
    min-height:100vh;
}

.page-wrapper{
    width:100%;
    padding:55px 18px;
}

.container{
    max-width:980px;
    margin:0 auto;
    background:rgba(255,255,255,0.94);
    padding:36px;
    border-radius:26px;
    border:3px solid #C6FAD2;
    box-shadow:0 14px 35px rgba(0,0,0,0.12);
}

.top-bar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    flex-wrap:wrap;
    gap:15px;
    margin-bottom:35px;
}


.back-btn,
.create-btn{

    display:inline-flex;
    align-items:center;
    justify-content:center;

    padding:14px 24px;

    border-radius:999px;

    text-decoration:none;

    font-size:16px;

    font-weight:bold;

    transition:0.25s;
}

.back-btn{
    background:white;
    color:#F48882;
    border:2px solid #FAD2CC;
}



h2{
    text-align:center;
    color:#F48882;
    font-size:36px;
    margin-bottom:8px;
}

.subtitle{
    text-align:center;
    color:#777;
    margin-bottom:32px;
}

label{
    display:block;
    margin-top:18px;
    margin-bottom:8px;
    font-weight:bold;
    color:#555;
}

input[type="text"],
select{
    width:100%;
    padding:14px 16px;
    border:2px solid #C6FAD2;
    border-radius:16px;
    outline:none;
    font-size:15px;
    background:#fff;
    color:#333;
    transition:0.2s;
}

input[type="text"]:focus,
select:focus{
    border-color:#DD9BCF;
    box-shadow:0 0 0 4px rgba(221,155,207,0.2);
}

/* TAG UI */

#tag-container{
    display:flex;
    flex-wrap:wrap;
    align-items:center;
    gap:8px;
    padding:10px;
    border:2px solid #C6FAD2;
    border-radius:16px;
    background:white;
    min-height:54px;
}

#tag-input{
    flex:1;
    min-width:160px;
    border:none;
    outline:none;
    font-size:15px;
    background:transparent;
    color:#333;
}

.tag-box{
    display:flex;
    align-items:center;
    gap:8px;
    background:#DD9BCF;
    color:white;
    padding:7px 14px;
    border-radius:20px;
    font-size:14px;
    font-weight:bold;
}

.tag-text{
    color:white;
    display:inline-block;
}

.remove-tag{
    cursor:pointer;
    font-size:18px;
    color:white;
}


}

/* SECTION */

.content-title{
    margin-top:32px;
    color:#F48882;
    font-size:20px;
}

.section-block{
    border:2px solid #FAD2CC;
    padding:20px;
    border-radius:22px;
    margin-bottom:20px;
    background:#FFF7FB;
    box-shadow:0 6px 18px rgba(0,0,0,0.06);
}

.section-header{
    margin-bottom:14px;
}

.rows-container{
    display:flex;
    flex-direction:column;
    gap:10px;
}

.item-row{
    display:grid;
    grid-template-columns:1fr 2fr;
    gap:12px;
}

.btn-add-row,
.btn-add-section,
.btn-submit{
    border:none;
    cursor:pointer;
    font-weight:bold;
    transition:0.2s;
}

.btn-add-row{
    background:#C6FAD2;
    color:#333;
    padding:9px 16px;
    border-radius:18px;
    margin-top:14px;
}

.btn-add-row:hover{
    background:#9BE7B0;
}

.btn-add-section{
    background:#FAD2CC;
    color:#333;
    padding:12px 22px;
    border-radius:22px;
    margin-bottom:18px;
}

.btn-add-section:hover{
    background:#F48882;
    color:white;
}

.btn-submit{
    display:block;
    width:100%;
    padding:15px;
    background:#DD9BCF;
    color:white;
    border-radius:22px;
    font-size:17px;
    margin-top:10px;
}

.btn-submit:hover{
    background:#F48882;
    transform:translateY(-1px);
}

@media(max-width:700px){
    .container{
        padding:26px 18px;
    }

    h2{
        font-size:30px;
    }

    .item-row{
        grid-template-columns:1fr;
    }
}
</style>
</head>

<body>

<jsp:include page="header.jsp" />

<%
    UserBean loginUser = (UserBean) session.getAttribute("loginUser");
    if(loginUser == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<div class="page-wrapper">

<div class="container">

 <div class="top-bar">

        <a class="back-btn"
           href="javascript:history.back()">

            ← Back

        </a>

       

    </div>


    <h2>Create New Cheatsheet</h2>
    <p class="subtitle">Build sections, rows and tags beautifully</p>

    <form id="cheatsheetForm"
          action="${pageContext.request.contextPath}/CreateCheatsheetServlet"
          method="post">

        <label for="title">Cheatsheet Title</label>
        <input type="text"
               id="title"
               name="title"
               placeholder="e.g. Regular Expressions"
               required>

        <label for="category">Category</label>
        <select id="category" name="category_id">
            <c:forEach var="c" items="${categories}">
                <option value="${c.id}">${c.name}</option>
            </c:forEach>
        </select>

        <label>Tags</label>
        <div id="tag-container">
            <input type="text"
                   id="tag-input"
                   placeholder="Type and press Enter">
        </div>

        <input type="hidden" id="tags-hidden" name="tags">

        <label class="content-title">
            Cheat Sheet Content
        </label>

        <div id="sections-main-container">

            <div class="section-block">

                <div class="section-header">
                    <input type="text"
                           class="section-title-input"
                           placeholder="Section Name e.g. Anchors"
                           style="font-weight:bold;">
                </div>

                <div class="rows-container">
                    <div class="item-row">
                        <input type="text"
                               class="item-key"
                               placeholder="Symbol e.g. ^">

                        <input type="text"
                               class="item-value"
                               placeholder="Description e.g. Start of string">
                    </div>
                </div>

                <button type="button"
                        class="btn-add-row"
                        onclick="addRow(this)">
                    + Add Row
                </button>

            </div>

        </div>

        <button type="button"
                class="btn-add-section"
                onclick="addSection()">
            + Add New Section
        </button>

        <input type="hidden" id="note-hidden" name="note">

        <button type="submit" class="btn-submit">
            Save Cheatsheet
        </button>

    </form>

</div>

</div>

<jsp:include page="footer.jsp" />

<script>
const tagContainer = document.getElementById("tag-container");
const tagInput = document.getElementById("tag-input");
const tagsHidden = document.getElementById("tags-hidden");
let tags = [];

tagInput.addEventListener("keydown", function(e) {
    if(e.key === "Enter" && tagInput.value.trim() !== "") {
        e.preventDefault();

        const val = tagInput.value.trim().toLowerCase();

        if(!tags.includes(val)) {
            tags.push(val);
            renderTags();
        }

        tagInput.value = "";
    }
});

function renderTags() {
    const input = tagInput;
    tagContainer.innerHTML = "";

    tags.forEach(function(tag, index) {
        const span = document.createElement("div");
        span.className = "tag-box";

        span.innerHTML =
            '<span class="tag-text">' + tag + '</span>' +
            '<span class="remove-tag" onclick="removeTag(' + index + ')">&times;</span>';

        tagContainer.appendChild(span);
    });

    tagContainer.appendChild(input);
    tagsHidden.value = tags.join(",");
    input.focus();
}


function removeTag(index) {
    tags.splice(index, 1);
    renderTags();
}

function addRow(btn) {
    const rowsContainer = btn.previousElementSibling;
    const div = document.createElement("div");
    div.className = "item-row";

    div.innerHTML =
        `<input type="text" class="item-key" placeholder="Key">
         <input type="text" class="item-value" placeholder="Value">`;

    rowsContainer.appendChild(div);
}

function addSection() {
    const mainContainer = document.getElementById("sections-main-container");
    const div = document.createElement("div");
    div.className = "section-block";

    div.innerHTML =
        `<div class="section-header">
            <input type="text"
                   class="section-title-input"
                   placeholder="Section Name"
                   style="font-weight:bold;">
         </div>

         <div class="rows-container">
            <div class="item-row">
                <input type="text" class="item-key" placeholder="Key">
                <input type="text" class="item-value" placeholder="Value">
            </div>
         </div>

         <button type="button"
                 class="btn-add-row"
                 onclick="addRow(this)">
            + Add Row
         </button>`;

    mainContainer.appendChild(div);
}

document.getElementById("cheatsheetForm").onsubmit = function(e) {
    const sections = [];
    const sectionBlocks = document.querySelectorAll(".section-block");

    sectionBlocks.forEach(block => {
        const titleInput = block.querySelector(".section-title-input");
        const title = titleInput ? titleInput.value.trim() : "";
        const rows = block.querySelectorAll(".item-row");
        const items = [];

        rows.forEach(row => {
            const k = row.querySelector(".item-key").value.trim();
            const v = row.querySelector(".item-value").value.trim();

            if (k !== "" || v !== "") {
                items.push({ "k": k, "v": v });
            }
        });

        if (title !== "" || items.length > 0) {
            sections.push({ "title": title, "items": items });
        }
    });

    document.getElementById("note-hidden").value =
        JSON.stringify(sections);
};
</script>

</body>
</html>