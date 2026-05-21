package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.CategoryBean;
import model.UserBean;
import repository.CategoryRepository;
import repository.CheatsheetRepository;

/**
 * Servlet implementation class CreateCheatsheetServlet
 */
@WebServlet("/CreateCheatsheetServlet")
public class CreateCheatsheetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateCheatsheetServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		CategoryRepository repo = new CategoryRepository();
        List<CategoryBean> categories = repo.findAllActive(); // DB က select လုပ်
        
        request.setAttribute("categories", categories);
        RequestDispatcher rd = request.getRequestDispatcher("createCheatsheet.jsp");
        rd.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        UserBean loginUser = (UserBean) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Form parameters ယူခြင်း
        String title = request.getParameter("title");
        int categoryId = Integer.parseInt(request.getParameter("category_id"));
        String note = request.getParameter("note");
        String tagsRaw = request.getParameter("tags"); // "java,sql,html" string ရလာမယ်

        // Tag string ကို Array ပြောင်းခြင်း
        String[] tagArray = (tagsRaw != null && !tagsRaw.isEmpty()) ? tagsRaw.split(",") : new String[0];

        // Database ထဲ ထည့်ခြင်း
        CheatsheetRepository repo = new CheatsheetRepository();
        repo.createCheatsheet(title, categoryId, loginUser.getId(), note, tagArray);

        
        response.sendRedirect("ProfileViewServlet");
	}

}
