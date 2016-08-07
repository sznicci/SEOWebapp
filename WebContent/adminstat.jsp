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
		<title>Statisztikák</title>
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
				Statisztikák
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
			String sq1= "SELECT kulcsszo, tart_oldal, meresiEredmeny, datum, nev, valtozas FROM history, gyakorisag, felh_adatai WHERE felh_adatai.id=gyak_id AND gyakorisag.id=history_id ORDER BY kulcsszo, datum, meresiEredmeny";
			pst1 = c1.prepareStatement(sq1);
			rs1 = pst1.executeQuery();
			rs1.next();
			
			while( !rs1.isAfterLast() ){	
				String preKulcsszo= rs1.getString("kulcsszo");
				
				
			%>
				<br/>
				Kulcsszó: <%=preKulcsszo%>
				<table border="1">
					<tr>
  						<th>Helyezés</th>
  						<th>Hónap</th>
  						<th>Weboldal cím</th>
  						<th>Felhasználó</th>
  						<th>Változás előzőhöz képest</th>
					</tr>
					
					<%while( preKulcsszo.equals(rs1.getString("kulcsszo")) ){	%>
						
						<tr>
							<td><%=rs1.getInt("meresiEredmeny")%></td>
							<td><%=rs1.getDate(4)%></td>
							<td style="max-width:200px"><span class="bodySmall" style="word-wrap: break-word;"><%=rs1.getString("tart_oldal")%></span></td>
							<td><%=rs1.getString("nev")%></td>
							<td><%=rs1.getInt("valtozas")%></td>
						</tr>
						<% 
						
						
						if( !rs1.next() ){
							break;
						}
						
					}%>
					</table>	<%	
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