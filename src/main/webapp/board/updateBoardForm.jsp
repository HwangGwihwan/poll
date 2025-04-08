<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));

	BoardDao boardDao = new BoardDao();
	Board board = boardDao.selectBoardOne(num);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body class="container">
		<!-- nav.jsp 인클루드 -->
		<div>
			<jsp:include page="/inc/nav.jsp"></jsp:include>
		</div>
		
		<h1>글수정</h1>
		<form action="/poll/board/updateBoardAction.jsp" method="post">
			<input type="hidden" name="num" value="<%=num%>">
			<table class="table table-striped">
				<tr>
					<td>name</td>
					<td><input type="text" name="name" value="<%=board.getName()%>"></td>
				</tr>
				<tr>
					<td>subject</td>
					<td><input type="text" name="subject" value="<%=board.getSubject()%>"></td>
				</tr>
				<tr>
					<td>content</td>
					<td><textarea name="content" rows="5" cols="50"><%=board.getContent()%></textarea></td>
				</tr>
				<tr>
					<td>password</td>
					<td><input type="password" name="password"></td>
				</tr>
			</table>
			<button type="submit">수정하기</button>
		</form>
	</body>
</html>