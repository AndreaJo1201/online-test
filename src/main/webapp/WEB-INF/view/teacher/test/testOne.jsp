<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>시험 내역</title>
				
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
		<!-- 
		<div>
			<a href="${pageContext.request.contextPath}/teacher/test/modifyTest?testNo=${testNo}">시험 수정하기</a>
		</div>
		-->
		
		
		<!-- JavaScript Libraries -->
	    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
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
	</body>
</html>