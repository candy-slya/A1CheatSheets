package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.HomeCheatSheetBean;
import repository.HomeCheatSheetRepository;

@WebServlet("/SearchByTagServlet")
public class SearchByTagServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String tagIdParam = request.getParameter("tagId");

        if(tagIdParam == null || tagIdParam.trim().isEmpty()){
            response.sendRedirect("IndexServlet");
            return;
        }

        int tagId;

        try{
            tagId = Integer.parseInt(tagIdParam);
        }catch(Exception e){
            response.sendRedirect("IndexServlet");
            return;
        }

        HomeCheatSheetRepository repo = new HomeCheatSheetRepository();

        List<HomeCheatSheetBean> list =
            repo.findByTagId(tagId);

        request.setAttribute("cheatsheets", list);
        request.setAttribute("categoryName", "Tag Results");

        request.getRequestDispatcher("cheatsheets.jsp")
               .forward(request, response);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request,response);
    }
}