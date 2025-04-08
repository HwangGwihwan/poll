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
	<body>
		<!-- nav.jsp 인클루드 -->
		<div>
			<jsp:include page="/inc/nav.jsp"></jsp:include>
		</div>
		
		<h1>글 삭제</h1>
		<hr>
		<div>사용자의 비밀번호를 입력해주세요</div>
		<table class="table table-striped">
			<tr>
				<td>num</td>
				<td><%=board.getNum()%></td>
			</tr>
			<tr>
				<td>name</td>
				<td><%=board.getName()%></td>
			</tr>
			<tr>
				<td>subject</td>
				<td><%=board.getSubject()%></td>
			</tr>
		</table>
		<form action="/poll/board/deleteBoardAction.jsp" method="post">
			<input type="hidden" name="num" value="<%=num%>">
			<input type="text" name="password">
			<button type="submit">삭제하기</button>
		</form>
	</body>
</html>