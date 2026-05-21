package controller;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import model.UserBean;
import repository.UserRepository;
import util.PasswordUtil;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		  String name = request.getParameter("username");
	        String email = request.getParameter("email");
	        String password = request.getParameter("password");
	        String confirmPassword = request.getParameter("confirmPassword");

	        UserRepository repo = new UserRepository();

	        // 1. Required field check
	        if(name == null || name.trim().isEmpty() ||
	           email == null || email.trim().isEmpty() ||
	           password == null || password.trim().isEmpty() ||
	           confirmPassword == null || confirmPassword.trim().isEmpty()) {
	            request.setAttribute("error", "All fields are required!");
	            request.getRequestDispatcher("register.jsp").forward(request, response);
	            return;
	        }

	        // 2. Confirm password check
	        if(!password.equals(confirmPassword)) {
	            request.setAttribute("error", "Passwords do not match!");
	            request.getRequestDispatcher("register.jsp").forward(request, response);
	            return;
	        }

	        // 3. Email exists check
	        if(repo.emailExists(email)) {
	            request.setAttribute("error", "Email already exists!");
	            request.getRequestDispatcher("register.jsp").forward(request, response);
	            return;
	        }

	        // 4. Password encode (BCrypt)
	        String hashedPassword = PasswordUtil.hashPassword(password);

	        UserBean user = new UserBean();
	        user.setName(name);
	        user.setEmail(email);
	        user.setPassword(hashedPassword);

	        // 5. Insert user
	        int result = repo.addUser(user);

	        if(result > 0) {
	            response.sendRedirect("login.jsp?success=1");
	        } else {
	            request.setAttribute("error", "Registration failed!");
	            request.getRequestDispatcher("register.jsp").forward(request, response);
	        }
		
		
	}
}
