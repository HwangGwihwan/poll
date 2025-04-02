<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "java.util.*" %>
<%
	// question 테이블 리스트 -> 페이징 -> title 링크(startdate <= 오늘날짜 <= enddate) -> 투표프로그램
	// qeestionDat.selectQuestionList(Paging)
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	Paging paging = new Paging();
	paging.setCurrentPage(currentPage);
	paging.setRowPerPage(rowPerPage);
	
	QuestionDao questionDao = new QuestionDao();
	ArrayList<Question> list = questionDao.selelctQuestionList(paging);
	
	// 오늘 날짜 구하기
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String today = sdf.format(new Date());
	
	System.out.println(today);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>pollList</title>
	</head>
	<body>
		<h1>설문리스트</h1>
		<!-- foreach문 ArrayList<Question> list 출력 title
		링크(startdate) <= 오늘날짜 <= enddate) 투표시작전, 투표종료, 투표하기-->
		<table border="1">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>시작일~종료일</th>
				<th>type</th>
				<th>투표</th>
			</tr>
			<%
				for (Question question : list) {
			%>
					<tr>
						<td><%=question.getNum()%></td>
						<td><%=question.getTitle()%></td>
						<td><%=question.getStartdate()%> ~ <%=question.getEnddate()%></td>
						<td><%=question.getType()%></td>
						<td>
						<%
							if (today.compareTo(question.getStartdate()) < 0) { // 투표시작전
						%>
								투표시작전
						<%
							} else if (today.compareTo(question.getEnddate()) > 0) { // 투표이후
						%>
								투표종료
						<%
							} else { // 투표가능
						%>
								<a href=''>투표하기</a>
						<%
							}
						%>
						
						</td>
					</tr>
			<%
				}
			%>
		</table>
	</body>
</html>