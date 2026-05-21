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
import util.PasswordUtil;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
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
		
		
		 String email = request.getParameter("email");
	        String password = request.getParameter("password");

	        UserRepository repo = new UserRepository();
	        UserBean user = repo.findByEmail(email);

	        // 1. Required field check
	        if(email == null || email.trim().isEmpty() ||
	           password == null || password.trim().isEmpty()) {
	            request.setAttribute("error", "Email and Password are required!");
	            request.getRequestDispatcher("login.jsp").forward(request, response);
	            return;
	        }

	        // 2. User exists check
	        if(user == null) {
	            request.setAttribute("error", "Incorrect email or password!");
	            request.getRequestDispatcher("login.jsp").forward(request, response);
	            return;
	        }

	        // 3. Status check
	        if("inactive".equalsIgnoreCase(user.getStatus())) {
	            request.setAttribute("error", "Your account is blocked!");
	            request.getRequestDispatcher("login.jsp").forward(request, response);
	            return;
	        }

	        // 4. Password check (BCrypt)
	        if(!PasswordUtil.checkPassword(password, user.getPassword())) {
	            request.setAttribute("error", "Incorrect email or password!");
	            request.getRequestDispatcher("login.jsp").forward(request, response);
	            return;
	        }

	        // 5. Success → set session
	        HttpSession session = request.getSession();
	        session.setAttribute("loginUser", user);
	        session.setAttribute("userId", user.getId());

	        // 6. Role-based redirect
	        String role = user.getRole(); // or adminFlag
	        
	        if("admin".equalsIgnoreCase(role)) {
	            response.sendRedirect("AdminDashboardServlet");
	            
	        } else if("user".equalsIgnoreCase(role)) {
	        	response.sendRedirect("IndexServlet");
	            
	        } else {
	            response.sendRedirect("subadminview.jsp");
	        }
		
		
	}

}
