<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	ImageDao iamgeDao = new ImageDao();
	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(8);
	ArrayList<Image> list = iamgeDao.selectImageList(p);
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
		<%
			for (Image i : list) {		
		%>
				<table class="table table-striped">
					<tr>
						<td><%=i.getMemo()%></td>
					</tr>
					<tr>
						<td>
							<img src="/poll/upload/<%=i.getFilename()%>" width="300px" height="200px">
						</td>
					</tr>
					<tr>
						<td><a href="/poll/imageBoard/deleteImage.jsp?num=<%=i.getNum()%>&filename=<%=i.getFilename()%>">삭제</a></td>
					</tr>
					<tr>
				</table>
				<hr>
		<%
			}
		%>
	</body>
</html>