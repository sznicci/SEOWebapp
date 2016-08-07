<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="java.util.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Time" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Új kulcsszó létrehozása</title>
		<link rel="stylesheet" type="text/css" href="styles/style.css" />
	</head>
	
	
	<body>
		<%
        String sessionNev =  (String)session.getAttribute("nev");
		
		if( sessionNev == null || sessionNev.equals("") ) {
			response.sendRedirect("login.jsp");
		}       
		else if( sessionNev!=null && sessionNev.equals("admin") ){%>
	
		<div id="container">
	
			<div id="header01">
				Új kulcsszó létrehozása
			</div>
		
			<div id="header02" align="right">
				<a href="logout.jsp"><b>Kijelentkezés</b></a>
			</div>
		
			<div id="menu" style="height:200px;width:150px;float:left;">
			<br/>
				<a href="felhasznalok.jsp"><b>Felhasználók</b></a><br/><br/><br/>
				<a href="adminKulcsszo.jsp"><b>Weboldalak, kulcsszavak</b></a><br/><br/><br/>
				<a href="adminstat.jsp"><b>Statisztikák</b></a>
			</div>
		
			<div id="content" align="center" style="float:left;">
<%String letrehoz = request.getParameter("letrehoz");

if( letrehoz != null ){
		
	java.sql.Connection c1;
	java.sql.Statement s1;
	java.sql.ResultSet rs1;
	java.sql.PreparedStatement pst1;
	
	java.sql.Statement s2;
	java.sql.ResultSet rs2;
	java.sql.PreparedStatement pst2;
	DataSource seoDB;

	c1=null;
	s1=null;
	pst1=null;
	rs1=null;
	
	s2=null;
	pst2=null;
	rs2=null;
	
	javax.naming.Context initCtx = new javax.naming.InitialContext();
	javax.naming.Context envCtx = (javax.naming.Context) initCtx.lookup("java:comp/env");
	seoDB = (DataSource) envCtx.lookup("jdbc/seoDB");

	try{
		if(seoDB == null) {
			javax.naming.Context initCtx1 = new javax.naming.InitialContext();
			javax.naming.Context envCtx1 = (javax.naming.Context) initCtx1.lookup("java:comp/env");
			seoDB = (DataSource) envCtx1.lookup("jdbc/seoDB");
		}
	}
	catch(Exception e){
		System.out.println("inside the context exception");
		e.printStackTrace();
	}
	String felhasznalo= request.getParameter("felhasznalo");
	
	c1 = seoDB.getConnection();
	String sq1= "SELECT id FROM felh_adatai WHERE nev='" + felhasznalo +"'";
	pst1 = c1.prepareStatement(sq1);
	rs1 = pst1.executeQuery();
	rs1.next();
	
	
	String oldalcim= request.getParameter("oldalcim");
	String kulcsszo= request.getParameter("kulcsszo");
	String gyakorisag= request.getParameter("gyakorisag");
	int gyakorisagInt= Integer.parseInt(gyakorisag);	
	
	
	String sq2= "INSERT INTO gyakorisag SET oldalcim='"+ oldalcim +"', kulcsszo='"+ kulcsszo +"', gyakorisag='"+ gyakorisagInt +"', gyak_id='"+ rs1.getInt(1) +"'";
	pst2 = c1.prepareStatement(sq2);
	int intrs2 = pst2.executeUpdate();

}

%>
<br/><br/>
				A kulcsszót sikeresen létrehozta!
			</div>
		
		</div>
		

	</body>
</html>

<%
		}
        else{
        	response.sendRedirect("stat.jsp");
        }			
%>