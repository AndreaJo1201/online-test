<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	
	<body>
		<!-- empMenu include -->
		<div>
			<c:import url="/WEB-INF/view/employee/inc/empMenu.jsp"></c:import>
		</div>
		<h1>Add Teacher</h1>
		<div>${errorMsg}</div>
		<form method="post" action="${pageContext.request.contextPath}/employee/teacher/addTeacher">
			<table border="1">
				<tr>
					<td>ID</td>
					<td><input type="text" name="teacherId" placeholder="ID"></td>
				</tr>
				<tr>
					<td>Password</td>
					<td><input type="password" name="teacherPw" placeholder="Password"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="teacherName" placeholder="이름"></td>
				</tr>
			</table>
			<button type="submit">등록</button>
		</form>
	</body>
</html>