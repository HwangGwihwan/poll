<%@page import="dto.Image"%>
<%@page import="model.ImageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.util.*" %>
<%
	//request.getParameter() 다른 내용의 코드가 실행된다
	// enctype="application/x-www-form-urlencoded" : 문자열 -> 문자열 반환
	// enctype="multipart/form-data" : 바이너리 -> 문자열로 변환 -> 문자열 반환
	
	String title = request.getParameter("memo");
	System.out.println(title);
	
	// 파일의 바이너리(메타정도) 그대로 받아서 part객체안에 저장
	Part part = request.getPart("imageFile");
	
	// 업로드된 원본 파일 이름
	String originalName = part.getSubmittedFileName();
	// 원본이름에서 .확장자 추출
	String ext = originalName.substring(originalName.lastIndexOf("."));
	// 저장에 사용할 파일 이름 : 중복방지를 위해 UUID 유틸 클래스 사용
	String txt = (UUID.randomUUID().toString()).replace("-", "");
	String saveName = txt+ext; // 생성됨이름 뒤에 .확장자 추가
	System.out.println(saveName);
	
	Image image  = new Image();
	image.setMemo(title);
	image.setFilename(saveName);
	
	// 저장될 위치를 현재 프로젝트(톰켓 컨텍스트)안으로 지정
	String uploadPath = request.getServletContext().getRealPath("upload");
	System.out.println(uploadPath);
	
	File file = new File(uploadPath, saveName);
	InputStream inputStream = part.getInputStream(); // part객체안에 파일(바이너리)을 메모로리 불러 옴
	OutputStream outputStream = Files.newOutputStream(file.toPath()); // 메모리로 불러온 파일(바이너리)을 빈파일에 저장
	inputStream.transferTo(outputStream);
	
	// db저장
	ImageDao imageDao = new ImageDao();
	imageDao.insertImage(image);
	response.sendRedirect("/poll/imageBoard/imageList.jsp");

%>
