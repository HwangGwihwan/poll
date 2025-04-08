<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// Controller Layer(request분석, model호출)
	int num = Integer.parseInt(request.getParameter("num"));
	String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String password = request.getParameter("password");
	
	Board board = new Board();
	board.setNum(num);
	board.setName(name);
	board.setSubject(subject);
	board.setContent(content);
	board.setPass(password);
	
	BoardDao boardDao = new BoardDao();
	int row = boardDao.updateBoardOne(board);
	
	if (row == 0) { // 수정안됨(아마 비밀번호 틀림)
		response.sendRedirect("/poll/board/updateBoardForm.jsp?num=" + num);
	} else { // 수정성공
		response.sendRedirect("/poll/board/boardList.jsp");
	}
%>
