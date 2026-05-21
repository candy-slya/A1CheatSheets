package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.HomeCheatSheetBean;
import model.UserBean;
import repository.HomeCheatSheetRepository;
import repository.UserRepository;

@WebServlet("/UserProfileServlet")
public class UserProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String userIdParam = request.getParameter("userId");

        if(userIdParam == null || userIdParam.trim().isEmpty()){
            response.sendRedirect("IndexServlet");
            return;
        }

        int userId;

        try{
            userId = Integer.parseInt(userIdParam);
        }catch(Exception e){
            response.sendRedirect("IndexServlet");
            return;
        }

        UserRepository userRepo = new UserRepository();
        HomeCheatSheetRepository cheatRepo = new HomeCheatSheetRepository();

        UserBean profileUser = userRepo.findUserById(userId);

        if(profileUser == null){
            response.sendRedirect("IndexServlet");
            return;
        }

        List<HomeCheatSheetBean> publicList =
            cheatRepo.findPublicProfileCheatsheetsByUserId(userId);

        request.setAttribute("profileUser", profileUser);
        request.setAttribute("publicList", publicList);

        request.getRequestDispatcher("userProfile.jsp")
               .forward(request, response);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}