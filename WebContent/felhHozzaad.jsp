<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Felhasználó hozzáadása</title>
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
				Felhasználó hozzáadása<br/><br/>
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

				<form method="POST" action="sessionUjFelhasznalo.jsp">
  						<p><b>Felhasználó neve:</b> <input type="text" name="nev" size="20"/></p>
  						<p><b>Felhasználó jelszava:</b> &nbsp;&nbsp;<input type="password" name="jelszo" size="20"/></p>
  						<p><b>Felhasználó cégneve:</b> &nbsp;&nbsp;<input type="text" name="cegnev" size="30"/></p>
  						<p><b>Cégjegyzékszám:</b> &nbsp;&nbsp;<input type="text" name="cegjegyzekszam" size="20"/></p>
  						<p><b>Felhasználó e-mail címe:</b> <input type="text" name="email" size="30"/></p>
  						<p><input type="submit" value="Létrehozás" name="letrehoz"/></p><hr/><hr/>
  					
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