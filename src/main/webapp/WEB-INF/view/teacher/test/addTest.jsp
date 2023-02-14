<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>시험 등록</title>
		
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
							<td>
								<input type="text" readonly="readonly" value="${loginTeacher.teacherName}" name="testTeacher">
								<input type="hidden" readonly="readonly" value="${loginTeacher.teacherNo}" name="teacherNo">
							</td>
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
							<input type="checkbox" onchange="checkOx()"><label>정답</label>
							<input type="hidden" name="exampleOx" id="exampleOx" value="오답">
							<button type="button" id="removeE" onclick="removeExam()">보기 삭제</button>
						</div>
						<input type="hidden" name="exampleCnt" id="exampleCnt" value="1">
						<button type="button" id="addE" onclick="addExam()">보기 추가</button>
						<button type="button" id="removeQ" onclick="removeQuestion()">문제 삭제</button>
					</div>
					<button type="button" id="addQ" onclick="addQuestion()">문제 추가</button>
				</div>
				<button type="submit">시험 생성</button>
			</form>
		</div>
		
		<!-- script -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
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
				
			function addQuestion() {
				
				let $question = $('<div></div>');
				$question.attr('id','question');
				$question.attr('class','question');
				
				let $example = $('<div></div>');
				$example.attr('id', 'example');
				$example.attr('class', 'example');
				
				let $exampleTitle = $('<input type="text" placeholder="보기 내용" name="exampleTitle">');
				let $exampleOx1 = $('<input type="checkbox" onchange="checkOx()"><label>정답</label>');
				let $exampleOx2 = $('<input type="hidden" name="exampleOx" id="exampleOx" value="오답">');
				let $removeExam = $('<button type="button" id="removeE" onclick="removeExam()">보기 삭제</button>');
				
				$example.append($exampleTitle);
				$example.append($exampleOx1);
				$example.append($exampleOx2);
				$example.append($removeExam);
				
				let $span1 = $('<span>문제 입력</span>');
				let $div = $('<div><input type="text" placeholder="문제 내용" name="questionTitle"></div>');
				let $span2 = $('<span>보기 입력</span>');
				let $addE = $('<button type="button" id="addE" onclick="addExam()">보기 추가</button>');
				let $addQ = $('<button type="button" id="removeQ" onclick="removeQuestion()">문제 삭제</button>')
				let $exampleCnt = $('<input type="hidden" name="exampleCnt" id="exampleCnt" value="1">');
				
				$question.append($span1);
				$question.append($div);
				$question.append($span2);
				$question.append($example);
				$question.append($addE);
				$question.append($addQ);
				$question.append($exampleCnt);
				
				$('#addQ').before($question);
			}
			
			function addExam() {
				
				let $example = $('<div></div>');
				$example.attr('class', 'example');
				$example.attr('id', 'example');
				
				let $exampleTitle = $('<input type="text" placeholder="보기 내용" name="exampleTitle">');
				let $exampleOx1 = $('<input type="checkbox" onchange="checkOx()"><label>정답</label>');
				let $exampleOx2 = $('<input type="hidden" name="exampleOx" id="exampleOx" value="오답">');
				let $removeExam = $('<button type="button" id="removeE" onclick="removeExam()">보기 삭제</button>');
				
				$example.append($exampleTitle);
				$example.append($exampleOx1);
				$example.append($exampleOx2);
				$example.append($removeExam);
				
				$(event.target).before($example);
				
				let $target = $(event.target.parentNode);
				
				console.log($target.children('#exampleCnt'));
				
				let $examCnt = $target.children('#exampleCnt');
				$examCnt.attr('value',$target.children('#example').length);
				
			}
			
			function checkOx() {
				let $parent = $(event.target.parentNode);
				let $check = $parent.children('#exampleOx');
				
				let $target = $(event.target);
				
				if($target.is(':checked') == true) {
					$check.attr('value','정답');
				} else {
					$check.attr('value','오답');
				}
				
				
				console.log($check.val());	
				
			}
			
			function removeExam() {
				let $target = $(event.target.parentNode.parentNode);
				
				event.target.parentNode.remove();
				
				let $examCnt = $target.children('#exampleCnt');
				$examCnt.attr('value',$target.children('#example').length);
			}
			
			function removeQuestion() {
				event.target.parentNode.remove();
			}

		
		</script>
	</body>
</html>