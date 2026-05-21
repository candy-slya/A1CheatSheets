package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.HomeCheatSheetBean;
import model.UserBean;
import repository.BookmarkRepository;
import repository.HomeCheatSheetRepository;

@WebServlet("/ToggleBookmarkServlet")
public class ToggleBookmarkServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
            request.getSession(false);

        if(session == null ||
           session.getAttribute("loginUser") == null){

            response.sendRedirect("login.jsp");
            return;
        }

        UserBean loginUser =
            (UserBean) session.getAttribute("loginUser");

        String idParam =
            request.getParameter("id");

        if(idParam == null ||
           idParam.trim().isEmpty()){

            response.sendRedirect("IndexServlet");
            return;
        }

        int cheatsheetId = 0;

        try{
            cheatsheetId =
                Integer.parseInt(idParam);
        }catch(Exception e){
            response.sendRedirect("IndexServlet");
            return;
        }

        HomeCheatSheetRepository cheatRepo =
            new HomeCheatSheetRepository();

        HomeCheatSheetBean sheet =
            cheatRepo.findById(cheatsheetId);

        if(sheet == null){
            response.sendRedirect("IndexServlet");
            return;
        }

        if(sheet.getUserId() == loginUser.getId()){
            response.sendRedirect(
                "ViewCheatsheetServlet?id=" + cheatsheetId);
            return;
        }

        BookmarkRepository bookmarkRepo =
            new BookmarkRepository();

        boolean alreadyBookmarked =
            bookmarkRepo.isBookmarked(
                loginUser.getId(),
                cheatsheetId);

        if(alreadyBookmarked){
            bookmarkRepo.removeBookmark(
                loginUser.getId(),
                cheatsheetId);
        }else{
            bookmarkRepo.addBookmark(
                loginUser.getId(),
                cheatsheetId);
        }

        response.sendRedirect(
            "ViewCheatsheetServlet?id=" + cheatsheetId);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request,response);
    }
}