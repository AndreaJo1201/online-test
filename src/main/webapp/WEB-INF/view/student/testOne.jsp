<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>답안 확인</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	</head>
	
	<body>
		<!-- teacherMenu include -->
		<div>
			<c:import url="/WEB-INF/view/student/inc/studentMenu.jsp"></c:import>
		</div>
		
		<h1>성적 확인</h1>
		
		<table>
			<tr>
				<th>시험 제목</th>
				<td>${answer['testTitle']}</td>
			</tr>
			<tr>
				<th>강사</th>
				<td>${answer['teacherName']}</td>
			</tr>
			<tr>
				<th>시험일</th>
				<td>${answer['testDate']}</td>
			</tr>
		</table>
		<hr>
		
		<c:forEach var="q" items="${answer['questionList']}">
			<div>
				<span>${q['questionIdx']}번 문제</span>
				<br>
				<span>${q['questionTitle']}</span>
				<br>
				<span>학생이 선택한 답 : ${q['answer']}</span>
				<br>
				<c:forEach var="e" items="${q['example']}">
					<div>
						<c:if test="${e['exampleOx'] == '정답'}">
							<span style="color: red;">${e['exampleIdx']}번 ${e['exampleTitle']}</span>
						</c:if>
						<c:if test="${e['exampleOx'] == '오답'}">
							<span>${e['exampleIdx']}번 ${e['exampleTitle']}</span>
						</c:if>
					</div>
					<c:if test="${e['exampleOx'] == '정답' && e['exampleIdx'] == q['answer']}">
						<input type="hidden" name="answerOx" class="answerOx" value="${e['exampleOx']}">
					</c:if>
				</c:forEach>
			</div>
			<br>
		</c:forEach>
		<div>
			<span> 총 점수 : <span id="correct"></span> / 100</span>
			<input type="hidden" id="questionCnt" value="${fn:length(answer['questionList'])}">
		</div>
		
		<script>
			$(document).ready(function() {
				let totalScore = 100;
				let questionScore = totalScore / $('#questionCnt').val()
				let answerOx = $('.answerOx').length;
				
				let correct = questionScore * answerOx;
				console.log(totalScore);
				console.log(questionScore);
				console.log(answerOx);
				
				$('#correct').html(correct);
				
			})
		</script>
	</body>
</html>