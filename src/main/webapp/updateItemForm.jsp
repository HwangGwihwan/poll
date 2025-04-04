<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.*"%>
<%@ page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	// ? 번 문제와 아이템들 출력
	// type=1 아이템의 타입을 checkbox
	// type=0 아이템의 타입을 radio

	// Controller Layer(request분석값 + Model Layer 호출/반환)
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	
	// 1) questionOne
	QuestionDao questionDao = new QuestionDao();
	Question question = questionDao.selectQuestion(qnum);
	
	
	// 2) 1)의 items
	ItemDao itemDao = new ItemDao();
	ArrayList<Item> itemList = itemDao.selectItem(qnum);
	
%>

<!-- View -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>투표하기</title>
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
		<h1>투표하기</h1>
		<form action="/poll/updateItemAction.jsp" method="post">
			<input type="hidden" name="qnum" value="<%=qnum%>">
			<table class="table table-dark">
				<tr>
					<td>
						Q : <%=question.getTitle()%>
						(<%=question.getType() == 1 ? "복수투표가능" : "복수투표불가"%>)
					</td>
				</tr>
				<tr>
					<td>
					<%
						for (Item item : itemList) {
					%>
							<div>
							<%
								if (question.getType() == 0) { // radio
							%>
									<input type="radio" name="inum" value='<%=item.getInum()%>'>
							<%
								} else { // checkbox
							%>
									<input type="checkbox" name="inum" value='<%=item.getInum()%>'>
							<%
								}
							%>
							<%=item.getContent()%>
							</div>
					<%
						}
					%>
					</td>
				</tr>
			</table>
			<button class="btn btn-outline-success" type="submit">투표</button>
		</form>
	</body>
</html>