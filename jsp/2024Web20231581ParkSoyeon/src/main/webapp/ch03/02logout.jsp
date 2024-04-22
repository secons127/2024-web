<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	application.removeAttribute("loginCheck");
	response.sendRedirect("02loginForm.jsp");
%>