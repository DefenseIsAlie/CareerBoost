<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>Above</h3>
<%

String session_id = session.getId();
String c_id = (String)session.getAttribute("u_id");

if (session_id == null || c_id == null){
	RequestDispatcher rd = request.getRequestDispatcher("index.html");
	rd.forward(request, response);
}



%>
<h3>below</h3>
</body>
</html>