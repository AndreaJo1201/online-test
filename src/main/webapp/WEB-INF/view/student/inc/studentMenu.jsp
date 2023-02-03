<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div>
	<a href="${pageContext.request.contextPath}/student/studentTestList">시험 응시</a>
	<!--
		지나간 시험(table: test) 리스트 + 점수 - 점수확인버튼 클릭 - 제출한 답안지 확인 가능(table - paper)-(정답여부 O, X)
		오늘 날짜의 시험 리스트 응시버튼 -> 시험지(table: question JOIN(*) example) -> 답안지 제출(table : paper) 출력
	 -->
	
	<a href="${pageContext.request.contextPath}/student/modifyStudentPw">비밀번호변경</a>
	
	<a href="${pageContext.request.contextPath}/student/logout">로그아웃</a>
</div>