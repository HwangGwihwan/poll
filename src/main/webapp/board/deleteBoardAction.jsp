<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String password = request.getParameter("password");
	
	Board board = new Board();
	board.setNum(num);
	board.setPass(password);
	
	BoardDao boardDao = new BoardDao();
	int row = boardDao.deleteBoardOne(board);
	
	if (row == 0) { // 삭제안됨(비밀번호 틀림)
		response.sendRedirect("/poll/board/deleteBoardForm.jsp?num=" + num);
	} else { // 수정성공
		response.sendRedirect("/poll/board/boardList.jsp");
	}
%>