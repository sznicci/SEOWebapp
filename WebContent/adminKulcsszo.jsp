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
		<title>Kulcsszavak</title>
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
				Kulcsszavak
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
					String sq1= "SELECT gyakorisag.id, kulcsszo, nev, oldalcim, gyakorisag FROM gyakorisag, felh_adatai WHERE felh_adatai.id=gyak_id ORDER BY nev, kulcsszo";
					pst1 = c1.prepareStatement(sq1);
					rs1 = pst1.executeQuery();
					rs1.next();
					int sorszam= 1;
					%>
					
					<br/>
					<a href="ujKulcsszo.jsp"><b>Új kulcsszó hozzáadása</b></a>
					<br/><br/>
			
					Meglévő kulcsszavak listája:<br/>
					
					<%
								
					while( !rs1.isAfterLast() ){		
					
					%>
			

				<br/>
				Felhasználó: <%
				String preFelh= rs1.getString("nev");
				out.println(preFelh); %>
				<br/>
				<table>
					<tr>
  						
  						<th>Kulcsszó</th>
  						<th>Weboldal cím</th>
  						<th>Frissítési gyakoriság</th>
  						
					</tr>
					
						<% while( preFelh.equals(rs1.getString("nev")) ){ %>
						<tr>
							
							<td><%=rs1.getString("kulcsszo")%></td>
							<td><%=rs1.getString("oldalcim")%></td>
							<td><%=rs1.getInt("gyakorisag")%></td>
							<td><a href="felhWebKulcsszoKarbantartas.jsp?id=<%=rs1.getString("gyakorisag.id")%>"><b>Módosít</b></a></td>
  							<td><a href="felhWebKulcsszoKarbantartas.jsp?id=<%=rs1.getString("gyakorisag.id")%>"><b>Töröl</b></a></td>
						</tr>
						<% 
						sorszam+= 1;
						
						if( !rs1.next() ){
							break;
						}
						
					
					}%>
				
				</table><%
				}
				%>
				
			</div>
		
		</div>     
        <%}
        else{
        	response.sendRedirect("stat.jsp");
        }
        %>
	
		

	</body>
</html>