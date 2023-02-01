<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>강사리스트 | 사원</title>
	</head>
	
	<body>
		<!-- empMenu include -->
		<div>
			<c:import url="/WEB-INF/view/employee/inc/empMenu.jsp"></c:import>
		</div>
		
		<h1>Teacher List</h1>
		<a href="${pageContext.request.contextPath}/employee/teacher/addTeacher">강사등록</a>
		<table border="1">
			<tr>
				<th>teacherId</th>
				<th>teacherName</th>
				<th>삭제</th>
			</tr>
			<c:forEach var="t" items="${list}">
				<tr>
					<td>${t.teacherId}</td>
					<td>${t.teacherName}</td>
					<td><a href="${pageContext.request.contextPath}/employee/teacher/removeTeacher?teacherNo=${t.teacherNo}">삭제</a></td>
				</tr>
			</c:forEach>
		</table>
		<div>
			<a href="${pageContext.request.contextPath}/employee/teacher/teacherList?currentPage=${currentPage-1}">이전</a>
			<a href="${pageContext.request.contextPath}/employee/teacher/teacherList?currentPage=${currentPage+1}">다음</a>
		</div>	
	</body>
</html>