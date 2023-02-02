<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>사원 리스트</title>
	</head>
	
	<body>
		<!-- empMenu include -->
		<div>
			<c:import url="/WEB-INF/view/employee/inc/empMenu.jsp"></c:import>
		</div>
		
		<h1>Employee List</h1>
		<a href="${pageContext.request.contextPath}/employee/addEmp">사원등록</a>
		<a href="${pageContext.request.contextPath}/employee/logout">로그아웃</a>
		<form method="get" action="${pageContext.request.contextPath}/employee/empList">
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
				<th>empId</th>
				<th>empName</th>
				<th>삭제</th>
			</tr>
			<c:forEach var="e" items="${list}">
				<tr>
					<td>${e.empId}</td>
					<td>${e.empName}</td>
					<td><a href="${pageContext.request.contextPath}/employee/removeEmp?empNo=${e.empNo}">삭제</a></td>
				</tr>
			</c:forEach>
		</table>
		<div>
			<a href="${pageContext.request.contextPath}/employee/empList?currentPage=1&searchWord=${searchWord}&rowPerPage=${rowPerPage}&searchCategory=${searchCategory}">처음으로</a>
			<c:if test="${currentPage > 1}">
				<a href="${pageContext.request.contextPath}/employee/empList?currentPage=${currentPage-1}&searchWord=${searchWord}&rowPerPage=${rowPerPage}&searchCategory=${searchCategory}">이전</a>
			</c:if>
			<c:if test="${lastPage >= endPage}">
				<c:forEach var="a" begin="${beginPage}" end="${endPage}">
					<a href="${pageContext.request.contextPath}/employee/empList?currentPage=${a}&searchWord=${searchWord}&rowPerPage=${rowPerPage}&searchCategory=${searchCategory}">${a}</a>
				</c:forEach>
			</c:if>
			<c:if test="${lastPage < endPage}">
				<c:forEach var="a" begin="${beginPage}" end="${lastPage}">
					<a href="${pageContext.request.contextPath}/employee/empList?currentPage=${a}&searchWord=${searchWord}&rowPerPage=${rowPerPage}&searchCategory=${searchCategory}">${a}</a>
				</c:forEach>
			</c:if>
			<c:if test="${currentPage < lastPage}">
				<a href="${pageContext.request.contextPath}/employee/empList?currentPage=${currentPage+1}&searchWord=${searchWord}&rowPerPage=${rowPerPage}&searchCategory=${searchCategory}">다음</a>
			</c:if>
			<a href="${pageContext.request.contextPath}/employee/empList?currentPage=${lastPage}&searchWord=${searchWord}&rowPerPage=${rowPerPage}&searchCategory=${searchCategory}">끝으로</a>
		</div>
	</body>
</html>