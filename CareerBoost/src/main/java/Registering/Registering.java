package Registering;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet implementation class Registering
 */
public class Registering extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Registering() {
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
		// TODO Auto-generated method stub
		doGet(request, response);
		
HttpSession s = request.getSession();
        
		Connection con = null;
		
 		String url = "jdbc:mysql://localhost:3306/JobsData"; //MySQL URL and followed by the database name
 		String username = "JobPortal"; //MySQL username
 		String password = "CareerBoost123**"; //MySQL password
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // loading the driver
		
		try {
			con = DriverManager.getConnection(url, username, password);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} //attempting to connect to MySQL database
		
		
		if (request.getParameter("ubtn") != null) {
			String u_id = request.getParameter("uid");
			String u_pw = request.getParameter("password");
			String email = request.getParameter("email");
			String name = request.getParameter("uname");
			
			PreparedStatement st;
			
			try {
				st = con.prepareStatement("SELECT COUNT(*) FROM PortalUser WHERE u_id = ? ;");
				st.setString(1, u_id);
				
				ResultSet result = st.executeQuery();
				
				result.next();
				
				int count = result.getInt(1);
				
				if (count == 0) {
					// can register
					
					st = con.prepareStatement("INSERT INTO PortalUser VALUES (?, ?, ?, ?) ;");
					
					st.setString(1, u_id);
					st.setString(2, name);
					st.setString(3, u_pw);
					st.setString(4, email);
					
					int res = st.executeUpdate();
					if (res > 0) {
						// set the session attribute
						s.setAttribute("u_id", u_id);
			        	s.setAttribute("u_pw", u_pw);
			        	s.setAttribute("u_name", name);
			        	s.setAttribute("u_email", email);
			        	
			        	RequestDispatcher rd =  request.getRequestDispatcher("UserHome.jsp");
					    rd.forward(request, response);
					} else {
						RequestDispatcher rd =  request.getRequestDispatcher("userRegister.html");
					    rd.forward(request, response);
					}
				} else {
					// cannot register
					RequestDispatcher rd =  request.getRequestDispatcher("userRegister.html");
				    rd.forward(request, response);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		} else if (request.getParameter("cbtn") != null) {
			String c_id = request.getParameter("cid");
			String c_pw = request.getParameter("password");
			String email = request.getParameter("email");
			String name = request.getParameter("cname");
			
			PreparedStatement st;
			
			try {
				st = con.prepareStatement("SELECT COUNT(*) FROM Company WHERE c_id = ? ;");
				st.setString(1, c_id);
				
				ResultSet result = st.executeQuery();
				
				result.next();
				
				int count = result.getInt(1);
				
				if (count == 0) {
					// can register
					
					st = con.prepareStatement("INSERT INTO Company VALUES (?, ?, ?, ?) ;");
					
					st.setString(1, c_id);
					st.setString(2, name);
					st.setString(3, c_pw);
					st.setString(4, email);
					
					int res = st.executeUpdate();
					if (res > 0) {
						// set the session attribute
						s.setAttribute("c_id", c_id);
			        	s.setAttribute("c_pw", c_pw);
			        	s.setAttribute("c_name", name);
			        	s.setAttribute("c_email", email);
			        	
			        	System.out.println("Almost there");
			        	
			        	RequestDispatcher rd =  request.getRequestDispatcher("CompanyHome.jsp");
					    rd.forward(request, response);
					} else {
						RequestDispatcher rd =  request.getRequestDispatcher("companyRegister.html");
					    rd.forward(request, response);
					}
				} else {
					// cannot register
					RequestDispatcher rd =  request.getRequestDispatcher("companyRegister.html");
				    rd.forward(request, response);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
