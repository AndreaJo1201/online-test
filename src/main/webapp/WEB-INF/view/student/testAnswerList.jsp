<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>시험 목록</title>
	</head>
	
	<body>
		<!-- teacherMenu include -->
		<div>
			<c:import url="/WEB-INF/view/student/inc/studentMenu.jsp"></c:import>
		</div>
		
		<h1>TEST LIST(시험 목록)</h1>
		<form method="get" action="${pageContext.request.contextPath}/student/testList/check">
			<select name="rowPerPage">
				<option value=5>5</option>
				<option value=10 selected="selected">10</option>
				<option value=20>20</option>
			</select>
			<select name="searchCategory">
				<option value="title" selected="selected">시험 제목</option>
				<option value="name">강사 이름</option>
				<option value="all">시험 + 이름</option>
			</select>
			<input type="text" name="searchWord" placeholder="검색어">
			<button type="submit">검색</button>
		</form>
		<table border="1">
			<tr>
				<td>시험 제목</td>
				<td>강사</td>
				<td>시험일</td>
			</tr>
			<c:if test="${not empty list}">
				<c:forEach var="t" items="${list}">
					<tr>
						<td><a href="${pageContext.request.contextPath}/student/answerOne?testNo=${t.testNo}">${t.testTitle}</a></td>
						<td>${t.teacherName}</td>
						<td>${t.testDate}</td>
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
			<a href="${pageContext.request.contextPath}/student/testList?currentPage=1&searchWord=${searchWord}&rowPerPage=${paging['rowPerPage']}">처음으로</a>
			<c:if test="${paging['currentPage'] > 1}">
				<a href="${pageContext.request.contextPath}/student/testList?currentPage=${paging['currentPage']-1}&searchWord=${searchWord}&rowPerPage=${paging['rowPerPage']}">이전</a>
			</c:if>
			
			<c:if test="${paging['lastPage'] >= paging['endPage']}">
				<c:forEach var="a" begin="${paging['beginPage']}" end="${paging['endPage']}">
					<a href="${pageContext.request.contextPath}/student/testList?currentPage=${a}&searchWord=${searchWord}&rowPerPage=${paging['rowPerPage']}">${a}</a>
				</c:forEach>
			</c:if>
			
			<c:if test="${paging['lastPage'] < paging['endPage']}">
				<c:forEach var="a" begin="${paging['beginPage']}" end="${paging['lastPage']}">
					<a href="${pageContext.request.contextPath}/student/testList?currentPage=${a}&searchWord=${searchWord}&rowPerPage=${paging['rowPerPage']}">${a}</a>
				</c:forEach>
			</c:if>
			
			<c:if test="${paging['currentPage'] < paging['lastPage']}">
				<a href="${pageContext.request.contextPath}/student/testList?currentPage=${paging['currentPage']+1}&searchWord=${searchWord}&rowPerPage=${paging['rowPerPage']}">이전</a>
			</c:if>
			
			<a href="${pageContext.request.contextPath}/student/testList?currentPage=${paging['lastPage']}&searchWord=${searchWord}&rowPerPage=${paging['rowPerPage']}">끝으로</a>
		</div>
	</body>
</html>