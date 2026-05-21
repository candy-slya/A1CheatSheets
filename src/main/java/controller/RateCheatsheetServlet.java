package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.UserBean;
import repository.RatingRepository;

@WebServlet("/RateCheatsheetServlet")
public class RateCheatsheetServlet
extends HttpServlet {

    private static final long
    serialVersionUID = 1L;

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,
            IOException {

        HttpSession session =
            request.getSession(false);

        if(session == null ||
           session.getAttribute(
           "loginUser") == null){

            response.sendRedirect(
                "login.jsp");
            return;
        }

        UserBean loginUser =
            (UserBean)
            session.getAttribute(
                "loginUser");

        int cheatsheetId =
            Integer.parseInt(
                request.getParameter(
                    "cheatsheetId"));

        int rating =
            Integer.parseInt(
                request.getParameter(
                    "rating"));

        RatingRepository repo =
            new RatingRepository();

        repo.saveOrUpdateRating(
            loginUser.getId(),
            cheatsheetId,
            rating);

        response.sendRedirect(
            request.getContextPath()
            + "/ViewCheatsheetServlet?id="
            + cheatsheetId);
    }
}