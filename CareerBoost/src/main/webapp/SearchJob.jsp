<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "jakarta.servlet.http.*,jakarta.servlet.*" %>

<!DOCTYPE html>
<html>
	<head>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
		  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
		  <meta name="viewport" content="width=device-width, initial-scale=1">
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
<body>

<%
	String list_body = "<li class='list-group-item'>Available Jobs are: </li>";
	String comp_name = (String)request.getAttribute("cid");
	String skill_name = (String)request.getAttribute("skill_name");

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

	if (comp_name == ""){

	try{
		st = con.prepareStatement("SELECT job_description, salary, company_name, skill_name from Job NATURAL JOIN reuire_skill NATURAL JOIN Skill NATURAL JOIN posts_job NATURAL JOIN Company where skill_name = ?");
		st.setString(1, skill_name);

		ResultSet result = st.executeQuery();
		int count = 0;
		
		while (result.next() && count < 10 ){
			list_body += "<li class='list-group-item'> Job from company " + result.getString(3) + " With salary " + result.getString(2) + " Job requires: " + result.getString(1) +  " </li>";
		}
		
		list_body += "<li class='list-group-item'> And More.. </li>";
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
} else{
	try{
		st = con.prepareStatement("SELECT job_description, salary, company_name from Job NATURAL JOIN  posts_job NATURAL JOIN Company where company_name = ?");
		st.setString(1, comp_name);

		ResultSet result = st.executeQuery();
		int count = 0;
		while (result.next() && count < 10 ){
			list_body += "<li class='list-group-item'> Job from company " + result.getString(3) + " With salary " + result.getString(2) + " Job requires: " + result.getString(1) +  " </li>";
		}
		list_body += "<li class='list-group-item'> And More.. </li>";
	}catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
}

String Resume = null;
String ListHead = "<ul class='list-group' align='center'>";			
String ListENd = "</ul>";	

Resume = ListHead + list_body + ListENd;
 out.println(Resume);
%>

</body>
</html>