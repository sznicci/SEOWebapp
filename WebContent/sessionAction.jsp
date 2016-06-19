<%@page import="java.util.*" %>
<%@page import="java.util.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Time" %>
<%String nev = request.getParameter("nev");
String jelszo = request.getParameter("jelszo");

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
String sq1= "SELECT id FROM felh_adatai WHERE nev='"+nev+"' AND jelszo='"+jelszo+"'";
pst1 = c1.prepareStatement(sq1);
rs1 = pst1.executeQuery();
rs1.next();

if( nev == null || nev.equals("") || jelszo == null || jelszo.equals("") ) {
	response.sendRedirect("login.jsp");
}

else if( rs1.getInt(1)==1 ) {
	session.setAttribute("nev", request.getParameter("nev"));
	session.setAttribute("jelszo", jelszo);
	response.sendRedirect("adminstat.jsp");
}
else {
	session.setAttribute("nev", nev);
	session.setAttribute("jelszo", jelszo);
	response.sendRedirect("stat.jsp");
}

%>