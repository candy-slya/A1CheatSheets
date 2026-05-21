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
 * Servlet implementation class CategoriesServlet
 */
@WebServlet("/CategoriesServlet")
public class CategoriesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CategoriesServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 request.setCharacterEncoding("UTF-8");

	        String keyword = request.getParameter("keyword");

	        if(keyword == null){
	            keyword = "";
	        }

	        int page = 1;
	        int limit = 5;

	        String pageParam = request.getParameter("page");

	        if(pageParam != null){
	            page = Integer.parseInt(pageParam);
	        }

	        int offset = (page - 1) * limit;

	        CategoryRepository repo = new CategoryRepository();

	        List<CategoryBean> categories =
	            repo.findActiveWithSearch(keyword, offset, limit);

	        int totalRecords =
	            repo.countActiveWithSearch(keyword);

	        int totalPages =
	            (int) Math.ceil(totalRecords * 1.0 / limit);

	        request.setAttribute("categories", categories);
	        request.setAttribute("keyword", keyword);
	        request.setAttribute("currentPage", page);
	        request.setAttribute("totalPages", totalPages);

	        request.getRequestDispatcher("categorylist.jsp")
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
