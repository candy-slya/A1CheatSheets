package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.HomeCheatSheetBean;
import model.UserBean;
import repository.BookmarkRepository;

@WebServlet("/BookmarkListServlet")
public class BookmarkListServlet extends HttpServlet {

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

        BookmarkRepository repo =
            new BookmarkRepository();

        List<HomeCheatSheetBean> bookmarkList =
            repo.findBookmarksByUserId(loginUser.getId());

        request.setAttribute("bookmarkList", bookmarkList);

        request.getRequestDispatcher("bookmarkList.jsp")
               .forward(request, response);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}