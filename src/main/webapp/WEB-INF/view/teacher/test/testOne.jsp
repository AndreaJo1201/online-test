<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>시험 내역</title>
	</head>
	
	<body>
		<h1>시험 상세보기</h1>
		
		<table border="1">
			<tr>
				<td>시험 명</td>
				<td>${test['testTitle']}</td>
			</tr>
			<tr>
				<td>담당 강사</td>
				<td>${test['teacherName']}</td>
			</tr>
			<tr>
				<td>시험 응시일</td>
				<td>${test['testDate']}</td>
			</tr>
		</table>
		<c:forEach var="q" items="${test['questionList']}">
			<div>
				<span>${q['questionIdx']}번 문제</span>
				<br>
				<span>${q['questionTitle']}</span>
				<hr>
				<c:forEach var="e" items="${q['example']}">
					<c:if test="${e['exampleOx'] == '정답'}">
						<span style="color:aqua;">${e['exampleIdx']}. ${e['exampleTitle']}</span>
					</c:if>
					<c:if test="${e['exampleOx'] == '오답'}">
						<span>${e['exampleIdx']}. ${e['exampleTitle']}</span>
					</c:if>
				</c:forEach>
			</div>
		</c:forEach>
	</body>
</html>