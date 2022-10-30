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
		<title>User Home</title>
	</head>
<body>
<%
String apply_job = (String)session.getAttribute("apply_job");
   System.out.println(apply_job);
if (apply_job != null){
	System.out.println("Reached here");
	out.println("<script>alert('Success fully applied')</script>");
	session.removeAttribute("apply_job");
}
%>

<%
	String session_id = session.getId();
	String u_id = (String)session.getAttribute("u_id");
	session.setAttribute("u_id", u_id);

	if (u_id == null) {
		// securing home page using sessions
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
		
	String ListENd = "</ul>";	

	Resume = ListHead + list_body + ListENd;
 	// out.println(Resume);
%>
<section class="vh-100" style="background-color: #eee;">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-md-12 col-xl-4">

        <div class="card" style="border-radius: 15px;">
          <div class="card-body text-center">
            <div class="mt-3 mb-4">
              <img src="data:image/png;base64,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"
                class="rounded-circle img-fluid" style="width: 100px;" />
            </div>
            <h4 class="mb-2"><% out.print(u_name); %></h4>
            <p class="text-muted mb-4">@PortalUser <span class="mx-2">|</span> User ID : <% out.print(u_id); %></p>
            
            <button type="button" class="btn btn-primary btn-rounded btn">
              <% out.print(u_email); %>
            </button>
          </div>
        </div>

      </div>
    </div>
  </div>
</section>


<div style="display : flex; align-items: center; justify-content:center; padding : 1rem; margin-top : 5rem;" >
<div style="width:40%; border : 0.1px solid black; padding : 3rem; border-radius : 1rem;" class="container mt-3">
  <h1>Search for JOBS >> </h1>
  <form action="SearchJob" method="post">
  	<div class="mb-3 mt-3">
      <input type="text" class="form-control" id="cid" placeholder="Enter Company name (or leave blank for every company)" name="cid">
    </div>
    <div class="mb-3 mt-3">
      <input type="text" class="form-control" id="email" placeholder="Enter skill name (or leave blank for every skill)" name="skill_name">
    </div>
    <button type="submit" class="btn btn-primary" name="cbtn">Search</button>
  </form>
</div>
</div>


<div style="display : flex; align-items: center; justify-content:center; padding : 1rem; margin-top : 5rem;" >
<div style="width:40%; border : 0.1px solid black; padding : 3rem; border-radius : 1rem;" class="container mt-3">
  <h1>Apply for a JOB >> </h1>
  <form action="SearchJob" method="post">
  	<div class="mb-3 mt-3">
      <input type="text" class="form-control" id="job_id_for_apply" placeholder="Enter Job ID" name="job_id_for_apply" required>
    </div>
    <button type="submit" class="btn btn-primary" name="apply_btn">Apply</button>
  </form>
</div>
</div>


<div style="display : flex; align-items: center; justify-content:center; padding : 1rem; margin-top : 5rem;" >
<div style="width:40%; border : 0.1px solid black; padding : 3rem; border-radius : 1rem;" class="container mt-3">
  <h1>Update your Skills >> </h1>
  <form action="UpdateSkill" method="post">
  	<div class="mb-3 mt-3">
   
      <input type="text" class="form-control" id="cid" placeholder="Enter skill name 1" name="sid5" required>
    </div>
    <div class="mb-3 mt-3">
     
      <input type="text" class="form-control" id="email" placeholder="Enter skill name 2" name="sid1" required>
    </div>
    <div class="mb-3 mt-3">
     
      <input type="text" class="form-control" id="email" placeholder="Enter skill name 3" name="sid2" required>
    </div>
    <div class="mb-3 mt-3">
      
      <input type="text" class="form-control" id="email" placeholder="Enter skill name 4" name="sid3" required>
    </div>
    <div class="mb-3 mt-3">
      <input type="text" class="form-control" id="email" placeholder="Enter skill name 5" name="sid4" required>
    </div>
    <button type="text" class="btn btn-primary" name="cbtn">Update</button>
  </form>
</div>
</div>




<h3 align='center'>Check Status</h3>

<%
	String status_body;
	status_body = "<li class='list-group-item'> You got hired in -> <br> </li>";
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