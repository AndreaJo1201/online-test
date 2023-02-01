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
		
		<h1>${loginEmp.empName}님 비밀번호 수정</h1>
		<form method="post" action="${pageContext.request.contextPath}/employee/modifyEmpPw">
			<table border="1">
				<tr>
					<td>현재 비밀번호</td>
					<td><input type="password" name="oldPw"></td>
				</tr>
				<tr>
					<td>변경할 비밀번호</td>
					<td><input type="password" name="newPw"></td>
				</tr>
			</table>
			<button type="submit">변경하기</button>
		</form>
	</body>
</html>