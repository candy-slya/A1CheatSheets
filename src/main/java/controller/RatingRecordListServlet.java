package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.RatingRecordBean;
import model.UserBean;
import repository.RatingRepository;

@WebServlet("/RatingRecordListServlet")
public class RatingRecordListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
            request.getSession(false);

        if(session == null ||
           session.getAttribute("loginUser") == null){

            response.sendRedirect("login.jsp");
            return;
        }

        UserBean loginUser =
            (UserBean) session.getAttribute("loginUser");

        RatingRepository repo =
            new RatingRepository();

        List<RatingRecordBean> ratingRecordList =
            repo.findRatingRecordsByOwnerId(
                loginUser.getId());

        request.setAttribute(
            "ratingRecordList",
            ratingRecordList);

        request.getRequestDispatcher(
            "ratingRecordList.jsp")
            .forward(request,response);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request,response);
    }
}