package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.CategoryBean;
import repository.CategoryRepository;

/**
 * Servlet implementation class EditCategoryServlet
 */
@WebServlet("/EditCategoryServlet")
public class EditCategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditCategoryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	      int id =
	              Integer.parseInt(request.getParameter("id"));

	          CategoryRepository repo =
	              new CategoryRepository();

	          CategoryBean category =
	              repo.findById(id);

	          request.setAttribute("category", category);

	          request.getRequestDispatcher("editcategory.jsp")
	                 .forward(request, response);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 request.setCharacterEncoding("UTF-8");

	        int id =
	            Integer.parseInt(request.getParameter("id"));

	        String name =
	            request.getParameter("name");

	        String description =
	            request.getParameter("description");

	        CategoryBean category =
	            new CategoryBean();

	        category.setId(id);
	        category.setName(name);
	        category.setDescription(description);

	        CategoryRepository repo =
	            new CategoryRepository();

	        repo.update(category);

	        response.sendRedirect(
	            request.getContextPath()
	            + "/ManageCategoriesServlet");
		
		
	}

}
