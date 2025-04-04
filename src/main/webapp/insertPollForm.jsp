<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertPollForm</title>
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
		<!-- nav.jsp include -->
		<jsp:include page="/inc/nav.jsp"></jsp:include>
		<h1>투표프로그램</h1>
		<hr>
		<h2>설문작성</h2>
		<form action="/poll/insertPollAction.jsp" method="post">
			<table class="table table-bordered table-striped table-hover">
				<tr>
					<td>질문</td>
					<td colspan="2">
						<input class="col col-sm-5 rounded" type="text" name="title">
					</td>
				</tr>
				<tr>
					<td rowspan="7"></td>
					<td>1) <input class="rounded" type="text" name="content"></td>
					<td>2) <input class="rounded" type="text" name="content"></td>
				</tr>
				<tr>
					<td>3) <input class="rounded" type="text" name="content"></td>
					<td>4) <input class="rounded" type="text" name="content"></td>
				</tr>
				<tr>
					<td>5) <input class="rounded" type="text" name="content"></td>
					<td>6) <input class="rounded" type="text" name="content"></td>
				</tr>
				<tr>
					<td>7) <input class="rounded" type="text" name="content"></td>
					<td>8) <input class="rounded" type="text" name="content"></td>
				</tr>
				<tr>
					<td>시작일</td>
					<td>
						<input class="rounded" type="date" name="startdate">
					</td>
				</tr>
				<tr>
					<td>종료일</td>
					<td>
						<input class="rounded" type="date" name="enddate">
					</td>
				</tr>
				<tr>
					<td>복수투표</td>
					<td>
						<input type="radio" name="type" value="1">yes
						<input type="radio" name="type" value="0">no
					</td>
				</tr>				
			</table>
			<button class="btn btn-outline-success" type="submit">작성하기</button>
			<button class="btn btn-outline-danger" type="reset">다시쓰기</button>
		</form>
	</body>
</html>