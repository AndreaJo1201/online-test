<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div>
	<!--
		지나간 시험(table: test) 리스트 + 점수 - 점수확인버튼 클릭 - 제출한 답안지 확인 가능(table - paper)-(정답여부 O, X)
		오늘 날짜의 시험 리스트 응시버튼 -> 시험지(table: question JOIN(*) example) -> 답안지 제출(table : paper) 출력
	 -->
	
	<!-- 응시시험목록(점수확인) -->
	
	
	<div class="sidebar pe-4 pb-3">
		<nav class="navbar bg-secondary navbar-dark">
			<a href="${pageContext.request.contextPath}/student/testList" class="navbar-brand mx-4 mb-3">
				<h3 class="text-primary"><i class="fa fa-user-edit me-2"></i>Online-TEST</h3>
			</a>
			<div class="d-flex align-items-center ms-4 mb-4">
				<div class="position-relative">
					<img class="rounded-circle" src="/online-test/img/user.jpg" alt="" style="width: 40px; height: 40px;">
					<div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
				</div>
				<div class="ms-3">
					<h6 class="mb-0">${loginStudent.studentId}</h6>
						<span>${loginStudent.studentName}</span>
				</div>
			</div>
			<div class="navbar-nav w-100">
				<a href="${pageContext.request.contextPath}/student/testList" class="nav-item nav-link"><i class="fa fa-laptop me-2"></i>시험 목록</a>
				<a href="${pageContext.request.contextPath}/student/testList/check" class="nav-item nav-link"><i class="fa fa-keyboard me-2"></i>응시 목록</a>
				<a href="${pageContext.request.contextPath}/student/modifyStudentPw" class="nav-item nav-link"><i class="fa fa-keyboard me-2"></i>비밀번호 변경</a>
				<a href="${pageContext.request.contextPath}/student/logout" class="nav-item nav-link"><i class="fa fa-keyboard me-2"></i>로그 아웃</a>
			</div>
		</nav>
	</div>
</div>