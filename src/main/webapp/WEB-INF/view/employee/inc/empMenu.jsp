<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div>
	<a href="${pageContext.request.contextPath}/employee/empList">사원관리</a>
	<!-- 등록시 ID 체크(employee + teacher + student) -->
	
	<a href="${pageContext.request.contextPath}/employee/teacher/teacherList">강사관리</a>
	<!-- 강사 목록, 강사 삭제 -->
	<!-- 등록시 ID 체크(employee + teacher + student) -->
	
	<a href="${pageContext.request.contextPath}/employee/student/studentList">학생관리</a>
	<!-- 학생 목록, 학생 삭제 -->
	<!-- 등록시 ID 체크(employee + teacher + student) -->
	
	<a href="${pageContext.request.contextPath}/employee/modifyEmpPw">비밀번호변경</a>
	
	<a href="${pageContext.request.contextPath}/employee/logout">로그아웃</a>
</div>