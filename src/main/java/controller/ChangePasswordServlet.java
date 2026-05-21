package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.UserBean;
import repository.UserRepository;
import util.PasswordUtil;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if(session == null ||
           session.getAttribute("loginUser") == null){

            response.sendRedirect("login.jsp");
            return;
        }

        UserBean loginUser =
            (UserBean) session.getAttribute("loginUser");

        String oldPassword =
            request.getParameter("oldPassword");

        String newPassword =
            request.getParameter("newPassword");

        String confirmPassword =
            request.getParameter("confirmPassword");

        if(oldPassword == null || oldPassword.trim().isEmpty()){
            request.setAttribute("error", "Old password is required.");
            request.getRequestDispatcher("changePassword.jsp")
                   .forward(request,response);
            return;
        }

        if(newPassword == null || newPassword.length() < 5){
            request.setAttribute("error", "New password must be at least 5 characters.");
            request.getRequestDispatcher("changePassword.jsp")
                   .forward(request,response);
            return;
        }

        if(!newPassword.equals(confirmPassword)){
            request.setAttribute("error", "New password and confirm password do not match.");
            request.getRequestDispatcher("changePassword.jsp")
                   .forward(request,response);
            return;
        }

        UserRepository repo = new UserRepository();

        String dbHashedPassword =
            repo.findPasswordByUserId(loginUser.getId());

        if(dbHashedPassword == null ||
           !PasswordUtil.checkPassword(oldPassword, dbHashedPassword)){

            request.setAttribute("error", "Old password is incorrect.");
            request.getRequestDispatcher("changePassword.jsp")
                   .forward(request,response);
            return;
        }

        String newHashedPassword =
            PasswordUtil.hashPassword(newPassword);

        boolean ok =
            repo.updatePassword(loginUser.getId(), newHashedPassword);

        if(ok){
            request.setAttribute("success", "Password changed successfully.");
        }else{
            request.setAttribute("error", "Password change failed.");
        }

        request.getRequestDispatcher("changePassword.jsp")
               .forward(request,response);
    }

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect("changePassword.jsp");
    }
}