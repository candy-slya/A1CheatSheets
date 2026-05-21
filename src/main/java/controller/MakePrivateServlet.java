package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import repository.HomeCheatSheetRepository;

/**
 * Servlet implementation class MakePrivateServlet
 */
@WebServlet("/MakePrivateServlet")
public class MakePrivateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MakePrivateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		int id =
	            Integer.parseInt(
	                request.getParameter("id"));

	        HomeCheatSheetRepository repo =
	            new HomeCheatSheetRepository();

	        repo.makePrivate(id);

	        response.sendRedirect(
	            request.getContextPath()
	            + "/PublicCheatsheetServlet");
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
