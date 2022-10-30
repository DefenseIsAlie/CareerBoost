package SearchJob;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet implementation class SearchJob
 */
public class SearchJob extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchJob() {
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
	    
	    System.out.println("Reached 46");
	    System.out.println((String)request.getAttribute("jid"));
	    System.out.println("Reached 48");
	    String j_id = request.getParameter("job_id_for_apply");
	    System.out.println("Job id is " + j_id);
	    System.out.println((String) request.getParameter("cid"));
		if (j_id != null) {
		    System.out.println("Reached 50");
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

		    PreparedStatement st;
		    
		    HttpSession session =request.getSession();
		    
		    String u_id = (String) session.getAttribute("u_id");
		    
		    
		    try {
                st = con.prepareStatement("INSERT INTO applies VALUES (?, ?)");
                st.setString(1, u_id);
                st.setString(2, j_id);
                
                int result = st.executeUpdate();
                
                
                
            } catch (SQLException e) {
                // TODO: handle exception
                e.printStackTrace();
            }
		    session.setAttribute("apply_job", j_id);
		    RequestDispatcher  rDispatcher = request.getRequestDispatcher("UserHome.jsp");
            rDispatcher.forward(request, response);
		}
		
		System.out.println("reached jsp");
		RequestDispatcher rd = request.getRequestDispatcher("SearchJob.jsp");
		rd.forward(request, response);
		
	}

}
