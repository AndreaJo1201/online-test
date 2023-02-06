<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>시험 등록</title>
	</head>
	
	<body>
		<div>
			<form method="post" action="${pageContext.request.contextPath}/teacher/test/addTest">
				<div>
					<table>
						<tr>
							<td>시험 제목</td>
							<td><input type="text" placeholder="시험 제목" name="testTitle"></td>
						</tr>
						<tr>
							<td>응시일</td>
							<td><input type="date" name="testDate"></td>
						</tr>
						<tr>
							<td>담당 강사</td>
							<td><input type="text" readonly="readonly" value="${loginTeacher.teacherName}"></td>
						</tr>
					</table>
				</div>
				<div class="test">
					<div class="question" id="question">
						<span>문제 입력</span>
						<div>
							<input type="text" placeholder="문제 내용" name="questionTitle">
						</div>
						
						<span>보기 입력</span>
						<div class="example" id="example">
							<input type="text" placeholder="보기 내용" name="exampleTitle">
							<input type="radio" name="exampleOx" value="정답">정답
							<input type="radio" name="exampleOx" value="오답" style="visibility: hidden;" checked="checked">
							<button type="button" id="removeExam">보기 삭제</button>
						</div>
						<button type="button" id="addE">보기 추가</button>
					</div>
					<button type="button" id="addQ" onclick="addQuestion()">문제 추가</button>
				</div>
				<button type="submit">시험 생성</button>
			</form>
		</div>
		
		<!-- script -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
		<script>
			
			//처리를 어떻게 해야할까..
		
		</script>
	</body>
</html>