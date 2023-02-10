<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>시험 응시</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	</head>
	
	<body>
		<h1>${test['testTitle']}</h1>
		<p>
			<span>담당 강사</span> <span>${test['teacherName']}</span>
			<br>
			<span>시험일</span> <span>${test['testDate'] }</span>
		</p>
		<div>
			<form method="post" action="${pageContext.request.contextPath}/student/test/addPaper">
				<input type="hidden" readonly="readonly" name="studentNo" value="${studentNo}">
				
				<c:forEach var="q" items="${test['questionList']}">
					<div id="question">
						<span>${q['questionIdx']}번 문제</span>
						<input type="hidden" name="questionNo" value="${q['questionNo']}">
						<br>
						<span>${q['questionTitle']}</span>
						<hr>
						<c:forEach var="e" items="${q['example']}" varStatus="example">
							<div id="example">
								<input type="radio" name="${q['questionTitle']}" value="${e['exampleIdx']}" onchange="checkOx()">
								<label>${e['exampleIdx']}. ${e['exampleTitle']}</label>
							</div>
						</c:forEach>
						<input type="hidden" name="answer" id="answer" value="">
					</div>
				</c:forEach>
				<button type="submit">제출하기</button>
			</form>
		</div>
		
		<script>
			function checkOx() {
				let $question = $(event.target.parentNode.parentNode);
				let $answer = $question.children("#answer");
				
				let $target = $(event.target);
				
				if($target.is(':checked') == true) {
					$answer.attr('value', $target.val());
				}
				
				console.log($answer.val())
			}
		</script>
	</body>
</html>