<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Kulcsszó törlése</title>
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
				Kulcsszó törlése
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
			
				<br><br>
				<table>
					<tr>
  						<th>Weboldal neve: </th> &nbsp;&nbsp;
  						<th></th>
					</tr>
					<tr>
  						<th>Kulcsszó: </th> &nbsp;&nbsp;
  						<th></th>
					</tr>
					
					<tr>
						<td> Biztosan törölni akarja a megadott kulcsszót? </td>
					</tr>
					<tr>
						<td> <a href="adminKulcsszo.jsp"><b>Igen</b></a> </td>
						<td> <a href="adminKulcsszo.jsp"><b>Nem</b></a> </td>
					</tr>
				</table>
			</div>
		
		</div>
		
		<%}
        else{
        	response.sendRedirect("stat.jsp");
        }
        %>

	</body>
</html>