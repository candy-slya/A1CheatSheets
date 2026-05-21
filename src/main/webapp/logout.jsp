<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    // Clear session
    session.invalidate();
    // Redirect back to home (guest view)
    response.sendRedirect("IndexServlet");
%>
