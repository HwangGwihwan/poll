<%@ page import="java.util.ArrayList"%>
<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	BoardDao boardDao = new BoardDao();
	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(8);
	int lastPage = p.getLastPage(boardDao.getTotal());
	
	ArrayList<Board> boardList = boardDao.selectBoardList(p);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>boardList</title>
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
		
		<h1>BoardList</h1>
		<!-- boardList table... -->
		<table class="table table-striped">
			<thead>
				<tr>
					<td>num</td>
					<td>subject</td>
				</tr>
			</thead>
			<tbody>
			<%
				for (Board b : boardList) {
			%>
					<tr>
						<td><%=b.getNum()%></td>
						<td>
						<%
							for (int i = 0; i < b.getDepth(); i++) {
						%>
								&nbsp;&nbsp;&nbsp;&nbsp;
						<%
							}
							if (b.getDepth() > 0) {
						%>
								ㄴ
						<%
							}
						%>
							<a href="/poll/board/boardOne.jsp?num=<%=b.getNum()%>"><%=b.getSubject()%></a>
						</td>
					</tr>
			<%
				}
			%>
			</tbody>
		</table>
		<!-- 페이징 -->
		<%
			if (currentPage > 1) {
		%>
				<a class="btn btn-outline-primary" href='/poll/board/boardList.jsp?currentPage=<%=currentPage - 1%>'>이전</a>
		<%
			}
		
			if (currentPage < lastPage) {
		%>
				<a class="btn btn-outline-primary" href='/poll/board/boardList.jsp?currentPage=<%=currentPage + 1%>'>다음</a>
		<%
			}
		%>
	</body>
</html>