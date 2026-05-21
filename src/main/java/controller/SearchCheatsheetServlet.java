package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.HomeCheatSheetBean;
import repository.HomeCheatSheetRepository;

@WebServlet("/SearchCheatsheetServlet")
public class SearchCheatsheetServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String keyword = request.getParameter("keyword");

        if(keyword == null){
            keyword = "";
        }

        HomeCheatSheetRepository repo = new HomeCheatSheetRepository();

        List<HomeCheatSheetBean> list =
            repo.searchCheatsheets(keyword.trim());

        request.setAttribute("cheatsheets", list);
        request.setAttribute("categoryName", "Search : " + keyword);

        request.getRequestDispatcher("cheatsheets.jsp")
               .forward(request, response);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request,response);
    }
}