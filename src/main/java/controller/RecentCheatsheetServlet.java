package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.HomeCheatSheetBean;
import repository.HomeCheatSheetRepository;

@WebServlet("/RecentCheatsheetServlet")
public class RecentCheatsheetServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HomeCheatSheetRepository repo = new HomeCheatSheetRepository();

        List<HomeCheatSheetBean> list =
            repo.findRecentCheatsheets();

        request.setAttribute("cheatsheets", list);
        request.setAttribute("categoryName", "Recent Cheatsheets");

        request.getRequestDispatcher("cheatsheets.jsp")
               .forward(request,response);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request,response);
    }
}