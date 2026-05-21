<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Cheatsheet</title>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:Arial, sans-serif;
    background:linear-gradient(135deg,#F6FFEE,#FFF7FB,#FAD2CC);
    color:#333;
}

.container{
    max-width:980px;
    margin:45px auto;
    padding:35px;
    background:white;
    border:3px solid #C6FAD2;
    border-radius:26px;
    box-shadow:0 12px 30px rgba(0,0,0,0.1);
}

.page-title{
    color:#F48882;
    font-size:42px;
    margin-bottom:30px;
}

label{
    display:block;
    margin-top:18px;
    margin-bottom:8px;
    font-weight:bold;
    color:#555;
    font-size:18px;
}

input[type="text"]{
    width:100%;
    padding:15px 18px;
    border:2px solid #C6FAD2;
    border-radius:18px;
    outline:none;
    font-size:16px;
}

input[type="text"]:focus{
    border-color:#DD9BCF;
    box-shadow:0 0 0 4px rgba(221,155,207,0.18);
}

#tag-container{
    display:flex;
    flex-wrap:wrap;
    align-items:center;
    gap:10px;
    padding:12px;
    border:2px solid #C6FAD2;
    border-radius:18px;
    background:white;
    min-height:60px;
}

#tag-input{
    flex:1;
    min-width:180px;
    border:none;
    outline:none;
    font-size:16px;
    background:transparent;
}

.tag-box{
    display:flex;
    align-items:center;
    gap:8px;
    background:#DD9BCF;
    color:white;
    padding:8px 14px;
    border-radius:22px;
    font-size:14px;
    font-weight:bold;
}

.remove-tag{
    cursor:pointer;
    font-size:18px;
}

.content-title{
    margin-top:35px;
    margin-bottom:18px;
    color:#F48882;
    font-size:28px;
}

.section-block{
    border:2px solid #FAD2CC;
    padding:24px;
    border-radius:24px;
    margin-bottom:22px;
    background:#FFF7FB;
    box-shadow:0 8px 20px rgba(0,0,0,0.06);
}

.section-header{
    margin-bottom:16px;
}

.rows-container{
    display:flex;
    flex-direction:column;
    gap:12px;
}

.item-row{
    display:grid;
    grid-template-columns:1fr 2fr;
    gap:14px;
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
    padding:10px 18px;
    border-radius:20px;
    margin-top:16px;
}

.btn-add-section{
    background:#FAD2CC;
    color:#333;
    padding:13px 24px;
    border-radius:24px;
    margin-bottom:24px;
}

.btn-submit{
    display:block;
    width:100%;
    padding:16px;
    background:#DD9BCF;
    color:white;
    border-radius:24px;
    font-size:18px;
    margin-top:16px;
}

.btn-submit:hover{
    background:#F48882;
}

@media(max-width:700px){
    .container{
        padding:26px 18px;
    }

    .item-row{
        grid-template-columns:1fr;
    }

    .page-title{
        font-size:34px;
    }
}
</style>
</head>

<body>

<jsp:include page="header.jsp" />

<div class="container">

    <h1 class="page-title">
        Edit Cheatsheet
    </h1>

    <form id="cheatsheetForm"
          action="${pageContext.request.contextPath}/EditCheatsheetServlet"
          method="post">

        <input type="hidden"
               name="id"
               value="${sheet.id}">

        <label>Cheatsheet Title</label>

        <input type="text"
               name="title"
               value="<c:out value='${sheet.title}'/>"
               required>

        <label>Tags</label>

        <div id="tag-container">
            <input type="text"
                   id="tag-input"
                   placeholder="Type and press Enter">
        </div>

        <input type="hidden"
               id="tags-hidden"
               name="tags"
               value="<c:out value='${sheet.tags}'/>">

        <h3 class="content-title">
            Cheat Sheet Content
        </h3>

        <div id="sections-main-container"></div>

        <textarea id="old-note-data"
                  style="display:none;">${sheet.note}</textarea>

        <button type="button"
                class="btn-add-section"
                onclick="addSection()">
            + Add New Section
        </button>

        <input type="hidden"
               id="note-hidden"
               name="note">

        <button type="submit"
                class="btn-submit">
            Save Changes
        </button>

    </form>

</div>

<jsp:include page="footer.jsp" />

<script>
const tagContainer = document.getElementById("tag-container");
const tagInput = document.getElementById("tag-input");
const tagsHidden = document.getElementById("tags-hidden");

let tags = [];

const oldTags = tagsHidden.value;

if(oldTags && oldTags.trim() !== ""){
    tags = oldTags.split(",")
        .map(function(t){
            return t.trim();
        })
        .filter(function(t){
            return t !== "";
        });
}

renderTags();

tagInput.addEventListener("keydown", function(e){

    if(e.key === "Enter" && tagInput.value.trim() !== ""){

        e.preventDefault();

        const val =
            tagInput.value.trim().toLowerCase();

        if(!tags.includes(val)){
            tags.push(val);
            renderTags();
        }

        tagInput.value = "";
    }
});

function renderTags(){

    const input = tagInput;

    tagContainer.innerHTML = "";

    tags.forEach(function(tag, index){

        const span =
            document.createElement("div");

        span.className = "tag-box";

        span.innerHTML =
            '<span>' + escapeHtml(tag) + '</span>' +
            '<span class="remove-tag" onclick="removeTag(' + index + ')">&times;</span>';

        tagContainer.appendChild(span);
    });

    tagContainer.appendChild(input);

    tagsHidden.value = tags.join(",");
}

function removeTag(index){

    tags.splice(index, 1);

    renderTags();
}

const oldNoteElement =
    document.getElementById("old-note-data");

const oldNote =
    oldNoteElement ? oldNoteElement.value.trim() : "";

console.log("EDIT OLD NOTE =", oldNote);

const mainContainer =
    document.getElementById("sections-main-container");

if(oldNote !== ""){

    try{

        const sections =
            JSON.parse(oldNote);

        if(Array.isArray(sections) && sections.length > 0){

            sections.forEach(function(sec){
                addSection(sec);
            });

        }else{
            addSection();
        }

    }catch(e){

        console.log("NOTE JSON ERROR =", e);
        console.log("NOTE DATA =", oldNote);

        addSection();
    }

}else{
    addSection();
}

function addSection(sectionData){

    const div =
        document.createElement("div");

    div.className = "section-block";

    const title =
        sectionData && sectionData.title
        ? sectionData.title
        : "";

    div.innerHTML =
        '<div class="section-header">' +
            '<input type="text" class="section-title-input" placeholder="Section Name e.g. Anchors" value="' + escapeAttr(title) + '">' +
        '</div>' +
        '<div class="rows-container"></div>' +
        '<button type="button" class="btn-add-row" onclick="addRow(this)">+ Add Row</button>';

    mainContainer.appendChild(div);

    const rowsContainer =
        div.querySelector(".rows-container");

    if(sectionData &&
       sectionData.items &&
       sectionData.items.length > 0){

        sectionData.items.forEach(function(item){

            addRowToContainer(
                rowsContainer,
                item.k,
                item.v
            );
        });

    }else{

        addRowToContainer(
            rowsContainer,
            "",
            ""
        );
    }
}

function addRow(btn){

    const rowsContainer =
        btn.previousElementSibling;

    addRowToContainer(
        rowsContainer,
        "",
        ""
    );
}

function addRowToContainer(rowsContainer, key, val){

    const row =
        document.createElement("div");

    row.className = "item-row";

    row.innerHTML =
        '<input type="text" class="item-key" placeholder="Symbol e.g. ^" value="' + escapeAttr(key || "") + '">' +
        '<input type="text" class="item-value" placeholder="Description e.g. Start of string" value="' + escapeAttr(val || "") + '">';

    rowsContainer.appendChild(row);
}

function escapeHtml(text){

    return String(text)
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;");
}

function escapeAttr(text){

    return String(text)
        .replace(/&/g, "&amp;")
        .replace(/"/g, "&quot;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;");
}

document.getElementById("cheatsheetForm").onsubmit =
function(){

    const sections = [];

    const sectionBlocks =
        document.querySelectorAll(".section-block");

    sectionBlocks.forEach(function(block){

        const title =
            block.querySelector(".section-title-input")
                 .value.trim();

        const rows =
            block.querySelectorAll(".item-row");

        const items = [];

        rows.forEach(function(row){

            const k =
                row.querySelector(".item-key")
                   .value.trim();

            const v =
                row.querySelector(".item-value")
                   .value.trim();

            if(k !== "" || v !== ""){

                items.push({
                    "k": k,
                    "v": v
                });
            }
        });

        if(title !== "" || items.length > 0){

            sections.push({
                "title": title,
                "items": items
            });
        }
    });

    document.getElementById("note-hidden").value =
        JSON.stringify(sections);
};
</script>

</body>
</html>