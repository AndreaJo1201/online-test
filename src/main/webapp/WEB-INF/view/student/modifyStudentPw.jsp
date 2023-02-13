<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 수정.Student</title>
		
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
		<div class="container-fluid position-relative d-flex p-0">
	        <!-- Spinner Start -->
	        <div id="spinner" class="show bg-dark position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
	            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
	                <span class="sr-only">Loading...</span>
	            </div>
	        </div>
	        <!-- Spinner End -->
			<!-- studentMenu include -->
			<div>
				<c:import url="/WEB-INF/view/student/inc/studentMenu.jsp"></c:import>
			</div>
			
			<div class="container-fluid">
	            <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
	                <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
	                    <div class="bg-secondary rounded p-4 p-sm-5 my-4 mx-3">
	                        <div class="d-flex align-items-center justify-content-between mb-3">
	                            <a href="${pageContext.request.contextPath}/student/modifyStudentPw" class="">
	                                <h3 class="text-primary"><i class="fa fa-user-edit me-2"></i>Online-Test</h3>
	                            </a>
	                            <h3>Password 변경</h3>
	                        </div>
	                        <form method="post" action="${pageContext.request.contextPath}/student/modifyStudentPw" id="modifyForm">
		                        <div class="form-floating mb-3">
		                            <input type="text" class="form-control" id="floatingInput" placeholder="현재 비밀번호" name="oldPw">
		                            <label for="floatingInput">현재 비밀번호</label>
		                        </div>
		                        <div class="form-floating mb-4">
		                            <input type="password" class="form-control" id="floatingPassword" placeholder="변경할 비밀번호" name="newPw">
		                            <label for="floatingPassword">변경할 비밀번호</label>
		                        </div>
		                        <button type="button" class="btn btn-primary py-3 w-100 mb-4" id="modifyBtn">변경하기</button>
	                        </form>
	                    </div>
	                </div>
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
	    <script>
	    	$(document).ready(function() {
	    		let allCheck = false;
	    		
	    		$('#loginBtn').click(function() {
	    			if($('#floatingInput').val().length < 1) {
	    				alert('현재 비밀번호를 입력해주세요.');
	    			} else if($('#floatingPassword').val().length < 1) {
	    				alert('변경할 비밀번호를 입력해주세요.');
	    			} else {
	    				allCheck = true;
	    			}
	    			
	    			if(allCheck) {
	    				$('#modifyForm').submit();
	    			}
	    		});
	    	})
	    </script>
	    	
	    <!-- Template Javascript -->
	    <script src="/online-test/js/main.js"></script>
	</body>
</html>