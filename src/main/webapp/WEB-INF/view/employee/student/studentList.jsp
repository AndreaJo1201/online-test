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
		
		<h1>Student List</h1>
		<a href="${pageContext.request.contextPath}/employee/student/addStudent">학생등록</a>
		<form method="get" action="${pageContext.request.contextPath}/employee/student/studentList">
			<select name="rowPerPage">
				<option value=5>5</option>
				<option value=10 selected="selected">10</option>
				<option value=20>20</option>
			</select>
			<select name="searchCategory">
				<option value="ID" selected="selected">ID</option>
				<option value="name">이름</option>
				<option value="all">ID + 이름</option>
			</select>
			<input type="text" name="searchWord" placeholder="검색어">
			<button type="submit">이름검색</button>
		</form>		
		<table border="1">
			<tr>
				<th>studentId</th>
				<th>studentName</th>
				<th>삭제</th>
			</tr>
			<c:forEach var="s" items="${list}">
				<tr>
					<td>${s.studentId}</td>
					<td>${s.studentName}</td>
					<td><a href="${pageContext.request.contextPath}/employee/student/removeStudent?studentNo=${s.studentNo}">삭제</a></td>
				</tr>
			</c:forEach>
		</table>
		<div>
			<a href="${pageContext.request.contextPath}/employee/student/studentList?currentPage=1&searchWord=${searchWord}&rowPerPage=${paging['rowPerPage']}&searchCategory=${searchCategory}">처음으로</a>
			<c:if test="${paging['currentPage'] > 1}">
				<a href="${pageContext.request.contextPath}/employee/student/studentList?currentPage=${paging['currentPage']-1}&searchWord=${searchWord}&rowPerPage=${paging['rowPerPage']}&searchCategory=${searchCategory}">이전</a>
			</c:if>
			<c:if test="${paging['lastPage'] >= paging['endPage']}">
				<c:forEach var="a" begin="${paging['beginPage']}" end="${paging['endPage']}">
					<a href="${pageContext.request.contextPath}/employee/student/studentList?currentPage=${a}&searchWord=${searchWord}&rowPerPage=${paging['rowPerPage']}&searchCategory=${searchCategory}">${a}</a>
				</c:forEach>
			</c:if>
			<c:if test="${paging['lastPage'] < paging['endPage']}">
				<c:forEach var="a" begin="${paging['beginPage']}" end="${paging['lastPage']}">
					<a href="${pageContext.request.contextPath}/employee/student/studentList?currentPage=${a}&searchWord=${searchWord}&rowPerPage=${paging['rowPerPage']}&searchCategory=${searchCategory}">${a}</a>
				</c:forEach>
			</c:if>
			<c:if test="${paging['currentPage'] < paging['lastPage']}">
				<a href="${pageContext.request.contextPath}/employee/student/studentList?currentPage=${paging['currentPage']+1}&searchWord=${searchWord}&rowPerPage=${paging['rowPerPage']}&searchCategory=${searchCategory}">다음</a>
			</c:if>
			<a href="${pageContext.request.contextPath}/employee/student/studentList?currentPage=${paging['lastPage']}&searchWord=${searchWord}&rowPerPage=${paging['rowPerPage']}&searchCategory=${searchCategory}">끝으로</a>
		</div>			
	</body>
</html>