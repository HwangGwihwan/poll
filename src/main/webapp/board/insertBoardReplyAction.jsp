<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// Controller Layer(request분석, model호출)
	String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String password = request.getParameter("password");
	int pos = Integer.parseInt(request.getParameter("pos"));
	int ref = Integer.parseInt(request.getParameter("ref"));
	int depth = Integer.parseInt(request.getParameter("depth"));
	
	// Form 입력타입(DTO 사용가능)으로 묶음
	Board board = new Board();
	board.setName(name);
	board.setSubject(subject);
	board.setContent(content);
	board.setPos(pos);
	board.setRef(ref);
	board.setDepth(depth);
	board.setPass(password);
	board.setIp(request.getRemoteAddr());
	
	// logging(디버깅......)
	System.out.println(board.toString());
	
	BoardDao boardDao = new BoardDao();
	boardDao.insertBoardReply(board);
	
	// 뷰가 있다면 뷰를 연결(디스패츠 ex: include), 뷰가 없다면 클라이언트에 다른 요청을 강제(리다이렉트)
	response.sendRedirect("/poll/board/boardList.jsp");
%>