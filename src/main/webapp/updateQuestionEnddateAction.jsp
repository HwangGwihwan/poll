<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	int num = Integer.parseInt(request.getParameter("num"));
	String title = request.getParameter("title");
	String startdate = request.getParameter("startdate");
	String enddate = request.getParameter("enddate");
	int type = Integer.parseInt(request.getParameter("type"));
	
	// 오늘 날짜 구하기
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String today = sdf.format(new Date());
	
	if (today.compareTo(enddate) > 0) { // 날짜수정불가
		response.sendRedirect("/poll/updateQuestionEnddateForm.jsp?num=" + num);
		return;
	}
	
	Question question = new Question();
	question.setNum(num);
	question.setTitle(title);
	question.setStartdate(startdate);
	question.setEnddate(enddate);
	question.setType(type);
	
	QuestionDao questionDao = new QuestionDao();
	questionDao.updateQuestion(question);
	
	response.sendRedirect("/poll/pollList.jsp");
%>

