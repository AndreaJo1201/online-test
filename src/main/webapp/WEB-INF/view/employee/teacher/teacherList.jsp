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
		<form method="get" action="${pageContext.request.contextPath}/employee/teacher/teacherList">
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
			<a href="${pageContext.request.contextPath}/employee/teacher/teacherList?currentPage=1&searchWord=${searchWord}&rowPerPage=${rowPerPage}&searchCategory=${searchCategory}">처음으로</a>
			<c:if test="${currentPage > 1}">
				<a href="${pageContext.request.contextPath}/employee/teacher/teacherList?currentPage=${currentPage-1}&searchWord=${searchWord}&rowPerPage=${rowPerPage}&searchCategory=${searchCategory}">이전</a>
			</c:if>
			<c:if test="${lastPage >= endPage}">
				<c:forEach var="a" begin="${beginPage}" end="${endPage}">
					<a href="${pageContext.request.contextPath}/employee/teacher/teacherList?currentPage=${a}&searchWord=${searchWord}&rowPerPage=${rowPerPage}&searchCategory=${searchCategory}">${a}</a>
				</c:forEach>
			</c:if>
			<c:if test="${lastPage < endPage}">
				<c:forEach var="a" begin="${beginPage}" end="${lastPage}">
					<a href="${pageContext.request.contextPath}/employee/teacher/teacherList?currentPage=${a}&searchWord=${searchWord}&rowPerPage=${rowPerPage}&searchCategory=${searchCategory}">${a}</a>
				</c:forEach>
			</c:if>
			<c:if test="${currentPage < lastPage}">
				<a href="${pageContext.request.contextPath}/employee/teacher/teacherList?currentPage=${currentPage+1}&searchWord=${searchWord}&rowPerPage=${rowPerPage}&searchCategory=${searchCategory}">다음</a>
			</c:if>
			<a href="${pageContext.request.contextPath}/employee/teacher/teacherList?currentPage=${lastPage}&searchWord=${searchWord}&rowPerPage=${rowPerPage}&searchCategory=${searchCategory}">끝으로</a>
		</div>
	</body>
</html>