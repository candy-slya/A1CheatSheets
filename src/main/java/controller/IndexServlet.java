package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.CategoryBean;
import model.TagBean;
import repository.CategoryRepository;
import repository.TagRepository;

/**
 * Servlet implementation class IndexServlet
 */
@WebServlet("/IndexServlet")
public class IndexServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IndexServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		 CategoryRepository categoryRepo =
		            new CategoryRepository();

		        List<CategoryBean> categories =
		            categoryRepo.findAllActive();

		        request.setAttribute(
		            "categories",
		            categories);

		        TagRepository tagRepo =
		            new TagRepository();

		        List<TagBean> popularTags =
		            tagRepo.findPopularTags();

		        request.setAttribute(
		            "popularTags",
		            popularTags);

		        request.getRequestDispatcher("index.jsp")
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
