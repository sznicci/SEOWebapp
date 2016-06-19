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
		<title>Statisztika</title>
		<link rel="stylesheet" type="text/css" href="styles/style.css" />
	</head>
	
	
	<body><%
        String nev =  (String)session.getAttribute("nev");
		String jelszo = (String)session.getAttribute("jelszo");
		
		if( nev == null || nev.equals("") ) {
			response.sendRedirect("login.jsp");
		}       
		else{%> 
		<div id="container">
	
			<div id="header01">
				Statisztikák
			</div>
		
			<div id="header02" align="right">
				<a href="logout.jsp"><b>Kijelentkezés</b></a>
			</div>
		
			
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
			String sq1= "SELECT kulcsszo, tart_oldal, meresiEredmeny, datum, valtozas FROM history, gyakorisag, felh_adatai WHERE nev='"+nev+"' AND jelszo='"+jelszo+"' AND felh_adatai.id=gyak_id AND gyakorisag.id=history_id ORDER BY kulcsszo, datum, meresiEredmeny";
			pst1 = c1.prepareStatement(sq1);
			rs1 = pst1.executeQuery();
			boolean hasRows= rs1.next(); 
			
			%>
		
		
			<div id="content" align="center">
				 <% 
				
							
							
							if( !hasRows ){
								out.println("Önnek még nincs kulcsszava.");
							}
							else{
								//rs1.next();
								while( !rs1.isAfterLast() ){
								String preKulcsszo= rs1.getString("kulcsszo");
						
				%><hr>
				Kulcsszó: <%=preKulcsszo%>
				<table border=1>
					<tr><hr>
  						<th>Helyezés</th>
  						<th>Dátum</th>
  						<th>Oldalcím</th>
  						<th>Változás előző méréshez képest</th><hr>
					</tr>
				
				
				<%while( preKulcsszo.equals(rs1.getString("kulcsszo")) ){%>
						
						<tr>
							<td><%=rs1.getInt("meresiEredmeny")%></td>
							<td><%=rs1.getDate(4)%></td>
							<td style="max-width:200px"><span class="bodySmall" style="word-wrap: break-word;"><%=rs1.getString("tart_oldal")%></span></td>
							<td><%=rs1.getInt("valtozas")%></td>
						</tr>
						<% 
						//rs1.next();
						if( !rs1.next() ){
							break;
						}
						
					}
				%>
				</table><%
							}
			}
					%>
				
			</div>
		
		</div>
		
		<%}%>

	</body>
</html>