<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>Above</h3>
<%

String user_id = (String)session.getAttribute("u_id");
String user_pw = (String)session.getAttribute("u_pw");

out.println("<h4>"+user_id+"</h4>");

%>
<h3>below</h3>

</body>
</html>