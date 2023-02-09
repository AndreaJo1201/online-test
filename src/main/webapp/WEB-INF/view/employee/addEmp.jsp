<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>사원 등록</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	</head>
	
	<body>
		<!-- empMenu include -->
		<div>
			<c:import url="/WEB-INF/view/employee/inc/empMenu.jsp"></c:import>
		</div>
		<h1>Add Employee</h1>
		<div>${errorMsg}</div>
		<div>
			<input type="text" id="id">
			<button type="button" id="ckBtn">중복검사</button>
		</div>
		<form method="post" action="${pageContext.request.contextPath}/employee/addEmp">
			<table border="1">
				<tr>
					<td>ID</td>
					<td><input type="text" name="empId" placeholder="ID" id="empId"></td>
				</tr>
				<tr>
					<td>Password</td>
					<td><input type="password" name="empPw" placeholder="Password"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="empName" placeholder="이름"></td>
				</tr>
			</table>
			<button type="submit">등록</button>
		</form>
		
		<script>
			$('#ckBtn').click(function() {
				$.ajax({
					url:'/online-test/idck',
					type:'get',
					data:{id:$('#id').val()},
					success:function(model) { // model : 'YES' or 'NO'
						if(model=='YES') {
							// 사용가능한 ID
							$('#empId').attr('value',$('#id').val());
						} else {
							// 사용 불가능한 ID
							alert($('#id').val()+'는(은) 사용중인 아이디입니다.');
						}
					}
				})
			})
		
			$('#addBtn').click(function() {
				// 폼 유효성 검사(전송 전)
				// 폼 액션 전송
				console.log('폼 액션 전송');
			})
		</script>
	</body>
</html>