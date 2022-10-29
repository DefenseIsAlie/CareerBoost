<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "jakarta.servlet.http.*,jakarta.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<!-- JavaScript Bundle with Popper -->
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
</head>
<body>

<%

String session_id = session.getId();
String u_id = (String)session.getAttribute("u_id");

if (session_id == null || u_id == null){
	RequestDispatcher rd = request.getRequestDispatcher("index.html");
	rd.forward(request, response);
}

String list_body = "<li class='list-group-item'>Your skills are: </li>";

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

try{
st = con.prepareStatement("SELECT skill_name from has_skill NATURAL JOIN Skill where u_id = ?");
st.setString(1, u_id);

ResultSet result = st.executeQuery();
int count = 0;
while (result.next() && count < 5 ){
	list_body += "<li class='list-group-item'>" + result.getString(1) +  " </li>";
}
list_body += "<li class='list-group-item'> And More.. </li>";
}catch (SQLException e) {
// TODO Auto-generated catch block
e.printStackTrace();
}


%>
<% 

String u_name = (String)session.getAttribute("u_name");
String u_password = (String)session.getAttribute("u_pw");
String u_email  = (String)session.getAttribute("u_email");


String Resume = null;
String ListHead = "<ul class='list-group' align='center'>";
String list_name =	"<li class='list-group-item'>Hello "+ u_name + " Your email is: "+ u_email +"</li>";
				
String ListENd = "</ul>";	

Resume = ListHead + list_name +list_body + ListENd;
 out.println(Resume);
%>

<h3 align='center'>Job Search</h3>
<div style="display : flex; align-items: center; justify-content:center; padding : 1rem; margin-top : 5rem;" >
<div style="width:40%; border : 0.1px solid black; padding : 3rem; border-radius : 1rem;" class="container mt-3">
  <h1 align="center">Search for jobs ...</h1>
  <form action="SearchJob" method="post">
  	<div class="mb-3 mt-3">
      <label for="cid">From Company ... Or </label>
      <input type="text" class="form-control" id="cid" placeholder="Enter Company name" name="cid">
    </div>
    <div class="mb-3 mt-3">
      <label for="email">In this Skill </label>
      <input type="text" class="form-control" id="email" placeholder="Enter skill name" name="skill_name">
    </div>
    <button type="submit" class="btn btn-primary" name="cbtn">Submit</button>
  </form>
</div>
</div>


<h3 align='center'>Update Resume</h3>

<div style="display : flex; align-items: center; justify-content:center; padding : 1rem; margin-top : 5rem;" >
<div style="width:40%; border : 0.1px solid black; padding : 3rem; border-radius : 1rem;" class="container mt-3">
  <h1 align="center">Update your Skills ...</h1>
  <form action="UpdateSkill" method="post">
  	<div class="mb-3 mt-3">
      <label for="cid">Skill 1</label>
      <input type="text" class="form-control" id="cid" placeholder="Skill name" name="cid" required>
    </div>
    <div class="mb-3 mt-3">
      <label for="email">Skill 2</label>
      <input type="email" class="form-control" id="email" placeholder="Skill name" name="email" required>
    </div>
    <div class="mb-3 mt-3">
      <label for="email">Skill 3</label>
      <input type="email" class="form-control" id="email" placeholder="Skill name" name="email" required>
    </div>
    <div class="mb-3 mt-3">
      <label for="email">Skill 4</label>
      <input type="email" class="form-control" id="email" placeholder="Skill name" name="email" required>
    </div>
    <div class="mb-3 mt-3">
      <label for="email">Skill 5</label>
      <input type="email" class="form-control" id="email" placeholder="Skill name" name="email" required>
    </div>
    <button type="submit" class="btn btn-primary" name="cbtn">Submit</button>
  </form>
</div>
</div>

<h3 align='center'>Check Status</h3>
<%
String status_body;
    		  status_body = "<li class='list-group-item'> You got hired in: </li>";
PreparedStatement status_chk;
    		  try{  
					
    			  status_chk = con.prepareStatement("SELECT company_name, job_description, salary FROM hired NATURAL JOIN Job NATURAL JOIN Company where u_id = ?");
    			  status_chk.setString(1, u_id);
    			  
    			  ResultSet result  = status_chk.executeQuery();
    			  
    			  int count = 0;
    			  while (result.next() && count < 5 ){
    			  	list_body += "<li class='list-group-item'> Company " + result.getString(1) + " Hired you for "+ result.getString(2) + " With salary " + result.getString(3) + " </li>";
    			  }
    			  
    			}catch (SQLException e) {
    			  // TODO Auto-generated catch block
    			  e.printStackTrace();
    			  }
    		  

String Status;    		  

Status = ListHead + status_body + ListENd;

out.println(Status);

%>



</body>
</html>