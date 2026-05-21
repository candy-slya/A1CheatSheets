package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.UserBean;
import repository.UserRepository;

/**
 * Servlet implementation class ManageUsersServlet
 */
@WebServlet("/ManageUsersServlet")
public class ManageUsersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageUsersServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		   UserRepository userRepo =
		            new UserRepository();

		        String keyword =
		            request.getParameter("keyword");

		        List<UserBean> users;

		        /* SEARCH */

		        if(keyword != null &&
		           !keyword.trim().isEmpty()){

		            users =
		                userRepo.searchUsers(keyword);

		        }

		        /* NORMAL LIST */

		        else{

		            users =
		                userRepo.findByRoleAndStatus();
		        }

		        request.setAttribute("users", users);

		        RequestDispatcher rd =
		            request.getRequestDispatcher("userlist.jsp");

		        rd.forward(request, response);
		
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
