<%@ page import="dto.*"%>
<%@ page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));

	QuestionDao questionDao = new QuestionDao();
	Question question = new Question();
	
	question = questionDao.selectQuestion(num);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateQuestionEnddateForm</title>
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
		<style>
			body {
				text-align: center;
			}
		</style>
	</head>
	<body>
		<h1>종료날짜 수정</h1>
		<form action="/poll/updateQuestionEnddateAction.jsp" method="post">
			<input type="hidden" name="num" value='<%=num%>'>
			<input type="hidden" name="startdate" value='<%=question.getStartdate()%>'>
			<input type="hidden" name="type" value='<%=question.getType()%>'>
			<table class="table table-bordered table-striped table-hover">
				<tr>
					<td>제목</td>
					<td>
						<input class="col col-sm-5 rounded" type="text" name="title" value='<%=question.getTitle()%>' readonly>
					</td>
				</tr>
				<tr>
					<td>종료일</td>
					<td>
						<input class="rounded" type="date" name="enddate" value='<%=question.getEnddate()%>'>
					</td>
				</tr>		
			</table>
			<button class="btn btn-outline-success" type="submit">수정하기</button>
		</form>
	</body>
</html>