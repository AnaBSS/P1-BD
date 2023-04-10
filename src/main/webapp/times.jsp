<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Times</title>
</head>
<body>
	<div>
        <jsp:include page="menu.jsp"/>
    </div>
    <div>
    	<H1>Lista de Times</H1>
	</div>
	<div>
		<form action="times" method="post">
	 		<input type="submit" id="botao" name="botao" value="LISTAR">
	 	</form>
	</div>
	<br/>
	<div>
        <c:if test="${not empty times }">
            <table border="1">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>Cidade</th>
                        <th>Est�dio</th>
                        <th>Material Esportivo</th>
                    </tr>
                </thead>
                <tbody>
                 	<c:forEach items="${times }" var="times">
                        <tr>
                            <td><c:out value="${times.Cod_time }"/></td>
                            <td><c:out value="${times.Nome }"/></td>
                            <td><c:out value="${times.Cidade }"/></td>
                            <td><c:out value="${times.Estadio }"/></td>
                            <td><c:out value="${times.Material_esportivo }"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
	</div>
</body>
</html>