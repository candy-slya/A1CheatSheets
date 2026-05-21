package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.CategoryBean;
import repository.CategoryRepository;

/**
 * Servlet implementation class ManageCategoriesServlet
 */
@WebServlet("/ManageCategoriesServlet")
public class ManageCategoriesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageCategoriesServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 CategoryRepository repo = new CategoryRepository();
		    List<CategoryBean> categories = repo.findAllActive(); // only active categories

		    request.setAttribute("categories", categories);
		    request.getRequestDispatcher("addcategory.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	    // Get form parameters
	    String name = request.getParameter("name");
	    String description = request.getParameter("description");

	    // Build CategoryBean
	    CategoryBean category = new CategoryBean();
	    category.setName(name);
	    category.setDescription(description);
	   

	    // Insert into DB
	    CategoryRepository repo = new CategoryRepository();
	    repo.insert(category);

	    // After insert, redirect back to ManageCategoriesServlet (which forwards to addcategory.jsp)
	    response.sendRedirect("ManageCategoriesServlet");

    }

    

}
