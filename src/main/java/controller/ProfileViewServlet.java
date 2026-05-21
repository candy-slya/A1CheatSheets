package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.HomeCheatSheetBean;
import model.UserBean;
import repository.BookmarkRepository;
import repository.HomeCheatSheetRepository;

@WebServlet("/ProfileViewServlet")
public class ProfileViewServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public ProfileViewServlet() {
        super();
    }

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

        HomeCheatSheetRepository cheatRepo =
            new HomeCheatSheetRepository();

        BookmarkRepository bookmarkRepo =
            new BookmarkRepository();

        List<HomeCheatSheetBean> publicList =
            cheatRepo.findPublicByUserId(
                loginUser.getId());

        List<HomeCheatSheetBean> privateList =
            cheatRepo.findPrivateByUserId(
                loginUser.getId());

        List<HomeCheatSheetBean> bookmarkList =
            bookmarkRepo.findBookmarksByUserId(
                loginUser.getId());

        request.setAttribute(
            "publicList",
            publicList);

        request.setAttribute(
            "privateList",
            privateList);

        request.setAttribute(
            "bookmarkList",
            bookmarkList);

        request.getRequestDispatcher(
            "profile.jsp")
            .forward(request,response);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}