package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.HomeCheatSheetBean;
import repository.HomeCheatSheetRepository;

/**
 * Servlet implementation class CheatsheetListServlet
 */
@WebServlet("/CheatsheetListServlet")
public class CheatsheetListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheatsheetListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int categoryId =
	            Integer.parseInt(
	                request.getParameter("categoryId"));

	        HomeCheatSheetRepository repo =
	            new HomeCheatSheetRepository();

	        List<HomeCheatSheetBean> cheatsheets =
	            repo.findPublicByCategoryId(categoryId);

	        request.setAttribute(
	            "cheatsheets",
	            cheatsheets);

	        request.getRequestDispatcher(
	            "cheatsheets.jsp")
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
