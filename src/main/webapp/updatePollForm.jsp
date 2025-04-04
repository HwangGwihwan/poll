<%@ page import="java.util.*"%>
<%@ page import="dto.*"%>
<%@ page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	
	QuestionDao questionDao = new QuestionDao();
	ItemDao itemDao = new ItemDao();
	Question question = new Question();
	
	question = questionDao.selectQuestion(num);
	ArrayList<Item> list = itemDao.selectItem(num);

	int i = 1;
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updatePollForm</title>
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
		<h1>투표 수정</h1>
		<form action="/poll/updatePollAction.jsp" method="post">
			<input type="hidden" name="num" value='<%=num%>'>
			<table class="table table-bordered table-striped table-hover">
				<tr>
					<td>질문</td>
					<td colspan="2">
						<input class="col col-sm-5 rounded" type="text" name="title" value='<%=question.getTitle()%>'>
					</td>
				</tr>
				<tr>
					<td rowspan="7"></td>
					<%
						for (Item item : list) {
					%>
							<td><%=i%>) <input class="rounded" type="text" name="content" value='<%=item.getContent()%>'></td>
					<%
							if (i % 2 == 0) {
					%>
								</tr><tr>
					<%		}
						i++; 
						}
					
						while (i <= 8) {
					%>
							<td><%=i%>) <input class="rounded" type="text" name="content"></td>
					<%
							if (i % 2 == 0) {
					%>
								</tr><tr>
					<%
							}
						i++;
						}
					%>
					<td>시작일</td>
					<td>
						<input class="rounded" type="date" name="startdate" value='<%=question.getStartdate()%>'>
					</td>
				</tr>
				<tr>
					<td>종료일</td>
					<td>
						<input class="rounded" type="date" name="enddate" value='<%=question.getEnddate()%>'>
					</td>
				</tr>
				<tr>
					<td>복수투표</td>
					<td>
						<input type="radio" name="type" value="1" <% if (question.getType() == 1) {%> checked <%}%>>yes
						<input type="radio" name="type" value="0" <% if (question.getType() == 0) {%> checked <%}%>>no
					</td>
				</tr>				
			</table>
			<button class="btn btn-outline-success" type="submit">수정하기</button>
		</form>
	</body>
</html>