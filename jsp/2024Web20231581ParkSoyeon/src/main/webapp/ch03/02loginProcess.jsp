<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String i=request.getParameter("id");
String p=request.getParameter("pw");

if(i.equals("dong")){
	application.setAttribute("loginCheck", "ok");
} else {

}
response.sendRedirect("02loginForm.jsp");

%>