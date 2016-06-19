<%@page import="java.util.*" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Kijelentkezett</title>
	<link rel="stylesheet" type="text/css" href="styles/style.css" />
</head>
<body>
<%session.removeAttribute("nev");%>
Sikeresen kijelentkezett. Kérjük
<a href="login.jsp"><b>jelentkezzen be.</b></a>
</body>
</html>