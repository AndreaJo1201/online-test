<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div>
	<a href="${pageContext.request.contextPath}/teacher/testList">시험 관리</a>
	<!--
		시험회차(table : test) 관리(CRUD) & 문제 관리 
		개별 시험회차 클릭하면 해당 회차의 문제리스트 출력(문제CRUD)
		개별 문제 클릭하면 해당 문제의 보기 리스트 출력(보기 CRUD)
	 -->
	
	<a href="${pageContext.request.contextPath}/teacher/modifyTeacherPw">비밀번호변경</a>
	
	<a href="${pageContext.request.contextPath}/teacher/logout">로그아웃</a>
</div>