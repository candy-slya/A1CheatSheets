package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.HomeCheatSheetBean;
import model.UserBean;
import repository.BookmarkRepository;
import repository.HomeCheatSheetRepository;
import repository.RatingRepository;

@WebServlet("/ViewCheatsheetServlet")
public class ViewCheatsheetServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public ViewCheatsheetServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String idParam =
            request.getParameter("id");

        if(idParam == null ||
           idParam.trim().isEmpty()){

            response.sendRedirect("IndexServlet");
            return;
        }

        int id;

        try{
            id = Integer.parseInt(idParam);
        }catch(Exception e){
            response.sendRedirect("IndexServlet");
            return;
        }

        HomeCheatSheetRepository repo =
            new HomeCheatSheetRepository();

        repo.increaseViewCount(id);

        HomeCheatSheetBean sheet =
            repo.findById(id);

        if(sheet == null){
            response.sendRedirect("IndexServlet");
            return;
        }

        BookmarkRepository bookmarkRepo =
            new BookmarkRepository();

        RatingRepository ratingRepo =
            new RatingRepository();

        boolean bookmarked = false;

        int bookmarkCount =
            bookmarkRepo.countBookmarkByCheatsheetId(id);

        double averageRating =
            ratingRepo.getAverageRating(id);

        int ratingCount =
            ratingRepo.getRatingCount(id);

        int userRating = 0;

        HttpSession session =
            request.getSession(false);

        if(session != null &&
           session.getAttribute("loginUser") != null){

            UserBean loginUser =
                (UserBean) session.getAttribute("loginUser");

            bookmarked =
                bookmarkRepo.isBookmarked(
                    loginUser.getId(),
                    id);

            userRating =
                ratingRepo.getUserRating(
                    loginUser.getId(),
                    id);
        }

        request.setAttribute("sheet", sheet);
        request.setAttribute("bookmarked", bookmarked);
        request.setAttribute("bookmarkCount", bookmarkCount);
        request.setAttribute("averageRating", averageRating);
        request.setAttribute("ratingCount", ratingCount);
        request.setAttribute("userRating", userRating);

        request.getRequestDispatcher("viewCheatsheet.jsp")
               .forward(request, response);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}