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
 * Servlet implementation class PendingCheatsheetServlet
 */
@WebServlet("/PendingCheatsheetServlet")
public class PendingCheatsheetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PendingCheatsheetServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		  HomeCheatSheetRepository repo = new HomeCheatSheetRepository();

	        List<HomeCheatSheetBean> pendingList =
	            repo.findPendingCheatsheets();

	        request.setAttribute("pendingList", pendingList);

	        request.getRequestDispatcher("pendingCheatsheets.jsp")
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
