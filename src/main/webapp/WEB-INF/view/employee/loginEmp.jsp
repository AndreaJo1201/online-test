<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	
	<body>
		<h1>login</h1>
		
		<form method="post" action="${pageContext.request.contextPath}/employee/loginEmp">
			<input type="text" name="empId" placeholder="ID">
			<input type="password" name="empPw" placeholder="PW">
			<button type="submit">Log In</button>
		</form>
	</body>
</html>