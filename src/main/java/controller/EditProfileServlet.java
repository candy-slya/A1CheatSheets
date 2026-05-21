package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.UserBean;
import repository.UserRepository;

/**
 * Servlet implementation class EditProfileServlet
 */
@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditProfileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 request.setCharacterEncoding("UTF-8");

	        HttpSession session =
	            request.getSession(false);

	        if(session == null ||
	           session.getAttribute("loginUser") == null){

	            response.sendRedirect("login.jsp");
	            return;
	        }

	        UserBean loginUser =
	            (UserBean) session.getAttribute("loginUser");

	        String name =
	            request.getParameter("name");

	        if(name == null || name.trim().isEmpty()){

	            request.setAttribute(
	                "error",
	                "Name cannot be empty.");

	            request.getRequestDispatcher("editProfile.jsp")
	                   .forward(request,response);
	            return;
	        }

	        UserRepository repo =
	            new UserRepository();

	        boolean ok =
	            repo.updateName(
	                loginUser.getId(),
	                name.trim());

	        if(ok){

	            loginUser.setName(name.trim());

	            session.setAttribute(
	                "loginUser",
	                loginUser);

	            request.setAttribute(
	                "success",
	                "Profile updated successfully.");

	        }else{

	            request.setAttribute(
	                "error",
	                "Profile update failed.");
	        }

	        request.getRequestDispatcher("editProfile.jsp")
	               .forward(request,response);
		
		
	}

}
