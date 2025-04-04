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
	int rowPerPage = 4;
	Paging paging = new Paging();
	paging.setCurrentPage(currentPage);
	paging.setRowPerPage(rowPerPage);
	
	QuestionDao questionDao = new QuestionDao();
	ItemDao itemDao = new ItemDao();
	
	int lastPage = paging.getLastPage(questionDao.getTotal());
	
	ArrayList<HashMap<String, Object>> list = questionDao.selelctQuestionList(paging);
	
	// 오늘 날짜 구하기
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String today = sdf.format(new Date());
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>pollList</title>
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<!-- nav.jsp include -->
		<jsp:include page="/inc/nav.jsp"></jsp:include>
		<h1>설문리스트</h1>
		<!-- foreach문 ArrayList<Question> list 출력 title
		링크(startdate) <= 오늘날짜 <= enddate) 투표시작전, 투표종료, 투표하기-->
		<table class="table table-dark table-hover">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>시작일~종료일</th>
				<th>복수투표</th>
				<th>현재투표현황</th> 
				<th>투표</th>
				<th>삭제</th>
				<th>수정</th>
				<th>종료일자수정</th>
				<th>결과</th>
			</tr>
			<%
				for (HashMap<String, Object> map : list) {
			%>
					<tr>
						<td><%=map.get("num")%></td>
						<td><%=map.get("title")%></td>
						<td><%=map.get("startdate")%> ~ <%=map.get("enddate")%></td>
						<td>
						<%
							if ((int)map.get("type") == 0) {
						%>
								불가능
						<%
							} else {
						%>
								가능
						<%
							}
						%>
						</td>
						<td><%=map.get("cnt")%></td>
						<td>
						<%
							if (today.compareTo((String)map.get("startdate")) < 0){ // 투표시작전
						%>
								투표시작전
						<%
							} else if (today.compareTo((String)map.get("enddate")) > 0) { // 투표이후
						%>
								투표종료
						<%
							} else { // 투표가능
						%>
								<a href='/poll/updateItemForm.jsp?qnum=<%=map.get("num")%>'>투표하기</a>
						<%
							}
						%>
						</td>
						<td>
						<%
							if ((int)map.get("cnt") > 0) {
						%>
								삭제불가
						<%
							} else {
						%>
								<a href='/poll/deletePoll.jsp?qnum=<%=map.get("num")%>'>삭제</a>
						<%
							}
						%>
						</td>
						<td> <!-- 누군가 투표를 했으면 전체수정 불가능 -->
						<%
							if ((int)map.get("cnt") > 0) {
						%>
								수정불가
						<%
							} else {
						%>
								<a href='/poll/updatePollForm.jsp?num=<%=map.get("num")%>'>수정</a>
						<%
							}
							
						%>
						</td>
						<td>
						<%
							if (today.compareTo((String)map.get("enddate")) > 0) {
						%>
								수정불가
						<%
							} else {
						%>
								<a href='/poll/updateQuestionEnddateForm.jsp?num=<%=map.get("num")%>'>종료날짜 수정</a>
						<%
							}
						%>
						</td>
						<td>
						<%
							if (today.compareTo((String)map.get("enddate")) > 0) {
						%>
								<a class="btn btn-outline-danger" href='/poll/questionOneResult.jsp?qnum=<%=map.get("num")%>'>결과보기</a>
						<%
							} else {
						%>
								투표진행중
						<%
							}
						%>
						</td>
					</tr>
			<%
				}
			%>
		</table>
		<!-- 페이징 -->
		<%
			if (currentPage > 1) {
		%>
				<a href='/poll/pollList.jsp?currentPage=<%=currentPage - 1%>'>[이전]</a>
		<%
			}
		
			if (currentPage < lastPage) {
		%>
				<a href='/poll/pollList.jsp?currentPage=<%=currentPage + 1%>'>[다음]</a>
		<%
			}
		%>
	</body>
</html>