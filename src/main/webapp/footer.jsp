<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>

.footer{

    margin-top:60px;

    background:linear-gradient(
        90deg,
        #C6FAD2,
        #F6FFEE,
        #FAD2CC
    );

    border-top:4px solid #DD9BCF;

    padding:45px 30px 25px;

    box-shadow:0 -2px 12px rgba(0,0,0,0.08);
}

/* TOP */

.footer-top{

    display:flex;

    justify-content:space-between;

    align-items:flex-start;

    flex-wrap:wrap;

    gap:40px;

    margin-bottom:35px;
}

/* BRAND */

.footer-brand h2{

    color:#F48882;

    font-size:34px;

    margin-bottom:10px;
}

.footer-brand p{

    color:#555;

    max-width:320px;

    line-height:1.7;
}

/* LINKS */

.footer-links h3,
.footer-contact h3{

    color:#DD9BCF;

    margin-bottom:15px;

    font-size:20px;
}

.footer-links a{

    display:block;

    text-decoration:none;

    color:#444;

    margin-bottom:10px;

    transition:0.2s;
}

.footer-links a:hover{

    color:#F48882;

    transform:translateX(3px);
}

/* CONTACT */

.footer-contact p{

    color:#555;

    margin-bottom:10px;
}

/* BOTTOM */

.footer-bottom{

    border-top:1px solid rgba(0,0,0,0.08);

    padding-top:20px;

    text-align:center;

    color:#777;

    font-size:14px;
}

/* SOCIAL */

.socials{

    margin-top:15px;

    display:flex;

    gap:12px;
}

.socials a{

    width:38px;

    height:38px;

    border-radius:50%;

    background:#DD9BCF;

    color:white;

    display:flex;

    align-items:center;

    justify-content:center;

    text-decoration:none;

    font-size:16px;

    transition:0.2s;
}

.socials a:hover{

    background:#F48882;

    transform:translateY(-2px);
}

</style>

<div class="footer">

    <div class="footer-top">

        <div class="footer-brand">

            <h2>Cheatsheet</h2>

            <p>
                Create, save and explore beautiful
                cheatsheets for programming,
                regex, commands and more.
            </p>

            <div class="socials">

                <a href="#">F</a>

                <a href="#">T</a>

                <a href="#">I</a>

                <a href="#">G</a>

            </div>

        </div>

        <div class="footer-links">

            <h3>Quick Links</h3>

            <a href="${pageContext.request.contextPath}/IndexServlet">
                Home
            </a>

            <a href="${pageContext.request.contextPath}/CreateCheatsheetServlet">
                Create Cheatsheet
            </a>

            <a href="${pageContext.request.contextPath}/ProfileViewServlet">
                Profile
            </a>

        </div>

        <div class="footer-contact">

            <h3>Contact</h3>

            <p>Email : cheatsheet@gmail.com</p>

            <p>Phone : +95 999 123 456</p>

            <p>Location : Myanmar</p>

        </div>

    </div>

    <div class="footer-bottom">

        © 2026 Cheatsheet Platform.
        All Rights Reserved.

    </div>

</div>