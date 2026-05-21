package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.UserBean;
import repository.HomeCheatSheetRepository;

@WebServlet("/PrivateButtonServlet")
public class PrivateButtonServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null ||
           session.getAttribute("loginUser") == null){

            response.sendRedirect("login.jsp");
            return;
        }

        UserBean loginUser =
            (UserBean) session.getAttribute("loginUser");

        int id = Integer.parseInt(request.getParameter("id"));

        HomeCheatSheetRepository repo =
            new HomeCheatSheetRepository();

        repo.makePrivate(id);

        response.sendRedirect(
            request.getContextPath() + "/PublicCheatsheetServlet");
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}