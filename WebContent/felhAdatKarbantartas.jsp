<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="java.util.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Time" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Felhasználó adatainak karbantartása</title>
		<link rel="stylesheet" type="text/css" href="styles/style.css" />
	</head>
	
	
	<body><%
        String nev =  (String)session.getAttribute("nev");
		
		if( nev == null || nev.equals("") ) {
			response.sendRedirect("login.jsp");
		}       
		else if( nev!=null && nev.equals("admin") ){%>
	
		<div id="container">
	
			<div id="header01">
				Felhasználó adatainak karbantartása
			</div>
		
			<div id="header02" align="right">
				<a href="logout.jsp"><b>Kijelentkezés</b></a>
			</div>
		
			<div id="menu" style="height:200px;width:150px;float:left;">
			<br>
				<a href="felhasznalok.jsp"><b>Felhasználók</b></a><br><br><br>
				<a href="adminKulcsszo.jsp"><b>Weboldalak, kulcsszavak</b></a><br><br><br>
				<a href="adminstat.jsp"><b>Statisztikák</b></a>
			</div>
		
			<div id="content" align="center" style="float:left;">
			
				<%  String idString= request.getParameter("id");
					int id= Integer.parseInt(idString);	
				
					java.sql.Connection c1;
					java.sql.Statement s1;
					java.sql.ResultSet rs1;
					java.sql.PreparedStatement pst1;
					DataSource seoDB;

					c1=null;
					s1=null;
					pst1=null;
					rs1=null;

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
					c1 = seoDB.getConnection();
					String sq1= "SELECT * FROM felh_adatai WHERE id='" + id +"'";
					pst1 = c1.prepareStatement(sq1);
					rs1 = pst1.executeQuery();
					rs1.next();
					
					%>
				<%=rs1.getString("nev")%> adatainak módosítása:
				<br><br><hr>
				<form method="POST" action="sessionAdatValtozas.jsp?id=<%=rs1.getString("id")%>">
  						<p><b>Felhasználó neve:</b> <input type="text" name="nev" size="10" value="<%=rs1.getString("nev")%>"></p>
  						<p><b>Felhasználó jelszava:</b> &nbsp;&nbsp;<input type="password" name="jelszo" size="20" value="<%=rs1.getString("jelszo")%>"></p>
  						<p><b>Felhasználó cégneve:</b> &nbsp;&nbsp;<input type="text" name="cegnev" size="30" value="<%=rs1.getString("cegnev")%>"></p>
  						<p><b>Cégjegyzékszám:</b> <input type="text" name="cegjegyzekszam" size="10" value="<%=rs1.getString("cegjegyzekszam")%>"></p>
  						<p><b>Felhasználó e-mail címe:</b> <input type="text" name="email" size="30" value="<%=rs1.getString("email")%>"></p>
  						<p><input type="submit" value="Módosít" name="modosit"></p><hr><hr><br>
  						<p><input type="submit" value="Töröl" name="torol"></p>
				</form>
			</div>
		
		</div>
		
		<%}
        else{
        	response.sendRedirect("stat.jsp");
        }
        %>

	</body>
</html>