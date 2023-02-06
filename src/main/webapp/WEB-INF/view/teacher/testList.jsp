<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>TEST LIST</title>
	</head>
	
	<body>
		<!-- teacherMenu include -->
		<div>
			<c:import url="/WEB-INF/view/teacher/inc/teacherMenu.jsp"></c:import>
		</div>
		
		<h1>TEST LIST(시험 목록)</h1>
		<a href="${pageContext.request.contextPath}/teacher/addTest">시험등록</a>
		<a href="${pageContext.request.contextPath}/teacher/logout">로그아웃</a>
				<form method="get" action="${pageContext.request.contextPath}/teacher/testList">
			<select name="rowPerPage">
				<option value=5>5</option>
				<option value=10 selected="selected">10</option>
				<option value=20>20</option>
			</select>
			<input type="text" name="searchWord" placeholder="검색어">
			<button type="submit">이름검색</button>
		</form>
		<table border="1">
			<tr>
				<th>시험</th>
				<th>시험게시일</th>
				<th>삭제</th>
			</tr>
			<c:if test="${not empty list}">
				<c:forEach var="t" items="${list}">
					<tr>
						<td><a href="${pageContext.request.contextPath}/teacher/modifyTest?testNo=${t.testNo}">${t.testTitle}</a></td>
						<td>${t.testDate}</td>
						<td><a href="${pageContext.request.contextPath}/teacher/removeTest?testNo=${t.testNo}">삭제</a></td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty list}">
				<tr>
					<td colspan="3">등록된 시험이 없습니다.</td>
				</tr>
			</c:if>
		</table>
		<div>
			<a href="${pageContext.request.contextPath}/teacher/testList?currentPage=1&searchWord=${searchWord}&rowPerPage=${paging['rowPerPage']}">처음으로</a>
			<c:if test="${paging['currentPage'] > 1}">
				<a href="${pageContext.request.contextPath}/teacher/testList?currentPage=${paging['currentPage']-1}&searchWord=${searchWord}&rowPerPage=${paging['rowPerPage']}">이전</a>
			</c:if>
			
			<c:if test="${paging['lastPage'] >= paging['endPage']}">
				<c:forEach var="a" begin="${paging['beginPage']}" end="${paging['endPage']}">
					<a href="${pageContext.request.contextPath}/teacher/testList?currentPage=${a}&searchWord=${searchWord}&rowPerPage=${paging['rowPerPage']}">${a}</a>
				</c:forEach>
			</c:if>
			
			<c:if test="${paging['lastPage'] < paging['endPage']}">
				<c:forEach var="a" begin="${paging['beginPage']}" end="${paging['lastPage']}">
					<a href="${pageContext.request.contextPath}/teacher/testList?currentPage=${a}&searchWord=${searchWord}&rowPerPage=${paging['rowPerPage']}">${a}</a>
				</c:forEach>
			</c:if>
			
			<c:if test="${paging['currentPage'] < paging['lastPage']}">
				<a href="${pageContext.request.contextPath}/teacher/testList?currentPage=${paging['currentPage']+1}&searchWord=${searchWord}&rowPerPage=${paging['rowPerPage']}">이전</a>
			</c:if>
			
			<a href="${pageContext.request.contextPath}/teacher/testList?currentPage=${paging['lastPage']}&searchWord=${searchWord}&rowPerPage=${paging['rowPerPage']}">끝으로</a>
		</div>
	</body>
</html>