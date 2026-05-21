package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.HomeCheatSheetBean;
import repository.HomeCheatSheetRepository;

@WebServlet("/PopularCheatsheetServlet")
public class PopularCheatsheetServlet
extends HttpServlet {

    private static final long
    serialVersionUID = 1L;

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,
            IOException {

        HomeCheatSheetRepository repo =
            new HomeCheatSheetRepository();

        List<HomeCheatSheetBean> popularList =
            repo.findPopularCheatsheets();

        request.setAttribute(
            "popularList",
            popularList);

        request.getRequestDispatcher(
            "popularCheatsheets.jsp")
            .forward(request,response);
    }

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,
            IOException {

        doGet(request,response);
    }
}