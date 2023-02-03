<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Login</title>
	</head>
	
	<body>
		<!-- 로그인 전 -->
		<c:if test="${loginEmp == null}">
			<h1>login</h1>
			
			<form method="post" action="${pageContext.request.contextPath}/loginEmp">
				<input type="text" name="empId" placeholder="ID">
				<input type="password" name="empPw" placeholder="PW">
				<button type="submit">Log In</button>
			</form>
		</c:if>
		
		<!-- 로그인 상태 -->
		<c:if test="${loginEmp != null}">
			<h1>${loginEmp.empName}님 반갑습니다.</h1>
			<a href="${pageContext.request.contextPath}/employee/logout">로그아웃</a>
		</c:if>
	</body>
</html>