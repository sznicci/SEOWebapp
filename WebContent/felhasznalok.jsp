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
		<title>Felhasználók</title>
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
				Felhasználók
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
			
				<% java.sql.Connection c1;
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
					String sq1= "SELECT id, nev FROM felh_adatai";
					pst1 = c1.prepareStatement(sq1);
					rs1 = pst1.executeQuery();
					
					%>
			
			
			

				<a href="felhHozzaad.jsp"><b>Új felhasználó hozzáadása</b></a>
				<br/><br/><br/>
			
				Felhasználók listája:
				
				<table>
					<tr>
  						<th>Sorszám</th>
  						<th>Felhasználó</th>
					</tr>
					
					<% while( rs1.next() ){ %>
						<tr>
							
							<td><%=rs1.getString("id")%></td>
							<td><%=rs1.getString("nev")%></td>
							<td><a href="felhAdatKarbantartas.jsp?id=<%=rs1.getString("id")%>"><b>Módosít</b></a></td>
  							<td><a href="felhAdatKarbantartas.jsp?id=<%=rs1.getString("id")%>"><b>Töröl</b></a></td>
						</tr>
						<% 						
					   }
					%>
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