<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<link rel="stylesheet" href="./css/styles.css">

<title>Jogos</title>
</head>
<body>
	<div>
        <jsp:include page="menu.jsp"/>
    </div>
    <div>
    	<form action="jogos" method="post">
    		<table>
    			<tr>
    				<td><input type="date" id="data" name="data"></td>
    				<td><input type="submit" id="botao" name="botao" value="BUSCAR"></td>
    				<br/>
    				<br/>
    				<td><input type="submit" id="botao" name="botao" value="GERAR"></td>
    			</tr>
    		</table>
    	</form>
    </div>
    <div>
    	<c:if test="${not empty jogos }">
    		<table>
    			<thead>
    				<tr>
    					<th>Time A</th>
    					<th>Time B</th>
    					<th>Data</th>
    				</tr>
    			</thead>
    			
    			<tbody>
    				<c:forEach items="${jogos }" var="jogo">
    					<tr>
    						<td><c:out value="${jogo.nome_timeA }"></c:out></td>
    						<td><c:out value="${jogo.nome_timeB }"></c:out></td>
    						<td><c:out value="${jogo.data_rodada }"></c:out></td>
    					</tr>
    				</c:forEach>
    			</tbody>
    		</table>
    	</c:if>
    </div>
    <div align="center">

	   <c:choose>
			<c:when test="${not empty jogos }">
				<table class="z" border="1">
					<thead>
						<tr>
							<th>Time A</th>
							<th>Time B</th>
							<th>Data</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${jogos }" var="jogo">
							<tr>
								<td><c:out value="${jogo.nome_timeA }"></c:out></td>
								<td><c:out value="${jogo.nome_timeB }"></c:out></td>
								<td><c:out value="${jogo.data_rodada }"></c:out></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:when>
      
			<c:otherwise>
				<div class="z">
                  	<p>Não existem jogos nessa data</p>
				</div>
			</c:otherwise>		
	 	</c:choose>		
	</div>
</body>
</html>