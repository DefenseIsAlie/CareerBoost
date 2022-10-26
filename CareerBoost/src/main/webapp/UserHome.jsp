<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

String user_id = (String)session.getAttribute("u_id");
String user_pw = (String)session.getAttribute("u_pw");

out.println(user_id);

%>

</body>
</html>