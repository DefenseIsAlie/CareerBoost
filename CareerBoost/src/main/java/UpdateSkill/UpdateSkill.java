package UpdateSkill;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.Session;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Servlet implementation class UpdateSkill
 */
public class UpdateSkill extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateSkill() {
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
		
		Connection con = null;

        String url = "jdbc:mysql://localhost:3306/JobsData"; //MySQL URL and followed by the database name
        String username = "JobPortal"; //MySQL username
        String password = "CareerBoost123**"; //MySQL password
        
        HttpSession session = request.getSession();
        String u_id = (String)session.getAttribute("u_id");

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
        
        
        try {
            st = con.prepareStatement("DELETE FROM has_skill WHERE u_id = ?");
            st.setString(1, u_id);
            st.execute();
            
            String sid1 = request.getParameter("sid1");
            String sid2 = request.getParameter("sid2");
            String sid3 = request.getParameter("sid3");
            String sid4 = request.getParameter("sid4");
            String sid5 = request.getParameter("sid5");


            
            
            st = con.prepareStatement("INSERT INTO has_skill VALUES (?,?), (?,?), (?,?), (?,?), (?,?)");
            st.setString(1, u_id);
            st.setString(3, u_id);
            st.setString(5, u_id);
            st.setString(7, u_id);
            st.setString(9, u_id);
            st.setString(2, sid1);
            st.setString(4, sid2);
            st.setString(6, sid3);
            st.setString(8, sid4);
            st.setString(10, sid5);
            st.execute();
            
        } catch (SQLException e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        
		
		
		RequestDispatcher rd = request.getRequestDispatcher("UserHome.jsp");
		rd.forward(request, response);
	}

}
