<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<script>
	let message = "<c:out value='${message}'/>"
	let url = "<c:out value='${url}'/>"
	alert(message);
	location.href = url;
</script>