<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="./css/styles.css">

<title>Grupos</title>
</head>
<body>
	<div>
        <jsp:include page="menu.jsp"/>
    </div>
    <div>
    	<H1>Grupos do Paulistão</H1>
	</div>
	<div>
		<form action="grupos" method="post">
	 		<input type="submit" id="botao" name="botao" value="Gerar">
	 	</form>
	</div>
	<div class="tabelas">
		<c:if test="${not empty grupoA }">
			<table class="tabelaA">
				<thead>
					<tr>
						<th>Time</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${grupoA }" var="ga">
						<tr>
							<td><c:out value="${ga.nome_time }"></c:out></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
		
		<c:if test="${not empty grupoB }">
			<table class="tabelaB">
				<thead>
					<tr>
						<th>Time</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${grupoB }" var="gb">
						<tr>
							<td><c:out value="${gb.nome_time }"></c:out></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
		
		<c:if test="${not empty grupoC }">
			<table class="tabelaC">
				<thead>
					<tr>
						<th>Time</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${grupoC }" var="gc">
						<tr>
							<td><c:out value="${gc.nome_time }"></c:out></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
		
		<c:if test="${not empty grupoD }">
			<table class="tabelaD">
				<thead>
					<tr>
						<th>Time</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${grupoD }" var="gd">
						<tr>
							<td><c:out value="${gd.nome_time }"></c:out></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
		
	</div>
</body>
</html>