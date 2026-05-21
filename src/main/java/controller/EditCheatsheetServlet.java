package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.HomeCheatSheetBean;
import repository.HomeCheatSheetRepository;

/**
 * Servlet implementation class EditCheatsheetServlet
 */
@WebServlet("/EditCheatsheetServlet")
public class EditCheatsheetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditCheatsheetServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		   int id = Integer.parseInt(request.getParameter("id"));

	        HomeCheatSheetRepository repo =
	            new HomeCheatSheetRepository();

	        HomeCheatSheetBean sheet =
	            repo.findCheatsheetForEdit(id);

	        request.setAttribute("sheet", sheet);

	        request.getRequestDispatcher("editCheatsheet.jsp")
	               .forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 request.setCharacterEncoding("UTF-8");

	        int id =
	            Integer.parseInt(request.getParameter("id"));

	        String title =
	            request.getParameter("title");

	        String note =
	            request.getParameter("note");

	        String tags =
	            request.getParameter("tags");

	        HomeCheatSheetRepository repo =
	            new HomeCheatSheetRepository();

	        repo.updateCheatsheetWithTags(
	            id,
	            title,
	            note,
	            tags
	        );

	        response.sendRedirect(
	            request.getContextPath()
	            + "/ViewCheatsheetServlet?id=" + id);
		
		
	}

}
