<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*"%>
<%@ page import="java.util.*" %>
<%
	// controller(1.요청값 분석, 2.모델 호출)
	// 1. 요청값 분석
	Question question = new Question();
	ArrayList<Item> list = new ArrayList<>();
	
	String title = request.getParameter("title");
	
	// 2. 모델(메소드) 호출

%>