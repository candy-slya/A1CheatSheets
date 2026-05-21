package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import repository.HomeCheatSheetRepository;

@WebServlet("/UpdateCheatsheetStatusServlet")
public class UpdateCheatsheetStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int id =
            Integer.parseInt(request.getParameter("id"));

        String status =
            request.getParameter("status");

        if(!"active".equals(status) &&
           !"inactive".equals(status)){

            response.sendRedirect("CheatsheetRecordServlet");
            return;
        }

        HomeCheatSheetRepository repo =
            new HomeCheatSheetRepository();

        repo.updateCheatsheetStatus(id, status);

        response.sendRedirect("CheatsheetRecordServlet");
    }
}