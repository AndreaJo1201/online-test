<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>응시 목록</title>
				
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
		
		<div class="content container-fluid pt-4 px-4">
			<h1>TEST LIST(응시 목록)</h1>
			
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
				<button type="submit" class="btn btn-primary">검색</button>
			</form>
			<br>
			<div class="bg-secondary rounded">
				<table class="table text-center">
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
				
				<div class="text-center">
					<a href="${pageContext.request.contextPath}/student/testList?currentPage=1&searchWord=${searchWord}&searchCategory=${searchCategory}&rowPerPage=${paging['rowPerPage']}" class="btn btn-primary m-2">처음으로</a>
					<c:if test="${paging['currentPage'] > 1}">
						<a href="${pageContext.request.contextPath}/student/testList?currentPage=${paging['currentPage']-1}&searchWord=${searchWord}&searchCategory=${searchCategory}&rowPerPage=${paging['rowPerPage']}" class="btn btn-primary m-2">이전</a>
					</c:if>
					
					<c:if test="${paging['lastPage'] >= paging['endPage']}">
						<c:forEach var="a" begin="${paging['beginPage']}" end="${paging['endPage']}">
							<a href="${pageContext.request.contextPath}/student/testList?currentPage=${a}&searchWord=${searchWord}&searchCategory=${searchCategory}&rowPerPage=${paging['rowPerPage']}">${a}</a>
						</c:forEach>
					</c:if>
					
					<c:if test="${paging['lastPage'] < paging['endPage']}">
						<c:forEach var="a" begin="${paging['beginPage']}" end="${paging['lastPage']}">
							<a href="${pageContext.request.contextPath}/student/testList?currentPage=${a}&searchWord=${searchWord}&searchCategory=${searchCategory}&rowPerPage=${paging['rowPerPage']}">${a}</a>
						</c:forEach>
					</c:if>
					
					<c:if test="${paging['currentPage'] < paging['lastPage']}">
						<a href="${pageContext.request.contextPath}/student/testList?currentPage=${paging['currentPage']+1}&searchWord=${searchWord}&searchCategory=${searchCategory}&rowPerPage=${paging['rowPerPage']}" class="btn btn-primary m-2">이전</a>
					</c:if>
					
					<a href="${pageContext.request.contextPath}/student/testList?currentPage=${paging['lastPage']}&searchWord=${searchWord}&searchCategory=${searchCategory}&rowPerPage=${paging['rowPerPage']}" class="btn btn-primary m-2">끝으로</a>
				</div>
			</div>
		</div>
		
				
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