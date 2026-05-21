package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.UserBean;
import repository.CategoryRepository;
import repository.HomeCheatSheetRepository;
import repository.UserRepository;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet
       extends HttpServlet {

    private static final long
        serialVersionUID = 1L;

    public AdminDashboardServlet() {

        super();
    }

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)

            throws ServletException,
                   IOException {

        request.setCharacterEncoding(
            "UTF-8");

        response.setCharacterEncoding(
            "UTF-8");

        response.setContentType(
            "text/html; charset=UTF-8");

        HttpSession session =
            request.getSession(false);

        if(session == null){

            response.sendRedirect(
                "login.jsp");

            return;
        }

        UserBean loginUser =

            (UserBean)
            session.getAttribute(
                "loginUser");

        if(loginUser == null ||

           !"admin".equalsIgnoreCase(
               loginUser.getRole())){

            response.sendRedirect(
                "index.jsp");

            return;
        }

        UserRepository userRepo =
            new UserRepository();

        CategoryRepository categoryRepo =
            new CategoryRepository();

        HomeCheatSheetRepository cheatRepo =
            new HomeCheatSheetRepository();

        int totalUsers =
            userRepo.countUsers();

        int totalCategories =
            categoryRepo.countActiveCategories();

        int pendingCheatsheets =
            cheatRepo.countPendingCheatsheets();
        
        int totalCheatsheets =

        	    cheatRepo.countAllCheatsheets();

        	request.setAttribute(
        	    "totalCheatsheets",
        	    totalCheatsheets);
        

        request.setAttribute(
            "totalUsers",
            totalUsers);

        request.setAttribute(
            "totalCategories",
            totalCategories);

        request.setAttribute(
            "pendingCheatsheets",
            pendingCheatsheets);

        request.getRequestDispatcher(
            "adminview.jsp")
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