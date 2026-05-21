package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.HomeCheatSheetBean;
import model.UserBean;
import repository.HomeCheatSheetRepository;

/**
 * Servlet implementation class PrivateCheatsheetServlet
 */
@WebServlet("/PrivateCheatsheetServlet")
public class PrivateCheatsheetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PrivateCheatsheetServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		


        HttpSession session =
                request.getSession();

        UserBean loginUser =
                (UserBean) session.getAttribute("loginUser");

        if(loginUser == null){

            response.sendRedirect("login.jsp");
            return;
        }

        int userId = loginUser.getId();

        HomeCheatSheetRepository repo =
                new HomeCheatSheetRepository();

        List<HomeCheatSheetBean> privateList =
                repo.findPrivateByUserId(userId);

        request.setAttribute(
                "privateList",
                privateList);

        request.getRequestDispatcher(
                "privateCheatsheets.jsp")
                .forward(request, response);
    
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
