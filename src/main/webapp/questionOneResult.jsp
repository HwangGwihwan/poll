<%@page import="java.util.ArrayList"%>
<%@ page import="dto.*"%>
<%@ page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// Controller : request 분석 + mode 호출
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	
	// 1) questionOne
	QuestionDao questionDao = new QuestionDao();
	Question question = questionDao.selectQuestion(qnum);
	
	// 2) 1)의 items
	ItemDao itemDao = new ItemDao();
	ArrayList<Item> itemList = itemDao.selectItem(qnum);
	
	// 3) 총투표수
	int totalCount = itemDao.selectItemCountByQnum(qnum);
	
	

%>
<!-- View -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<!-- nav.jsp include -->
		<jsp:include page="/inc/nav.jsp"></jsp:include>
		<h1><%=qnum%>번 설문 투표결과</h1>
		<table border="1" width="80%">
			<tr>
				<td colspan="4">
					Q : <%=question.getTitle()%>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					총 투표수 : <%=totalCount%>
				</td>
			</tr>
			<tr>
				<td>번호</td><td>내용</td><td>카운트(차트)</td><td>카운트</td>
			</tr>
			<%
				for (Item i : itemList) {
			%>
					<tr>
						<td><%=i.getInum()%></td>
						<td><%=i.getContent()%></td>
						<td>
						<!-- 각 count값에 대한 백분율 값 -->
						<%
							int percentage = (int)(Math.round((double)i.getCount() / totalCount * 100));
							for (int n = 0; n < percentage; n++) {
						%>
								*
						<%
							}
						%>
						</td>
						<td><%=i.getCount()%></td>
					</tr>
			<%
				}
			%>
			
		</table>
	</body> 
</html>