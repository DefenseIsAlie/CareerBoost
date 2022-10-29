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

String c_id = (String)session.getAttribute("c_id");
String c_pw = (String)session.getAttribute("c_pw");

out.println("<h4>"+c_id+"</h4>");

%>
<h3>below</h3>
</body>
</html>