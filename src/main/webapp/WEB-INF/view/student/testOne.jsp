<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>답안 확인</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
		
		<meta content="width=device-width, initial-scale=1.0" name="viewport">
	    <meta content="" name="keywords">
	    <meta content="" name="description">
	
	    <!-- Favicon -->
	    <link href="/online-test/img/favicon.ico" rel="icon">
	
	    <!-- Google Web Fonts -->
	    <link rel="preconnect" href="https://fonts.googleapis.com">
	    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap" rel="stylesheet"> 
	    
	    <!-- Icon Font Stylesheet -->
	    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
	
	    <!-- Libraries Stylesheet -->
	    <link href="/online-test/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
	    <link href="/online-test/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
	
	    <!-- Customized Bootstrap Stylesheet -->
	    <link href="/online-test/css/bootstrap.min.css" rel="stylesheet">
	
	    <!-- Template Stylesheet -->
	    <link href="/online-test/css/style.css" rel="stylesheet">
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
		
		<!-- JavaScript Libraries -->
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	    <script src="/online-test/lib/chart/chart.min.js"></script>
	    <script src="/online-test/lib/easing/easing.min.js"></script>
	    <script src="/online-test/lib/waypoints/waypoints.min.js"></script>
	    <script src="/online-test/lib/owlcarousel/owl.carousel.min.js"></script>
	    <script src="/online-test/lib/tempusdominus/js/moment.min.js"></script>
	    <script src="/online-test/lib/tempusdominus/js/moment-timezone.min.js"></script>
	    <script src="/online-test/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>
	    <!-- Template Javascript -->
	    <script src="/online-test/js/main.js"></script>
		
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