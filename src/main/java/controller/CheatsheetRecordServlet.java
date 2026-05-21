package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.HomeCheatSheetBean;
import model.UserBean;
import repository.HomeCheatSheetRepository;

@WebServlet("/CheatsheetRecordServlet")
public class CheatsheetRecordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session =
            request.getSession(false);

        if(session == null ||
           session.getAttribute("loginUser") == null){

            response.sendRedirect("login.jsp");
            return;
        }

        UserBean loginUser =
            (UserBean) session.getAttribute("loginUser");

        if(!"admin".equalsIgnoreCase(loginUser.getRole())){
            response.sendRedirect("IndexServlet");
            return;
        }

        HomeCheatSheetRepository repo =
            new HomeCheatSheetRepository();

        List<HomeCheatSheetBean> records =
            repo.getAllPublicActiveRecords();

        request.setAttribute("records", records);

        request.getRequestDispatcher("cheatsheetRecordList.jsp")
               .forward(request, response);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}